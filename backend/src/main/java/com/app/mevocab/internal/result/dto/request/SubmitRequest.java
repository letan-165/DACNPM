package com.app.mevocab.internal.result.dto.request;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class SubmitRequest {
    String resultID;
    List<Submit> submits;
    @Data
    public static class Submit {
        Integer questionID;
        String answer;
    }
}
