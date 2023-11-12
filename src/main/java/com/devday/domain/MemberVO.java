package com.devday.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
CREATE TABLE member_tbl (
    mem_id          VARCHAR2(15),
    mem_pw          CHAR(60)                    NOT NULL,  
    mem_name        VARCHAR2(30)                NOT NULL,
    mem_email       VARCHAR2(50)                NOT NULL,
    mem_phone       VARCHAR2(15)                NOT NULL,
    mem_postcode    CHAR(5)                     NOT NULL,
    mem_addr        VARCHAR2(100)               NOT NULL,
    mem_deaddr      VARCHAR2(100)               NOT NULL,
    mem_point       NUMBER  DEFAULT   0         NOT NULL,
    mem_joindate    DATE    DEFAULT   sysdate   NOT NULL,
    mem_updatedate  DATE    DEFAULT   sysdate   NOT NULL,
    mem_lastlogin   DATE    DEFAULT   sysdate   NOT NULL,
    adm_check       NUMBER  DEFAULT   0         NOT NULL,
    CONSTRAINT pk_mem_tbl PRIMARY KEY(mem_id) 
);
*/

@Getter
@Setter
@ToString
public class MemberVO {
	
	// 로그인을 위한 식별 정보
	private String mem_id; // 회원 아이디
	// @Getter & @Setter ─ mem_id
	/*
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	*/ 
	private String mem_pw; // 회원 비밀번호
	
	// 회원 정보(개인 정보)
	private String mem_name; // 회원 이름
	private String mem_phone; // 회원 전화번호
	private String mem_email; // 회원 이메일
	private String mem_postcode; // 회원 우편번호
	private String mem_addr; // 회원 주소
	private String mem_deaddr; // 회원 상세주소
	private int mem_point; // 회원 포인트(DEFAULT 0)
	private Date mem_joindate; // 가입 일자(DEFAULT sysdate) 
	private Date mem_updatedate; // 수정 일자(DEFAULT sysdate)
	private Date mem_lastlogin; // 접속 일자(DEFAULT sysdate)
	private int adm_check; // 회원 상태(DEFAULT 0: 사용자 / 1: 관리자)
	
	// @ToString
	/*
	@Override
	public String toString() {
		return "MemberVO [mem_id=" + mem_id + ", mem_pw=" + mem_pw + ", mem_name=" + mem_name + ", mem_phone="
				+ mem_phone + ", mem_email=" + mem_email + ", mem_postcode=" + mem_postcode + ", mem_addr=" + mem_addr
				+ ", mem_deaddr=" + mem_deaddr + ", mem_point=" + mem_point + ", mem_joindate=" + mem_joindate
				+ ", mem_updatedate=" + mem_updatedate + ", mem_lastlogin=" + mem_lastlogin + ", adm_check=" + adm_check
				+ "]";
	}
	*/
}
