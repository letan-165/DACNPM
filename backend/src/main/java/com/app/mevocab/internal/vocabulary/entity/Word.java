package com.app.mevocab.internal.vocabulary.entity;

import com.app.mevocab.internal.topic.entity.Topic;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Document
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Word {
    @Id
    String word;
    String translation;
    Topic topic;
    String phonetic;
    String audio;
    List<String> partOfSpeeches;
}
