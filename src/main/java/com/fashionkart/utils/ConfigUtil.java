package com.fashionkart.utils;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ConfigUtil {

    private static final Logger logger = LoggerFactory.getLogger(ConfigUtil.class);
    private static final Properties properties = new Properties();

    static {
        try {
            FileInputStream fileInputStream = new FileInputStream("D:\\credentials.properties");
            properties.load(fileInputStream);
            fileInputStream.close();
            logger.info("Configuration file loaded successfully.");
        } catch (IOException e) {
            logger.error("Error loading configuration file", e);
        }
    }

    public static String getProperty(String key) {
        return properties.getProperty(key);
    }
}
