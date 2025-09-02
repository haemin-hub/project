package com.example.ApiRound.Service;

import com.example.ApiRound.dto.CommunityPostDto;
import com.example.ApiRound.mapper.CommunityPostMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommunityPostServiceImpl implements CommunityPostService{

    @Autowired
    private CommunityPostMapper mapper;

    @Override
    public List<CommunityPostDto> getAllPosts(){
        return mapper.findAllPosts();
    }

    @Override
    public CommunityPostDto getPostbyId(int postId){
        return mapper.findPostbyId(postId);
    }

    @Override
    public void createPost(CommunityPostDto post){
        mapper.insertPost(post);
    }

    @Override
    public void updatePost(CommunityPostDto post){
        mapper.updatePost(post);
    }

    @Override
    public  void deletePost(int postId){
        mapper.softDeletePost(postId);
    }
}
