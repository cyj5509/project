package com.devday.domain;

import java.util.Date;

import lombok.Data;

/*
CREATE TABLE admin_table (
    ad_id          VARCHAR2(15),                            -- 관리자 아이디
    ad_pw          VARCHAR2(60)                NOT NULL,    -- 관리자 비밀번호
    ad_last_login   DATE    DEFAULT   sysdate  NOT NULL,    -- 접속 일자
    CONSTRAINT pk_ad_id PRIMARY KEY(ad_id)
);
*/

@Data
public class AdminVO {

	private String ad_id;
	private String ad_pw;
	private Date ad_last_login;
}
