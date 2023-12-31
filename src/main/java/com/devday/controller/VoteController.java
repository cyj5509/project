package com.devday.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.devday.domain.BoardVO;
import com.devday.domain.UserVO;
import com.devday.domain.VoteVO;
import com.devday.dto.VoteResultDTO;
import com.devday.service.UsBoardService;
import com.devday.service.VoteService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController // AJAX로만 활용(JSP 파일 미사용)
@RequiredArgsConstructor
@RequestMapping("/user/board/*") 
@Log4j
public class VoteController {

	private final VoteService voteService;
	private final UsBoardService usBoardService;
	
	@PostMapping("/likeAction")
	public ResponseEntity<Map<String, Object>> likeAction(HttpSession session,
														  @RequestParam("bd_number") Long bd_number, 
														  @RequestParam("actionType") String actionType) {

		Map<String, Object> map = new HashMap<>();
		
		UserVO us_vo = (UserVO) session.getAttribute("userStatus");
		if (us_vo == null) { 
			// 비회원인 경우 처리
	        map.put("msg", "비회원은 해당 기능을 사용할 수 없습니다."); // 비회원 접근 오류 메시지
	        return new ResponseEntity<>(map, HttpStatus.UNAUTHORIZED); // HTTP 상태 코드 401
	    }
		
		// 사용자가 로그인한 상태
		String us_id = us_vo.getUs_id();
		
		log.info("타입 선택: " + actionType);
		
		// 유효성 검사: actionType이 유효한지 확인
		if (!actionType.equals("like") && !actionType.equals("dislike") && !actionType.equals("none")) {
			
			map.put("msg", "오류가 발생했습니다. 나중에 다시 시도해 주세요.");
			return new ResponseEntity<>(map, HttpStatus.BAD_REQUEST); // HTTP 상태 코드 400
		}
		
		VoteVO vt_vo = new VoteVO();
		vt_vo.setUs_id(us_id);
		vt_vo.setBd_number(bd_number);
		vt_vo.setVt_status(actionType);
		
		log.info("게시물 투표 데이터: " + vt_vo);

		BoardVO bd_vo = usBoardService.get(bd_number, true);
		log.info("게시판 유형: " + bd_vo.getBd_type());
		
		VoteResultDTO vt_dto = voteService.insertVote(vt_vo, bd_vo.getBd_type()); // 투표 처리(추가, 취소, 변경)
		
		// 결과와 투표 상태, 집계된 추천/비추천 수를 map에 넣음
	    String result = vt_dto.isVoteResult() ? "success" : "cancel";
	    
	    map.put("result", result);	    
		map.put("actionType", actionType);
		map.put("likes", vt_dto.getLikesCount()); // 집계된 추천 수
		map.put("dislikes", vt_dto.getDislikesCount()); // 집계된 비추천 수
		map.put("voteDate", vt_dto.getVt_register_date()); // JSON 변환 시 밀리초 단위의 타임스탬프 형식으로 전달
		map.put("serverDate", new Date()); // 현재 서버 날짜 및 시간

		return new ResponseEntity<>(map, HttpStatus.OK); // HTTP 상태 코드 200
	}
	
	@GetMapping("/getCurrentVoteStatus")
	public ResponseEntity<Map<String, Object>> getCurrentVoteStatus(@RequestParam("bd_number") Long bd_number, 
									   HttpSession session, HttpServletRequest request) {
		
	    // 세션에서 사용자 정보 가져오기
		UserVO us_vo = (UserVO) session.getAttribute("userStatus");
		String us_id = us_vo != null ? us_vo.getUs_id() : null; // 세션에 사용자 정보가 없는 경우 비회원
	
	    // 현재 투표 상태와 수를 가져오는 로직
	    String voteStatus = voteService.getCurrentVoteStatus(bd_number, us_id);
	    VoteVO vt_vo = voteService.getLatestVote(bd_number, us_id);
	    
	    Map<String, Integer> voteCounts = voteService.countVoteStatus(bd_number); 	
	    Map<String, Object> result = new HashMap<>();
	    
	    result.put("voteStatus", voteStatus);
	    result.putAll(voteCounts); 
	    log.info("투표 집계: " + voteCounts); // {like=개수, dislike=개수}
	    
	    result.put("voteDate", vt_vo != null ? vt_vo.getVt_register_date() : null);
	    result.put("serverDate", new Date()); // 현재 서버 날짜 및 시간

	    log.info("반환 컬럼: " + result.keySet());
	    
	    return new ResponseEntity<>(result, HttpStatus.OK);
	}

}
