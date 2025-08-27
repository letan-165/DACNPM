package com.app.mevocab.internal.quiz.controller;

import com.app.mevocab.common.ApiResponse;
import com.app.mevocab.internal.quiz.dto.request.QuestionDeleteRequest;
import com.app.mevocab.internal.quiz.dto.request.QuestionSaveRequest;
import com.app.mevocab.internal.quiz.dto.request.QuizSaveRequest;
import com.app.mevocab.internal.quiz.dto.response.QuizResponse;
import com.app.mevocab.internal.quiz.service.QuizService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/quiz")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class QuizController {
    QuizService quizService;

    @GetMapping("/public")
    ApiResponse<List<QuizResponse>> findAll() {
        return ApiResponse.<List<QuizResponse>>builder()
                .result(quizService.findAll())
                .build();
    }

    @PostMapping("/public/save")
    ApiResponse<QuizResponse> save(@RequestBody QuizSaveRequest request) {
        return ApiResponse.<QuizResponse>builder()
                .result(quizService.save(request))
                .build();
    }

    @DeleteMapping("/public/delete/{quizID}")
    ApiResponse<Boolean> delete(@PathVariable String quizID) {
        quizService.delete(quizID);
        return ApiResponse.<Boolean>builder()
                .result(true)
                .build();
    }

    @PostMapping("/public/questions/save")
    ApiResponse<List<Integer>> saveQuestions(@RequestBody QuestionSaveRequest request) {
        return ApiResponse.<List<Integer>>builder()
                .result(quizService.saveQuestions(request))
                .build();
    }

    @DeleteMapping("/public/questions/delete")
    ApiResponse<List<Integer>> deleteQuestions(@RequestBody QuestionDeleteRequest request) {
        return ApiResponse.<List<Integer>>builder()
                .result(quizService.deleteQuestions(request))
                .build();
    }
}
