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
    bd_number         NUMBER,                           -- 게시물 번호
    bd_type           VARCHAR2(40)            NOT NULL, -- 게시물 구분(타입)
    us_id             VARCHAR2(15)            NOT NULL, -- 사용자 아이디
    bd_title          VARCHAR2(100)           NOT NULL, -- 게시물 제목
    bd_content        VARCHAR2(4000)          NOT NULL, -- 게시물 내용
    bd_register_date  DATE    DEFAULT sysdate,          -- 등록 일자
    bd_update_date    DATE    DEFAULT sysdate,          -- 수정 일자
    bd_view_count     NUMBER  DEFAULT 0,                -- 조회수
    CONSTRAINT pk_bd_number PRIMARY KEY(bd_number)
);
*/	
	private Long bd_number;
	private String bd_type;
	private String us_id;
	private String bd_title;
	private String bd_content;
	private Date bd_register_date;
	private Date bd_update_date;
	private int bd_view_count;
}
