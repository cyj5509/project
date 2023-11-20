package com.devday.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.devday.domain.CartVO;
import com.devday.dto.CartDTOList;

// DAO 의미와 동일한 의미
public interface CartMapper {

	void cart_add(CartVO vo); // 장바구니 추가 관련 메서드

	// 상품 테이블과 장바구니 테이블의 조인 작업으로 CartDTOList 활용
	// List<CartDTOList>: CartVO에서 여러 개의 데이터를 가져올 경우
	List<CartDTOList> cart_list(String mem_id); // 장바구니 목록 관련 메서드
	
	// 장바구니 수량 변경 관련 메서드
	void cart_amount_change(
			@Param("cart_code") Long cart_code,
			@Param("cart_amount") int cart_amount
	);
	
	// 장바구니 목록에서 개별 삭제 관련 메서드
	void cart_list_del(Long cart_code);
	
	//장바구니 선택삭제. 파라미터 List컬렉션 사용.
	void cart_sel_delete(List<Long> cart_code_arr);
}
