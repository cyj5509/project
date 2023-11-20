package com.devday.domain;

import java.util.Date;

import lombok.Data;

/*
CREATE TABLE payment_tbl (
	pay_code          NUMBER PRIMARY KEY,    
  	ord_code          NUMBER NOT NULL,        
  	mem_id            VARCHAR2(50) NOT NULL, 
  	pay_method        VARCHAR2(50) NOT NULL, 
  	pay_date          DATE  NULL,             
  	pay_tot_price     NUMBER NOT NULL,			
	pay_nobank_price  NUMBER NULL,	
  	pay_nobank_user   VARCHAR2(50) NULL,    
  	pay_nobank        VARCHAR2(50) NULL,     
  	pay_memo          VARCHAR2(50) NULL         
  	pay_bankaccount   VARCHAR2(50) NULL 
);
*/

@Data
public class PaymentVO {

	// 기본타입은 클라이언트에서 값을 전달해줘야 한다. 참조타입은 null로 처리될 수 있어 400번 에러를 피할 수 있음
	
	private Integer pay_code; // 일련번호
	private Long ord_code; // 주문번호
	private String mem_id; // 회원 ID
	private String pay_method; // 결제방식
	private Date pay_date; // 걀제일
	private Integer pay_tot_price; // 결제금액: private int pay_tot_price;
	
	// 이하 Null로 처리
	private Integer pay_nobank_price; // 무통장 입금금액: private int pay_nobank_price;
	private String pay_nobank_user; // 무통장 입금자명
	private String pay_nobank; // 입금은행
	private String pay_memo; // 메모
	private String pay_bankaccount; // 입금계좌번호
}
