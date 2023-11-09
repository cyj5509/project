package com.devday.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.devday.domain.ProductVO;
import com.devday.dto.Criteria;
import com.devday.dto.ProductDTO;

public interface AdProductMapper {

	// 상품 등록
	void prd_insert(ProductVO vo);

	List<ProductVO> prd_list(Criteria cri);

	int getTotalCount(Criteria cri);

	// [방법 1]
	// @Param(""): 파라미터가 2개 이상 사용되는 경우 해당 어노테이션 필수(Mapper에서만 쓰임)
	void prd_checked_modify1(
			@Param("prd_num") Integer prd_num, 
			@Param("prd_price") Integer prd_price,
			@Param("prd_buy") String prd_buy
	);

	// [방법 2]
	void prd_checked_modify2(List<ProductDTO> prd_modify_list);

	ProductVO prd_edit(Integer prd_num);
	
	// 상품 수정
	void prd_edit_ok(ProductVO vo);
	
	// 상품 삭제
	void prd_delete(Integer prd_num);
}
