package com.devday.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.devday.domain.ProductVO;
import com.devday.dto.Criteria;
import com.devday.mapper.UsProductMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UsProductServiceImpl implements UsProductService {

	private final UsProductMapper usProductMapper;
	
	@Override
	public List<ProductVO> getListWithPagingByCategory(Integer cg_code, Criteria cri) {
		
		return usProductMapper.getListWithPagingByCategory(cg_code, cri);
	}
	
	@Override
	public int getTotalCountByCategory(Integer cg_code, Criteria cri) {
		
		return usProductMapper.getTotalCountByCategory(cg_code, cri);
	}

	@Override
	public List<ProductVO> getListWithPagingForAll(Criteria cri) {
		
		return usProductMapper.getListWithPagingForAll(cri);
	}

	@Override
	public int getTotalCountForAll(Criteria cri) {
		
		return usProductMapper.getTotalCountForAll(cri);
	}
	
	@Override
	public ProductVO getProductDetails(Integer pd_number) {

		return usProductMapper.getProductDetails(pd_number);
	}
	
	@Override
	public List<ProductVO> searchByKeyword(String keyword, String[] typeArr) {
		
	    Map<String, Object> params = new HashMap<>();
	    params.put("keyword", keyword);
	    params.put("typeArr", typeArr);
	    
	    return usProductMapper.searchByKeyword(params);
	}

}
