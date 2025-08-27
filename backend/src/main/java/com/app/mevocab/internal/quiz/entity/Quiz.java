package com.app.mevocab.internal.quiz.entity;

import com.app.mevocab.internal.quiz.dto.Question;
import com.app.mevocab.internal.topic.entity.Topic;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.Instant;
import java.util.Map;

@Document
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Quiz {
    @Id
    String quizID;
    Topic topic;
    String title;
    Map<Integer,Question> questions;
    Instant updateAt;
}
