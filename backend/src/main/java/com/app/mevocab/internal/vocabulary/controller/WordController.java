package com.app.mevocab.internal.vocabulary.controller;

import com.app.mevocab.common.ApiResponse;
import com.app.mevocab.internal.vocabulary.dto.request.WordRequest;
import com.app.mevocab.internal.vocabulary.entity.Word;
import com.app.mevocab.internal.vocabulary.service.WordService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/word")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE,makeFinal = true)
public class WordController {
    WordService wordService;

    @GetMapping("/public")
    ApiResponse<List<Word>> findAll(){
        return ApiResponse.<List<Word>>builder()
                .message("Lấy danh sách tu vung")
                .result(wordService.findAll())
                .build();
    }

    @GetMapping("/public/topic/{name}")
    ApiResponse<List<Word>> findAllByTopic(@PathVariable String name){
        return ApiResponse.<List<Word>>builder()
                .message("Lấy danh sách tu vung theo chu de "+name)
                .result(wordService.findAllByTopic(name))
                .build();
    }

    @PostMapping("/public/suggest")
    ApiResponse<Word> suggest(@RequestBody WordRequest request){
        return  ApiResponse.<Word>builder()
                .message("ý kiến từ vựng")
                .result(wordService.suggest(request,false))
                .build();
    }

    @PostMapping("/public/create")
    ApiResponse<Word> create(@RequestBody WordRequest request){
        return  ApiResponse.<Word>builder()
                .message("Lưu từ vựng")
                .result(wordService.suggest(request,true))
                .build();
    }

    @DeleteMapping("/public/{word}")
    ApiResponse<Boolean> deleteById(@PathVariable String word){
        wordService.deleteById(word);
        return ApiResponse.<Boolean>builder()
                .message("Xóa chủ đề")
                .result(true)
                .build();
    }

}
