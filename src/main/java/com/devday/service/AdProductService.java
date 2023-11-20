package com.devday.service;

import java.util.List;

import com.devday.domain.ProductVO;
import com.devday.dto.Criteria;

public interface AdProductService {

	// 상품 등록
	void prd_insert(ProductVO vo);

	List<ProductVO> prd_list(Criteria cri);
	
	int getTotalCount(Criteria cri);
	
	// [방법 1]
	void prd_checked_modify1(List<Integer> prd_num_arr, List<Integer> prd_price_arr, List<String> prd_buy_arr);
	
	// [방법 2]
	void prd_checked_modify2(List<Integer> prd_num_arr, List<Integer> prd_price_arr, List<String> prd_buy_arr);

	ProductVO prd_edit(Integer prd_num);	
	
	// 상품 수정
	void prd_edit(ProductVO vo); // 꼭 prd_edit_ok로 이름을 변경할 필요 없음
	
	// 상품 삭제
	void prd_delete(Integer prd_num);
}
