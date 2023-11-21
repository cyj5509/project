package com.devday.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/*
CREATE TABLE product_tbl(
    pd_number            NUMBER CONSTRAINT product_pk PRIMARY KEY, -- 상품 번호
    cg_code              NUMBER                NULL,               -- 카테고리 코드(2차 이후)
    pd_name              VARCHAR2(50)          NOT NULL,           -- 상품 이름
    pd_price             NUMBER                NOT NULL,           -- 상품 가격
    pd_discount          NUMBER                NOT NULL,           -- 상품 할인율
    pd_company           VARCHAR2(50)          NOT NULL,           -- 상품 제조사(또는 출판사)
    pd_content           VARCHAR2(4000)        NOT NULL,           -- 상품 상세 내용
    pd_img_folder        VARCHAR2(50)          NOT NULL,           -- 상품 이미지 폴더명
    pd_img               VARCHAR2(100)         NOT NULL,           -- 상품 이미지
    pd_amount            NUMBER                NOT NULL,           -- 상품 수량
    pd_buy_status        CHAR(1)               NOT NULL,           -- 판매 여부
    pd_register_date     DATE DEFAULT sysdate  NOT NULL,           -- 등록일자
    pd_update_date       DATE DEFAULT sysdate  NOT NULL,           -- 수정일자
    FOREIGN KEY(cg_code) REFERENCES category_tbl(cg_code)
);
*/

@Data
public class ProductVO {

	// pd_nun, pd_up_folder, pd_img, pd_date, pd_updatedate는 직접 입력 받지 않음
	
	private Integer pd_number; // 시퀀스 생성(사용자로부터 직접 입력받지 않음)
	private Integer cg_code; // cg_code: 2차 카테고리 코드
	private String pd_name;
	private int pd_price;
	private int pd_discount;

	private String pd_company;
	private String pd_content;
	private String pd_img_folder; // 클라이언트에서 직접 입력받지 않고 스프링에서 별도로 처리(매퍼 작업)
	private String pd_img; // 클라이언트에서 직접 입력받지 않고 스프링에서 별도로 처리(매퍼 작업)
	
	private int pd_amount;
	private String pd_buy_status;
	
	private Date pd_register_date;
	private Date pd_update_date; //직접 입력 받지 않음
	
	// private MultipartFile uploadFile; 여기서 작성하거나 컨트롤러에서 매개변수로 활용
}
