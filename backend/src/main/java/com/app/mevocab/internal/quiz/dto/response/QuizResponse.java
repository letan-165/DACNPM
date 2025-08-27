package com.app.mevocab.internal.quiz.dto.response;

import com.app.mevocab.common.enums.QuestionType;
import com.app.mevocab.internal.quiz.dto.Question;
import com.app.mevocab.internal.topic.entity.Topic;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.Instant;
import java.util.List;

@Document
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class QuizResponse {
    String quizID;
    Topic topic;
    String title;
    List<Question> questions;
    Instant updateAt;
}
