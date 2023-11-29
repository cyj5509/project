package com.devday.service;

import java.util.List;

import com.devday.domain.OrderBasicVO;
import com.devday.domain.OrderDetailInfoVO;
import com.devday.domain.OrderDetailProductVO;
import com.devday.dto.Criteria;

public interface AdOrderService {

	List<OrderBasicVO> order_list(Criteria cri);
	
	int getTotalCount(Criteria cri);
	
	List<OrderDetailInfoVO> orderDetailInfo1(Long od_number);
	
	List<OrderDetailProductVO> orderDetailInfo2(Long od_number); // MyBatis의 resultMap 사용(예외)
	
	void order_product_delete(Long od_number, Integer pd_number);
}
