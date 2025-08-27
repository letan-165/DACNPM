package com.app.mevocab.internal.vocabulary.service;

import com.app.mevocab.internal.vocabulary.dto.request.WordRequest;
import com.app.mevocab.internal.vocabulary.entity.Word;
import com.app.mevocab.internal.vocabulary.repository.Client.DictionaryClient;
import com.app.mevocab.internal.vocabulary.repository.Client.LingvaClient;
import com.app.mevocab.internal.vocabulary.repository.WordRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE,makeFinal = true)
@Slf4j
public class WordService {
    WordRepository wordRepository;
    LingvaClient lingvaClient;
    DictionaryClient dictionaryClient;

    public Word save(WordRequest request){
        log.info("LingvaClient: {}", lingvaClient.getTranslation(request.getWord()));
        log.info("DictionaryClient: {}",dictionaryClient.getDictionary(request.getWord()));
        return  null;
    }

}
