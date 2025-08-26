package com.app.mevocab.internal.user.service;

import com.app.mevocab.common.enums.UserRole;
import com.app.mevocab.common.exception.AppException;
import com.app.mevocab.common.exception.ErrorCode;
import com.app.mevocab.internal.user.dto.request.UserSignUpRequest;
import com.app.mevocab.internal.user.dto.response.UserResponse;
import com.app.mevocab.internal.user.entity.User;
import com.app.mevocab.internal.user.mapper.UserMapper;
import com.app.mevocab.internal.user.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE,makeFinal = true)
@Slf4j
public class UserService {
    UserRepository userRepository;
    UserMapper userMapper;

    public List<UserResponse> findAll(){
        return userRepository.findAll().stream()
                .map(userMapper::toUserResponse)
                .toList();
    }

    public UserResponse findById(String userID) {
        User user = userRepository.findById(userID)
                .orElseThrow(()->new AppException(ErrorCode.USER_NO_EXISTS));
        return userMapper.toUserResponse(user);
    }

    public UserResponse findByName(String name) {
        User user = userRepository.findByUsername(name)
                .orElseThrow(()->new AppException(ErrorCode.USER_NO_EXISTS));
        return userMapper.toUserResponse(user);
    }
}
