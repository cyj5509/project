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
	public List<ProductVO> prd_list(Integer cg_code, Criteria cri) {
		
		return userProductMapper.prd_list(cg_code, cri);
	}

	@Override
	public int getTotalCount(Integer cg_code) {
		
		return userProductMapper.getTotalCount(cg_code);
	}
	
	@Override
	public ProductVO prd_detail(Integer prd_num) {

		return userProductMapper.prd_detail(prd_num);
	}
}
