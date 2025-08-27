package com.app.mevocab.internal.quiz.repository;

import com.app.mevocab.internal.quiz.entity.Quiz;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface QuizRepository extends MongoRepository<Quiz,String> {
}
