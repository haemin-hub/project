package com.example.ApiRound.Service;

import com.example.ApiRound.dto.ListDto;
import com.example.ApiRound.mapper.ListMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ListServiceImpl implements ListService {

    private final ListMapper listMapper;

    @Autowired
    public ListServiceImpl(ListMapper listMapper) {
        this.listMapper = listMapper;
    }

    @Override
    public List<ListDto> getAllList() {
        return listMapper.findAll();
    }

    @Override
    public ListDto getListById(Long id) {
        return listMapper.findById(id);
    }

    @Override
    public void addList(ListDto hospital) {
        listMapper.insertList(hospital);
    }

    @Override
    public List<ListDto> getListByCategory(String category) {
        return listMapper.findByCategory(category);
    }

    @Override
    public List<ListDto> getListByRegionAndCategory(String region, String category) {
        return listMapper.findByRegionAndCategory(region, category);
    }
}
