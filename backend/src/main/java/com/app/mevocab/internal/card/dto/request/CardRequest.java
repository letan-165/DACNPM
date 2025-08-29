package com.app.mevocab.internal.card.dto.request;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CardRequest {
    String word;
    boolean memorized;
}
