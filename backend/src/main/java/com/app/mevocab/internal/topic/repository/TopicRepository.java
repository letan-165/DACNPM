package com.app.mevocab.internal.topic.repository;

import com.app.mevocab.internal.topic.entity.Topic;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TopicRepository extends MongoRepository<Topic,String> {
}
