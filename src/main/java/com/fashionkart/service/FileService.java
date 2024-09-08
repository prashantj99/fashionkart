package com.fashionkart.service;

import javax.servlet.http.Part;
import java.io.IOException;
import java.util.Collection;
import java.util.List;

public interface FileService {
    List<String> handleFileUploads(Collection<Part> fileParts) throws IOException;
}
