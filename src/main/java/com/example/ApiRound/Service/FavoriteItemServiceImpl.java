package com.example.ApiRound.Service;

import com.example.ApiRound.dto.FavoriteItemDto;
import com.example.ApiRound.dto.ListDto;
import com.example.ApiRound.mapper.FavoriteItemMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class FavoriteItemServiceImpl implements FavoriteItemService {

    private final FavoriteItemMapper favoriteItemMapper;

    public FavoriteItemServiceImpl(FavoriteItemMapper favoriteItemMapper) {
        this.favoriteItemMapper = favoriteItemMapper;
    }

    @Override
    public void addFavorite(Long userId, Long itemId) {
        if (!favoriteItemMapper.isFavorite(userId, itemId)) {
            FavoriteItemDto dto = new FavoriteItemDto();
            dto.setUserId(userId);
            dto.setItemId(itemId);
            int res = favoriteItemMapper.insertFavorite(dto);
            System.out.println("insertFavorite 결과: " + res);
        }else {
            System.out.println("이미 즐겨찾기 있음");
        }
    }

    @Override
    public void removeFavorite(Long userId, Long itemId) {
        favoriteItemMapper.deleteFavorite(userId, itemId);
    }

    @Override
    public boolean isFavorite(Long userId, Long itemId) {
        return favoriteItemMapper.isFavorite(userId, itemId);
    }

    @Override
    public List<ListDto> getFavoriteItems(Long userId) {
        return favoriteItemMapper.getFavoritesByUserId(userId);
    }

    @Override
    public List<ListDto> getFavoritesByUserId(Long userId) {
        return favoriteItemMapper.getFavoritesByUserId(userId);
    }
}
