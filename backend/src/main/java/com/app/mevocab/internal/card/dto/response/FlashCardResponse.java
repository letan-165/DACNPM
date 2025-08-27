package com.app.mevocab.internal.card.dto.response;

import com.app.mevocab.internal.card.dto.Card;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class FlashCardResponse {
    String studentID;
    List<Card> cards;
}
