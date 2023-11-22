package com.devday.domain;

import lombok.Data;

/*
CREATE TABLE order_detail_table (
    od_number     NUMBER    NOT NULL CONSTRAINT fk_dt_od_number REFERENCES order_basic_table(od_number),  -- 주문 번호
    pd_number     NUMBER    NOT NULL CONSTRAINT fk_dt_pd_number REFERENCES product_table(pd_number),      -- 상품 번호
    od_amount     NUMBER    NOT NULL,                                                                     -- 개별 수량
    od_price      NUMBER    NOT NULL,                                                                     -- 개별 가격
    CONSTRAINT ck_dt_number PRIMARY KEY (od_number, pd_number)
);
*/

@Data
public class OrderDetailVO {

	private Long od_number; // 주문번호: 시퀀스로 처리
	private Integer pd_number; // 상품코드
	private int od_amount; // 개별 상품 개수: 카트 쪽에서 받아옴
	private int od_price; // 개별 상품 가격: 카트 쪽에서 받아옴
}
