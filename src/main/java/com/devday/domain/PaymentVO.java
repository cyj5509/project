package com.devday.domain;

import java.util.Date;

import lombok.Data;

/*
CREATE TABLE payment_table (
    pm_number               NUMBER CONSTRAINT pk_pm_code PRIMARY KEY, -- 결제 번호
    od_number               NUMBER NOT NULL,                          -- 주문 번호
    us_id                   VARCHAR2(50) NOT NULL,                    -- 사용자 아이디
    pm_method               VARCHAR2(50) NOT NULL,                    -- 결제 방식
    pm_complete_date        DATE DEFAULT sysdate NULL,                -- 결제 완료 일자
    pm_total_price          NUMBER NOT NULL,                          -- 결제 금액
    pm_no_bankbook_bank     VARCHAR2(50) NULL,                        -- 무통장 입금은행
    pm_no_bankbook_account  VARCHAR2(50) NULL,                        -- 무통장 입금계좌
    pm_no_bankbook_price    NUMBER NULL,                              -- 무통장 입금금액
    pm_no_bankbook_user     VARCHAR2(50) NULL,                        -- 무통장 입금자명
    pm_memo                 VARCHAR2(50) NULL                         -- 메모
);
*/

@Data
public class PaymentVO {

	// 기본타입은 클라이언트에서 값을 전달해줘야 한다. 참조타입은 null로 처리될 수 있어 400번 에러를 피할 수 있음
	
	private Integer pm_number; // 일련번호
	private Long od_number; // 주문번호
	private String us_id; // 회원 ID
	private String pm_method; // 결제방식
	private Date pm_complete_date; // 걀제일
	private Integer pm_total_price; // 결제금액: private int pm_tot_price;
	
	// 이하 Null로 처리
	private String pm_no_bankbook_bank; // 입금은행
	private String pm_no_bankbook_account; // 입금계좌번호
	private Integer pm_no_bankbook_price; // 무통장 입금금액: private int pm_nobank_price;
	private String pm_no_bankbook_user; // 무통장 입금자명
	private String pm_memo; // 메모
}
