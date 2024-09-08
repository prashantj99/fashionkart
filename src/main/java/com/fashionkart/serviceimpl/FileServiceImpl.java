package com.fashionkart.serviceimpl;

import com.fashionkart.service.FileService;
import com.fashionkart.utils.FirebaseStorageUtil;

import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class FileServiceImpl implements FileService {
    @Override
    public List<String> handleFileUploads(Collection<Part> fileParts) throws IOException {
        List<String> imageUrls = new ArrayList<>();
        for (Part filePart : fileParts) {
            if (filePart.getContentType() != null && filePart.getContentType().startsWith("image/")) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                try (InputStream inputStream = filePart.getInputStream()) {
                    String imageUrl = FirebaseStorageUtil.uploadFile(fileName, inputStream);
                    imageUrls.add(imageUrl);
                }
            }
        }
        return imageUrls;
    }
}
