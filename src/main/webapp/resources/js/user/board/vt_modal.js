$(document).ready(function () {

	// 전역변수
	let bd_number = $('body').data('bd_number'); // 게시물 번호
	// console.log("게시물 번호:", bd_number);
	let boardType = $('#bd_type').val();

	let currentType = null; // 현재 사용자의 투표 타입 초기화
	let voteDate = null; // 현재 사용자의 투표 등록일 초기화
	let serverDate = null; // 현재 서버의 날짜 및 시간 초기화

	// 페이지 로딩 시 현재 투표 상태와 투표 수 확인
	checkAndApplyVoteStatus();

	// lodash 라이브러리의 debounce 함수 사용(함수 표현식 형태는 호이스팅 불가)
	// 실행 요청이 연속적으로 들어온 경우 가장 마지막 요청만 수행
	const debouncedAction = _.debounce(function (bd_number, actionType) {

		console.log('actionType:', actionType);
		// "falsy"(빈 문자열, null, undefined, 0, false, NaN) 중 하나일 때 체크
		// if (!actionType) return; // 함수 실행을 종료하여 서버로의 AJAX 요청 방지

		// '좋아요/싫어요' 버튼 비활성화
		$('.btn_vote').prop('disabled', true);

		$.ajax({
			url: '/user/board/likeAction',
			type: 'POST',
			data: {
				bd_number: bd_number,
				actionType: actionType,
			},
			dataType: 'json', // JSON 형식의 응답(map)
			success: handleLikeDislikeAction, // 응답 처리 함수(참조), 소괄호 없음
			error: function (xhr, status, error) {
				// '좋아요/싫어요' 버튼 활성화
				$('.btn_vote').prop('disabled', false);

				// 401 Unauthorized 상태 처리
				if (xhr.status == 401) {
					console.log(xhr.statusText); // "Unauthorized" 대신 단순 error 표시
					// alert(xhr.responseJSON.msg);
					alert("로그인이 필요한 기능입니다. 비회원은 사용할 수 없습니다.");
				} else {
					console.log(xhr.statusText); // "Bad Request" 대신 단순 error 표시
					// Map 방식이 아닌 단순 문자열로 응답한 경우, xhr.responseText
					alert(xhr.responseJSON.msg);
				}
			}
		});
	}, 1000); // 1초(1000ms) 동안 연속 클릭 방지

	// 추천 및 비추천 액션 처리 함수
	function handleLikeDislikeAction(response) {

		// '좋아요/싫어요' 버튼 활성화
		$('.btn_vote').prop('disabled', false);

		if (response.result == 'success') {
			// 투표 성공 처리
			// 객체 접근법으로서 점 표기법(Dot Notation)을 사용하여 고정된 속성 이름에 접근
			currentType = response.actionType; // 투표 상태 업데이트
			// Date 객체를 통해 밀리초 단위의 타임스탬프 형식에서 일반적인 날짜 형식으로 변환
			voteDate = new Date(response.voteDate);
			updateButtonState(response.actionType);
		} else if (response.result == 'cancel') {
			currentType = null;  // 현재 투표 상태 초기화
			voteDate = null; // 현재 투표 일자 초기화
			updateButtonState(null); // 버튼 스타일 초기화
		}
		serverDate = new Date(response.serverDate); // 서버의 날짜 및 시간
		updateVoteCounts(response.likes, response.dislikes);
	}

	// 버튼 활성화/비활성화 처리 함수
	function updateButtonState(actionType) {
		if (actionType == 'like') {
			$('#btn_like').addClass('like-active');
			$('#btn_dislike').removeClass('dislike-active');
		} else if (actionType == 'dislike') {
			$('#btn_dislike').addClass('dislike-active');
			$('#btn_like').removeClass('like-active');
		} else {
			$('#btn_like').removeClass('like-active');
			$('#btn_dislike').removeClass('dislike-active');
		}
	}

	// 추천 및 비추천 수 업데이트 함수
	function updateVoteCounts(likes, dislikes) {
		$('#likes').text(likes);
		$('#dislikes').text(dislikes);
	}

	// 모달 표시 함수
	function showVoteModal(action, message) {
		// 모달 설정 코드
		let modalTitle = action == 'change' ? '[선택 변경]' : '[선택 취소]';
		$('#btn_change').toggle(action == 'change'); // 변경 버튼 표시/숨김
		$('#btn_cancel').toggle(action == 'cancel'); // 취소 버튼 표시/숨김

		$('#voteChangeModal').find('.modal-title').text(modalTitle);
		$('#voteChangeModal').find('.modal-body').text(message);

		// '변경' 버튼 클릭 이벤트
		$('#btn_change').off("click").on("click", function () {
			console.log("변경 버튼 클릭");

			// 서버에 투표 변경 요청
			handleVoteAction(bd_number, action == 'change' ? (currentType == 'like' ? 'dislike' : 'like') : currentType);
		});

		// '취소' 버튼 클릭 이벤트
		$('#btn_cancel').off("click").on("click", function () {
			console.log("취소 버튼 클릭");

			// 현재 투표 상태가 null이 아니면 취소 요청
			if (currentType != null) {
				handleVoteAction(bd_number, 'none'); // 아무것도 없는 상태로 되돌림										
			}
		});

		$('#voteChangeModal').modal('show');
	}

	// 투표 변경 및 취소 로직을 실행하는 함수(함수 선언식 형태는 호이스팅 가능)
	function handleVoteAction(bd_number, voteType) {

		debouncedAction(bd_number, voteType); // 실제 투표 처리
		$('#voteChangeModal').modal('hide'); // 모달 닫기

		// 모달이 완전히 닫히고 실행되는 이벤트(hide.bs.modal과는 다소 다름)
		// 이벤트 핸들러 중복 등록 방지 및 새로운 핸들러 등록
		$('#voteChangeModal').off('hidden.bs.modal').on('hidden.bs.modal', function () {
			console.log("모달 닫힘 후 상태:", voteType);
			if (voteType === 'none') {
				alert("기존 선택이 정상적으로 취소되었습니다.");
			} else {
				alert("기존 선택이 정상적으로 변경되었습니다.");
			}
		});
	}

	// 현재 투표 상태와 서버 시간을 확인하고 초기 UI 상태를 설정하는 함수
	function checkAndApplyVoteStatus() {

		$.ajax({
			url: '/user/board/getCurrentVoteStatus',
			type: 'GET',
			data: { bd_number: bd_number },
			dataType: 'json', // JSON 형식의 응답(map)
			success: function (data) {
				currentType = data.voteStatus; // 현재 사용자의 투표 상태
				voteDate = new Date(data.voteDate); // 마지막 투표 시간
				serverDate = new Date(data.serverDate); // 서버의 날짜 및 시간

				updateButtonState(currentType);
				updateVoteCounts(data.like, data.dislike); // 추천 및 비추천 수 집계
			}
		});
	}

	// 등록 날짜와 현재 날짜를 비교하는 함수							
	function isSameDay(date1, date2) {
		return date1.getFullYear() == date2.getFullYear() &&
			date1.getMonth() == date2.getMonth() &&
			date1.getDate() == date2.getDate(); // getDate()는 일, getDay()는 요일을 의미함
	}

	// '좋아요/싫어요' 버튼 클릭 이벤트
	// 기존에 등록된 모든 이벤트 핸들러 제거 후 새로운 이벤트 핸들러 추가
	// off(): "Maximum call stack size exceeded" 오류로 인한 처리
	$('.btn_vote').off("click").on("click", function () {

		let attemptType = $(this).data('vt_status'); // 클릭된 버튼의 투표 타입 저장
		let today = serverDate; // 서버로부터 받은 현재 날짜 사용

		// 사용자의 현재 투표 상태와 클릭된 버튼의 투표 타입에 따라 서버 요청
		// voteDate가 null이 아닌 경우에만 isSameDay 함수를 호출
		if (voteDate && isSameDay(voteDate, today)) {
			// 당일 투표한 경우(등록 날짜와 현재 날짜가 같음)
			if (boardType == 'free' || (boardType != 'free' && currentType != null)) {
				// 1일 1회 게시판 또는 계정당 1회 게시판에 당일 이미 투표한 경우
				if (currentType == attemptType) {
					// 같은 타입을 다시 클릭한 경우 ─ 취소 모달 표시 등
					if (confirm('이미 오늘 선택하셨습니다. 취소하려면 확인 버튼을 클릭해 주세요.')) {
						showVoteModal('cancel', '기존 선택을 취소하시겠습니까?');
					}
				} else {
					// 다른 타입을 클릭한 경우 ─ 변경 모달 표시 등
					if (confirm('이미 오늘 선택하셨습니다. 변경하려면 확인 버튼을 클릭해 주세요.')) {
						showVoteModal('change', '기존 선택을 변경하시겠습니까?');
					}
				}
			}
		} else {
			// 당일 이후에 투표한 경우 또는 voteDate가 null인 경우
			if (boardType == 'free') {
				// 1일 1회 게시판에서 당일 이외 투표 시 새로운 투표 추가
				debouncedAction(bd_number, attemptType); // 즉시 서버 요청
			} else if (boardType != 'free') {
				// 계정당 1회 게시판에서의 처리
				if (currentType != null) {
					// 현재 상태가 있는 경우로서 당일 이후 투표 시 변경/취소 불가
					alert('이전에 이미 선택하셨습니다. 당일 이후 변경 및 취소는 불가합니다.');
				} else {
					// 현재 상태가 없는 경우로서 당일 투표 시 새로운 투표 추가
					debouncedAction(bd_number, attemptType); // 즉시 서버 요청
				}
			}
		}
	});

}); // ready-end