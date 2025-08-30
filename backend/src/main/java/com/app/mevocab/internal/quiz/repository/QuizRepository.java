package com.app.mevocab.internal.quiz.repository;

import com.app.mevocab.internal.quiz.entity.Quiz;
import com.app.mevocab.internal.vocabulary.entity.Word;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuizRepository extends MongoRepository<Quiz,String> {
    List<Quiz> findAllByTopic_Name(String topic);
}
