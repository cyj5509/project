package com.devday.domain;

import lombok.Data;

/*
CREATE TABLE order_detail_table (
    od_number     NUMBER    NOT NULL CONSTRAINT fk_dt_od_number REFERENCES order_basic_table(od_number),  -- 주문 번호
    pd_number     NUMBER    NOT NULL CONSTRAINT fk_dt_pd_number REFERENCES product_table(pd_number),      -- 상품 번호
    od_amount     NUMBER    NOT NULL,                                                                     -- 상품 개별 수량
    od_price      NUMBER    NOT NULL,                                                                     -- 상품 개별 가격
    CONSTRAINT ck_dt_number PRIMARY KEY (od_number, pd_number)
);
*/

// 주문 테이블(상세)은 2개 컬럼을 대상으로 복합키 설정
// od_number만 사용 시 상품 일부가 아닌 전체 삭제, pd_number만 사용 시 타인 주문까지 삭제 

@Data
public class OrderDetailVO {

	// 테이블의 컬럼명
	private Long od_number; // 주문번호: 시퀀스로 처리
	private Integer pd_number; // 상품코드
	private int od_amount; // 개별 상품 개수: 카트 쪽에서 받아옴
	private int od_price; // 개별 상품 가격: 카트 쪽에서 받아옴(=pd_price)
}
