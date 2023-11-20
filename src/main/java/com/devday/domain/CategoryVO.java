package com.devday.domain;

// import lombok.Data;

/*
CREATE TABLE category_tbl(
	cg_code      NUMBER         PRIMARY KEY,    -- 카테고리 코드
	cg_prt_code  NUMBER         NULL,           -- 상위카테고리 코드
	cg_name      VARCHAR2(50)   NOT NULL,
	FOREIGN KEY(cg_prt_code) REFERENCES category_tbl(cg_code)
);
*/

// @Data
public class CategoryVO {
	
	private Integer cg_code; // 1차든 2차든 모든 카테고리 코드
	private Integer cg_prt_code; // 1차 카테고리 코드
	private String cg_name; // 카테고리명
	
	// 소스 메뉴 단축키: [Alt]+[Shift]+[S]
	// @Getter, @Setter
	public Integer getCg_code() {
		return cg_code;
	}
	public void setCg_code(Integer cg_code) {
		this.cg_code = cg_code;
	}
	public Integer getCg_prt_code() {
		return cg_prt_code;
	}
	public void setCg_prt_code(Integer cg_prt_code) {
		this.cg_prt_code = cg_prt_code;
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
		return "CategotyVO [cg_code=" + cg_code + ", cg_prt_code=" + cg_prt_code + ", cg_name=" + cg_name + "]";
	}
}
