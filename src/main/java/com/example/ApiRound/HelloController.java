package com.example.ApiRound;

import com.example.ApiRound.Service.ClickLogService;
import com.example.ApiRound.dto.CompanyClickCountDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.net.URLDecoder;
import java.net.URLEncoder;
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
        return "hello"; // /WEB-INF/views/hello.jsp
    }

    @GetMapping("/main")
    public String main(Model model) {
        List<CompanyClickCountDto> topCompanies = clickLogService.getTop3CompaniesLast7Days();
        model.addAttribute("topCompanies", topCompanies);
        return "main"; // /WEB-INF/views/main.jsp
    }

    @GetMapping("/tourism")
    public String tourism(Model model) {
        return "tourism";
    }

    @GetMapping("/plastic-surgery")
    public String surgery(Model model) {
        return "plastic-surgery";
    }

    @GetMapping("/skincare")
    public String skincare(Model model) {
        return "skincare";
    }

    @GetMapping("/favorite")
    public String favorite(Model model) {
        return "favorite";
    }

    @GetMapping("/location")
    public String location() {
        return "location";
    }

    @GetMapping("/list")
    public String list(Model model, String category, String region) {
        try {
            String decodedRegion = URLDecoder.decode(region, "UTF-8");
            switch (category) {
                case "dental":
                    return "redirect:/dental_list?region=" + URLEncoder.encode(decodedRegion, "UTF-8");
                case "korean.medicine":
                    return "redirect:/korea_list?region=" + URLEncoder.encode(decodedRegion, "UTF-8");
                case "massage":
                    return "redirect:/massage_list?region=" + URLEncoder.encode(decodedRegion, "UTF-8");
                case "pharmacy":
                    return "redirect:/pharmacy_list?region=" + URLEncoder.encode(decodedRegion, "UTF-8");
                case "skin":
                    return "redirect:/skin_list?region=" + URLEncoder.encode(decodedRegion, "UTF-8");
                case "waxing":
                    return "redirect:/waxing_list?region=" + URLEncoder.encode(decodedRegion, "UTF-8");
                case "plastic":
                case "tourism":
                default:
                    return "redirect:/plastic_list?region=" + URLEncoder.encode(decodedRegion, "UTF-8");
            }
        } catch (Exception e) {
            switch (category) {
                case "dental":
                    return "redirect:/dental_list?region=" + region;
                case "korean.medicine":
                    return "redirect:/korea_list?region=" + region;
                case "massage":
                    return "redirect:/massage_list?region=" + region;
                case "pharmacy":
                    return "redirect:/pharmacy_list?region=" + region;
                case "skin":
                    return "redirect:/skin_list?region=" + region;
                case "waxing":
                    return "redirect:/waxing_list?region=" + region;
                case "plastic":
                case "tourism":
                default:
                    return "redirect:/plastic_list?region=" + region;
            }
        }
    }

    // 나머지 list 메서드들 그대로 유지
    @GetMapping("/dental_list")
    public String dental_list(Model model, String region) {
        try {
            String decodedRegion = URLDecoder.decode(region, "UTF-8");
            model.addAttribute("region", decodedRegion);
        } catch (Exception e) {
            model.addAttribute("region", region);
        }
        return "dental_list";
    }

    @GetMapping("/korea_list")
    public String korea_list(Model model, String region) {
        try {
            String decodedRegion = URLDecoder.decode(region, "UTF-8");
            model.addAttribute("region", decodedRegion);
        } catch (Exception e) {
            model.addAttribute("region", region);
        }
        return "korea_list";
    }

    @GetMapping("/massage_list")
    public String massage_list(Model model, String region) {
        try {
            String decodedRegion = URLDecoder.decode(region, "UTF-8");
            model.addAttribute("region", decodedRegion);
        } catch (Exception e) {
            model.addAttribute("region", region);
        }
        return "massage_list";
    }

    @GetMapping("/pharmacy_list")
    public String pharmacy_list(Model model, String region) {
        try {
            String decodedRegion = URLDecoder.decode(region, "UTF-8");
            model.addAttribute("region", decodedRegion);
        } catch (Exception e) {
            model.addAttribute("region", region);
        }
        return "pharmacy_list";
    }

    @GetMapping("/skin_list")
    public String skin_list(Model model, String region) {
        try {
            String decodedRegion = URLDecoder.decode(region, "UTF-8");
            model.addAttribute("region", decodedRegion);
        } catch (Exception e) {
            model.addAttribute("region", region);
        }
        return "skin_list";
    }

    @GetMapping("/waxing_list")
    public String waxing_list(Model model, String region) {
        try {
            String decodedRegion = URLDecoder.decode(region, "UTF-8");
            model.addAttribute("region", decodedRegion);
        } catch (Exception e) {
            model.addAttribute("region", region);
        }
        return "waxing_list";
    }

    @GetMapping("/plastic_list")
    public String plastic_list(Model model, String region) {
        try {
            String decodedRegion = URLDecoder.decode(region, "UTF-8");
            model.addAttribute("region", decodedRegion);
        } catch (Exception e) {
            model.addAttribute("region", region);
        }
        return "plastic_list";
    }
}
