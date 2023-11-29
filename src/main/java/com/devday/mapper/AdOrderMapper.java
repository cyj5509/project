package com.devday.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.devday.domain.OrderBasicVO;
import com.devday.domain.OrderDetailInfoVO;
import com.devday.domain.OrderDetailProductVO;
import com.devday.dto.Criteria;

public interface AdOrderMapper {

	List<OrderBasicVO> order_list(Criteria cri);
	
	int getTotalCount(Criteria cri);
	
	// 주문상세 1
	List<OrderDetailInfoVO> orderDetailInfo1(Long od_number);
	
	// 주문상세 2 ─ MyBatis의 resultMap 사용(예외)
	List<OrderDetailProductVO> orderDetailInfo2(Long od_number); // 기존 클래스 이용: OrderDetailVO, ProductVO 필드가 있는 클래스
	
	// @Param: 하나 있을 때도 사용하나, 일반적으로 생략함
	void order_product_delete(@Param("od_number") Long od_number, @Param("pd_number") Integer pd_number);
}
