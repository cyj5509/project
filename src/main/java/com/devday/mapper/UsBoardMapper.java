package com.devday.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.devday.domain.BoardVO;
import com.devday.domain.VoteVO;
import com.devday.dto.Criteria;

public interface UsBoardMapper {

	// 특별하지 않으면 INSERT, UPDATE, DELETE의 리턴값은 void

	// 게시글 등록, 조회 및 수정 관련 메서드
	void register(BoardVO board); // 게시글 등록(INSERT 문)
	BoardVO get(Long bd_number); // 게시물 조회 및 수정(SELECT 문)
	void readCount(Long bd_number); // 조회 수 증가(UPDATE 문)
	
	int checkVote(Map<String, Object> map);
	List<Map<String, String>> getCurrentVoteStatus(Map<String, Object> map);
	void insertVote(VoteVO vt_vo);
	
	void cancelVote(VoteVO vt_vo); // 투표 취소: 같은 상태로 다시 투표하는 경우(UPDATE 문)
	void changeVote(VoteVO vt_vo); // 투표 변경: 다른 상태로 다시 투표하는 경우(UPDATE 문)
	
	// 게시물 추천 및 비추천 관련 메서드
	void increaseLike(Long bd_number); // 추천 수 증가(UPDATE 문)
	void increaseDislike(Long bd_number); // 비추천 수 증가(UPDATE 문)
	void decreaseLike(Long bd_number); // 추천 수 감소(UPDATE 문)
	void decreaseDislike(Long bd_number); // 비추천 수 감소(UPDATE 문)
	
	// 전체 목록(여러 개): List<BoardVO> 리턴값
	List<BoardVO> getList();

	// 페이징 목록(여러 개): List<BoardVO> 리턴값 -> pageNum, amount, type, keyword 사용
	List<BoardVO> getListWithPaging(@Param("cri") Criteria cri, 
								   @Param("bd_type") String bd_type);

	// 전체 데이터 개수(검색 포함)
	int getTotalCount(@Param("cri") Criteria cri, 
					  @Param("bd_type") String bd_type);


	// 게시물 수정
	void modify(BoardVO board);

	// 게시물 삭제
	void delete(Long bd_number);
}
