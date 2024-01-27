package com.devday.service;

import java.util.List;

import com.devday.domain.ProductVO;
import com.devday.dto.Criteria;

public interface AdProductService {

	// 상품 등록
	void insert(ProductVO vo);

	List<ProductVO> getListWithPaging(Criteria cri);
	
	int getTotalCount(Criteria cri);
	
	// [방법 1]
	void pd_checked_modify1(List<Integer> pd_number_arr, List<Integer> pd_price_arr, List<String> pd_buy_status_arr);
	
	// [방법 2]
	void pd_checked_modify2(List<Integer> pd_number_arr, List<Integer> pd_price_arr, List<String> pd_buy_status_arr);

	ProductVO get(Integer pd_number); // 상품 조회	
	void edit(ProductVO vo); // 상품 수정
	void delete(Integer pd_number); // 상품 삭제
}
