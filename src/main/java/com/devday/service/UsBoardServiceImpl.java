package com.devday.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.devday.domain.BoardVO;
import com.devday.domain.BoardVoteVO;
import com.devday.domain.VoteVO;
import com.devday.dto.Criteria;
import com.devday.dto.VoteResultDTO;
import com.devday.mapper.UsBoardMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class UsBoardServiceImpl implements UsBoardService {

	private final UsBoardMapper usBoardMapper;

	@Override
	public void register(BoardVO board) {

		usBoardMapper.register(board);
	}

	@Override
	@Transactional
	public BoardVO get(Long bd_number, boolean increaseReadCount) {
		
		// 게시물 조회 페이지에서만 true, 나머지는 false로 처리 
		if (increaseReadCount) {
			usBoardMapper.readCount(bd_number); // usBoardService 인터페이스에 부존재
		}

		return usBoardMapper.get(bd_number);
	}
	
	@Override
	public BoardVoteVO getVoteAction(Long bd_number) {

		return usBoardMapper.getVoteAction(bd_number);
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
			log.info("반환 컬럼명(키): " + status.keySet()); // [vt_status, userType]: 쿼리 결과로 반환된 Map의 모든 컬럼명(키)  
			// 리스트를 순회한 각 Map에서 'userType'을 키로, 'vt_status'을 값으로 한 쌍을 저장
			// 컬럼명을 별칭으로 지정해주지 않는 한 대문자로 반환하므로 원칙상 대문자로 사용
			String userType = status.get("userType");
			String voteStatus = status.get("vt_status");
			log.info("사용자 유형: " + userType + ", 투표 유형: " + voteStatus);
			
			statusMap.put(userType, voteStatus);
		}
		
		// 회원과 비회원의 투표 상태를 포함한 Map 반환
		return statusMap; // {"Member": "like", "NonMember": "like"}와 같은 9가지 경우 중 하나 반환 
	}
	// 생략 예정? 아직 투표하지 않은 경우, vt_status를 "none"으로 저장하여 JSON 변환 시 null 키 방지
	
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
			} else {
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
	    	// "좋아요"를 선택한 경우
	        if (increase) usBoardMapper.increaseLike(bd_number); // 추천 수 증가
	        else usBoardMapper.decreaseLike(bd_number); // 추천 수 감소
	    } else if ("dislike".equals(vt_status)) {
	    	// "싫어요"를 선택한 경우
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
