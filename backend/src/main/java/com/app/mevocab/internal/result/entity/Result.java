package com.app.mevocab.internal.result.entity;

import com.app.mevocab.internal.quiz.dto.Question;
import com.app.mevocab.internal.quiz.entity.Quiz;
import com.app.mevocab.internal.result.dto.Answer;
import com.app.mevocab.internal.topic.entity.Topic;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.Instant;
import java.util.Map;

@Document
@Builder(toBuilder = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Result {
    @Id
    String resultID;
    Quiz quiz;
    String studentID;
    Map<Integer, Answer> answers;
    int totalQuestion;
    int totalCorrect;
    double score;
    Instant createAt;
    Instant finish;
}
