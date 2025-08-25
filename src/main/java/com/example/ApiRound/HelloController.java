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

    @GetMapping("/detail")
    public String detail(Model model) {
        return "detail"; // /WEB-INF/views/detail.jsp로 연결됨
    }

    @GetMapping("/detail")
    public static void detail(String[] args) {

    }


    @GetMapping("/main")
    public static void main(String[] args) {

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

}