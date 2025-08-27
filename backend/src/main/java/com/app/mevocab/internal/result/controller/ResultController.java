package com.app.mevocab.internal.result.controller;

import com.app.mevocab.common.ApiResponse;
import com.app.mevocab.internal.result.dto.request.JoinQuizRequest;
import com.app.mevocab.internal.result.dto.request.SubmitRequest;
import com.app.mevocab.internal.result.dto.response.ResultResponse;
import com.app.mevocab.internal.result.service.ResultService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/result")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ResultController {
    ResultService resultService;

    @GetMapping("/public/{studentID}")
    ApiResponse<List<ResultResponse>> findAllByStudentID(@PathVariable String studentID) {
        return ApiResponse.<List<ResultResponse>>builder()
                .result(resultService.findAllByStudentID(studentID))
                .build();
    }

    @PostMapping("/public/join")
    ApiResponse<ResultResponse> join(@RequestBody JoinQuizRequest request) {
        return ApiResponse.<ResultResponse>builder()
                .result(resultService.join(request))
                .build();
    }

    @PostMapping("/public/submit")
    ApiResponse<ResultResponse> submit(@RequestBody SubmitRequest request) {
        return ApiResponse.<ResultResponse>builder()
                .result(resultService.submit(request))
                .build();
    }

    @PostMapping("/public/{resultID}/finish")
    ApiResponse<ResultResponse> finish(@PathVariable String resultID) {
        return ApiResponse.<ResultResponse>builder()
                .result(resultService.finish(resultID))
                .build();
    }
}
