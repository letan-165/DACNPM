package com.app.mevocab.internal.user.mapper;


import com.app.mevocab.internal.user.dto.request.UserSignUpRequest;
import com.app.mevocab.internal.user.dto.response.UserResponse;
import com.app.mevocab.internal.user.entity.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface UserMapper {
    @Mapping(target = "role", ignore = true)
    User toUser(UserSignUpRequest request);
    UserResponse toUserResponse(User user);

}
