package com.devday.domain;

import lombok.Data;

@Data
public class OrderDetailProductVO {

	// 클래스 필드 방식 -> MyBatis에서는 resultMap으로 사용
	private OrderDetailVO orderDetailVO; //  AdOrderMapper.xml에서 <collection>으로 표현
	private ProductVO productVO; //  AdOrderMapper.xml에서 <collection>으로 표현
}
