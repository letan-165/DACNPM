package com.app.mevocab.internal.card.entity;

import com.app.mevocab.internal.card.dto.Card;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;
import java.util.Map;

@Document
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class FlashCard{
    @Id
    String studentID;
    Map<String,Card> cards;
}
