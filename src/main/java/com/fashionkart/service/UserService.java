package com.fashionkart.service;

import com.fashionkart.entities.Token;
import com.fashionkart.entities.User;

import java.util.List;
import java.util.Optional;

public interface UserService {
    void updateUser(User user);
    User registerUser(User user);
    User authenticate(String email, String password);
    User getUserById(Long id);
    List<User> getAllUsers();
    void deleteUser(Long id);
    boolean isUsernameTaken(String username);
    Optional<User> findByUsername(String username);
    Optional<User> findByEmailAndPassword(String email, String password);
    Optional<User> findByEmail(String email);
    boolean saveToken(Token token);
    Optional<Token> findTokenByValue(String tokenValue);
    void deleteToken(Token token);
    Optional<Token> findTokenByUser(User user);
    Optional<User> findByUsernameAndPassword(String username, String password);
    void updateProfileImage(Long userId, String newImageUrl);
}
