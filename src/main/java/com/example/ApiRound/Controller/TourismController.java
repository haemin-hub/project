package com.example.ApiRound.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TourismController {
    
    @GetMapping("/tourism")
    public String tourismList() {
        return "tourism_list";
    }

    @GetMapping("/package")
    public String packageList() { return "package";}
}
