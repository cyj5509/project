package com.devday.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
CREATE TABLE category_table (
    cg_code         NUMBER        CONSTRAINT pk_cg_code PRIMARY KEY,  -- 하위 카테고리 코드(1차 포함 2차 이후)
    cg_parent_code  NUMBER        NULL,                               -- 상위 카테고리 코드(1차만 해당)
    cg_name         VARCHAR2(50)  NOT NULL,                           -- 카테고리 이름(범주)
    CONSTRAINT fk_cg_parent_code FOREIGN KEY(cg_parent_code) REFERENCES category_table(cg_code)
);
*/

@Getter
@Setter
@ToString
public class CategoryVO {
	
	private Integer cg_code; // 1차든 2차든 모든 카테고리 코드
	private Integer cg_parent_code; // 1차 카테고리 코드
	private String cg_name; // 카테고리명
    private List<CategoryVO> secondCategoryList; // 2차 카테고리 목록
}
