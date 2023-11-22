package com.devday.domain;

import java.util.Date;

import lombok.Data;

/*
CREATE TABLE order_basic_tbl(
    od_number         NUMBER CONSTRAINT order_basic_pk PRIMARY KEY, -- 주문 번호
    us_id             VARCHAR2(15)          NOT NULL,               -- 회원 아이디
    od_name           VARCHAR2(30)          NOT NULL,               -- 주문자의 이름
    od_phone          VARCHAR2(20)          NOT NULL,               -- 주문자의 전화번호
    od_postcode       CHAR(5)               NOT NULL,               -- 주문자의 우편번호
    od_addr_basic     VARCHAR2(50)          NOT NULL,               -- 주문자의 기본 주소
    od_addr_detail    VARCHAR2(50)          NOT NULL,               -- 주문자의 상세 주소
    od_total_price    NUMBER                NOT NULL,               -- 주문 상품 전체 수량
    od_date           DATE DEFAULT sysdate  NOT NULL,               -- 주문 일자
    od_status         VARCHAR2(20)          NOT NULL,               -- 주문 상태
    pm_status         VARCHAR2(20)          NOT NULL,               -- 결제 상태
    FOREIGN KEY(us_id) REFERENCES user_tbl(us_id)
);
*/

@Data
public class OrderBasicVO {

	private Long od_code; // 주문 번호: DB의 시퀀스 사용
	private String us_id; // 회원 아이디: 인증 세션에서 처리
	
	// 주문정보 페이지 전송에서 받음
	private String od_name; // 주문자명
	private String od_postcode; // 우편번호
	private String od_addr_basic; // 기본 주소
	private String od_addr_detail; // 상세 주소
	private String od_phone; // 전화번호
	private Integer od_total_price; //  총 주문 금액
	
	private Date od_register_date; // 주문 등록일자: 내부적으로 처리(sysdate)
	
	private String od_status; // 주문 상태
	private String pm_status; // 결제 상태
}
