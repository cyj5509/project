package com.devday.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.devday.domain.ProductVO;
import com.devday.dto.Criteria;

public interface UsProductMapper {
	
	// 특정 카테고리 내 상품 조회(조건 검색 활용)
	List<ProductVO> getListWithPagingByCategory(@Param("cg_code") Integer cg_code, 
						    @Param("cri") Criteria cri);
	int getTotalCountByCategory(@Param("cg_code") Integer cg_code, 
		    		  @Param("cri") Criteria cri);
	
	// 전체 상품 조회(조건 검색 활용)
	List<ProductVO> getListWithPagingForAll(Criteria cri);
	int getTotalCountForAll(Criteria cri);
	
	// 상품의 상세 정보 조회
	ProductVO getProductDetails(Integer pd_number);
}
