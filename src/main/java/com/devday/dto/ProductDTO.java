package com.devday.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor // 모든 필드를 대상으로 매개변수가 있는 생성자 메서드 생성
public class ProductDTO {

	private Integer pd_number;
	private int pd_price;
	private String pd_buy_status;
	
	// @AllArgsConstructor
	/*
	public ProductDTO(Integer pd_number, int pd_price, String pd_buy_status) {
		super();
		this.pd_number = pd_number;
		this.pd_price = pd_price;
		this.pd_buy_status = pd_buy_status;
	}
	*/
	
}
