package com.app.mevocab.internal.topic.service;

import com.app.mevocab.common.exception.AppException;
import com.app.mevocab.common.exception.ErrorCode;
import com.app.mevocab.internal.topic.entity.Topic;
import com.app.mevocab.internal.topic.repository.TopicRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class TopicService {
    TopicRepository topicRepository;

    public List<Topic> findAll(){
        return topicRepository.findAll();
    }

    public Topic save(Topic topic){
        return topicRepository.save(topic);
    }

    public void deleteById(String id){
        if(!topicRepository.existsById(id))
            throw new AppException(ErrorCode.TOPIC_NO_EXISTS);

        topicRepository.deleteById(id);
    }
}
