package com.app.mevocab.internal.card.controller;

import com.app.mevocab.common.ApiResponse;
import com.app.mevocab.internal.card.dto.request.CardSaveRequest;
import com.app.mevocab.internal.card.dto.response.FlashCardResponse;
import com.app.mevocab.internal.card.entity.FlashCard;
import com.app.mevocab.internal.card.service.FlashCardService;
import com.app.mevocab.internal.topic.entity.Topic;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/flashcard")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE,makeFinal = true)
public class FlashCardController {
    FlashCardService flashCardService;

    @GetMapping("/public/{studentID}")
    ApiResponse<FlashCardResponse> findByStudentID(@PathVariable String studentID){
        return ApiResponse.<FlashCardResponse>builder()
                .message("Lay the cuar hoc sinh")
                .result(flashCardService.toFlashCardResponse(flashCardService.findByStudentID(studentID)))
                .build();
    }

    @GetMapping("/public/unmemorized/{studentID}")
    ApiResponse<FlashCardResponse> findUnmemorizedCards(@PathVariable String studentID){
        return ApiResponse.<FlashCardResponse>builder()
                .message("Lay the cuar hoc sinh")
                .result(flashCardService.findUnmemorizedCards(studentID))
                .build();
    }

    @PostMapping("/public/save")
    ApiResponse<FlashCardResponse> save(@RequestBody CardSaveRequest request){
        return ApiResponse.<FlashCardResponse>builder()
                .message("Luu the hoc sinh")
                .result(flashCardService.save(request))
                .build();
    }
}
