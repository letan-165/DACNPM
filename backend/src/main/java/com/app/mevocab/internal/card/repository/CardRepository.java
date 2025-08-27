package com.app.mevocab.internal.card.repository;

import com.app.mevocab.internal.card.entity.Card;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CardRepository extends MongoRepository<Card, String> {
}
