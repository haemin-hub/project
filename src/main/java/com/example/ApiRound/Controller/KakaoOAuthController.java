package com.example.ApiRound.Controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.view.RedirectView;

import java.io.IOException;

@Controller
@RequestMapping("/oauth/kakao")
public class KakaoOAuthController {

    @Value("${kakao.client-id}")
    private String clientId;

    @Value("${kakao.redirect-uri}")
    private String redirectUri;

    @Value("${kakao.client-secret:}")  // 선택
    private String clientSecret;

    private final RestTemplate restTemplate = new RestTemplate();

    @GetMapping("/callback")
    public RedirectView kakaoCallback(@RequestParam String code, HttpSession session) throws IOException {
        System.out.println("카카오 콜백 호출됨 ! ");
        // 1. 카카오 토큰 요청을 위한 헤더 및 파라미터 세팅
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", clientId);
        params.add("redirect_uri", redirectUri);
        params.add("code", code);

        if (clientSecret != null && !clientSecret.isEmpty()) {
            params.add("client_secret", clientSecret);
        }

        HttpEntity<MultiValueMap<String, String>> tokenRequest = new HttpEntity<>(params, headers);

        // 2. Access Token 요청
        ResponseEntity<String> tokenResponse = restTemplate.postForEntity(
                "https://kauth.kakao.com/oauth/token",
                tokenRequest,
                String.class
        );

        // 3. 토큰 파싱
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode tokenJson = objectMapper.readTree(tokenResponse.getBody());
        String accessToken = tokenJson.get("access_token").asText();

        // 4. 사용자 정보 요청
        HttpHeaders userInfoHeaders = new HttpHeaders();
        userInfoHeaders.setBearerAuth(accessToken);

        HttpEntity<?> userInfoRequest = new HttpEntity<>(userInfoHeaders);

        ResponseEntity<String> userInfoResponse = restTemplate.exchange(
                "https://kapi.kakao.com/v2/user/me",
                HttpMethod.GET,
                userInfoRequest,
                String.class
        );

        JsonNode userInfoJson = objectMapper.readTree(userInfoResponse.getBody());
        System.out.println("Kakao User Info: " + userInfoJson.toPrettyString());

        //  세션에 사용자 정보 저장하거나 DB에 저장하는 로직 추가 가능
        session.setAttribute("userId", userInfoJson.get("id").asText());

        // 5. 로그인 완료 후 메인 페이지로 리다이렉트
        return new RedirectView("/main");
    }

    @GetMapping("/logout")
    public RedirectView logout(HttpSession session) {
        session.invalidate();
        return new RedirectView("/");
    }
}
