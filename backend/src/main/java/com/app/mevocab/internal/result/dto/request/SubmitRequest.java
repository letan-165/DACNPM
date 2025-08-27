package com.app.mevocab.internal.result.dto.request;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class SubmitRequest {
    String resultID;
    Integer questionID;
    String answer;
}
