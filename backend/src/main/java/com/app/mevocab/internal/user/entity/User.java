package com.app.mevocab.internal.user.entity;


import com.app.mevocab.common.enums.UserRole;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class User {
    @Id
    String userID;
    String username;
    String password;
    UserRole role;
    String name;
    String email;
}
