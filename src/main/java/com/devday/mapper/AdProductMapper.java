package com.devday.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.devday.domain.ProductVO;
import com.devday.dto.Criteria;
import com.devday.dto.ProductDTO;

public interface AdProductMapper {

	// 상품 등록
	void insert(ProductVO vo);

	List<ProductVO> getListWithPaging(Criteria cri);

	int getTotalCount(Criteria cri);

	// [방법 1]
	// @Param(""): 파라미터가 2개 이상 사용되는 경우 해당 어노테이션 필수(Mapper에서만 쓰임)
	void pd_checked_modify1(
			@Param("pd_number") Integer pd_number, 
			@Param("pd_price") Integer pd_price,
			@Param("pd_buy_status") String pd_buy_status
	);

	// [방법 2]
	void pd_checked_modify2(List<ProductDTO> pd_modify_list);

	ProductVO get(Integer pd_number); // 상품 조회
	void edit(ProductVO vo); // 상품 수정
	void delete(Integer pd_number); // 상품 삭제
}
