package com.devday.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.devday.domain.OrderBasicVO;
import com.devday.domain.PaymentVO;
import com.devday.mapper.OrderMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {

	private final OrderMapper orderMapper;

	@Override
	public int getOrderSeq() {

		return orderMapper.getOrderSeq();
	}

	// * 서비스 패키지는 트랜잭션을 포함한 비즈니스 로직 때문에 필요
	// 하나의 메서드에서 한꺼번에 처리✳
	@Transactional // 트랜잭션 적용: 하나라도 실패 시 성공된 것들도 일종의 롤백 처리(기존 DB상 개념)
	@Override
	public void order_insert(OrderBasicVO o_vo, PaymentVO p_vo) {
		
		orderMapper.order_insert(o_vo);
		orderMapper.order_detail_insert(o_vo.getOrd_code(), o_vo.getMem_id());
		orderMapper.cart_del(o_vo.getMem_id());
		orderMapper.payment_insert(p_vo);
	}
	
}
