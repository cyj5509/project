package com.devday.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.devday.domain.BoardVO;
import com.devday.domain.VoteVO;
import com.devday.dto.Criteria;
import com.devday.dto.VoteResultDTO;
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
	public BoardVO get(Long bd_number, boolean increaseReadCount) {

		if (increaseReadCount) {
			usBoardMapper.readCount(bd_number); // usBoardService 인터페이스에 부존재
		}

		return usBoardMapper.get(bd_number);
	}

	@Override
	public boolean checkVote(Long bd_number, String us_id) {
		
	    Map<String, Object> map = new HashMap<>();
	    map.put("bd_number", bd_number);
	    map.put("us_id", us_id);

	    int count = usBoardMapper.checkVote(map);
	    return count > 0;
	}
	
	@Override
	public Map<String, String> getCurrentVoteStatus(Long bd_number, String us_id) {
		
		// 쿼리 파라미터를 담을 Map 생성
		Map<String, Object> params = new HashMap<>();
		params.put("bd_number", bd_number); // 게시물 번호
		params.put("us_id", us_id); // 사용자 아이디
		
		// 쿼리 실행 결과를 List로 받음. 각 Map은 회원/비회원의 투표 상태를 담고 있음
	    List<Map<String, String>> voteStatusList = usBoardMapper.getCurrentVoteStatus(params);
		
		// 회원 및 비회원의 투표 상태를 저장할 Map 생성
		Map<String, String> statusMap = new HashMap<>();
		for (Map<String, String> status : voteStatusList) {
			// 리스트를 순회하면서 각 Map에서 'UserType'(Member/NonMember)과 'vt_status'의 쌍을 저장
			statusMap.put(status.get("UserType"), status.get("vt_status"));
		}
		// 회원과 비회원의 투표 상태를 포함한 Map 반환
		return statusMap; // {"Member": "like", "NonMember": "like"}와 같은 9가지 경우 중 하나 반환 
	}
	
	@Override
	@Transactional
	public VoteResultDTO insertVote(VoteVO vt_vo) {
		
		// 회원 및 비회원의 투표 상태를 포함한 Map을 가져옴
	    Map<String, String> voteStatusMap = getCurrentVoteStatus(vt_vo.getBd_number(), vt_vo.getUs_id());
		// 현재 사용자의 투표 상태 확인
	    String currentStatus = voteStatusMap.get(vt_vo.getUs_id() != null ? "Member" : "NonMember");
		boolean alreadyVoteToday = currentStatus != null;
		
		// 이전 날짜 투표 여부 확인
		boolean alreadyVotePrev = checkVote(vt_vo.getBd_number(), vt_vo.getUs_id()); 

		if (!alreadyVoteToday) {
			// 오늘 아직 투표하지 않은 경우 새로운 투표 추가
			usBoardMapper.insertVote(vt_vo);
			updateCount(vt_vo.getBd_number(), vt_vo.getVt_status(), true); // 추천/비추천 수 증가
			return new VoteResultDTO(true);
		} else if (alreadyVoteToday && !alreadyVotePrev) {
			// 동일 날짜에 이전 투표가 있지만 다른 날짜의 이전 투표가 없는 경우
			if (vt_vo.getVt_status().equals(currentStatus)) {
				// 같은 상태로 다시 투표하는 경우(투표 취소)
				usBoardMapper.cancelVote(vt_vo);
				updateCount(vt_vo.getBd_number(), currentStatus, false); // 추천/비추천 수 감소
			} else  {
				// 다른 상태로 다시 투표하는 경우(투표 변경)
				usBoardMapper.changeVote(vt_vo);
				updateCount(vt_vo.getBd_number(), currentStatus, false); // 이전 카운트 감소
				updateCount(vt_vo.getBd_number(), vt_vo.getVt_status(), true); // 새로운 카운트 증가
			}
			return new VoteResultDTO(true);
		}
		return new VoteResultDTO(false);		
	}
	
	// insertVote 메서드 내에서 사용(일관성 등을 위해 재정의), boolean increase는 true/false 직접 제어
	@Override 
	public void updateCount(Long bd_number, String vt_status, boolean increase) {
	    if ("like".equals(vt_status)) {
	        if (increase) usBoardMapper.increaseLike(bd_number); // 추천 수 증가
	        else usBoardMapper.decreaseLike(bd_number); // 추천 수 감소
	    } else if ("dislike".equals(vt_status)) {
	        if (increase) usBoardMapper.increaseDislike(bd_number); // 비추천 수 증가
	        else usBoardMapper.decreaseDislike(bd_number); // 비추천 수 감소
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
