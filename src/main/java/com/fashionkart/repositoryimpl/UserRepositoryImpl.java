package com.fashionkart.repositoryimpl;

import com.fashionkart.entities.User;
import com.fashionkart.repository.UserRepository;
import com.fashionkart.utils.FactoryProvider;
import com.fashionkart.utils.PasswordUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;
import java.util.Optional;

public class UserRepositoryImpl implements UserRepository {

    @Override
    public User save(User user) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.persist(user);
            tx.commit();
            return user;
        }
    }

    @Override
    public void update(User user) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.merge(user);
            tx.commit();
        }
    }

    @Override
    public Optional<User> findById(Long id) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return Optional.ofNullable(session.find(User.class, id));
        }
    }

    @Override
    public Optional<User> findByEmailAndPassword(String email, String password) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Optional<User> userOptional = session.createQuery("FROM User WHERE email = :email", User.class)
                    .setParameter("email", email)
                    .uniqueResultOptional();
            if (userOptional.isPresent()) {
                User user = userOptional.get();
                if(PasswordUtil.checkPassword(password, user.getPassword())){
                    System.out.println(user.getEmail());
                    return Optional.of(user);
                }
            }
            return Optional.empty();
        }
    }

    @Override
    public Optional<User> findByUsernameAndPassword(String username, String password) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Optional<User> userOptional = session.createQuery("FROM User WHERE username = :username", User.class)
                    .setParameter("username", username)
                    .uniqueResultOptional();
            if (userOptional.isPresent()) {
                User user = userOptional.get();
                if(PasswordUtil.checkPassword(password, user.getPassword())){
                    return Optional.of(user);
                }
            }
            return Optional.empty();
        }
    }

    @Override
    public Optional<User> findByEmail(String email) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("FROM User WHERE email = :email", User.class)
                    .setParameter("email", email)
                    .uniqueResultOptional();
        }
    }

    @Override
    public List<User> findAll() {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("FROM User", User.class).list();
        }
    }

    @Override
    public void delete(User user) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.remove(session.contains(user) ? user : session.merge(user)); // Remove or merge the user before removing
            tx.commit();
        }
    }

    @Override
    public User findByUsername(String username) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("FROM User WHERE username = :username", User.class)
                    .setParameter("username", username)
                    .uniqueResult();
        }
    }
}
