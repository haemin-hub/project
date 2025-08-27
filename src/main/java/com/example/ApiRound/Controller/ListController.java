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

    public String redirectList(String region, String category) {
        try {
            String decodedRegion = java.net.URLDecoder.decode(region, "UTF-8");
            String encodedRegion = java.net.URLEncoder.encode(decodedRegion, "UTF-8");

            return switch (category) {
                case "dental"          -> "redirect:/list/search?region=" + encodedRegion + "&category=dental";
                case "korean.medicine" -> "redirect:/list/search?region=" + encodedRegion + "&category=korean.medicine";
                case "massage"         -> "redirect:/list/search?region=" + encodedRegion + "&category=massage";
                case "pharmacy"        -> "redirect:/list/search?region=" + encodedRegion + "&category=pharmacy";
                case "skin"            -> "redirect:/list/search?region=" + encodedRegion + "&category=skin";
                case "waxing"          -> "redirect:/list/search?region=" + encodedRegion + "&category=waxing";
                case "plastic", "tourism" -> "redirect:/list/search?region=" + encodedRegion + "&category=plastic";
                default                -> "redirect:/list/search?region=" + encodedRegion + "&category=plastic";
            };
        } catch (Exception e) {
            return "redirect:/list/search?region=" + region + "&category=" + category;
        }
    }

    // 전체 병원 목록 조회 → list.jsp (페이징 적용)
    @GetMapping
    public String getAllList(Model model,
                             @RequestParam(required = false) String region,
                             @RequestParam(required = false, name = "subRegion") String subRegion,
                             @RequestParam(required = false) String category,
                             @RequestParam(defaultValue = "1") int pageNo,
                             @RequestParam(defaultValue = "18") int amount) {

        System.out.println("=== 요청 파라미터 ===");
        System.out.println("region: " + region);
        System.out.println("category: " + category);
        System.out.println("subRegion: " + subRegion);
        System.out.println("pageNo: " + pageNo);
        System.out.println("amount: " + amount);
        
        // 디버깅용: 모든 카테고리 값 출력
        List<String> allCategories = listService.getAllCategories();
        System.out.println("=== 데이터베이스의 모든 카테고리 ===");
        for (String cat : allCategories) {
            System.out.println("카테고리: " + cat);
        }

        // null 가드 + 트리밍
        region    = (region    == null) ? "" : region.trim();
        subRegion = (subRegion == null) ? "" : subRegion.trim();
        category  = (category  == null) ? "" : category.trim();

        pageNo = Math.max(1, pageNo);
        amount = Math.max(1, amount);
        int offset = (pageNo - 1) * amount;

        // 총 개수 & 현재 페이지 데이터
        int totalCount;
        List<ListDto> lists;
        
        // region과 subRegion이 "전국"일 때는 카테고리만으로 검색
        if ("전국".equals(region) && "전국".equals(subRegion)) {
            System.out.println("=== 전국 카테고리 검색 ===");
            System.out.println("카테고리: " + category);
            System.out.println("amount: " + amount + ", offset: " + offset);
            totalCount = listService.countByCategory(category);
            lists = listService.getListByCategoryPaged(category, amount, offset);
            System.out.println("총 개수: " + totalCount);
            System.out.println("조회된 리스트 개수: " + (lists != null ? lists.size() : 0));
            model.addAttribute("mode", "category");

            // 조회된 데이터 확인
            if (lists != null && !lists.isEmpty()) {
                System.out.println("=== 조회된 데이터 샘플 ===");
                System.out.println("첫 번째 항목: " + lists.get(0));
            }
        } else {
            System.out.println("=== 지역별 검색 ===");
            System.out.println("지역: " + region + ", 구: " + subRegion + ", 카테고리: " + category);
            totalCount = listService.countByRegionAndCategory(region, subRegion, category);
            lists = listService.getListByRegionAndSubregionPaged(region, subRegion, category, amount, offset);
            model.addAttribute("mode", "search");
            System.out.println("총 개수: " + totalCount);
            System.out.println("조회된 리스트 개수: " + (lists != null ? lists.size() : 0));
        }

        // 페이지 블록 계산 (blockSize = 5)
        int totalPages = (int) Math.ceil((double) totalCount / amount);
        int blockSize  = 5;
        int startPage  = ((pageNo - 1) / blockSize) * blockSize + 1;
        int endPage    = Math.min(startPage + blockSize - 1, Math.max(totalPages, 1));

        // 모델 바인딩
        model.addAttribute("lists", lists);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("pageNo", pageNo);
        model.addAttribute("amount", amount);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("region", region);
        model.addAttribute("subregion", subRegion);
        model.addAttribute("category", category);

        System.out.println("=== 모델 바인딩 완료 ===");
        System.out.println("lists size: " + (lists != null ? lists.size() : 0));
        System.out.println("totalCount: " + totalCount);
        System.out.println("totalPages: " + totalPages);
        System.out.println("startPage: " + startPage);
        System.out.println("endPage: " + endPage);

        return "list"; // /WEB-INF/views/list.jsp
    }

    // 단일 병원 조회 → detail.jsp
    @GetMapping("/{id}")
    public String getListById(@PathVariable Long id, Model model) {
        ListDto hospital = listService.getListById(id);
        model.addAttribute("list", hospital);
        return "detail";
    }

    // ✅ 지역 + 카테고리별 병원 조회 (페이징 적용) → list.jsp
    @GetMapping("/search")
    public String getListByRegionAndCategory(@RequestParam(required = false) String region,
                                             @RequestParam(required = false) String subregion,
                                             @RequestParam(required = false) String category,
                                             @RequestParam(defaultValue = "1") int pageNo,
                                             @RequestParam(defaultValue = "10") int amount,
                                             Model model) {

        // null 가드 + 트리밍
        region    = (region    == null) ? "" : region.trim();
        subregion = (subregion == null) ? "" : subregion.trim();
        category  = (category  == null) ? "" : category.trim();

        pageNo = Math.max(1, pageNo);
        amount = Math.max(1, amount);
        int offset = (pageNo - 1) * amount;

        // 총 개수 & 현재 페이지 데이터 (Service에 메서드 구현 필요)
        int totalCount = listService.countByRegionAndCategory(region, subregion, category);
        List<ListDto> lists = listService.getListByRegionAndSubregionPaged(region, subregion, category, amount, offset);

        // 페이지 블록 계산 (blockSize = 5)
        int totalPages = (int) Math.ceil((double) totalCount / amount);
        int blockSize  = 5;
        int startPage  = ((pageNo - 1) / blockSize) * blockSize + 1;
        int endPage    = Math.min(startPage + blockSize - 1, Math.max(totalPages, 1));
        Integer prevPage = (startPage > 1) ? startPage - 1 : null;
        Integer nextPage = (endPage < totalPages) ? endPage + 1 : null;

        // 모델 바인딩
        model.addAttribute("lists", lists);
        model.addAttribute("totalCount", totalCount);

        model.addAttribute("pageNo", pageNo);
        model.addAttribute("amount", amount);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("prevPage", prevPage);
        model.addAttribute("nextPage", nextPage);

        model.addAttribute("region", region);
        model.addAttribute("subregion", subregion);
        model.addAttribute("category", category);

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

    // 카테고리별(전국) 병원 목록: 페이징
    @GetMapping("/category/{category}")
    public String getListByCategoryPaged(@PathVariable String category,
                                         @RequestParam(defaultValue = "1") int pageNo,
                                         @RequestParam(defaultValue = "10") int amount,
                                         Model model) {

        category = (category == null) ? "" : category.trim();
        pageNo   = Math.max(1, pageNo);
        amount   = Math.max(1, amount);
        int offset = (pageNo - 1) * amount;

        int totalCount     = listService.countByCategory(category);
        List<ListDto> lists = listService.getListByCategoryPaged(category, amount, offset);

        int totalPages = (int) Math.ceil((double) totalCount / amount);
        int blockSize  = 5;
        int startPage  = ((pageNo - 1) / blockSize) * blockSize + 1;
        int endPage    = Math.min(startPage + blockSize - 1, Math.max(totalPages, 1));

        model.addAttribute("lists", lists);
        model.addAttribute("totalCount", totalCount);

        model.addAttribute("pageNo", pageNo);
        model.addAttribute("amount", amount);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        // 뷰에서 사용
        model.addAttribute("region", "전국");     // 상단 "선택된 지역" 표시용
        model.addAttribute("subregion", "전국");      // 비움
        model.addAttribute("category", category); // 현재 카테고리

        // 페이지네이션 링크 분기용 (JSP에서 사용)
        model.addAttribute("mode", "category");

        return "list";
    }

}
