package com.fashionkart.repository;

import com.fashionkart.entities.Token;
import com.fashionkart.entities.User;

import java.util.Optional;

public interface TokenRepository {
    Token save(Token token);
    Optional<Token> findByToken(String token);
    void delete(Token token);
    Optional<Token> findByUser(User user);
}
