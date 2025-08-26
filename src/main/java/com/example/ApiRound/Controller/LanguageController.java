package com.example.ApiRound.Controller;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class LanguageController {

    @GetMapping("/lang")
    public String changeLanguage(@RequestParam("code") String langCode, 
                                HttpServletRequest request, 
                                HttpServletResponse response) {
        
        LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
        
        if (localeResolver != null) {
            Locale locale = null;
            
            switch (langCode) {
                case "ko":
                    locale = Locale.KOREAN;
                    break;
                case "en":
                    locale = Locale.ENGLISH;
                    break;
                case "ja":
                    locale = Locale.JAPANESE;
                    break;
                case "zh":
                    locale = Locale.CHINESE;
                    break;
                default:
                    locale = Locale.KOREAN;
                    break;
            }
            
            localeResolver.setLocale(request, response, locale);
        }
        
        // 이전 페이지로 리다이렉트하거나 홈으로 이동
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            return "redirect:" + referer;
        }
        
        return "redirect:/";
    }
}
