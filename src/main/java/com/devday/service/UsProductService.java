package com.devday.service;

import java.util.List;

import com.devday.domain.ProductVO;
import com.devday.dto.Criteria;

public interface UsProductService {

	List<ProductVO> getListWithPagingByCategory(Integer cg_code, Criteria cri);
	int getTotalCountByCategory(Integer cg_code, Criteria cri);

	List<ProductVO> getListWithPagingForAll(Criteria cri);
	int getTotalCountForAll(Criteria cri);
	
	ProductVO getProductDetails(Integer pd_number);
}
