package com.app.mevocab.internal.result.dto.request;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class JoinQuizRequest {
    String studentID;
    String quizID;
}
