package com.devday.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/*
CREATE TABLE product_tbl(
        prd_num                 NUMBER CONSTRAINT pk_prd_tbl PRIMARY KEY,
        cg_code                 NUMBER                  NULL,
        prd_name                VARCHAR2(50)            NOT NULL,
        prd_price               NUMBER                  NOT NULL,
        prd_discount            NUMBER                  NOT NULL,
        prd_publisher           VARCHAR2(50)            NOT NULL,
        prd_content             VARCHAR2(4000)          NOT NULL,   
        prd_up_folder           VARCHAR2(50)            NOT NULL,
        prd_img                 VARCHAR2(100)           NOT NULL,  -- 크기 변경으로 새로 작업해야 함
        prd_amount              NUMBER                  NOT NULL,
        prd_buy                 CHAR(1)		           NOT NULL, // 판매 여부 타입 변경으로 새로 작업해야 함
        prd_date                DATE DEFAULT sysdate    NOT NULL,
        prd_updatedate          DATE DEFAULT sysdate    NOT NULL,
        FOREIGN KEY(cg_code)    REFERENCES category_tbl(cg_code)
);
*/

@Data
public class ProductVO {

	// prd_nun, prd_up_folder, prd_img, prd_date, prd_updatedate는 직접 입력 받지 않음
	
	private Integer prd_num; // 시퀀스 생성(사용자로부터 직접 입력받지 않음)
	private Integer cg_code; // cg_code: 2차 카테고리 코드
	private String prd_name;
	private int prd_price;
	private int prd_discount;

	private String prd_publisher;
	private String prd_content;
	private String prd_up_folder; // 클라이언트에서 직접 입력받지 않고 스프링에서 별도로 처리(매퍼 작업)
	private String prd_img; // 클라이언트에서 직접 입력받지 않고 스프링에서 별도로 처리(매퍼 작업)
	
	private int prd_amount;
	private String prd_buy;
	
	private Date prd_date;
	private Date prd_updatedate; //직접 입력 받지 않음
	
	// private MultipartFile uploadFile; 여기서 작성하거나 컨트롤러에서 매개변수로 활용
}
