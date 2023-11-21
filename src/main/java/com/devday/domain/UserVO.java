package com.devday.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
CREATE TABLE user_tbl (
    us_id            VARCHAR2(15),                        -- 회원 아이디
    us_pw            VARCHAR2(60)               NOT NULL, -- 회원 비밀번호
    us_name          VARCHAR2(30)               NOT NULL, -- 회원 이름
    us_email         VARCHAR2(50)               NOT NULL, -- 회원 이메일 
    us_phone         VARCHAR2(15)               NOT NULL, -- 회원 전화번호
    us_postcode      CHAR(5)                    NOT NULL, -- 회원 우편번호
    us_addr_basic    VARCHAR2(100)              NOT NULL, -- 회원 기본주소
    us_addr_detail   VARCHAR2(100)              NOT NULL, -- 회원 상세주소
    us_point         NUMBER  DEFAULT   0        NOT NULL, -- 회원 포인트
    us_join_date     DATE    DEFAULT   sysdate  NOT NULL, -- 회원 가입일자
    us_update_date   DATE    DEFAULT   sysdate  NOT NULL, -- 회원 수정일자
    us_last_login    DATE    DEFAULT   sysdate  NOT NULL, -- 회원 접속일자
    us_status        NUMBER  DEFAULT   0        NOT NULL, -- 회원 상태(관리자: 1, 사용자: 0)
    CONSTRAINT user_pk PRIMARY KEY(us_id)
);
*/

@Getter
@Setter
@ToString
public class UserVO {
	
	// 로그인을 위한 식별 정보
	private String us_id; // 회원 아이디
	// @Getter & @Setter ─ us_id
	/*
	public String getus_id() {
		return us_id;
	}
	public void setus_id(String us_id) {
		this.us_id = us_id;
	}
	*/ 
	private String us_pw; // 회원 비밀번호
	
	// 회원 정보(개인 정보)
	private String us_name; // 회원 이름
	private String us_phone; // 회원 전화번호
	private String us_email; // 회원 이메일
	private String us_postcode; // 회원 우편번호
	private String us_addr; // 회원 기본 주소 -> us_addr_basic
	private String us_deaddr; // 회원 상세주소 -> us_addr_detail
	private int us_point; // 회원 포인트(DEFAULT 0)
	private Date us_join_date; // 가입 일자(DEFAULT sysdate) 
	private Date us_update_date; // 수정 일자(DEFAULT sysdate)
	private Date us_last_login; // 접속 일자(DEFAULT sysdate)
	private int us_status; // 회원 상태(DEFAULT 0: 사용자 / 1: 관리자)
	
	// @ToString
	/*
	@Override
	public String toString() {
		return "MemberVO [us_id=" + us_id + ", us_pw=" + us_pw + ", us_name=" + us_name + ", us_phone="
				+ us_phone + ", us_email=" + us_email + ", us_postcode=" + us_postcode + ", us_addr=" + us_addr
				+ ", us_deaddr=" + us_deaddr + ", us_point=" + us_point + ", us_joindate=" + us_joindate
				+ ", us_updatedate=" + us_updatedate + ", us_lastlogin=" + us_lastlogin + ", adm_check=" + adm_check
				+ "]";
	}
	*/
}
