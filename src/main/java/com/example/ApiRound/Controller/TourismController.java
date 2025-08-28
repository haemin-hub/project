package com.example.ApiRound.Controller;

import com.example.ApiRound.Service.ListService;
import com.example.ApiRound.dto.ListDto;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Collections;
import java.util.List;

@Controller
public class TourismController {

    private final ListService listService;

    @Autowired
    public TourismController(ListService listService) {
        this.listService = listService;
    }

    @GetMapping("/tourism")
    public String tourismList() {
        return "tourism_list";
    }


}
