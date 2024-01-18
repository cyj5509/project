package com.devday.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.devday.domain.CommentVO;
import com.devday.domain.UserVO;
import com.devday.dto.Criteria;
import com.devday.dto.PageDTO;
import com.devday.service.CommentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController // AJAX로만 활용(JSP 파일 미사용)
@RequiredArgsConstructor
@RequestMapping("/comment/*") 
@Log4j
public class CommentController {

	private final CommentService commentService;
	private final PasswordEncoder passwordEncoder; // 비회원 관련 암호화 처리(security 폴더 참고)
	
	// 댓글 관리(추가, 수정, 삭제)
    @PostMapping("/manageComments")
    public ResponseEntity<String> manageComments(@RequestBody CommentVO cm_vo,
    		 									 @RequestParam("action") String action,                                                 
                                                 HttpSession session) {
    	
    	log.info("작업 유형: " + action);
    	log.info("댓글 데이터: " + cm_vo);
    	
        // 세션에서 사용자 상태 확인
        UserVO us_vo = (UserVO) session.getAttribute("userStatus");
        if (us_vo == null) {
			// 비회원 사용자인 경우
        	cm_vo.setUs_id(""); // 회원 아이디를 빈 문자열로 설정
        	
        	String guest_nickname = cm_vo.getCm_guest_nickname();
        	String guest_pw = cm_vo.getCm_guest_pw();
        	
        	// 비회원 닉네임 처리: 닉네임이 제공되지 않은 경우 기본값 설정
        	if (guest_nickname == null || guest_nickname.trim().isEmpty()) {
        		cm_vo.setCm_guest_nickname("guest"); // 기본값으로 'guest' 설정
        	}
        	
			if ("modify".equals(action) || "delete".equals(action)) {
				
				// 특정 댓글 조회
			    CommentVO db_vo = commentService.findComment(cm_vo.getCm_code());
				
				if (db_vo == null || !passwordEncoder.matches(guest_pw, db_vo.getCm_guest_pw())) {
					// 비밀번호가 일치하지 않는 경우
					return new ResponseEntity<>("fail", HttpStatus.OK);
				}
			}
			
			// 비회원 비밀번호 처리: 비밀번호가 제공된 경우 암호화
			if (guest_pw != null && !guest_pw.isEmpty()) {
				cm_vo.setCm_guest_pw(passwordEncoder.encode(guest_pw)); // 암호화된 비밀번호로 설정
			}
        }
        // 댓글 추가, 수정, 삭제 처리
        commentService.manageComments(cm_vo, action);
        
        return new ResponseEntity<>("ok", HttpStatus.OK);
    }

    // 댓글 목록 조회(답글 포함)
    @GetMapping("/retrieveComments/{bd_number}")
    public ResponseEntity<Map<String, Object>> retrieveComments(@PathVariable Long bd_number, 
													    		@RequestParam("page") int page) {
    	
    	log.info("페이지 번호: " + page);
    	
    	// 페이지 번호와 크기를 기반으로 Criteria 객체 생성
    	Criteria cri = new Criteria();
    	cri.setPageNum(page);
    	cri.setAmount(20); // 한 페이지당 20개의 댓글 출력

    	List<CommentVO> commentsList  = commentService.retrieveComments(bd_number, cri);
    	
    	int totalCount = commentService.getTotalCount(bd_number); // 전체 댓글 수 계산
        PageDTO pageDTO = new PageDTO(cri, totalCount); // 페이징 정보를 담은 DTO 생성

        Map<String, Object> result = new HashMap<>();
        result.put("comments", commentsList);
        result.put("pageInfo", pageDTO);

        return new ResponseEntity<>(result, HttpStatus.OK); // ResponseEntity.ok(comments)와 동일함
    }	
}
