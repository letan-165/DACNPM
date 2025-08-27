package com.app.mevocab.internal.vocabulary.service;

import com.app.mevocab.common.exception.AppException;
import com.app.mevocab.common.exception.ErrorCode;
import com.app.mevocab.internal.topic.repository.TopicRepository;
import com.app.mevocab.internal.vocabulary.dto.request.WordRequest;
import com.app.mevocab.internal.vocabulary.dto.response.DictionaryResponse;
import com.app.mevocab.internal.vocabulary.entity.Word;
import com.app.mevocab.internal.vocabulary.repository.Client.DictionaryClient;
import com.app.mevocab.internal.vocabulary.repository.Client.LingvaClient;
import com.app.mevocab.internal.vocabulary.repository.WordRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE,makeFinal = true)
@Slf4j
public class WordService {
    WordRepository wordRepository;
    LingvaClient lingvaClient;
    DictionaryClient dictionaryClient;
    TopicRepository topicRepository;

    public List<Word> findAll() {
        return wordRepository.findAll();
    }

    public Word suggest(WordRequest request, boolean isSave){
        var topic = topicRepository.findById(request.getTopic())
                        .orElseThrow(()->new AppException(ErrorCode.TOPIC_NO_EXISTS));

        var lingvaResponse = lingvaClient.getTranslation(request.getWord());
        List<DictionaryResponse> dictionaryResponse = null;
        try {
            dictionaryResponse = dictionaryClient.getDictionary(request.getWord());
        } catch (Exception e) {
            throw new AppException(ErrorCode.VOCAB_INVALID);
        }

        String phonetic = "";
        String audio = "";

        var dictionary =  dictionaryResponse.get(0);
        for (var res : dictionary.getPhonetics()) {
            if (res.getText()!=null && res.getAudio()!=null) {
                phonetic = res.getText();
                audio = res.getAudio();
                break;
            }
        }

        var partOfSpeeches = dictionary.getMeanings().stream()
                .map(DictionaryResponse.Meaning::getPartOfSpeech)
                .toList();

        Word word = Word.builder()
                .word(request.getWord())
                .translation(lingvaResponse.getTranslation())
                .topic(topic)
                .phonetic(phonetic)
                .audio(audio)
                .partOfSpeeches(partOfSpeeches)
                .build();

        if(isSave)
            word = wordRepository.save(word);

        return word;
    }

    public void deleteById(String id) {
        if(!wordRepository.existsById(id))
            throw new AppException(ErrorCode.VOCAB_INVALID);

        wordRepository.deleteById(id);
    }

}
