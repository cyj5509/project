package com.devday.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.devday.domain.ProductVO;
import com.devday.dto.Criteria;
import com.devday.dto.ProductDTO;
import com.devday.mapper.AdProductMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdProductServiceImpl implements AdProductService {

	private final AdProductMapper adProductMapper;

	@Override
	public void insert(ProductVO vo) {
		
		adProductMapper.insert(vo);
	}

	@Override
	public List<ProductVO> getListWithPaging(Criteria cri) {
		
		return adProductMapper.getListWithPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		
		return adProductMapper.getTotalCount(cri);
	}

	@Override
	public void pd_checked_modify1(List<Integer> pd_number_arr, List<Integer> pd_price_arr, List<String> pd_buy_status_arr) {

		// DB의 연동작업이 size만큼 아래 작업이 진행이 된다.
		// Connection Open -> mapper.xml SQL 구문 실행 -> Connection Close
		
		// 배열은 [i], List는 .get(i)
		for (int i = 0; i < pd_number_arr.size(); i++) {
			adProductMapper.pd_checked_modify1(pd_number_arr.get(i), pd_price_arr.get(i), pd_buy_status_arr.get(i));
		}

	}

	@Override
	public void pd_checked_modify2(List<Integer> pd_number_arr, List<Integer> pd_price_arr, List<String> pd_buy_status_arr) {

		List<ProductDTO> pd_modify_list = new ArrayList<ProductDTO>();

		for (int i = 0; i < pd_number_arr.size(); i++) {
			ProductDTO productDTO = new ProductDTO(pd_number_arr.get(i), pd_price_arr.get(i), pd_buy_status_arr.get(i));
			pd_modify_list.add(productDTO);
		}
		
		adProductMapper.pd_checked_modify2(pd_modify_list);
	}

	@Override
	public ProductVO get(Integer pd_number) {
		
		return adProductMapper.get(pd_number);
	}

	@Override
	public void edit(ProductVO vo) {

		adProductMapper.edit(vo);
	}

	@Override
	public void delete(Integer pd_number) {
		
		adProductMapper.delete(pd_number);
	}
}
