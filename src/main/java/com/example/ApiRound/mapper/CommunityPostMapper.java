package com.example.ApiRound.mapper;

import com.example.ApiRound.dto.CommunityPostDto;

import java.util.List;

public interface CommunityPostMapper {
    List<CommunityPostDto> findAllPosts();
    CommunityPostDto findPostbyId(int postId);
    void insertPost(CommunityPostDto post);
    void updatePost(CommunityPostDto post);
    void softDeletePost(int postId);
}
