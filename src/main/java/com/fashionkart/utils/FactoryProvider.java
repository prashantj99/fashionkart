package com.fashionkart.utils;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class FactoryProvider {
    private static final Logger logger = LoggerFactory.getLogger(FactoryProvider.class);
    private static SessionFactory factory;

    public static SessionFactory getSessionFactory() {
        if (factory == null) {
            try {
                factory = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
            } catch (HibernateException e) {
                logger.error("HibernateException occurred during SessionFactory creation", e);
                throw new RuntimeException("Failed to create sessionFactory object", e);
            } catch (Exception e) {
                logger.error("Exception occurred during SessionFactory creation", e);
                throw new RuntimeException("Unexpected error occurred", e);
            }
        }
        return factory;
    }
}
