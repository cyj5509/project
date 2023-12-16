package com.devday.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.devday.domain.BoardVO;
import com.devday.domain.VoteVO;
import com.devday.dto.Criteria;
import com.devday.exception.AlreadyVoteException;
import com.devday.mapper.UsBoardMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UsBoardServiceImpl implements UsBoardService {

	private final UsBoardMapper usBoardMapper;

	@Override
	public void register(BoardVO board) {

		usBoardMapper.register(board);
	}

	@Override
	@Transactional
	public BoardVO get(Long bd_number) {

		usBoardMapper.readCount(bd_number); // usBoardService 인터페이스에 부존재

		return usBoardMapper.get(bd_number);
	}

	@Override
	public boolean voteCheck(Long bd_number, String us_id, String session_id, String actionType) {
	    Map<String, Object> map = new HashMap<>();
	    map.put("bd_number", bd_number);
	    map.put("us_id", us_id);
	    map.put("session_id", session_id);
	    map.put("vt_type", actionType);

	    int count = usBoardMapper.voteCheck(map);
	    return count > 0;
	}
	
	@Override
	@Transactional
	public void insertVote(VoteVO vt_vo) {
		// 이미 투표했는지 확인
		boolean alreadyVote = voteCheck(vt_vo.getBd_number(), vt_vo.getUs_id(), vt_vo.getSession_id(),
				vt_vo.getVt_type());

		if (alreadyVote) {
			throw new AlreadyVoteException("오늘 투표 완료"); // 개발자(관리자)용 메시지
		} else {
			// 아직 투표하지 않았다면 투표 정보 삽입
			usBoardMapper.insertVote(vt_vo);

			// 투표 후 게시물의 추천/비추천 수 업데이트
			if ("like".equals(vt_vo.getVt_type())) {
				usBoardMapper.increaseLike(vt_vo.getBd_number());
			} else {
				usBoardMapper.increaseDislike(vt_vo.getBd_number());
			}
			get(vt_vo.getBd_number());
		}
	}
		
	@Override
	public List<BoardVO> getList() {

		return usBoardMapper.getList();
	}

	@Override
	public void modify(BoardVO board) {

		usBoardMapper.modify(board);
	}

	@Override
	public void delete(Long bd_number) {

		usBoardMapper.delete(bd_number);
	}

	@Override
	public List<BoardVO> getListWithPaging(Criteria cri, String bd_type) {

		return usBoardMapper.getListWithPaging(cri, bd_type);
	}

	@Override
	public int getTotalCount(Criteria cri, String bd_type) {

		return usBoardMapper.getTotalCount(cri, bd_type);
	}
}
