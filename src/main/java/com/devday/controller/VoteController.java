package com.devday.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

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
@RequestMapping("/vote/*") 
@Log4j
public class VoteController {

	private final VoteService voteService;
	
	@PostMapping("/likeAction")
	public ResponseEntity<Map<String, Object>> likeAction(HttpSession session,
														  @RequestParam("bd_number") Long bd_number, 
														  @RequestParam("actionType") String actionType,
														  @RequestParam("bd_type") String bd_type) {

		Map<String, Object> map = new HashMap<>();
		
		UserVO us_vo = (UserVO) session.getAttribute("userStatus");
		String us_id = us_vo.getUs_id(); // 로그인한 상태의 사용자 아이디 가져오기
		
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
		log.info("게시판 유형: " + bd_type);
		
		// 게시판 유형에 따른 투표 처리
		VoteResultDTO vt_dto = voteService.insertVote(vt_vo, bd_type); // 투표 처리(추가, 취소, 변경)
		Date voteDate = vt_dto.getVt_register_date();
		Date serverDate = new Date();
		log.info("투표 날짜: " + voteDate);
		
		// 결과와 투표 상태, 집계된 추천/비추천 수를 map에 넣음
	    String result = vt_dto.isVoteResult() ? "success" : "cancel";
	    
	    map.put("result", result);	    
		map.put("actionType", actionType);
		map.put("likes", vt_dto.getLikesCount()); // 집계된 추천 수
		map.put("dislikes", vt_dto.getDislikesCount()); // 집계된 비추천 수
		
		// JSON 변환 시 밀리초 단위의 타임스탬프 형식으로 전달
		map.put("voteDate", voteDate); // 투표 날짜 정보
		map.put("serverDate", serverDate); // 서버 날짜 정보

		return new ResponseEntity<>(map, HttpStatus.OK); // HTTP 상태 코드 200
	}
	
	@GetMapping("/getCurrentVoteStatus")
	public ResponseEntity<Map<String, Object>> getCurrentVoteStatus(@RequestParam("bd_number") Long bd_number, 
									   								HttpSession session) {
		
	    // 세션에서 사용자 정보 가져오기
		UserVO us_vo = (UserVO) session.getAttribute("userStatus");
		String us_id = us_vo != null ? us_vo.getUs_id() : null; // 사용자 정보가 없는 경우 비회원
	
	    // 현재 투표 상태와 수를 가져오기
	    String voteStatus = voteService.getCurrentVoteStatus(bd_number, us_id);
	    VoteVO vt_vo = voteService.getLatestVote(bd_number, us_id);
	    
	    // 캘린더 객체로 서버 날짜와 투표 날짜 설정
	    Calendar serverCal = Calendar.getInstance();
	    Calendar voteCal = Calendar.getInstance();
	    
	    if (vt_vo != null && vt_vo.getVt_register_date() != null) {
	        voteCal.setTime(vt_vo.getVt_register_date()); // 투표 날짜로 설정
	    } else {
	        voteCal = null; // 투표 날짜가 없는 경우
	    }

	    // 클라이언트에 전달할 날짜
	    Date serverDate = serverCal.getTime();
	    Date voteDate = voteCal != null ? voteCal.getTime() : null;
	    
	    Map<String, Integer> voteCounts = voteService.countVoteStatus(bd_number);
	    Map<String, Object> result = new HashMap<>();
	    
	    result.put("voteStatus", voteStatus);
	    result.putAll(voteCounts); 
	    log.info("투표 집계: " + voteCounts); // {like=개수, dislike=개수}
	 
	    result.put("voteDate", voteDate); // 투표 등록 날짜
	    result.put("serverDate", serverDate); // 현재 서버 날짜

	    log.info("반환 컬럼: " + result.keySet());
	    
	    return new ResponseEntity<>(result, HttpStatus.OK);
	}

}
