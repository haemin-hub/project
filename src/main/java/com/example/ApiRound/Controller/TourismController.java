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

    @GetMapping("/package")
    public String packageList(Model model, @RequestParam(required = false, defaultValue = "") String category) {
        List<ListDto> data;
        if (category != null && !category.isBlank()) {
            // 카테고리별 최대 9개
            data = listService.getListByCategoryPaged(category, 9, 0);
        } else {
            // 전체에서 최대 9개
            List<ListDto> all = listService.getAllList();
            if (all == null) all = Collections.emptyList();
            int end = Math.min(9, all.size());
            data = all.subList(0, end);
        }
        if (data == null) data = Collections.emptyList();
        model.addAttribute("packages", data);
        return "package";
    }

    // 패키지 상세 페이지 라우팅: /package/{id} 로 접근
    @GetMapping("/package/{id}")
    public String packageDetail(@org.springframework.web.bind.annotation.PathVariable Long id, Model model) {
        // package.jsp에서 사용할 패키지 ID 전달
        model.addAttribute("packageId", id);
        return "package";
    }
}
