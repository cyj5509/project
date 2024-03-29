package com.devday.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.devday.domain.OrderBasicVO;
import com.devday.domain.PaymentVO;
import com.devday.mapper.UsOrderMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UsOrderServiceImpl implements UsOrderService {

	private final UsOrderMapper usOrderMapper;

	@Override
	public int getOrderSeq() {

		return usOrderMapper.getOrderSeq();
	}

	// * 서비스 패키지는 트랜잭션을 포함한 비즈니스 로직 때문에 필요
	// 하나의 메서드에서 한꺼번에 처리✳
	@Override
	@Transactional // 트랜잭션 적용: 하나라도 실패 시 성공된 것들도 일종의 롤백 처리(기존 DB상 개념)
	public void order_insert(OrderBasicVO ob_vo, PaymentVO pm_vo) {
		
		usOrderMapper.order_insert(ob_vo);
		usOrderMapper.order_detail_insert(ob_vo.getOd_number(), ob_vo.getUs_id());
		usOrderMapper.cart_del(ob_vo.getUs_id());
		usOrderMapper.payment_insert(pm_vo);
	}
	
}
