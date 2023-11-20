package com.devday.domain;

import java.util.Date;

import lombok.Data;

/*
CREATE TABLE admin_tbl (
    adm_id      VARCHAR2(15),
    adm_pw      VARCHAR2(60)                NOT NULL,
    adm_con     DATE    DEFAULT   sysdate   NOT NULL,
    CONSTRAINT pk_adm_tbl PRIMARY KEY(adm_id)
);
*/

@Data
public class AdminVO {

	private String adm_id;
	private String adm_pw;
	private Date adm_con;
}
