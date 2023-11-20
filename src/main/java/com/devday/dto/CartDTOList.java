package com.devday.dto;

import lombok.Data;

@Data
public class CartDTOList {
	
	// CartVO에서 Copy & Paste
	private Long cart_code;
	private Integer prd_num;
	private int cart_amount;
	
	// ProductVO에서 Copy & Paste
	private String prd_name;
	private int prd_price;
	private String prd_up_folder;
	private String prd_img;
	private int prd_discount;
}
