package com.devday.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor // 모든 필드를 대상으로 매개변수가 있는 생성자 메서드 생성
public class ProductDTO {

	private Integer prd_num;
	private int prd_price;
	private String prd_buy;
	
	// @AllArgsConstructor
	/*
	public ProductDTO(Integer pro_num, int pro_price, String pro_buy) {
		super();
		this.pro_num = pro_num;
		this.pro_price = pro_price;
		this.pro_buy = pro_buy;
	}
	*/
	
}
