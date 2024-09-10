package com.fashionkart.serviceimpl;

import com.fashionkart.entities.Token;
import com.fashionkart.entities.User;
import com.fashionkart.repository.TokenRepository;
import com.fashionkart.repository.UserRepository;
import com.fashionkart.repositoryimpl.TokenRepositoryImpl;
import com.fashionkart.repositoryimpl.UserRepositoryImpl;
import com.fashionkart.service.UserService;
import com.fashionkart.utils.PasswordUtil;

import java.util.List;
import java.util.Optional;

public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final TokenRepository tokenRepository;

    public UserServiceImpl() {
        this.userRepository = new UserRepositoryImpl();
        this.tokenRepository = new TokenRepositoryImpl();
    }

    @Override
    public void updateUser(User user) {
        userRepository.update(user);
    }

    @Override
    public User registerUser(User user) {
        return userRepository.save(user);
    }

    @Override
    public User authenticate(String email, String password) {
        return userRepository.findByEmailAndPassword(email, password)
                .filter(user -> PasswordUtil.checkPassword(password, user.getPassword()))
                .orElseThrow(() -> new RuntimeException("Invalid credentials"));
    }

    @Override
    public User getUserById(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found"));
    }

    @Override
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @Override
    public void deleteUser(Long id) {
        User user = getUserById(id);
        userRepository.delete(user);
    }

    @Override
    public boolean isUsernameTaken(String username) {
        return userRepository.findByUsername(username) != null;
    }

    @Override
    public Optional<User> findByUsername(String username) {
        return Optional.ofNullable(userRepository.findByUsername(username));
    }

    @Override
    public Optional<User> findByEmailAndPassword(String email, String password) {
        return userRepository.findByEmailAndPassword(email, password);
    }
    @Override
    public Optional<User> findByUsernameAndPassword(String username, String password) {
        return userRepository.findByUsernameAndPassword(username, password);
    }

    @Override
    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public boolean saveToken(Token token) {
        tokenRepository.save(token);
        return true;
    }

    @Override
    public Optional<Token> findTokenByValue(String tokenValue) {
        return tokenRepository.findByToken(tokenValue);
    }

    @Override
    public void deleteToken(Token token) {
        tokenRepository.delete(token);
    }

    @Override
    public Optional<Token> findTokenByUser(User user) {
        return tokenRepository.findByUser(user);
    }
    @Override
    public void updateProfileImage(Long userId, String newImageUrl) {
        User user = userRepository.findById(userId).orElseThrow(()-> new RuntimeException("User Not Found"));
        user.setImage(newImageUrl);
        userRepository.update(user);
    }
}
