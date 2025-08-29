package com.example.ApiRound.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // getter, setter, toString, equals, hashCode 자동 생성
@NoArgsConstructor // 기본 생성자
@AllArgsConstructor // 모든 필드 포함 생성자
public class ListDto {
    private Long id;
    private String name;
    private String region;
    private String subregion;
    private String address;
    private String phone;
    private String homepage;
    private Double coordX; // 위도/경도는 double 타입이 적합
    private Double coordY;
    private String category;
    private String imageUrl; // 사진 URL 필드 추가
}