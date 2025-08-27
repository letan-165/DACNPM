package com.app.mevocab.internal.quiz.dto.request;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class QuizSaveRequest {
    String quizID;
    String topic;
    String title;
}
