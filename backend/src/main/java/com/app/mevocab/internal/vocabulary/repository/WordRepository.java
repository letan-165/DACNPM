package com.app.mevocab.internal.vocabulary.repository;

import com.app.mevocab.internal.vocabulary.entity.Word;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WordRepository extends MongoRepository<Word, String> {
    List<Word> findAllByTopic_Name(String topic);
}
