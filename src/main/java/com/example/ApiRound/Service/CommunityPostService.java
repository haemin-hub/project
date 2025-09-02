package com.example.ApiRound.Service;

import com.example.ApiRound.dto.CommunityPostDto;

import java.util.List;

public interface CommunityPostService {
    List<CommunityPostDto> getAllPosts();
    CommunityPostDto getPostbyId(int postId);
    void createPost(CommunityPostDto post);
    void updatePost(CommunityPostDto post);
    void deletePost(int postId);
}
