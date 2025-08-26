package com.example.ApiRound.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data // @Getter, @Setter, @ToString, @EqualsAndHashCode 포함
@AllArgsConstructor  // 전체 필드 생성자
@NoArgsConstructor  // 기본 생성자
public class SocialUserDTO {
    private Long userId;
    private String socialId;
    private String email;
    private String name;
    private String profileImage;
    private String provider;
    private Timestamp createdAt; // TimeStamp - DB 연동용 (밀리초 단위 포함), JDBC에서 주로 사용
    private Timestamp lastLogin;

    private String accessToken;
}