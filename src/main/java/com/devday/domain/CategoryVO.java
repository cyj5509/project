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
	
	private Integer cg_code; // 모든 카테고리 코드
	private Integer cg_parent_code; // 상위 카테고리 코드
	private String cg_name; // 하위 카테고리명
	
	// 테이블에 직접 매핑되지 않고, 서버/클라이언트 간 데이터 전달을 위해 사용
	private String cg_parent_name; // 상위 카테고리명을 저장하기 위한 필드 
    private List<CategoryVO> secondCategoryList; // 2차 카테고리 목록을 저장하기 위한 필드
}
