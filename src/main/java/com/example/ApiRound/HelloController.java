package com.example.ApiRound;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HelloController {

    @GetMapping("/hello")
    public String hello(Model model) {
        model.addAttribute("message", "JSP 테스트 성공!");
        return "hello"; // /WEB-INF/views/hello.jsp로 연결됨
    }

    @GetMapping("/main")
    public String main(Model model) {
        return "main"; // /WEB-INF/views/main.jsp로 연결됨
    }

    @GetMapping("/tourism")
    public String tourism(Model model) {
        return "tourism"; // /WEB-INF/views/tourism.jsp로 연결됨
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

    @GetMapping("/dental_list")
    public String dental_list(Model model) {
        return "dental_list"; // /WEB-INF/views/dental_list.jsp로 연결됨
    }

    @GetMapping("/korea_list")
    public String korea_list(Model model) {
        return "korea_list"; // /WEB-INF/views/korea_list.jsp로 연결됨
    }

    @GetMapping("/massage_list")
    public String massage_list(Model model) {
        return "massage_list"; // /WEB-INF/views/massage_list.jsp로 연결됨
    }

    @GetMapping("/pharmacy_list")
    public String pharmacy_list(Model model) {
        return "pharmacy_list"; // /WEB-INF/views/pharmacy_list.jsp로 연결됨
    }

    @GetMapping("/skin_list")
    public String skin_list(Model model) {
        return "skin_list"; // /WEB-INF/views/skin_list.jsp로 연결됨
    }

    @GetMapping("/waxing_list")
    public String waxing_list(Model model) {
        return "waxing_list"; // /WEB-INF/views/waxing_list.jsp로 연결됨
    }
}