package com.devday.dto;

import lombok.Data;

@Data
public class CartDTOList {
	
	// CartVO에서 Copy & Paste
	private Long ct_code;
	private Integer pd_number;
	private int ct_amount;
	
	// ProductVO에서 Copy & Paste
	private String pd_name;
	private int pd_price;
	private String pd_image_folder;
	private String pd_image;
	private int pd_discount;
}
