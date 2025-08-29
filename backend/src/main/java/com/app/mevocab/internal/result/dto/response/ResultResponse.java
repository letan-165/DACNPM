package com.app.mevocab.internal.result.dto.response;

import com.app.mevocab.internal.quiz.dto.response.QuizResponse;
import com.app.mevocab.internal.quiz.entity.Quiz;
import com.app.mevocab.internal.result.dto.Answer;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.Instant;
import java.util.List;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ResultResponse {
    String resultID;
    QuizResponse quiz;
    String studentID;
    List<Answer> answers;
    int totalQuestion;
    int totalCorrect;
    Double score;
    Instant createAt;
    Instant finish;
}
