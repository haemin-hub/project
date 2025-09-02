package com.example.ApiRound.Controller;

import com.example.ApiRound.Service.CommunityPostService;
import com.example.ApiRound.dto.CommunityPostDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/community")
public class CommunityPostController {

    @Autowired
    private CommunityPostService service;

    @GetMapping("")
    public String listPosts(Model model){
        List<CommunityPostDto> posts = service.getAllPosts();
        System.out.println("posts size: " + posts.size());  // 데이터 크기 출력
        model.addAttribute("posts",posts);
        return "community";
    }

    @GetMapping("/view/{postId}")
    public String viewPost(@PathVariable int postId, Model model){
        CommunityPostDto post = service.getPostbyId(postId);
        model.addAttribute("post",post);
        return "community/view";
    }

    @GetMapping("/write")
    public String wirteForm(Model model){
        model.addAttribute("post",new CommunityPostDto());
        return "community/write";
    }

    @PostMapping("write")
    public String submitWrite(@ModelAttribute CommunityPostDto post){
        service.createPost(post);
        return "redirect:/community/list";
    }

    @GetMapping("/edit/{postId}")
    public String editForm(@PathVariable int postId,Model model){
        CommunityPostDto post = service.getPostbyId(postId);
        model.addAttribute("post",post);
        return "community/edit";
    }
    @PostMapping("/edit")
    public String submitEdit(@ModelAttribute CommunityPostDto post) {
        service.updatePost(post);
        return "redirect:/community/view/" + post.getPostId();
    }

    @PostMapping("/delete/{postId}")
    public String deletePost(@PathVariable int postId) {
        service.deletePost(postId);
        return "redirect:/community/list";
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
