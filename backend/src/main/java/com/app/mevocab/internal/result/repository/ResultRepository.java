package com.app.mevocab.internal.result.repository;

import com.app.mevocab.internal.result.entity.Result;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ResultRepository extends MongoRepository<Result,String> {
    List<Result> findAllByStudentID(String studentID);
}
