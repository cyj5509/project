package com.devday.mapper;

import java.util.List;

import com.devday.domain.OrderBasicVO;
import com.devday.dto.Criteria;

public interface AdOrderMapper {

	List<OrderBasicVO> order_list(Criteria cri);
	
	int getTotalCount(Criteria cri);
}
