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
	public void prd_insert(ProductVO vo) {
		
		adProductMapper.prd_insert(vo);
	}

	@Override
	public List<ProductVO> prd_list(Criteria cri) {
		
		return adProductMapper.prd_list(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		
		return adProductMapper.getTotalCount(cri);
	}

	@Override
	public void prd_checked_modify1(List<Integer> prd_num_arr, List<Integer> prd_price_arr, List<String> prd_buy_arr) {

		// DB의 연동작업이 size만큼 아래 작업이 진행이 된다.
		// Connection Open -> mapper.xml SQL 구문 실행 -> Connection Close
		
		// 배열은 [i], List는 .get(i)
		for (int i = 0; i < prd_num_arr.size(); i++) {
			adProductMapper.prd_checked_modify1(prd_num_arr.get(i), prd_price_arr.get(i), prd_buy_arr.get(i));
		}

	}

	@Override
	public void prd_checked_modify2(List<Integer> prd_num_arr, List<Integer> prd_price_arr, List<String> prd_buy_arr) {

		List<ProductDTO> prd_modify_list = new ArrayList<ProductDTO>();

		for (int i = 0; i < prd_num_arr.size(); i++) {
			ProductDTO productDTO = new ProductDTO(prd_num_arr.get(i), prd_price_arr.get(i), prd_buy_arr.get(i));
			prd_modify_list.add(productDTO);
		}
		
		adProductMapper.prd_checked_modify2(prd_modify_list);
	}

	@Override
	public ProductVO prd_edit(Integer prd_num) {
		
		return adProductMapper.prd_edit(prd_num);
	}

	@Override
	public void prd_edit(ProductVO vo) {

		adProductMapper.prd_edit_ok(vo);
	}

	@Override
	public void prd_delete(Integer prd_num) {
		
		adProductMapper.prd_delete(prd_num);
	}
}
