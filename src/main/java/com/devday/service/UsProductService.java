package com.devday.service;

import java.util.List;

import com.devday.domain.ProductVO;
import com.devday.dto.Criteria;

public interface UsProductService {

	// 2차 카테고리별 상품 리스트(페이징 정보 사용, 검색 제외)
	List<ProductVO> prd_list(Integer cg_code, Criteria cri);
	
	int getTotalCount(Integer cg_code);
	
	ProductVO prd_detail(Integer prd_num);
}
