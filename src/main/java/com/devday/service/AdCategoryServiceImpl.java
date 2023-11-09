package com.devday.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.devday.domain.CategoryVO;
import com.devday.mapper.AdCategoryMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class AdCategoryServiceImpl implements AdCategoryService {

	private final AdCategoryMapper adCategoryMapper;

	@Override
	public List<CategoryVO> getFirstCategoryList() {
		
		return adCategoryMapper.getFirstCategoryList();
	}

	@Override
	public List<CategoryVO> getSecondCategoryList(Integer cg_prt_code) {
		
		return adCategoryMapper.getSecondCategoryList(cg_prt_code);
	}  
	
	@Override
	public CategoryVO get(Integer cg_code) {

		return adCategoryMapper.get(cg_code);
	}
}
