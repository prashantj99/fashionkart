package com.fashionkart.repositoryimpl;

import com.fashionkart.entities.ProductImage;
import com.fashionkart.repository.ProductImageRepository;
import com.fashionkart.utils.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class ProductImageRepositoryImpl implements ProductImageRepository {

    @Override
    public ProductImage save(ProductImage productImage) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            if (productImage.getId() == null) {
                session.persist(productImage);
            } else {
                session.merge(productImage);
            }
            tx.commit();
            return productImage;
        }
    }
}
