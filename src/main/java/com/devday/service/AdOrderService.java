package com.devday.service;

import java.util.List;

import com.devday.domain.OrderBasicVO;
import com.devday.dto.Criteria;

public interface AdOrderService {

	List<OrderBasicVO> order_list(Criteria cri);
	
	int getTotalCount(Criteria cri);
}
