package com.devday.domain;

import lombok.Data;

/*
CREATE TABLE order_detail_tbl (
        od_code        NUMBER      NOT NULL REFERENCES order_tbl(ord_code),
        pd_number         NUMBER      NOT NULL REFERENCES product_tbl(prd_num),
        dt_amount       NUMBER      NOT NULL,
        dt_price        NUMBER      NOT NULL,  
        PRIMARY KEY (ord_code, prd_num) 
);
*/

@Data
public class OrderDetailVO {

	private Long od_code; // 주문번호: 시퀀스로 처리
	private Integer pd_number; // 상품코드
	private int dt_amount; // 개별 상품 개수: 카트 쪽에서 받아옴
	private int dt_price; // 개별 상품 가격: 카트 쪽에서 받아옴
}
