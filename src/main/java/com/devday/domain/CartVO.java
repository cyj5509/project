package com.devday.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CartVO {

/*
CREATE TABLE CART_TBL(
        CART_CODE        NUMBER,
        PRO_NUM         NUMBER          NOT NULL,
        MBSP_ID         VARCHAR2(15)    NOT NULL,
        CART_AMOUNT      NUMBER          NOT NULL,
        FOREIGN KEY(PRO_NUM) REFERENCES PRODUCT_TBL(PRO_NUM),
        FOREIGN KEY(MBSP_ID) REFERENCES MBSP_TBL(MBSP_ID),
        CONSTRAINT PK_CART_CODE primary key(CART_CODE) 
);
*/
	
	private Long cart_code;
	
	private Integer pro_num;
	private String mbsp_id;
	
	private int cart_amount;
}
