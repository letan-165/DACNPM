package com.app.mevocab.common.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;

@Getter
@AllArgsConstructor
public enum ErrorCode {
    QUESTION_INVALID(1011,"Question invalid", HttpStatus.BAD_REQUEST),
    RESULT_NO_EXISTS(1010,"Result no exists", HttpStatus.BAD_REQUEST),
    QUIZ_NO_EXISTS(1009,"Quiz no exists", HttpStatus.BAD_REQUEST),
    VOCAB_INVALID(1008,"Vocabulary invalid", HttpStatus.BAD_REQUEST),
    TOPIC_NO_EXISTS(1007,"Topic no exists", HttpStatus.BAD_REQUEST),
    TOKEN_LOGOUT(1006,"Token had logout", HttpStatus.BAD_REQUEST),
    PASSWORD_INVALID(1005,"Password don't valid", HttpStatus.BAD_REQUEST),
    AUTHENTICATION(1004,"Token not authentication ", HttpStatus.UNAUTHORIZED),
    AUTHORIZED(1003,"You don't have permission", HttpStatus.FORBIDDEN),
    USER_EXISTS(1002,"User existed", HttpStatus.BAD_REQUEST),
    USER_NO_EXISTS(1001,"User not exists", HttpStatus.BAD_REQUEST),
    OTHER_ERROL(9999,"Other errol", HttpStatus.INTERNAL_SERVER_ERROR);

    int code;
    String message;
    HttpStatusCode httpStatus;
}
