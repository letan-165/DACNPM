package com.app.mevocab.internal;

import com.app.mevocab.common.ApiResponse;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PingController {
    @GetMapping("/ping")
    ApiResponse<Boolean> ping(){
        return ApiResponse.<Boolean>builder()
                .message("pong")
                .result(true)
                .build();
    }
}
