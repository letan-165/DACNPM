package com.app.mevocab.internal.result.dto;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Answer {
    Integer answerID;
    String answer;
    boolean correct;
}
