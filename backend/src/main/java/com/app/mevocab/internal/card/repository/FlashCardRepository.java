package com.app.mevocab.internal.card.repository;

import com.app.mevocab.internal.card.entity.FlashCard;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FlashCardRepository extends MongoRepository<FlashCard, String> {
}
