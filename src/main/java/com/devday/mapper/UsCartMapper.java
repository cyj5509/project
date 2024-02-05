package com.devday.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.devday.domain.CartVO;
import com.devday.dto.CartDTOList;

// DAO 의미와 동일한 의미
public interface UsCartMapper {

	void cart_add(CartVO ct_vo); // 장바구니 추가 관련 메서드

	// 상품 테이블과 장바구니 테이블의 조인 작업으로 CartDTOList 활용
	// List<CartDTOList>: CartVO에서 여러 개의 데이터를 가져올 경우
	List<CartDTOList> cart_list(String us_id); // 장바구니 목록 관련 메서드
	
	// 장바구니 수량 변경 관련 메서드
	void cart_amount_change(
			@Param("ct_code") Long ct_code,
			@Param("ct_amount") int ct_amount
	);
	
	// 장바구니 목록에서 개별 삭제 관련 메서드
	void cart_list_del(Long ct_code);
	
	//장바구니 선택삭제. 파라미터 List컬렉션 사용.
	void cart_sel_delete(List<Long> ct_code_arr);
	
	void cartEmpty(String us_id);
	int countCartItems(String us_id);
	
}
