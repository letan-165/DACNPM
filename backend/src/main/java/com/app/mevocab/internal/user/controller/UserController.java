package com.app.mevocab.internal.user.controller;


import com.app.mevocab.common.ApiResponse;
import com.app.mevocab.internal.user.dto.request.UserSignUpRequest;
import com.app.mevocab.internal.user.dto.response.UserResponse;
import com.app.mevocab.internal.user.service.UserService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE,makeFinal = true)
public class UserController {
    UserService userService;

    @GetMapping
    ApiResponse<List<UserResponse>> findAll(){
        return ApiResponse.<List<UserResponse>>builder()
                .result(userService.findAll())
                .build();
    }

    @GetMapping("/public/id/{userID}")
    ApiResponse<UserResponse> findByID(@PathVariable String userID){
        return ApiResponse.<UserResponse>builder()
                .message("Tìm người dùng dựa vào ID:  "+userID)
                .result(userService.findById(userID))
                .build();
    }

    @GetMapping("/public/name/{name}")
    ApiResponse<UserResponse> findByName(@PathVariable String name){
        return ApiResponse.<UserResponse>builder()
                .message("Tìm người dùng dựa vào tên: "+name)
                .result(userService.findByName(name))
                .build();
    }

}
