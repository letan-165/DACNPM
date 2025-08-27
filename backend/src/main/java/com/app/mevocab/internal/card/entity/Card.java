package com.app.mevocab.internal.card.entity;

import com.app.mevocab.internal.vocabulary.entity.Word;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Card {
    @Id
    String cardID;
    String studentID;
    Word word;
    boolean isMemorized;
    String note;
}
