package com.fashionkart.repositoryimpl;

import com.fashionkart.repository.SalesRepository;
import com.fashionkart.utils.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SalesRepositoryImpl implements SalesRepository {

    @Override
    public Map<String, Integer> getProductsSoldPerMonth() {
        Map<String, Integer> productsSoldPerMonth = new HashMap<>();

        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            // This is a sample query; adjust it based on your actual schema
            String hql = "SELECT EXTRACT(MONTH FROM o.orderDate) as month, COUNT(o.id) as count " +
                         "FROM UserOrder o " +
                         "GROUP BY EXTRACT(MONTH FROM o.orderDate) ";

            Query<Object[]> query = session.createQuery(hql, Object[].class);

            List<Object[]> results = query.getResultList();
            for (Object[] result : results) {
                int month = ((Number) result[0]).intValue();
                long count = ((Number) result[1]).longValue();
                productsSoldPerMonth.put(monthToString(month), (int) count);
            }
        }

        return productsSoldPerMonth;
    }

    private String monthToString(int month) {
        switch (month) {
            case 1: return "January";
            case 2: return "February";
            case 3: return "March";
            case 4: return "April";
            case 5: return "May";
            case 6: return "June";
            case 7: return "July";
            case 8: return "August";
            case 9: return "September";
            case 10: return "October";
            case 11: return "November";
            case 12: return "December";
            default: return "Unknown";
        }
    }
}
