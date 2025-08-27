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

    @GetMapping("/list")
    public String list(Model model, String category, String region) {
        try {
            // URL 디코딩
            String decodedRegion = java.net.URLDecoder.decode(region, "UTF-8");
            
            // 카테고리에 따라 적절한 리스트 페이지로 리다이렉트
            switch (category) {
                case "dental":
                    return "redirect:/dental_list?region=" + java.net.URLEncoder.encode(decodedRegion, "UTF-8");
                case "korean.medicine":
                    return "redirect:/korea_list?region=" + java.net.URLEncoder.encode(decodedRegion, "UTF-8");
                case "massage":
                    return "redirect:/massage_list?region=" + java.net.URLEncoder.encode(decodedRegion, "UTF-8");
                case "pharmacy":
                    return "redirect:/pharmacy_list?region=" + java.net.URLEncoder.encode(decodedRegion, "UTF-8");
                case "skin":
                    return "redirect:/skin_list?region=" + java.net.URLEncoder.encode(decodedRegion, "UTF-8");
                case "waxing":
                    return "redirect:/waxing_list?region=" + java.net.URLEncoder.encode(decodedRegion, "UTF-8");
                case "plastic":
                case "tourism":
                default:
                    return "redirect:/plastic_list?region=" + java.net.URLEncoder.encode(decodedRegion, "UTF-8");
            }
        } catch (Exception e) {
            // 인코딩 에러 시 원본 region 사용
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
        return "massage_list"; // /WEB-INF/views/massage_list.jsp로 연결됨
    }

    @GetMapping("/pharmacy_list")
    public String pharmacy_list(Model model, String region) {
        try {
            String decodedRegion = URLDecoder.decode(region, "UTF-8");
            model.addAttribute("region", decodedRegion);
        } catch (Exception e) {
            model.addAttribute("region", region);
        }
        return "pharmacy_list"; // /WEB-INF/views/pharmacy_list.jsp로 연결됨
    }

    @GetMapping("/skin_list")
    public String skin_list(Model model, String region) {
        try {
            String decodedRegion = URLDecoder.decode(region, "UTF-8");
            model.addAttribute("region", decodedRegion);
        } catch (Exception e) {
            model.addAttribute("region", region);
        }
        return "skin_list"; // /WEB-INF/views/skin_list.jsp로 연결됨
    }

    @GetMapping("/waxing_list")
    public String waxing_list(Model model, String region) {
        try {
            String decodedRegion = URLDecoder.decode(region, "UTF-8");
            model.addAttribute("region", decodedRegion);
        } catch (Exception e) {
            model.addAttribute("region", region);
        }
        return "waxing_list"; // /WEB-INF/views/waxing_list.jsp로 연결됨
    }

    @GetMapping("/plastic_list")
    public String plastic_list(Model model, String region) {
        try {
            String decodedRegion = URLDecoder.decode(region, "UTF-8");
            model.addAttribute("region", decodedRegion);
        } catch (Exception e) {
            model.addAttribute("region", region);
        }
        return "plastic_list"; // /WEB-INF/views/plastic_list.jsp로 연결됨
    }

    @GetMapping("/package")
    public String packagePage(Model model) {
        model.addAttribute("message", "JSP 테스트 성공!");
        return "package"; // /WEB-INF/views/package.jsp로 연결됨
    }
}