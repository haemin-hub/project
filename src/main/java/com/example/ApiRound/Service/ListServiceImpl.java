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
    public void addList(ListDto listDto) {
        listMapper.insert(listDto);  // mapper에서 insert 메서드를 만들어야 함
    }

    @Override
    public List<ListDto> getListByCategory(String category) {
        return listMapper.findByCategory(category);
    }

    @Override
    public List<ListDto> getListByRegionAndSubregion(String region, String subregion, String category) {
        return listMapper.findByRegionAndCategory(region, subregion, category);
    }

    @Override
    public int countByRegionAndCategory(String region, String subregion, String category) {
        return listMapper.countByRegionAndCategory(region, subregion, category);
    }

    @Override
    public List<ListDto> getListByRegionAndSubregionPaged(String region, String subregion, String category,
                                                          int limit, int offset) {
        return listMapper.findByRegionAndCategoryPaged(region, subregion, category, limit, offset);
    }

    @Override
    public int countByCategory(String category) {
        return listMapper.countByCategory(category);
    }

    @Override
    public List<ListDto> getListByCategoryPaged(String category, int amount, int offset) {
        return listMapper.findByCategoryPaged(category, amount, offset);
    }

    @Override
    public List<String> getAllCategories() {
        return listMapper.getAllCategories();
    }
}
