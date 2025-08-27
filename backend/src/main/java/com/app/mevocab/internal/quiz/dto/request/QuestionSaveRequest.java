package com.app.mevocab.internal.quiz.dto.request;

import com.app.mevocab.common.enums.QuestionType;
import com.app.mevocab.internal.quiz.dto.Question;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class QuestionSaveRequest {
    String quizID;
    List<Question> questions;
}
