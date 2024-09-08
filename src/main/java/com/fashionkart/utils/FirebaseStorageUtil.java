package com.fashionkart.utils;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.Blob;
import com.google.cloud.storage.Bucket;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import lombok.extern.slf4j.Slf4j;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Slf4j
public class FirebaseStorageUtil {

    private static final String CREDENTIAL_PATH = ConfigUtil.getProperty("firebase.credentals.path");
    private static final String BUCKET_NAME = ConfigUtil.getProperty("firebase.bucket-name");
    private static final int SIGNED_URL_EXPIRATION_MINUTES = 30; //30 min

    private static final Storage storage = initializeStorage();

    private FirebaseStorageUtil() {
        // Prevent instantiation
    }

    private static Storage initializeStorage() {
        try (InputStream serviceAccount = new FileInputStream(CREDENTIAL_PATH)) {
            GoogleCredentials credentials = GoogleCredentials.fromStream(serviceAccount);
            FirebaseOptions options = FirebaseOptions.builder()
                    .setCredentials(credentials)
                    .setStorageBucket(BUCKET_NAME)
                    .build();

            if (FirebaseApp.getApps().isEmpty()) {
                FirebaseApp.initializeApp(options);
            }

            return StorageOptions.newBuilder()
                    .setCredentials(credentials)
                    .setProjectId(BUCKET_NAME.split("/")[0])
                    .build()
                    .getService();
        } catch (IOException e) {
            log.error("Failed to initialize Firebase Storage", e);
            throw new RuntimeException("Firebase Storage initialization failed", e);
        }
    }

    public static String uploadFile(String fileName, InputStream inputStream) throws IOException {
        try {
            String uniqueFileName = UUID.randomUUID() + "-" + fileName;
            String mimeType = Files.probeContentType(Paths.get(fileName));
            mimeType = mimeType != null ? mimeType : "application/octet-stream";

            Bucket bucket = storage.get(BUCKET_NAME);
            Blob blob = bucket.create(uniqueFileName, inputStream, mimeType);
            log.info("File uploaded successfully: {}", uniqueFileName);

            return uniqueFileName;
        } catch (IOException e) {
            log.error("Error uploading file: {}", fileName, e);
            throw e;
        }
    }

    public static String generateSignedUrl(String filePath) throws IOException {
        try {
            Blob blob = storage.get(BUCKET_NAME, filePath);
            if (blob == null) {
                throw new IOException("File not found: " + filePath);
            }
            return blob.signUrl(SIGNED_URL_EXPIRATION_MINUTES, TimeUnit.MINUTES, Storage.SignUrlOption.withV4Signature()).toString();
        } catch (IOException e) {
            log.error("Error generating signed URL for file: {}", filePath, e);
            throw e;
        }
    }
}
