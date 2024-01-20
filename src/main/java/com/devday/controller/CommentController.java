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
	public ResponseEntity<Object> manageComments(@RequestBody CommentVO cm_vo, @RequestParam("action") String action,
			HttpSession session) {

		log.info("작업 유형: " + action);
		log.info("댓글 데이터: " + cm_vo);

		// 응답 객체 초기화
		Map<String, Object> response = new HashMap<>();

		// 세션에서 사용자 상태 확인
		UserVO us_vo = (UserVO) session.getAttribute("userStatus");

		// 세션 기반 권한 관리가 아닌 요청마다 권한을 검증하는 방식 채택(UsBoardController와 상이함)
		if (us_vo != null) {
			// 회원이 자신이나 다른 사용자의 댓글을 수정/삭제하는 경우
			if (cm_vo.getUs_id() == null) {
				// 회원이 비회원 댓글을 수정/삭제하는 경우, 비밀번호 검증 진행
				Map<String, Object> guestResponse = handleGuestComment(cm_vo, action);
				if (guestResponse != null && "fail".equals(guestResponse.get("status"))) {
					log.info("비회원 댓글에 대한 비밀번호 인증 실패: " + guestResponse);
					// 인증 실패(비밀번호 불일치 등)의 경우, 오류 메시지와 함께 인증 실패 응답 반환
					return new ResponseEntity<>(guestResponse, HttpStatus.FORBIDDEN); // 상태 코드 403
				}
			} else if (!us_vo.getUs_id().equals(cm_vo.getUs_id())) {
				// 회원이 다른 회원의 댓글을 수정/삭제 시도 시 
				cm_vo.setCm_guest_pw(null); // 비회원 비밀번호를 null로 설정
				Map<String, String> errorResponse = new HashMap<>(); // 클라이언트에 전달(반환)할 오류 메시지를 담는 변수
				errorResponse.put("message", "해당 작업을 수행할 권한이 없습니다.");
				return new ResponseEntity<>(errorResponse, HttpStatus.UNAUTHORIZED); // 상태 코드 401
			}
		} else {
			// cm_vo.setUs_id(null); // 회원 아이디를 null로 설정
			// 비회원의 댓글 수정/삭제에 대한 비밀번호 검증 절차 진행
			Map<String, Object> guestResponse = handleGuestComment(cm_vo, action);
			if (guestResponse != null && "fail".equals(guestResponse.get("status"))) {
				// 인증 실패(비밀번호 불일치 등)의 경우, 오류 메시지와 함께 인증 실패 응답 반환
				return new ResponseEntity<>(guestResponse, HttpStatus.FORBIDDEN); // 상태 코드 403
			}
		}
		// 댓글 추가, 수정, 삭제 처리
		commentService.manageComments(cm_vo, action);

		// 작업 유형에 따른 응답 설정
		if (action.equals("insert")) {
			response.put("status", "ok");
			response.put("cm_code", cm_vo.getCm_code()); // 새로 추가된 cm_code 반환
		} else if (action.equals("modify") || action.equals("delete")) {
			response.put("status", "ok");
		} else {
			response.put("status", "fail");
		}
		return new ResponseEntity<>(response, HttpStatus.OK);
	}
	
	// 댓글 관리 중 비회원 댓글 처리를 위한 별도의 메서드(manageComments에서 활용함)
	private Map<String, Object> handleGuestComment(CommentVO cm_vo, String action) {

		Map<String, Object> response = new HashMap<>();
		
		// 회원 아이디가 설정되어 있는 경우, 비회원 처리 로직 생략
	    if (cm_vo.getUs_id() != null && !cm_vo.getUs_id().isEmpty()) {
	        return response;
	    }
		
		String guest_nickname = cm_vo.getCm_guest_nickname();
		String guest_pw = cm_vo.getCm_guest_pw();
		log.info("암호화 처리 전 비밀번호: " + guest_pw);

		// 비회원 닉네임 처리: 닉네임이 제공되지 않은 경우 기본값('guest') 설정
		if (guest_nickname == null || guest_nickname.trim().isEmpty()) {
			cm_vo.setCm_guest_nickname("guest");
		}

		if ("modify".equals(action) || "delete".equals(action)) {
			// 댓글 수정 또는 삭제 시 비밀번호 확인
			CommentVO db_vo = commentService.findComment(cm_vo.getCm_code()); // 특정 댓글 조회
			if (db_vo == null || !passwordEncoder.matches(guest_pw, db_vo.getCm_guest_pw())) {
				// 비밀번호가 일치하지 않는 경우
				response.put("status", "fail");
			    response.put("message", "비밀번호가 일치하지 않습니다. 다시 입력해 주세요.");
			}
		} else if (guest_pw != null && !guest_pw.isEmpty()) {
			// 비회원 비밀번호 처리: 새 댓글 추가 시 암호화
			String encodedPw = passwordEncoder.encode(guest_pw);
			cm_vo.setCm_guest_pw(encodedPw);
			log.info("암호화 처리 후 비밀번호: " + encodedPw);
		}
		
		return response;
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

		List<CommentVO> commentsList = commentService.retrieveComments(bd_number, cri);

		log.info("댓글 데이터: " + commentsList);

		int totalCount = commentService.getTotalCount(bd_number); // 전체 댓글 수 계산
		PageDTO pageDTO = new PageDTO(cri, totalCount); // 페이징 정보를 담은 DTO 생성

		Map<String, Object> result = new HashMap<>();
		result.put("comments", commentsList);
		result.put("pageInfo", pageDTO);

		return new ResponseEntity<>(result, HttpStatus.OK); // ResponseEntity.ok(comments)와 동일함
	}
}
