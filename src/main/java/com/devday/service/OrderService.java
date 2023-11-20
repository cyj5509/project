package com.devday.service;

import com.devday.domain.OrderBasicVO;
import com.devday.domain.PaymentVO;

public interface OrderService {

	int getOrderSeq(); // 주문번호에 사용할 시퀀스

	// 주문하기
	void order_insert(OrderBasicVO o_vo, PaymentVO p_vo); 

}
