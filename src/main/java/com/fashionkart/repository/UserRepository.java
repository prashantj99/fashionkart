package com.fashionkart.repository;

import com.fashionkart.entities.User;

import java.util.List;
import java.util.Optional;

public interface UserRepository {
    User save(User user);
    void update(User user);
    Optional<User> findById(Long id);
    Optional<User> findByEmail(String email);
    Optional<User> findByEmailAndPassword(String email, String password);
    List<User> findAll();
    void delete(User user);
    User findByUsername(String username);

    Optional<User> findByUsernameAndPassword(String username, String password);
}
