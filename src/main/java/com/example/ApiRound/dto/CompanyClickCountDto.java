package com.example.ApiRound.dto;

import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CompanyClickCountDto {
    private Long companyId;
    private String companyName; // 업체 이름 (ITEM_LIST.NAME 컬럼이라고 가정)
    private int clickCount;
}