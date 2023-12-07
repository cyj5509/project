package com.devday.service;

import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.devday.domain.UserVO;
import com.devday.dto.EmailDTO;
import com.devday.dto.FindInfoDTO;
import com.devday.dto.LoginDTO;
import com.devday.mapper.UserMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class UserServiceImpl implements UserService {

	private final UserMapper userMapper; 
	private final EmailService emailService; 
	private final PasswordEncoder passwordEncoder; // [참고] security 폴더의 spring-security.xml
	
	// 회원가입 관련 메서드
	@Override
	public void join(UserVO vo) {
		
		userMapper.join(vo);
	}
	
	// 아이디 중복검사 관련 메서드
	@Override
	public String idCheck(String us_id) {
		
		return userMapper.idCheck(us_id);
	}
	
	// 일반적인 로그인 관련 메서드(SELECT 문)
	@Override
	public UserVO login(String us_id) {

		return userMapper.login(us_id);
	}
	
	//  최근 접속 일자 관련 메서드(UPDATE 문)
	@Override
	public void lastLoginTime(String us_id) {

		userMapper.lastLoginTime(us_id);
	}
	
	// 로그인 및 접속 일자 포함한 추가 메서드
	@Override
	public UserVO enhancedLogin(LoginDTO lo_dto, HttpServletResponse response) {
		
		log.info("서비스 ─ 로그인 정보: " + lo_dto);
		UserVO us_vo = login(lo_dto.getUs_id()); // 로그인 관련 메서드 호출

		// 아이디를 조건으로 한 데이터 존재 및 평문 비밀번호와 암호화된 비밀번호 일치
		if (us_vo != null && passwordEncoder.matches(lo_dto.getUs_pw(), us_vo.getUs_pw())) {
			lastLoginTime(lo_dto.getUs_id()); // 최근 접속 일자 관련 메서드 호출

			// 아이디 저장 기능이 선택된 경우, 쿠키에 사용자 아이디 저장
	        if (lo_dto.isRememberId()) {
	            Cookie cookie = new Cookie("remember_id", lo_dto.getUs_id());
	            cookie.setMaxAge(60 * 60 * 24 * 365); // 쿠키 유효기간 365일(1년)로 설정
	            cookie.setPath("/"); // 쿠키 경로 설정
	            cookie.setHttpOnly(true); // JavaScript 접근 방지
	            response.addCookie(cookie);
	        } else {
	            // 아이디 저장 기능이 선택되지 않은 경우, 쿠키 삭제
	            Cookie cookie = new Cookie("remember_id", null);
	            cookie.setMaxAge(0); // 쿠키 삭제
	            cookie.setPath("/"); // 쿠키 경로 설정
	            cookie.setHttpOnly(true); // JavaScript 접근 방지
	            response.addCookie(cookie);
	        }
	        
	        // 로그인 유지 기능이 선택된 경우, 쿠키에 로그인 정보 저장
			if (lo_dto.isRememberLogin()) {
				String loginToken = UUID.randomUUID().toString();
				Date now = new Date();
				Calendar calendar = Calendar.getInstance(); // Calendar 인스턴스 생성
				calendar.setTime(now); // 현재 날짜 및 시간으로 설정
				calendar.add(Calendar.DATE, 30); // 30일 후를 만료일로 설정
				Date expiryDate = calendar.getTime();

				us_vo.setUs_login_token(loginToken);; // 로그인 토큰 설정
				us_vo.setTk_expiry_date(expiryDate); // 토큰 만료일 설정
				updateUserToken(us_vo); // DB에 토큰 및 만료일 저장

	        		Cookie cookie = new Cookie("loginToken", loginToken);
	        		cookie.setMaxAge(60 * 60 * 24 * 30); // 쿠키 유효기간 30일로 설정
	        		cookie.setPath("/"); // 쿠키 경로 설정
	        		cookie.setHttpOnly(true); // JavaScript 접근 방지
	        		response.addCookie(cookie);
	        }
			return us_vo;
		}
		return null; // 로그인 실패
	}
	
	// 로그인 유지 관련 메서드(UPDATE 문)
	@Override
	public void updateUserToken(UserVO vo) {
		userMapper.updateUserToken(vo);
	}
	
	// 자동 로그인 처리 관련 메서드(SELECT 문)
	@Override
	public UserVO getUserByToken(String us_login_token) {
		
	    return userMapper.getUserByToken(us_login_token);
	}
	
	// 아이디 찾기 관련 메서드
	@Override
	public UserVO findId(FindInfoDTO findInfoDTO) {
	
		return userMapper.findId(findInfoDTO);
		
	}
	
	@Override
	public boolean isUserForId(String us_name, String us_email) {
	    FindInfoDTO findInfoDTO = FindInfoDTO.ofFindId(us_name, us_email);
	    
	    return userMapper.findId(findInfoDTO) != null;
	}
	
	@Override
	public boolean isUserForPw(String us_id, String us_name, String us_email) {
	    FindInfoDTO findInfoDTO = FindInfoDTO.ofFindPw(us_id, us_name, us_email);
	    return userMapper.findPw(findInfoDTO) > 0;
	}
	
	// 비밀번호 업데이트 관련 메서드
	@Override
	public boolean resetPw(FindInfoDTO findInfoDTO) {
	
		return userMapper.resetPw(findInfoDTO);
	}
	
	// 비밀번호 찾기 및 업데이트 관련 메서드
	@Override
	public boolean processFindPw(FindInfoDTO findInfoDTO) {
		
		// userMapper.findPw(findInfoDTO): 회원정보 조회 관련 메서드 호출
		int userCheck = userMapper.findPw(findInfoDTO); // int com.devday.mapper.MemberMapper.findPw(FindInfoDTO findInfoDTO)
		// 사용자가 존재하는 경우
		if (userCheck > 0) {
			// 임시 비밀번호 및 암호화된 비밀번호 생성 후 설정
			String tempPassword = UUID.randomUUID().toString().replaceAll("-", "").substring(0, 8); // 임시 비밀번호 8자리 ─ 클라이언트용
			log.info("임시 비밀번호: " + tempPassword);

			String encoPassword = passwordEncoder.encode(tempPassword); // 암호화된 비밀번호 ─ 서버용(DB 저장)
			findInfoDTO.setUs_pw(encoPassword); // 암호화된 비밀번호로 필드값 설정

			userMapper.resetPw(findInfoDTO); // DB에 암호화된 비밀번호 업데이트

			try {
				// EmailDTO.ofTempPw(receiverMail, tempPassword): 임시 비밀번호 발송을 위한 정적 팩토리 메서드 호출
				EmailDTO emailDTO = EmailDTO.ofTempPw(findInfoDTO.getUs_email(), tempPassword);
				log.info("발송할 이메일 정보: " + emailDTO);

				emailService.sendMail(emailDTO); // 메일 발송 관련 메서드 호출
				return true;
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
		}
		return false; // 사용자가 존재하지 않는 경우
	}

	@Override
	public String isPwMatch(String us_id) {

		return userMapper.isPwMatch(us_id);
	}
	
	// 회원수정 관련 메서드
	@Override
	public void modify(UserVO vo) {
		
		userMapper.modify(vo);
	}

	// 회원탈퇴 관련 메서드
	@Override
	public void delete(String us_id) {
		
		userMapper.delete(us_id);
	}
}
