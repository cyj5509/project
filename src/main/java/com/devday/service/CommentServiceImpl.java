package com.devday.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.devday.domain.CommentVO;
import com.devday.dto.Criteria;
import com.devday.dto.PageDTO;
import com.devday.mapper.CommentMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class CommentServiceImpl implements CommentService {

	private final CommentMapper commentMapper;

	@Transactional
    @Override
    public void manageComments(CommentVO cm_vo, String action) {
		
        switch (action) {
            case "insert":
                commentMapper.insert(cm_vo);
                break;
            case "modify":
                commentMapper.modify(cm_vo);
                break;
            case "delete":
                commentMapper.delete(cm_vo.getCm_code());
                break;
        }
    }
	
	@Override
	public CommentVO findComment(Long cm_code) {
		
		return commentMapper.findComment(cm_code);
	}
	
	@Override
    public List<CommentVO> retrieveComments(Long bd_number, Criteria cri) {

		List<CommentVO> comments = commentMapper.getComment(bd_number, cri);
		
		// 각 댓글에 대한 대댓글 조회 및 추가
	    for (CommentVO comment : comments) {
	        List<CommentVO> replies = commentMapper.getReply(comment.getCm_code());
	        comment.setReplies(replies); // CommentVO에 대댓글 목록을 설정
	    }

	    return comments; // 수정된 댓글 목록 반환
	}

	@Override
	public int getTotalCount(Long bd_number) {
		
		return commentMapper.getTotalCount(bd_number);
	}
}
