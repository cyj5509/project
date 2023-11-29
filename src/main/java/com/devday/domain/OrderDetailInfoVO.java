package com.devday.domain;

import lombok.Data;

// 관리자 기능 ─ 주문상세 정보를 저장하기 위한 목적
// 주문상세 테이블과 상품 테이블을 조인한 결과를 담기 위한 클래스

@Data
public class OrderDetailInfoVO {
	
	private Long od_number; // 주문번호: 시퀀스로 처리
	private Integer pd_number; // 상품코드
	private String pd_name;
	private int pd_price; // 상품가격(=od_price)
	private int od_amount; // 개별 상품 개수: 카트 쪽에서 받아옴
	
	private int od_total_price; // 총 주문금액(pd_price * od_amount). OrderBasicVO의 od_total_price와는 다름
	
	private String pd_image_folder; // 클라이언트에서 직접 입력받지 않고 스프링에서 별도로 처리(매퍼 작업)
	private String pd_image; // 클라이언트에서 직접 입력받지 않고 스프링에서 별도로 처리(매퍼 작업)
	
}
