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
	
	// 로그인 정보
	private String mem_id; // 회원 아이디
	private String mem_pw; // 회원 비밀번호
	
	// 회원 정보
	private String mem_name; // 회원 이름
	private String mem_phone; // 회원 전화번호
	private String mem_email; // 회원 이메일
	private String mem_postcode; // 회원 우편번호
	private String mem_addr; // 회원 주소
	private String mem_deaddr; // 회원 상세주소
	
	private int mem_point; // 회원 포인트(DEFAULT 0)
	private Date mem_joindate; // 가입일자(DEFAULT sysdate) 
	private Date mem_updatedate; // 수정일자(DEFAULT sysdate)
	private Date mem_lastlogin; // 마지막 접속일자(DEFAULT sysdate)

	private int adm_check; // 관리자 구분(0:일반사용자, 1:관리자)
}
