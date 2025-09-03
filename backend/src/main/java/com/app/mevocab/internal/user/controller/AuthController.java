package com.app.mevocab.internal.user.controller;

import com.app.mevocab.common.ApiResponse;
import com.app.mevocab.internal.user.dto.request.LoginRequest;
import com.app.mevocab.internal.user.dto.request.TokenRequest;
import com.app.mevocab.internal.user.dto.request.UserSignUpRequest;
import com.app.mevocab.internal.user.dto.response.LoginResponse;
import com.app.mevocab.internal.user.dto.response.UserResponse;
import com.app.mevocab.internal.user.service.AuthService;
import com.nimbusds.jose.JOSEException;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.ParseException;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE,makeFinal = true)
public class AuthController {
    AuthService authService;

    @PostMapping("/public/signup")
    ApiResponse<UserResponse> signUp(@RequestBody UserSignUpRequest request){
        return ApiResponse.<UserResponse>builder()
                .message("Đăng kí người dùng: "+request.getName())
                .result(authService.signUp(request))
                .build();
    }

    @PostMapping("/public/login")
    ApiResponse<LoginResponse> login(@RequestBody LoginRequest request) throws JOSEException {
        return ApiResponse.<LoginResponse>builder()
                .message("Xác nhận đăng nhập tài khoản: "+request.getUsername())
                .result(authService.login(request))
                .build();
    }

    @PostMapping("/instropect")
    public ApiResponse<Boolean> instropect(@RequestBody TokenRequest request) throws ParseException, JOSEException {
        return ApiResponse.<Boolean>builder()
                .result(authService.instropect(request))
                .build();
    }

}
