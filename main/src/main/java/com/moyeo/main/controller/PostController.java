package com.moyeo.main.controller;

import com.moyeo.main.dto.AddPostReq;
import com.moyeo.main.dto.GetPostRes;
import com.moyeo.main.entity.User;
import com.moyeo.main.exception.BaseException;
import com.moyeo.main.exception.ErrorMessage;
import com.moyeo.main.service.MoyeoPostService;
import com.moyeo.main.service.PostService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@RequestMapping("/api/auth/post")
@RestController
@Slf4j
@Tag(name = "Post")
public class PostController {
    private final PostService postService;
    private final MoyeoPostService moyeoPostService;


    //포스트 등록 (Address 1 - 국가 -> Address 4 - 동네)
    @PostMapping(value = "", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @Operation(summary = "포스트 등록")
    public ResponseEntity<?> addPost(@RequestPart MultipartFile flagFile,
                                     @RequestPart List<MultipartFile> imageFiles,
                                     @RequestPart MultipartFile voiceFile,
                                     @Valid @ModelAttribute AddPostReq addPostReq,
                                     @RequestParam(required = false, defaultValue = "false") Boolean isMoyeo) throws Exception {
        log.info("포스트 등록 시작");
        if (isMoyeo == false) {
            postService.insertPost(imageFiles, flagFile, voiceFile, addPostReq);

            // addPost 요청에 대한 응답으로 timelineId 반환
            Map<String, Object> res = new HashMap<>();
            res.put("timelineId", addPostReq.getTimelineId());
            log.info("포스트 등록 완료");
            return ResponseEntity.ok(res);
        } else {
            moyeoPostService.insertPost(imageFiles, flagFile, voiceFile, addPostReq);

            // addPost 요청에 대한 응답으로 timelineId 반환
            Map<String, Object> res = new HashMap<>();
            res.put("timelineId", addPostReq.getTimelineId());
            log.info("포스트(모여) 등록 완료");
            return ResponseEntity.ok(res);
        }
    }

    @DeleteMapping("/{postId}")
    @Operation(summary = "포스트 삭제")
    public ResponseEntity<?> deletePost(@PathVariable Long postId) throws Exception {
        if (postId == null) {
            log.info("postId 값 없음");
            throw new BaseException(ErrorMessage.VALIDATION_FAIL_EXCEPTION);
        }
        postService.deletePostById(postId);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/main/{location}")
    @Operation(summary = "포스트 검색 조회 (메인 페이지에서 지역으로 검색)")
    public ResponseEntity<?> getPost(@PathVariable String location) throws Exception {
        if (location == null) {
            log.info("location 값 없음");
            throw new BaseException(ErrorMessage.VALIDATION_FAIL_EXCEPTION);
        }
        List<GetPostRes> getPostResList = postService.findByLocation(location);
        return ResponseEntity.ok(getPostResList);
    }

    @GetMapping("/mine/{myLocation}")
    @Operation(summary = "포스트 검색 조회 (내 페이지에서 지역으로 검색)")
    public ResponseEntity<?> getMyPost(@PathVariable String myLocation) throws Exception {
        // accessToken에서 user 가져오기
        Long userUid = null;
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() != null) {
            User user = (User) auth.getPrincipal();
            userUid = user.getUserId();
        }

        // 응답
        if (myLocation == null) {
            log.info("location 값 없음");
            throw new BaseException(ErrorMessage.VALIDATION_FAIL_EXCEPTION);
        }
        List<GetPostRes> getPostResList = postService.findMyPost(myLocation, userUid);
        return ResponseEntity.ok(getPostResList);
    }
}
