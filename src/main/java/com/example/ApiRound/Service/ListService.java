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
    List<ListDto> getListByRegionAndSubregion(String region, String subRegion, String category);

    int countByRegionAndCategory(String region, String subregion, String category);

    List<ListDto> getListByRegionAndSubregionPaged(String region, String subregion, String category,
                                                   int limit, int offset);

    // 총 게시글(전국)
    int countByCategory(String category);
    List<ListDto> getListByCategoryPaged(String category, int amount, int offset);

    // 디버깅용: 모든 카테고리 값 조회
    List<String> getAllCategories();
}
