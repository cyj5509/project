package com.devday.service;

import java.util.List;
import java.util.Map;

import com.devday.domain.CommentVO;
import com.devday.dto.Criteria;

public interface CommentService {

	// 댓글 추가, 수정, 삭제 관련 메서드
	void manageComments(CommentVO cm_vo, String action); 
	CommentVO findComment(Long cm_code);
	
	// 댓글 및 대댓글 처리 관련 메서드
	List<CommentVO> retrieveComments(Long bd_number, Criteria cri);
	int getTotalCount(Long bd_number);
}
