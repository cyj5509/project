package com.devday.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
CREATE TABLE CART_TBL(
        CART_CODE       NUMBER,
        PRD_NUM         NUMBER          NOT NULL,
        MEM_ID          VARCHAR2(15)    NOT NULL,
        CART_AMOUNT     NUMBER          NOT NULL,
        FOREIGN KEY(PRD_NUM) REFERENCES PRODUCT_TBL(PRD_NUM),
        FOREIGN KEY(MEM_ID) REFERENCES MEMBER_TBL(MEM_ID),
        CONSTRAINT PK_CART_CODE primary key(CART_CODE) 
);
*/

@Getter
@Setter
@ToString
public class CartVO {
	
	private Long cart_code; // 장바구니 코드: 시퀀스를 통해 처리. 그 외 나머지는 Ajax 처리(pro_list.jsp 참고)
	private Integer prd_num; // 상품 코드
	private String user_id; // 회원아이디: 세션 활용
	private int cart_amount; // 장바구니 수량
}
