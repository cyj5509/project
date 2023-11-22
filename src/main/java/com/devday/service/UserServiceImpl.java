package com.devday.service;

import java.util.UUID;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.devday.domain.UserVO;
import com.devday.dto.EmailDTO;
import com.devday.dto.FindInfoDTO;
import com.devday.mapper.UserMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class UserServiceImpl implements UserService {

	private final UserMapper userMapper; // MemberMapper 인터페이스
	private final EmailService emailService; // EmailService 인터페이스 implements EmailServiceImpl 클래스
	
	// spring-security.xml의 <bean id="bCryptPasswordEncoder" class="org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder">
	// PasswordEncoder 인터페이스 implements BCryptPasswordEncoder 클래스
	private final PasswordEncoder passwordEncoder;
	
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
	
	// 로그인 관련 메서드
	@Override
	public UserVO login(String us_id) {

		return userMapper.login(us_id);
	}
	
	// 접속일자 업데이트 관련 메서드
	@Override
	public void loginTimeUpdate(String us_id) {

		userMapper.loginTimeUpdate(us_id);
	}
	
	// 아이디 찾기 관련 메서드
	@Override
	public UserVO findId(FindInfoDTO findInfoDTO) {
	
		return userMapper.findId(findInfoDTO);
		
	}

//	// 비밀번호 찾기 관련 메서드
//	@Override
//	public int findPw(FindInfoDTO findInfoDTO) {
//		
//		return userMapper.findPw(findInfoDTO);
//	}
	
	@Override
	public boolean isUserForId(String us_name, String us_email) {
	    FindInfoDTO findInfoDTO = FindInfoDTO.ofFindId(us_name, us_email);
	    lo
	    
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
