package com.app.mevocab.internal.quiz.dto;

import com.app.mevocab.common.enums.QuestionType;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.HashSet;
import java.util.List;
@Builder(toBuilder = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Question {
    Integer questionID;
    String title;
    QuestionType type;
    List<String> options;
    String correct;

    public boolean checkQuestion() {
        if (type.equals(QuestionType.ENTER)) {
            int count = title.split("=@=", -1).length - 1;
            return count == 1;
        } else {
            return options != null && options.contains(correct);
        }
    }
}
