package com.example.ApiRound.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CommunityPostDto {
    private int postId;
    private String userId;
    private String title;
    private String content;
    private Timestamp createAt;
    private int likeCount;
    private String category;
    private String isDeleted;
    private String isUpdate;

}
