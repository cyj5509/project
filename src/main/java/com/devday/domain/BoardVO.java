package com.devday.domain;

import java.util.Date;

// import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// @Data
@Getter
@Setter
@ToString
public class BoardVO {

/*
CREATE TABLE board_table (
    bd_number         NUMBER,                             -- 게시물 번호
    bd_type           VARCHAR2(40)              NOT NULL, -- 게시물 구분
    us_id             VARCHAR2(40),                       -- 사용자 아이디(NULL 허용)
    bd_title          VARCHAR2(100)             NOT NULL, -- 게시물 제목
    bd_content        VARCHAR2(4000)            NOT NULL, -- 게시물 내용
    bd_register_date  DATE    DEFAULT sysdate   NOT NULL, -- 등록 일자
    bd_update_date    DATE    DEFAULT sysdate   NOT NULL, -- 수정 일자
    bd_view_count     NUMBER  DEFAULT 0,                  -- 조회수
    bd_guest_nickname VARCHAR2(40),                       -- 비회원 닉네임(NULL 허용)
    bd_guest_pw       VARCHAR2(60),                       -- 비회원 비밀번호(NULL 허용)
    bd_like_count     NUMBER  DEFAULT 0,                  -- 추천 수
    bd_dislike_count  NUMBER  DEFAULT 0,                  -- 비추천 수
    CONSTRAINT pk_bd_number PRIMARY KEY(bd_number)
);
*/	
	// 회원 및 비회원 공통 필드
	private Long bd_number;
	private String us_id; // 회원 아이디
	private String bd_type;
	private String bd_title;
	private String bd_content;
	private Date bd_register_date;
	private Date bd_update_date;
	private int bd_view_count;
	
	// 비회원 전용 필드
	private String bd_guest_nickname;
	private String bd_guest_pw;
	
	// 추천 및 비추천 필드
	private int bd_like_count;
	private int bd_dislike_count;
}
