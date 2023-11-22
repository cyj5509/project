package com.devday.domain;

/*
CREATE TABLE review_table(
	    rv_number         NUMBER,                         -- 리뷰 번호
	    us_id             VARCHAR2(15)          NOT NULL, -- 사용자 아이디
	    pd_number         NUMBER                NOT NULL, -- 상품 번호
	    rv_content        VARCHAR2(200)         NOT NULL, -- 리뷰 내용
	    rv_score          NUMBER                NOT NULL, -- 리뷰 평점
	    rv_register_date  DATE DEFAULT sysdate  NOT NULL, -- 등록 일자
	    CONSTRAINT fk_rv_us_id FOREIGN KEY(us_id) REFERENCES user_table(us_id),
	    CONSTRAINT fk_rv_pd_number FOREIGN KEY(pd_number) REFERENCES product_table(pd_number)
);
*/

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {

	// rew_num, mbsp_id, pro_num, rew_content, rew_score, rew_regdate
	
	private Long rv_number;
	private String us_id;
	private Integer pd_number;
	private String rv_content;
	private int rv_score;
	private Date rv_register_date;
}
