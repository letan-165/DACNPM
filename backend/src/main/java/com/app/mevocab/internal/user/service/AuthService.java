package com.app.mevocab.internal.user.service;

import com.app.mevocab.common.enums.UserRole;
import com.app.mevocab.common.exception.AppException;
import com.app.mevocab.common.exception.ErrorCode;
import com.app.mevocab.internal.user.dto.request.LoginRequest;
import com.app.mevocab.internal.user.dto.request.TokenRequest;
import com.app.mevocab.internal.user.dto.request.UserSignUpRequest;
import com.app.mevocab.internal.user.dto.response.LoginResponse;
import com.app.mevocab.internal.user.dto.response.UserResponse;
import com.app.mevocab.internal.user.entity.User;
import com.app.mevocab.internal.user.mapper.UserMapper;
import com.app.mevocab.internal.user.repository.UserRepository;
import com.nimbusds.jose.*;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jose.crypto.MACVerifier;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE,makeFinal = true)
public class AuthService {

    @NonFinal
    @Value("${key.jwt.value}")
    String KEY;

    @NonFinal
    @Value("${app.time.expiryTime}")
    int expiryTime;

    UserRepository userRepository;
    UserMapper userMapper;
    PasswordEncoder passwordEncoder;


    public UserResponse signUp(UserSignUpRequest request) {
        if(userRepository.existsByName(request.getName()))
            throw new AppException(ErrorCode.USER_EXISTS);

        User user = userMapper.toUser(request);
        user.setRole(UserRole.STUDENT);
        user.setPassword(passwordEncoder.encode(request.getPassword()));

        return userMapper.toUserResponse(
                userRepository.save(user));
    }

    public LoginResponse login(LoginRequest request) throws JOSEException {
        User user = userRepository.findByName(request.getUsername())
                .orElseThrow(()-> new AppException(ErrorCode.USER_NO_EXISTS));

        boolean check = passwordEncoder.matches(request.getPassword(), user.getPassword());

        if(!check)
            throw new AppException(ErrorCode.PASSWORD_INVALID);

        return LoginResponse.builder()
                .userID(user.getUserID())
                .name(user.getName())
                .token(generate(user))
                .build();
    }

    public String findNameByToken(String token) {
        String name = null;
        try {
            SignedJWT signedJWT = SignedJWT.parse(token);
            name = signedJWT.getJWTClaimsSet().getSubject();
        } catch (ParseException e) {
            throw new AppException(ErrorCode.AUTHENTICATION);
        }

        if(!userRepository.existsByName(name))
            throw new AppException(ErrorCode.USER_NO_EXISTS);

        return name;
    }

    public Boolean instropect(TokenRequest request) throws ParseException, JOSEException {
        SignedJWT jwt = SignedJWT.parse(request.getToken());
        var expiryTime = jwt.getJWTClaimsSet().getExpirationTime();
        JWSVerifier jwsVerifier = new MACVerifier(KEY.getBytes());

        boolean isVerify = jwt.verify(jwsVerifier);
        boolean isTime = expiryTime.after(Date.from(Instant.now()));

        if(!isVerify || !isTime )
            throw new AppException(ErrorCode.AUTHENTICATION);

        return true;
    }

    String generate(User user) throws JOSEException {
        JWTClaimsSet jwtClaimsSet = new JWTClaimsSet.Builder()
                .jwtID(UUID.randomUUID().toString())
                .issuer("MEVOCAB")
                .subject(user.getName())
                .issueTime(Date.from(Instant.now()))
                .expirationTime(Date.from(Instant.now().plus(expiryTime,ChronoUnit.SECONDS)))
                .claim("scope", user.getRole())
                .build();

        JWSHeader jwsHeader = new JWSHeader(JWSAlgorithm.HS256);
        Payload payload = new Payload(jwtClaimsSet.toJSONObject());
        JWSObject jwsObject = new JWSObject(jwsHeader,payload);
        jwsObject.sign(new MACSigner(KEY.getBytes()));

        return jwsObject.serialize();
    }
}
