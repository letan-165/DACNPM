package com.app.mevocab.internal.vocabulary.repository;

import com.app.mevocab.internal.vocabulary.entity.Word;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WordRepository extends MongoRepository<Word, String> {
}
