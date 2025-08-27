package com.app.mevocab.internal.card.dto;

import com.app.mevocab.internal.vocabulary.entity.Word;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Card {
    Word word;
    Boolean isMemorized;
    String note;
}
