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
import java.util.Objects;

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

    public List<Word> findAllByTopic(String topic) {
        if (!topicRepository.existsById(topic))
            throw new AppException(ErrorCode.TOPIC_NO_EXISTS);

        return wordRepository.findAllByTopic_Name(topic);
    }

    public Word suggest(WordRequest request, boolean isSave) {
        log.info(">>> API suggest called: word={}, topic={}, isSave={}",
                request.getWord(), request.getTopic(), isSave);

        // Kiểm tra từ có tồn tại trong DB chưa
        if (isSave && wordRepository.existsById(request.getWord())) {
            log.warn("Word '{}' already exists in DB", request.getWord());
            throw new AppException(ErrorCode.WORD_EXISTS);
        }

        // Kiểm tra topic
        var topic = topicRepository.findById(request.getTopic())
                .orElseThrow(() -> {
                    log.error("Topic '{}' does not exist", request.getTopic());
                    return new AppException(ErrorCode.TOPIC_NO_EXISTS);
                });
        log.info("Topic '{}' found for word '{}'", topic.getName(), request.getWord());

        // Gọi LingvaClient
        log.info("Calling LingvaClient for word='{}'", request.getWord());
        var lingvaResponse = lingvaClient.getTranslation(request.getWord());
        log.info("Lingva response for word='{}': {}", request.getWord(), lingvaResponse);

        // Gọi DictionaryClient
        List<DictionaryResponse> dictionaryResponse;
        try {
            log.info("Calling DictionaryClient for word='{}'", request.getWord());
            dictionaryResponse = dictionaryClient.getDictionary(request.getWord());
            log.info("Dictionary response size for word='{}': {}",
                    request.getWord(),
                    dictionaryResponse != null ? dictionaryResponse.size() : 0);
        } catch (Exception e) {
            log.error("DictionaryClient error for word='{}': {}", request.getWord(), e.getMessage(), e);
            throw new AppException(ErrorCode.VOCAB_INVALID);
        }

        // Xử lý kết quả dictionary
        String phonetic = "";
        String audio = "";

        if (dictionaryResponse != null && !dictionaryResponse.isEmpty()) {
            var dictionary = dictionaryResponse.get(0);

            for (var res : dictionary.getPhonetics()) {
                String t = res.getText();
                String a = res.getAudio();

                if (t != null && !t.isEmpty() && a != null && !a.isEmpty()) {
                    phonetic = t;
                    audio = a;
                    break;
                }
            }

            log.info("Phonetic='{}', Audio='{}' for word='{}'", phonetic, audio, request.getWord());

            var partOfSpeeches = dictionary.getMeanings().stream()
                    .map(DictionaryResponse.Meaning::getPartOfSpeech)
                    .toList();

            log.info("Part of speeches for word='{}': {}", request.getWord(), partOfSpeeches);

            // Build Word entity
            Word word = Word.builder()
                    .word(request.getWord())
                    .translation(lingvaResponse.getTranslation())
                    .topic(topic)
                    .phonetic(phonetic)
                    .audio(audio)
                    .partOfSpeeches(partOfSpeeches)
                    .build();

            if (isSave) {
                log.info("Saving new word '{}' into DB", word.getWord());
                word = wordRepository.save(word);
                log.info("Word '{}' saved successfully", word.getWord());
            }

            log.info("Suggest completed for word='{}'", word.getWord());
            return word;
        } else {
            log.error("Dictionary response is empty for word='{}'", request.getWord());
            throw new AppException(ErrorCode.VOCAB_INVALID);
        }
    }


    public void deleteById(String id) {
        if(!wordRepository.existsById(id))
            throw new AppException(ErrorCode.VOCAB_INVALID);

        wordRepository.deleteById(id);
    }

}
