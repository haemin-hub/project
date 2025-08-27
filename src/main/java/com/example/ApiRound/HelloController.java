package com.example.ApiRound;

import com.example.ApiRound.Service.ClickLogService;
import com.example.ApiRound.dto.CompanyClickCountDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class HelloController {

    private final ClickLogService clickLogService;

    public HelloController(ClickLogService clickLogService) {
        this.clickLogService = clickLogService;
    }

    @GetMapping("/hello")
    public String hello(Model model) {
        model.addAttribute("message", "JSP 테스트 성공!");
        return "hello"; // /WEB-INF/views/hello.jsp로 연결됨
    }

    @GetMapping("/main")
    public String main(Model model) {
        List<CompanyClickCountDto> topCompanies = clickLogService.getTop3CompaniesLast7Days();
        model.addAttribute("topCompanies", topCompanies);
        return "main"; // /WEB-INF/views/main.jsp
    }

    @GetMapping("/plastic-surgery")
    public String surgery(Model model) {
        return "plastic-surgery"; // /WEB-INF/views/plastic-surgery.jsp로 연결됨
    }

    @GetMapping("/skincare")
    public String skincare(Model model) {
        return "skincare"; // /WEB-INF/views/skincare.jsp로 연결됨
    }

    @GetMapping("/favorite")
    public String favorite(Model model) {
        return "favorite"; // /WEB-INF/views/favorite.jsp로 연결됨
    }


    @GetMapping("/location")
    public String location() {
        return "location";
    }
}
