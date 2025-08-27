package com.example.ApiRound.Service;

import com.example.ApiRound.dto.ListDto;

import java.util.List;

/**
 * 병원 정보 관련 서비스
 */
public interface ListService {

    // 전체 병원 목록 조회
    List<ListDto> getAllList();

    // ID로 병원 조회
    ListDto getListById(Long id);

    // 병원 등록
    void addList(ListDto hospital);

    // 🔹 카테고리별 병원 목록 조회
    List<ListDto> getListByCategory(String category);

    // 🔹 지역 + 카테고리 같이 검색 (예: 서울 치과)
    List<ListDto> getListByRegionAndCategory(String region, String category);

}
