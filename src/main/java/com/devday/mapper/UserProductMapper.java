package com.devday.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.devday.domain.ProductVO;
import com.devday.dto.Criteria;

public interface UserProductMapper {

	// 2차 카테고리별 상품 리스트(페이징 정보 사용, 검색 제외)
	// 파라미터가 하나인 경우 Mapper.xml에서 아래와 같이 작업함
	/*
  	ROWNUM <= #{pageNum} * #{amount} 
	RN > (#{pageNum} -1) * #{amount}]]>
	*/
	// 파라미터가 여러 개면 Mapper.xml에서 아래와 같이 작업함
	/*
  	ROWNUM <= #{cri.pageNum} * #{cri.amount} 
	RN > (#{cri.pageNum} -1) * #{cri.amount}]]>
	*/
	List<ProductVO> prd_list(
			@Param("cg_code") Integer cg_code, 
			@Param("cri") Criteria cri
	);
	
	int getTotalCount(Integer cg_code);
}
