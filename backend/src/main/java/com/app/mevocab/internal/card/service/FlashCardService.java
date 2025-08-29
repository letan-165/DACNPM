package com.app.mevocab.internal.card.service;

import com.app.mevocab.common.exception.AppException;
import com.app.mevocab.common.exception.ErrorCode;
import com.app.mevocab.internal.card.dto.Card;
import com.app.mevocab.internal.card.dto.request.CardSaveRequest;
import com.app.mevocab.internal.card.dto.response.FlashCardResponse;
import com.app.mevocab.internal.card.entity.FlashCard;
import com.app.mevocab.internal.card.repository.FlashCardRepository;
import com.app.mevocab.internal.user.repository.UserRepository;
import com.app.mevocab.internal.user.service.UserService;
import com.app.mevocab.internal.vocabulary.entity.Word;
import com.app.mevocab.internal.vocabulary.repository.WordRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE,makeFinal = true)
@Slf4j
public class FlashCardService {
    FlashCardRepository flashCardRepository;
    UserRepository userRepository;
    WordRepository wordRepository;

    public FlashCardResponse toFlashCardResponse (FlashCard flashCard){
        return FlashCardResponse.builder()
                .studentID(flashCard.getStudentID())
                .cards(flashCard.getCards().values().stream().toList())
                .build();
    }

    public FlashCard findByStudentID(String studentID){
        if(!userRepository.existsById(studentID))
            throw new AppException(ErrorCode.USER_NO_EXISTS);

        return flashCardRepository.findById(studentID)
                .orElse(flashCardRepository.save(FlashCard.builder()
                        .studentID(studentID)
                        .cards(new HashMap<>())
                        .build()));
    }

    public FlashCardResponse save(CardSaveRequest request){
        String studentID = request.getStudentID();
        FlashCard flashCard = findByStudentID(request.getStudentID());

        for (var card : request.getCards()) {
            Word word = wordRepository.findById(card.getWord())
                    .orElseThrow(()-> new AppException(ErrorCode.VOCAB_INVALID));

            Card cardU = Card.builder()
                    .word(word)
                    .isMemorized(card.isMemorized())
                    .build();

            flashCard.getCards().put(word.getWord(), cardU);
        }

        return toFlashCardResponse(flashCardRepository.save(flashCard));
    }

}
