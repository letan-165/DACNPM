package com.app.mevocab.internal.vocabulary.controller;

import com.app.mevocab.common.ApiResponse;
import com.app.mevocab.internal.vocabulary.dto.request.WordRequest;
import com.app.mevocab.internal.vocabulary.entity.Word;
import com.app.mevocab.internal.vocabulary.service.WordService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/word")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE,makeFinal = true)
public class WordController {
    WordService wordService;

    @PostMapping
    ApiResponse<Word> save(@RequestBody WordRequest request){
        return  ApiResponse.<Word>builder()
                .message("Lưu từ vựng")
                .result(wordService.save(request))
                .build();
    }
}
