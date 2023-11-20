package com.devday.domain;

import java.util.Date;

import lombok.Data;

/*
CREATE TABLE order_bs_tbl(
        ord_code            NUMBER                  PRIMARY KEY,
        mem_id              VARCHAR2(15)            NOT NULL,
        ord_name            VARCHAR2(30)            NOT NULL,
        ord_postcode        CHAR(5)                 NOT NULL,
        ord_addr_basic      VARCHAR2(50)            NOT NULL,
        ord_addr_detail     VARCHAR2(50)            NOT NULL,
        ord_tel             VARCHAR2(20)            NOT NULL,
        ord_price           NUMBER                  NOT NULL,  
        ord_regdate         DATE DEFAULT sysdate    NOT NULL,
        ord_status          VARCHAR2(20)            NOT NULL,
        payment_status      VARCHAR2(20)            NOT NULL,
        FOREIGN KEY(mem_id) REFERENCES member_tbl(mem_id)
);
*/

@Data
public class OrderBasicVO {

	private Long ord_code; // 주문 번호: DB의 시퀀스 사용
	private String mem_id; // 회원 아이디: 인증 세션에서 처리
	
	// 주문정보 페이지 전송에서 받음
	private String ord_name; // 주문자명
	private String ord_postcode; // 우편번호
	private String ord_addr_basic; // 기본 주소
	private String ord_addr_detail; // 상세 주소
	private String ord_tel; // 전화번호
	private Integer ord_price; //  총 주문 금액
	
	private Date ord_regdate; // 주문 일자: 내부적으로 처리(sysdate)
	
	private String ord_status; // 주문 상태
	private String payment_status; // 결제 상태
	
}
