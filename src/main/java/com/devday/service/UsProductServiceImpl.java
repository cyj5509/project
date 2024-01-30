package com.devday.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.devday.domain.ProductVO;
import com.devday.dto.Criteria;
import com.devday.mapper.UsProductMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UsProductServiceImpl implements UsProductService {

	private final UsProductMapper userProductMapper;
	
	@Override
	public List<ProductVO> getListWithPagingByCategory(Integer cg_code, Criteria cri) {
		
		return userProductMapper.getListWithPagingByCategory(cg_code, cri);
	}
	
	@Override
	public int getTotalCountByCategory(Integer cg_code, Criteria cri) {
		
		return userProductMapper.getTotalCountByCategory(cg_code, cri);
	}

	@Override
	public List<ProductVO> getListWithPagingForAll(Criteria cri) {
		
		return userProductMapper.getListWithPagingForAll(cri);
	}

	@Override
	public int getTotalCountForAll(Criteria cri) {
		
		return userProductMapper.getTotalCountForAll(cri);
	}
	
	@Override
	public ProductVO getProductDetails(Integer pd_number) {

		return userProductMapper.getProductDetails(pd_number);
	}
}
