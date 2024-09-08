package com.fashionkart.repositoryimpl;

import com.fashionkart.entities.Token;
import com.fashionkart.entities.User;
import com.fashionkart.repository.TokenRepository;
import com.fashionkart.utils.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.Optional;

public class TokenRepositoryImpl implements TokenRepository {

    @Override
    public Token save(Token token) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            if (token.getId() == null) {
                session.persist(token); // Use persist for new entities
            } else {
                session.merge(token); // Use merge for existing entities
            }
            tx.commit();
            return token;
        }
    }

    @Override
    public Optional<Token> findByToken(String token) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("FROM Token WHERE token = :token", Token.class)
                    .setParameter("token", token)
                    .uniqueResultOptional();
        }
    }

    @Override
    public void delete(Token token) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            Token tokenToDelete = session.contains(token) ? token : session.merge(token);
            session.delete(tokenToDelete);
            tx.commit();
        }
    }

    @Override
    public Optional<Token> findByUser(User user) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("FROM Token WHERE user = :user", Token.class)
                    .setParameter("user", user)
                    .uniqueResultOptional();
        }
    }
}
