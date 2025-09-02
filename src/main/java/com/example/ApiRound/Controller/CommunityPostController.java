package com.example.ApiRound.Controller;

import com.example.ApiRound.Service.CommunityPostService;
import com.example.ApiRound.dto.CommunityPostDto;
import com.example.ApiRound.dto.SocialUserDTO;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/community")
public class CommunityPostController {

    private final CommunityPostService service;
    public CommunityPostController(CommunityPostService service) { this.service = service; }

    // 목록: /community, /community/ , /community/list 모두 허용
    @GetMapping({"", "/", "/list"})
    public String listPosts(Model model){
        List<CommunityPostDto> posts = service.getAllPosts();
        System.out.println("posts size: " + posts.size());
        model.addAttribute("posts", posts);
        return "community";                 // /WEB-INF/views/community.jsp
    }

    @GetMapping("/view/{postId}")
    public String viewPost(@PathVariable int postId, Model model){
        CommunityPostDto post = service.getPostbyId(postId); // 메서드명 통일 권장
        model.addAttribute("post", post);
        return "community/view";
    }

    @GetMapping("/write")
    public String writeForm(Model model){
        model.addAttribute("post", new CommunityPostDto());
        return "community/write";
    }

    @PostMapping("/write") // ← 슬래시 추가
    public String submitWrite(@ModelAttribute CommunityPostDto post){
        service.createPost(post);
        return "redirect:/community";       // ← 목록으로
        // (만약 /community/list 로 가고 싶으면 위의 @GetMapping({"", "/", "/list"}) 가 있으니 그대로 써도 됨)
    }

    // 글 작성 (fetch POST)
    @PostMapping(value="/write/fetch", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    @ResponseBody
    public String writeFetch(
            @RequestParam String title,
            @RequestParam String content,
            @RequestParam String category,
            HttpSession session
    ) {
        // 로그인 상태 확인
        SocialUserDTO loginUser = (SocialUserDTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "login_required";
        }

        CommunityPostDto dto = new CommunityPostDto();
        dto.setTitle(title);
        dto.setContent(content);
        dto.setCategory(category);
        dto.setUserId(loginUser.getName()); // userId 대신 사용자 이름 저장

        try {
            service.createPost(dto);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @PostMapping(value="/edit/fetch", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    @ResponseBody
    public String editFetch(
            @RequestParam int postId,
            @RequestParam String title,
            @RequestParam String content,
            @RequestParam String category,
            HttpSession session
    ) {
        // 로그인 상태 확인
        SocialUserDTO loginUser = (SocialUserDTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "login_required";
        }

        // 간단 검증
        if (postId <= 0 || title == null || title.isBlank()
                || content == null || content.isBlank()
                || category == null || category.isBlank()) {
            return "invalid";
        }

        // 글 작성자 확인
        CommunityPostDto existingPost = service.getPostbyId(postId);
        if (existingPost == null) {
            return "post_not_found";
        }

        // 본인이 작성한 글인지 확인 (userId 대신 authorName 사용)
        if (!loginUser.getName().equals(existingPost.getAuthorName())) {
            return "unauthorized";
        }

        // DTO 구성
        CommunityPostDto dto = new CommunityPostDto();
        dto.setPostId(postId);
        dto.setTitle(title);
        dto.setContent(content);
        dto.setCategory(category);

        try {
            // 업데이트 실행
            service.updatePost(dto);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @GetMapping("/edit/{postId}")
    public String editForm(@PathVariable int postId, Model model){
        CommunityPostDto post = service.getPostbyId(postId);
        model.addAttribute("post", post);
        return "community/edit";
    }

    @PostMapping("/edit")
    public String submitEdit(@ModelAttribute CommunityPostDto post) {
        service.updatePost(post);
        return "redirect:/community/view/" + post.getPostId();
    }

    // fetch 전용 삭제 (시큐리티 없음)
    @PostMapping("/delete")
    @ResponseBody
    public String deletePostFetch(@RequestParam int postId, HttpSession session) {
        // 로그인 상태 확인
        SocialUserDTO loginUser = (SocialUserDTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "login_required";
        }

        // 글 작성자 확인
        CommunityPostDto existingPost = service.getPostbyId(postId);
        if (existingPost == null) {
            return "post_not_found";
        }

        // 본인이 작성한 글인지 확인 (userId 대신 authorName 사용)
        if (!loginUser.getName().equals(existingPost.getAuthorName())) {
            return "unauthorized";
        }

        try {
            service.deletePost(postId);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @PostMapping("/insert")
    @ResponseBody
    public String insertPost(@RequestParam String title, @RequestParam String content) {
        CommunityPostDto post = new CommunityPostDto();
        post.setTitle(title);
        post.setContent(content);
        service.createPost(post);
        return "success";
    }
}
