package com.devday.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
CREATE TABLE user_table (
    us_id            VARCHAR2(15),                      -- 사용자 아이디
    us_pw            VARCHAR2(60)             NOT NULL, -- 사용자 비밀번호
    us_name          VARCHAR2(30)             NOT NULL, -- 사용자 이름
    us_phone         VARCHAR2(15)             NOT NULL, -- 사용자 전화번호
    us_email         VARCHAR2(50)             NOT NULL, -- 사용자 이메일 
    us_postcode      CHAR(5)                  NOT NULL, -- 사용자 우편번호
    us_addr_basic    VARCHAR2(100)            NOT NULL, -- 사용자 기본주소
    us_addr_detail   VARCHAR2(100)            NOT NULL, -- 사용자 상세주소
    us_point         NUMBER DEFAULT 0         NOT NULL, -- 사용자 포인트
    us_join_date     DATE   DEFAULT sysdate   NOT NULL, -- 가입 일자
    us_update_date   DATE   DEFAULT sysdate   NOT NULL, -- 수정 일자
    us_last_login    DATE   DEFAULT sysdate   NOT NULL, -- 접속 일자
    us_status        NUMBER DEFAULT 0         NOT NULL, -- 사용자 상태(사용자: 0, 관리자: 1)
    CONSTRAINT pk_us_id PRIMARY KEY(us_id)
);
*/

@Getter
@Setter
@ToString
public class UserVO {
	
	// 로그인을 위한 식별 정보
	private String us_id; 
	private String us_pw; // 암호화된 비밀번호
	
	// 회원 정보(개인 정보)
	private String us_name;
	private String us_phone;
	private String us_email;
	private String us_postcode;
	private String us_addr_basic;
	private String us_addr_detail;
	private int us_point;
	private Date us_join_date;
	private Date us_update_date;
	private Date us_last_login;
	private Integer us_status;
	
	// @ToString
	/*
	@Override
	public String toString() {
		return "UserVO [us_id=" + us_id + ", us_pw=" + us_pw + ", us_name=" + us_name + ", us_phone=" + us_phone
				+ ", us_email=" + us_email + ", us_postcode=" + us_postcode + ", us_addr_basic=" + us_addr_basic
				+ ", us_addr_detail=" + us_addr_detail + ", us_point=" + us_point + ", us_join_date=" + us_join_date
				+ ", us_update_date=" + us_update_date + ", us_last_login=" + us_last_login + ", us_status=" + us_status
				+ "]";
	}
	*/

}
