package com.devday.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.devday.domain.OrderBasicVO;
import com.devday.domain.OrderDetailInfoVO;
import com.devday.domain.OrderDetailProductVO;
import com.devday.dto.Criteria;
import com.devday.mapper.AdOrderMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdOrderServiceImpl implements AdOrderService {

	private final AdOrderMapper adOrderMapper;
	
	@Override
	public List<OrderBasicVO> order_list(Criteria cri) {

		return adOrderMapper.order_list(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {

		return adOrderMapper.getTotalCount(cri);
	}

	@Override
	public List<OrderDetailInfoVO> orderDetailInfo1(Long od_number) {

		return adOrderMapper.orderDetailInfo1(od_number);
	}

	// MyBatis의 resultMap 사용(예외)
	@Override
	public List<OrderDetailProductVO> orderDetailInfo2(Long od_number) {
		
		return adOrderMapper.orderDetailInfo2(od_number);
	}
	
	@Override
	public void order_product_delete(Long od_number, Integer pd_number) {
	
		adOrderMapper.order_product_delete(od_number, pd_number);
	}

}
