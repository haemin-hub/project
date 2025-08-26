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
    public String mainPage() {
        return "main"; // /WEB-INF/views/main.jsp
    }

    @GetMapping("/tourism")
    public void tourism() {

    }

    @GetMapping("/plastic-surgery")
    public void surgery() {

    }

    @GetMapping("/skincare")
    public void skincare() {

    }

    @GetMapping("/location")
    public String location() {
        return "location";
    }

}