package com.example.ApiRound.mapper;

import com.example.ApiRound.dto.ListDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Mapper는 단순 DB 접근
 */
@Mapper
public interface ListMapper {

    // 전체 병원 리스트 조회
    List<ListDto> findAll();

    // id로 단일 병원 조회
    ListDto findById(@Param("id") Long id);

    // 🔹 카테고리별 병원 리스트 조회
    List<ListDto> findByCategory(@Param("category") String category);

    // 🔹 지역 + 구별 + 카테고리별 병원 리스트 조회
    List<ListDto> findByRegionAndCategory(@Param("region") String region,
                                          @Param("subregion") String subregion,
                                          @Param("category") String category);

    void insert(ListDto listDto);

    // 페이징을 위한 총 개수 조회
    int countByRegionAndCategory(@Param("region") String region,
                                 @Param("subregion") String subregion,
                                 @Param("category") String category);

    // 페이징을 위한 병원 리스트 조회
    List<ListDto> findByRegionAndCategoryPaged(@Param("region") String region,
                                               @Param("subregion") String subregion,
                                               @Param("category") String category,
                                               @Param("limit") int limit,
                                               @Param("offset") int offset);

    // 카테고리별 총 개수 조회
    int countByCategory(@Param("category") String category);

    // 카테고리별 페이징 조회
    List<ListDto> findByCategoryPaged(@Param("category") String category,
                                      @Param("amount") int amount,
                                      @Param("offset") int offset);

    // 디버깅용: 모든 카테고리 값 조회
    List<String> getAllCategories();
}
