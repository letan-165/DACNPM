package com.app.mevocab.internal.user.repository;

import com.app.mevocab.internal.user.entity.User;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends MongoRepository<User,String> {
    Optional<User> findByUsername(String name);
    boolean existsByUsername(String name);
}
