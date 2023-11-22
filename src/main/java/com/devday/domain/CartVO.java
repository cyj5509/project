package com.devday.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
CREATE TABLE cart_tbl(
    ct_code     NUMBER,                 -- 장바구니 코드
    pd_number     NUMBER      NOT NULL, -- 상품 번호
    us_id        VARCHAR2(15) NOT NULL, -- 회원 아이디
    ct_amount   NUMBER        NOT NULL, -- 장바구니 수량
    FOREIGN KEY(pd_number) REFERENCES product_tbl(pd_number),
    FOREIGN KEY(us_id) REFERENCES mbsp_tbl(us_id),
    CONSTRAINT cart_pk PRIMARY KEY(ct_code) 
);
*/

@Getter
@Setter
@ToString
public class CartVO {
	
	private Long ct_code; // 장바구니 코드: 시퀀스를 통해 처리. 그 외 나머지는 Ajax 처리(pro_list.jsp 참고)
	private Integer pd_number; // 상품 코드
	private String us_id; // 회원아이디: 세션 활용
	private int ct_amount; // 장바구니 수량
}
