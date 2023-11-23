package com.devday.domain;

// import lombok.Data;

/*
CREATE TABLE category_table (
    cg_code         NUMBER        CONSTRAINT pk_cg_code PRIMARY KEY,  -- 하위 카테고리 코드(2차 이후)
    cg_parent_code  NUMBER        NULL,                               -- 상위 카테고리 코드(1차)
    cg_name         VARCHAR2(50)  NOT NULL,                           -- 카테고리 이름(범주)
    CONSTRAINT fk_cg_parent_code FOREIGN KEY(cg_parent_code) REFERENCES category_table(cg_code)
);
*/

// @Data
public class CategoryVO {
	
	private Integer cg_code; // 1차든 2차든 모든 카테고리 코드
	private Integer cg_parent_code; // 1차 카테고리 코드
	private String cg_name; // 카테고리명
	
	// @Getter, @Setter
	public Integer getCg_code() {
		return cg_code;
	}
	public void setCg_code(Integer cg_code) {
		this.cg_code = cg_code;
	}
	public Integer getCg_parent_code() {
		return cg_parent_code;
	}
	public void setCg_parent_code(Integer cg_parent_code) {
		this.cg_parent_code = cg_parent_code;
	}
	public String getCg_name() {
		return cg_name;
	}
	public void setCg_name(String cg_name) {
		this.cg_name = cg_name;
	}
	
	// @ToString
	@Override
	public String toString() {
		return "CategotyVO [cg_code=" + cg_code + ", cg_parent_code=" + cg_parent_code + ", cg_name=" + cg_name + "]";
	}
}
