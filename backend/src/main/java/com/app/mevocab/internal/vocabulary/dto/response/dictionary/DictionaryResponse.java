package com.app.mevocab.internal.vocabulary.dto.response.dictionary;

import lombok.*;

import java.util.List;

@Data
public class DictionaryResponse {
    String word;
    List<Phonetic> phonetics;
    List<Meaning> meanings;

    @Data
    public static class Phonetic {
        String text;
        String audio;
    }

    @Data
    public static class Meaning {
        String partOfSpeech;
        List<Definition> definitions;
    }

    @Data
    public static class Definition {
        String definition;
    }
}
