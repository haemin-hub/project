package com.example.ApiRound.Controller;

import com.example.ApiRound.dto.ListDto;
import com.example.ApiRound.Service.ListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/list") // URL 기본 prefix
public class ListController {

    private final ListService listService;

    @Autowired
    public ListController(ListService listService) {
        this.listService = listService;
    }

    // 전체 병원 목록 조회 → list.jsp
    @GetMapping
    public String getAllList(Model model) {
        List<ListDto> lists = listService.getAllList();
        model.addAttribute("lists", lists);
        return "list"; // /WEB-INF/views/list.jsp
    }

    // 단일 병원 조회 → detail.jsp
    @GetMapping("/{id}")
    public String getListById(@PathVariable Long id, Model model) {
        ListDto hospital = listService.getListById(id);
        model.addAttribute("list", hospital);
        return "detail";
    }

    // 카테고리별 병원 목록 조회 → list.jsp
    @GetMapping("/category/{category}")
    public String getListByCategory(@PathVariable String category, Model model) {
        List<ListDto> hospitals = listService.getListByCategory(category);
        model.addAttribute("lists", hospitals);
        model.addAttribute("category", category);
        return "list"; // list.jsp
    }

    // 성형외과 목록 → plastic_list.jsp
    @GetMapping("/plastic_list")
    public String getPlasticList(Model model) {
        List<ListDto> lists = listService.getListByCategory("plastic_list");
        model.addAttribute("lists", lists);
        model.addAttribute("category", "성형외과");
        return "plastic_list";
    }

    // 피부과 목록 → skin_list.jsp
    @GetMapping("/skin_list")
    public String getSkinList(Model model) {
        List<ListDto> lists = listService.getListByCategory("skin_list");
        model.addAttribute("lists", lists);
        model.addAttribute("category", "피부과");
        return "skin_list";
    }

    // 치과 목록 → dental_list.jsp
    @GetMapping("/dental_list")
    public String getDentalList(Model model) {
        List<ListDto> lists = listService.getListByCategory("dental_list");
        model.addAttribute("lists", lists);
        model.addAttribute("category", "치과");
        return "dental_list";
    }

    // 약국 목록 → pharmacy_list.jsp
    @GetMapping("/pharmacy_list")
    public String getPharmacyList(Model model) {
        List<ListDto> lists = listService.getListByCategory("pharmacy_list");
        model.addAttribute("lists", lists);
        model.addAttribute("category", "약국");
        return "pharmacy_list";
    }

    // 마사지 목록 → massage_list.jsp
    @GetMapping("/massage_list")
    public String getMassageList(Model model) {
        List<ListDto> lists = listService.getListByCategory("massage_list");
        model.addAttribute("lists", lists);
        model.addAttribute("category", "마사지");
        return "massage_list";
    }

    // 한의원 목록 → korea_list.jsp
    @GetMapping("/korea_list")
    public String getKoreaList(Model model) {
        List<ListDto> lists = listService.getListByCategory("korea_list");
        model.addAttribute("lists", lists);
        model.addAttribute("category", "한의원");
        return "korea_list";
    }

    // 왁싱 목록 → waxing_list.jsp
    @GetMapping("/waxing_list")
    public String getWaxingList(Model model) {
        List<ListDto> lists = listService.getListByCategory("waxing_list");
        model.addAttribute("lists", lists);
        model.addAttribute("category", "왁싱");
        return "waxing_list";
    }


    // 지역 + 카테고리별 병원 조회 → list.jsp
    @GetMapping("/search")
    public String getListByRegionAndCategory(@RequestParam String region,
                                             @RequestParam String category,
                                             Model model) {
        List<ListDto> lists = listService.getListByRegionAndCategory(region, category);
        model.addAttribute("lists", lists);
        model.addAttribute("selectedRegion", region);
        model.addAttribute("selectedCategory", category);
        return "list";
    }

    // 등록 폼 → form.jsp
    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("listDto", new ListDto());
        return "form";
    }

    // 등록 처리
    @PostMapping
    public String addList(@ModelAttribute ListDto listDto) {
        listService.addList(listDto);
        return "redirect:/list"; // 등록 후 목록으로 이동
    }
}
