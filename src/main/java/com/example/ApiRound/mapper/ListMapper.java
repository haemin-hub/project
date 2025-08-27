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

    // 병원 등록
    void insertList(ListDto hospital);

    // 🔹 카테고리별 병원 리스트 조회
    List<ListDto> findByCategory(@Param("category") String category);

    // 🔹 지역 + 카테고리별 병원 리스트 조회
    List<ListDto> findByRegionAndCategory(@Param("region") String region,
                                          @Param("category") String category);
}
