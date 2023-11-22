package com.devday.domain;

import java.util.Date;

import lombok.Data;

/*
CREATE TABLE payment_tbl (
	pm_code          NUMBER PRIMARY KEY,    
  	od_code          NUMBER NOT NULL,        
  	us_id            VARCHAR2(50) NOT NULL, 
  	pm_method        VARCHAR2(50) NOT NULL, 
  	pm_date          DATE  NULL,             
  	pm_total_price     NUMBER NOT NULL,			
	pm_nobank_price  NUMBER NULL,	
  	pm_nobank_user   VARCHAR2(50) NULL,    
  	pm_non_bank        VARCHAR2(50) NULL,     
  	pm_memo          VARCHAR2(50) NULL         
  	pm_bank_account   VARCHAR2(50) NULL 
);
*/

@Data
public class PaymentVO {

	// 기본타입은 클라이언트에서 값을 전달해줘야 한다. 참조타입은 null로 처리될 수 있어 400번 에러를 피할 수 있음
	
	private Integer pm_code; // 일련번호
	private Long od_code; // 주문번호
	private String us_id; // 회원 ID
	private String pm_method; // 결제방식
	private Date pm_date; // 걀제일
	private Integer pm_total_price; // 결제금액: private int pm_tot_price;
	
	// 이하 Null로 처리
	private Integer pm_nobank_price; // 무통장 입금금액: private int pm_nobank_price;
	private String pm_nobank_user; // 무통장 입금자명
	private String pm_nobank; // 입금은행
	private String pm_memo; // 메모
	private String pm_bank_account; // 입금계좌번호
}
