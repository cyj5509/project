package com.devday.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.devday.domain.UserVO;
import com.devday.domain.VoteVO;
import com.devday.dto.VoteResultDTO;
import com.devday.service.VoteService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController // AJAX로만 활용(JSP 파일 미사용)
@RequiredArgsConstructor
@RequestMapping("/user/board/*") 
@Log4j
public class VoteController {

	private final VoteService voteService;
	
	@PostMapping("/likeAction")
	public ResponseEntity<Map<String, Object>> likeAction(HttpSession session,
														  @RequestParam("bd_number") Long bd_number, 
														  @RequestParam("actionType") String actionType) {

		Map<String, Object> map = new HashMap<>();
		
		UserVO us_vo = (UserVO) session.getAttribute("userStatus");
		if (us_vo == null) { // 비회원인 경우
	        map.put("result", "unauthorized"); // 비회원 접근 오류 메시지
	        return new ResponseEntity<>(map, HttpStatus.UNAUTHORIZED); // HTTP 상태 코드 401
	    }
		
		// 사용자가 로그인한 상태
		String us_id = us_vo.getUs_id();

		if (actionType == null) {
		    log.info("actionType은 null입니다.");
		} else if (actionType.isEmpty()) {
		    log.info("actionType은 빈 문자열입니다.");
		}
		
		// 유효성 검사: actionType이 유효한지 확인
		if (actionType == null || (!actionType.equals("like") && !actionType.equals("dislike"))) {
			map.put("result", "error");
			return new ResponseEntity<>(map, HttpStatus.BAD_REQUEST); // HTTP 상태 코드 400
		}

		VoteVO vt_vo = new VoteVO();

		vt_vo.setUs_id(us_id);
		vt_vo.setBd_number(bd_number);
		vt_vo.setVt_status(actionType);

		log.info("게시물 투표 데이터: " + vt_vo);

		VoteResultDTO vt_dto = voteService.insertVote(vt_vo); // 투표 처리(추가, 취소, 변경)
		
		// 결과와 투표 상태, 집계된 추천/비추천 수를 map에 넣음
	    String result = vt_dto.isVoteResult() ? "success" : null;
	    
	    map.put("result", result);
		map.put("actionType", actionType);
		map.put("likes", vt_dto.getLikesCount()); // 집계된 추천 수
		map.put("dislikes", vt_dto.getDislikesCount()); // 집계된 비추천 수


		return new ResponseEntity<>(map, HttpStatus.OK); // HTTP 상태 코드 200
	}
	
	@GetMapping("/getCurrentVoteStatus")
	public ResponseEntity<Map<String, Object>> getCurrentVoteStatus(@RequestParam("bd_number") Long bd_number, 
									   HttpSession session, HttpServletRequest request) {
		
	    // 세션에서 사용자 정보 가져오기
		UserVO us_vo = (UserVO) session.getAttribute("userStatus");
		
	    if (us_vo == null) {
	    	// 비회원인 경우 처리
	    	return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
	    } 
	    
	    String us_id = us_vo.getUs_id();
	    
	    // 현재 투표 상태와 수를 가져오는 로직
	    String voteStatus = voteService.getCurrentVoteStatus(bd_number, us_id);
	    Map<String, Integer> voteCounts = voteService.countVoteStatus(bd_number);
	    
	    Map<String, Object> result = new HashMap<>();
	    result.put("voteStatus", voteStatus);
	    result.putAll(voteCounts);
	    log.info("result 반환 컬럼: " + result.keySet());
	    
	    return new ResponseEntity<>(result, HttpStatus.OK);
	}

}
