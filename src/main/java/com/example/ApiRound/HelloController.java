package com.example.ApiRound;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HelloController {

    @GetMapping("/")
    public String index() {
        return "redirect:/main";
    }

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
    public void tourism() {

    }

    @GetMapping("/plastic-surgery")
    public void surgery() {

    }

    @GetMapping("/skincare")
    public void skincare() {

    }

    @GetMapping("/dental")
    public void dental() {

    }

    @GetMapping("/pharmacy")
    public void pharmacy() {

    }

    @GetMapping("/korean-medicine")
    public void medicine() {

    }
}