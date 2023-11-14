package com.devday.dto;

// import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
// @AllArgsConstructor // 기본 생성자를 구현해야 함
public class EmailDTO {

	private String senderName; // 발신자 이름
	private String senderMail; // 발신자 메일주소
	private String receiverMail; // 수신자 메일주소 즉, 회원메일 주소로 클라이언트 측에서 제공(join.jsp)
	private String subject; // 메일 제목
	private String content; // 메일 내용(본문)

	// 생성자 대신 정적 팩토리 메서드 이용
	// [참고 1] https://pamyferret.tistory.com/31
	// [참고 2] https://inpa.tistory.com/entry/GOF-%F0%9F%92%A0-%EC%A0%95%EC%A0%81-%ED%8C%A9%ED%86%A0%EB%A6%AC-%EB%A9%94%EC%84%9C%EB%93%9C-%EC%83%9D%EC%84%B1%EC%9E%90-%EB%8C%80%EC%8B%A0-%EC%82%AC%EC%9A%A9%ED%95%98%EC%9E%90
	
	// 회원가입 관련 메서드
	public static EmailDTO forJoinConfirm(String receiverMail, String authCode) {
		String subject = "DevDay 회원가입 인증코드";
		String content = "인증코드: " + authCode;
		return new EmailDTO("DevDay", "www.devday.com", receiverMail, subject, content);
	}
	
	// 비밀번호 찾기 관련 메서드
	public static EmailDTO forPwReset(String receiverMail, String tempPassword) {
		String subject = "DevDay 임시 비밀번호 안내";
		String content = "임시 비밀번호는 " + tempPassword + "입니다.";
		return new EmailDTO("DevDay", "www.devday.com", receiverMail, subject, content);
	}
	
	// @AllArgsConstructor
//	public EmailDTO() {
//
//		this.senderName = "DevDay";
//		this.senderMail = "www.devday.com";
//		this.subject = "DevDay 회원가입을 위한 메일 인증코드입니다.";
//		this.content = "하단의 인증코드를 알맞게 인증코드 입력란에 입력바랍니다.";
//	}

}
