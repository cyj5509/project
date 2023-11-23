package com.devday.service;

import java.util.List;

import com.devday.domain.ProductVO;
import com.devday.dto.Criteria;

public interface AdProductService {

	// 상품 등록
	void pd_insert(ProductVO vo);

	List<ProductVO> pd_list(Criteria cri);
	
	int getTotalCount(Criteria cri);
	
	// [방법 1]
	void pd_checked_modify1(List<Integer> pd_number_arr, List<Integer> pd_price_arr, List<String> pd_buy_status_arr);
	
	// [방법 2]
	void pd_checked_modify2(List<Integer> pd_number_arr, List<Integer> pd_price_arr, List<String> pd_buy_status_arr);

	ProductVO pd_edit(Integer pd_number);	
	
	// 상품 수정
	void pd_edit(ProductVO vo); // 꼭 prd_edit_ok로 이름을 변경할 필요 없음
	
	// 상품 삭제
	void pd_delete(Integer pd_number);
}
