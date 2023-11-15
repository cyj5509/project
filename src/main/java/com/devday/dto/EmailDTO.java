package com.devday.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
// 기존 @AllArgsConstructor는 정적 팩토리 메서드에서 완성된 객체를 반환하고 있기 때문에 불필요한 코드라서 생략
public class EmailDTO {
	
	private String senderName; // 발신할 이름(공통 필드)
	private String senderMail; // 발신할 메일 주소(공통 필드)
	private String receiverMail; // 수신할 메일 주소: 클라이언트 측에서 제공된 회원 메일주소
	private String subject; // 메일 제목
	private String content; // 메일 내용
	
	// 기본 생성자 생성: 공통 필드에 값을 할당하여 객체를 초기화 
	public EmailDTO() {
        this.senderName = "DevDay";
        this.senderMail = "admin@devday.com";
    }
	
	// 보조 생성자 생성: 중복 방지용으로 해당 클래스 내에서만 사용하기 위해 private 사용 
    private EmailDTO(String receiverMail, String subject, String content) {
   		// this(): 기본 생성자를 호출하여 senderName과 senderMail 초기화 
        this(); // 미작성 시 정적 팩토리 메서드에서 미완성된 객체가 반환되는 결과 초래 
        
        this.receiverMail = receiverMail;
        this.subject = subject;
        this.content = content;
    }

    // 정적 팩토리 메서드 네이밍 컨벤션에 따른 메서드명 'of~': 여러 매개변수를 통해 해당 클래스의 인스턴스 반환 시
    
	// 회원가입, 아이디 및 비밀번호 찾기 관련 메서드(정적 팩토리 메서드 1)
    public static EmailDTO ofAuthCode(String receiverMail, String authCode) {
        String subject = "DevDay 메일 인증번호 안내";
        String content = "인증번호는 " + authCode + "입니다.";
        
        // new EmailDTO(receiverMail, subject, content): 세 개의 매개변수를 받는 보조 생성자 호출
        return new EmailDTO(receiverMail, subject, content); // 완성된 객체 반환
    }

	// 임시 비빌번호 발송 관련 메서드(정적 팩토리 메서드 2)
    public static EmailDTO ofTempPw(String receiverMail, String tempPassword) {
        String subject = "DevDay 임시 비밀번호 안내";
        String content = "로그인을 위한 임시 비밀번호는 " + tempPassword + "입니다.";
        
        // new EmailDTO(receiverMail, subject, content): 세 개의 매개변수를 받는 보조 생성자 호출
        return new EmailDTO(receiverMail, subject, content); // 완성된 객체 반환
    }
}
