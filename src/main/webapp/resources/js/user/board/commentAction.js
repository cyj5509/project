$(document).ready(function () {

	// 전역변수 초기화 작업
	let currentPage = 1; // 현재 페이지 번호를 저장하는 변수

	// 페이지 로드 시 댓글 불러오기
	loadComments(bd_number, currentPage);

	// 댓글 작성 버튼 클릭 이벤트
	$(".btn_commentWrite").on("click", function () {
		// 폼을 항상 표시하도록 설정
		$(".comment-register-form").show(); // $(".comment-register-form").toggle();
	});

	// 댓글 등록 버튼 클릭 이벤트
	$("#btn_newCommentRegister").on("click", function () {

		let us_id = $("#us_id").val();
		let guest_nickname = $("#cm_guest_nickname").val();
		let guest_pw = $("#cm_guest_pw").val();
		let cm_content = $("#cm_content").val();

		// 회원 여부에 따른 닉네임 처리
		if (!us_id) {
			if (!guest_nickname || guest_nickname.trim() == '') {
				// 비회원인 경우 닉네임이 비어있으면 기본값으로 설정
				guest_nickname = 'guest';
			}
			if (!guest_pw || guest_pw.trim() == '') {
				alert("비밀번호를 입력해 주세요.");
				$("#guest_pw").focus();
				return;
			}
		} else {
			// 회원인 경우 비회원 닉네임 필드 무시
			guest_nickname = null;
		}

		if (!cm_content || cm_content.trim() == '') {
			alert("내용을 입력해 주세요.");
			$("#cm_content").focus();
			return;
		}

		// 댓글 추가 요청에 사용되는 데이터 객체로 JSON 형식으로 변환되어 서버에 전송
		let commentInsertData = {
			bd_number: bd_number,
			us_id: us_id,
			cm_guest_nickname: guest_nickname,
			cm_guest_pw: guest_pw,
			cm_content: cm_content
		}

		$.ajax({
			url: '/comment/manageComments?action=insert', // 요청을 보낼 서버의 URL
			type: 'POST', // ATTP 요청 방식(GET, POST 등)
			contentType: 'application/json', // 서버로 보내는 데이터의 타입
			data: JSON.stringify(commentInsertData),
			dataType: 'json', // 서버에서 응답으로 받기를 원하는 데이터 타입
			success: function (response) {
				if (response.status == "ok") {
					alert("댓글이 정상적으로 입력되었습니다.");
					console.log("추가된 댓글 코드:", response.cm_code);
					$(".comment-register-form").hide(); // 폼 숨김
					loadComments(bd_number, currentPage); // 댓글 목록 새로고침
				} else {
					alert("오류가 발생했습니다. 나중에 다시 시도해 주세요.");
				}
			}
		});

		// 필드 초기화
		if (!us_id) { // 비회원인 경우
			$("#cm_guest_pw").val("");
		}
		$("#cm_content").val(""); // 모든 경우에 내용 초기화
	});

	// 댓글 취소 버튼 클릭 이벤트
	$("#btn_newCommentCancel").on("click", function () {
		$(".comment-register-form").hide();
	});

	// 댓글 목록을 불러와 화면에 표시하는 함수
	function loadComments(bd_number, page) {

		// AJAX 요청을 통해 서버로부터 댓글 데이터를 가져옴
		$.ajax({
			url: '/comment/retrieveComments/' + bd_number + '?page=' + page,
			type: 'GET',
			dataType: 'json',
			success: function (response) {
				// 댓글 목록을 담을 HTML 요소 선택
				let commentsArea = $('#commentsArea tbody');
				commentsArea.empty(); // 기존의 댓글 목록을 비움

				// 핸들바 템플릿 가져오기
				let source = $("#comment-list-template").html();
				let template = Handlebars.compile(source);

				// 댓글 목록이 비어 있는 경우 확인
				if (response.comments.length == 0) {
					// 댓글 목록이 없는 경우, 테이블과 페이징 요소 숨김
					$('#commentsArea').hide();
				} else {
					// 댓글 목록이 있는 경우, 테이블과 페이징 요소 표시
					$('#commentsArea').show();

					// 각 댓글에 대해 HTML 생성 및 추가
					response.comments.forEach(function (comment) {

						// 댓글 데이터를 위한 컨텍스트 생성(답글 개수 포함)
						let commentContext = {
							cm_code: comment.cm_code,
							us_id: comment.us_id,
							cm_guest_nickname: comment.cm_guest_nickname,
							cm_content: comment.cm_content,
							cm_register_date: comment.cm_register_date,
							cm_update_date: comment.cm_update_date,
							repliesCount: comment.repliesCount // 답글 개수(추후 보완)
						};

						// 핸들바 템플릿을 사용하여 댓글 HTML 생성
						let commentHtml = template(commentContext);
						commentsArea.append(commentHtml); // 생성된 HTML을 댓글 목록에 추가

						// "답글 n개" 표시 영역이 있고 답글 개수가 0보다 큰 경우에만 표시(추후 보완)
						// 특정 댓글에만 영향을 주기 위해 속성 선택자와 클래스 선택자를 함께 사용
						if (comment.repliesCount > 0) {
							$('[data-cm_code=' + comment.cm_code + '] .replies-count')
								.text('답글 ' + repliesCount + '개').show();
						}
					});
					// 페이징 컨트롤을 화면에 표시하는 함수 호출
					printPagination(response.pageInfo, $('#commentPaging'))
				}
			}
		});
	}

	// 동적으로 페이지네이션 HTML(버튼)을 생성하여 화면에 표시하는 함수
	// JSP 파일에선 템플릿 리터럴, 즉 백틱을 이용하게 되면 제대로 동작하지 않음
	// 문자열 연결 연산자가 아닌 백틱의 사용을 위해선 외부 파일로 분리해야 함
	function printPagination(pageInfo, targetElement) {
		let paginationHtml = '<ul class="pagination">';

		// 맨 처음 표시 여부
		if (pageInfo.foremost) {
			paginationHtml += '<li class="page-item"><a class="page-link" href="#" data-page="1">처음</a></li>';
		}

		// 이전 표시 여부
		if (pageInfo.prev) {
			paginationHtml += '<li class="page-item"><a class="page-link" href="#" data-page="' + (pageInfo.startPage - 1) + '">이전</a></li>';
		}

		// 페이지 번호 출력
		for (let i = pageInfo.startPage; i <= pageInfo.endPage; i++) {
			let activeClass = pageInfo.cri.pageNum == i ? 'active' : '';
			paginationHtml += '<li class="page-item ' + activeClass + '"><a class="page-link" href="#" data-page="' + i + '">' + i + '</a></li>';
		}

		// 다음 표시 여부
		if (pageInfo.next) {
			paginationHtml += '<li class="page-item"><a class="page-link" href="#" data-page="' + (pageInfo.endPage + 1) + '">다음</a></li>';
		}

		// 맨 끝 표시 여부
		if (pageInfo.rearmost) {
			paginationHtml += '<li class="page-item"><a class="page-link" href="#" data-page="' + pageInfo.readEnd + '">끝</a></li>';
		}

		paginationHtml += '</ul>';
		// 생성된 페이지네이션 HTML을 targetElement 내부에 삽입
		targetElement.html(paginationHtml);
	}

	// 페이지네이션 버튼 클릭 이벤트 처리
	$(document).on('click', '.page-link', function (e) {
		e.preventDefault(); // 페이지 상단으로의 이동 방지
		let selectedPage = $(this).data('page'); // 댓글에서의 선택된 페이지 번호
		console.log('선택한 페이지 번호:', selectedPage);
		currentPage = selectedPage; // 선택된 페이지 번호를 업데이트
		loadComments(bd_number, currentPage); // 해당 페이지의 댓글을 불러옴
	});

	// 댓글 날짜 형식 변환 처리
	Handlebars.registerHelper('formatDate', function (commentTime) {

		const dateObj = new Date(commentTime);
		let year = dateObj.getFullYear();
		let month = dateObj.getMonth() + 1;
		let date = dateObj.getDate();
		let hour = dateObj.getHours();
		let minute = dateObj.getMinutes();

		// 한 자리 숫자인 경우 앞에 '0'을 붙임
		month = month < 10 ? '0' + month : month;
		date = date < 10 ? '0' + date : date;
		hour = hour < 10 ? '0' + hour : hour;
		minute = minute < 10 ? '0' + minute : minute;

		return year + "/" + month + "/" + date + " " + hour + ":" + minute;
	});

	// 댓글 열기/닫기 버튼 클릭 이벤트
	$(document).on('click', '.btn_allCommentToggle', function () {
		let commentsArea = $('#commentsArea');
		let commentTable = $('#commentTable tbody');

    // 댓글 목록이 비어 있는지 확인
    if (commentTable.children().length == 0) {
        alert("현재까지 작성된 댓글이 없습니다.");
				return;
    } else {
        commentsArea.toggle(); // 댓글 목록이 있다면, 토글
    }

		// 버튼 텍스트 토글
		if ($(this).text() == '열기 ▼') {
			$(this).text('닫기 ▲');
		} else {
			$(this).text('열기 ▼');
		}
	});

	// 내용 클릭 시 수정/삭제/답글 메뉴 표시
	$(document).on('click', '.comment-content', function () {
		// 현재 클릭된 내용을 제외한 다른 모든 메뉴 항목을 숨김
		$('.menu-items').not($(this).find('.menu-items')).hide();
		// 현재 클릭된 내용의 메뉴 토글
		$(this).find('.menu-items').toggle();
	});

	// 메뉴 외부를 클릭하면 메뉴 닫기
	// 전체 문서에 클릭 이벤트 리스너를 설정하여 클릭 이벤트를 감지
	$(document).on('click', function (e) {
		// 클릭된 요소가 해당 클래스 내부에 있지 않은 경우를 확인
		if (!$(e.target).closest('.comment-content').length) {
			// 내부 또는 자신이 클릭되지 않았다면 열려 있는 모든 '.menu-items'를 숨깁
			$('.menu-items').hide();
		}
	});

	// 댓글 수정 버튼 클릭 이벤트
	$(document).on('click', '.btn_commentModify', function () {

		// 수정 메뉴 클릭 시 기존 수정 폼이 열려 있는 경우 제거
		$('.comment-edit-form').remove();

		let commentRow = $(this).closest('tr');
		let cm_code = commentRow.data('cm_code');
		console.log("댓글 코드 1:", cm_code);
		let cm_content = commentRow.find('.comment-content').clone() // 내용 복제
			.children().remove().end() // 자식 요소(메뉴 항목) 제거 및 원래 객체(복제본)로 돌아감
			.text().trim(); // 텍스트 추출 및 공백 제거

		// 회원 여부 확인	
		let us_id = commentRow.data('us_id'); // 회원 아이디 데이터셋 속성 사용
		console.log("회원 아이디:", us_id);
		console.log("사용자명:", commentRow.find('.comment-user').text().trim());
		let isMemberComment = (us_id != undefined && us_id.trim() !== ''); // 회원 댓글 여부								
		let isCurrentUserMember = $("#us_id").val() != null; // 현재 사용자가 회원인지 여부
		console.log("회원 댓글 여부:", isMemberComment);
		console.log("현재 사용자의 회원 여부:", isCurrentUserMember);

		// 비회원이 회원 댓글 수정 시도 시 차단
		if (isMemberComment && !isCurrentUserMember) {
			alert("비회원은 회원의 댓글을 수정할 수 없습니다.");
			return;
		}

		let commentUser = isMemberComment ? us_id : commentRow.find('.comment-user').text().trim();

		// 수정 폼 템플릿을 가져와서 데이터를 설정
		let editFormHtml = Handlebars.compile($("#comment-edit-template").html())({
			cm_code: cm_code,
			cm_content: cm_content,
			isMember: isMemberComment, // 회원 여부 전달
			// 비회원인 경우 undefined로 설정하여 템플릿에서 렌더링하지 않음
			us_id: isMemberComment ? commentUser : undefined,
			// 회원인 경우 undefined로 설정하여 템플릿에서 렌더링하지 않음
			cm_guest_nickname: !isMemberComment ? commentUser : undefined
		});

		// 현재 댓글 바로 아래에 수정 폼 삽입
		commentRow.after(editFormHtml);
		// commentRow.hide(); // 필요한 경우 원본 댓글 숨김
	});

	// 수정 폼의 저장 버튼 클릭 이벤트
	$(document).on('click', '.btn-save-edit', function () {
		let formRow = $(this).closest('.comment-edit-form');
		let cm_code = formRow.data('cm_code');
		console.log("댓글 코드 2:", cm_code); // 댓글 코드 데이터셋 속성 사용

		let us_id = formRow.data('us_id'); // 회원 아이디 데이터셋 속성 사용
		let guest_pw_input = formRow.find('input[name="cm_guest_pw"]');
		let cm_content = formRow.find('textarea[name="cm_content"]').val();

		// 댓글 수정 요청에 사용되는 데이터 객체로 JSON 형식으로 변환되어 서버에 전송
		let commentModifyData = {
			cm_code: cm_code,
			us_id: us_id,
			cm_content: cm_content
		}

		// 비회원 댓글인 경우에만 비밀번호 입력 확인 및 비밀번호 추가
		if (!us_id && guest_pw_input.length > 0) {
			let guest_pw = guest_pw_input.val(); // 비회원 비밀번호 추출	
			if (!guest_pw || guest_pw.trim() == '') {
				alert("댓글 작성 시 입력했던 비밀번호를 입력해 주세요.");
				guest_pw_input.focus();
				return;
			}
			commentModifyData.cm_guest_pw = guest_pw; // 비회원 비밀번호 추가
		}

		// AJAX 요청을 통해 서버에 수정 요청을 보냄
		$.ajax({
			url: '/comment/manageComments?action=modify',
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify(commentModifyData),
			dataType: 'json',
			success: function (response) {
				if (response.status == 'ok') {
					alert('댓글이 정상적으로 수정되었습니다.');
					formRow.remove(); // 수정 폼 제거
					loadComments(bd_number, currentPage); // 댓글 목록 새로고침
				} else if (response == "fail") {
					alert("오류가 발생했습니다. 나중에 다시 시도해 주세요.");
				}
			},
			error: function (xhr, status, error) {
				if (xhr.status == 401) {
					alert(xhr.responseJSON.message); // "권한 없음" 메시지 출력
					$('.comment-edit-form').remove(); // 권한이 없는 경우 기존 수정 폼 제거
				} else if (xhr.status == 403) {
					alert(xhr.responseJSON.message); // "비밀번호 불일치" 메시지 출력
					guest_pw_input.val("");
					guest_pw_input.focus();
				}
			}
		});
	});

	// 수정 폼의 취소 버튼 클릭 이벤트
	$(document).on('click', '.btn-cancel-edit', function () {
		// $(this).closest('tr').prev('tr').show(); // 원래의 댓글 내용 다시 표시
		$(this).closest('tr').remove(); // 수정 폼 제거
	});

	// 댓글 삭제 버튼 클릭 이벤트
	$(document).on('click', '.btn_commentDelete', function () {
		let commentRow = $(this).closest('tr');
		let cm_code = commentRow.data('cm_code'); // 댓글 코드 데이터셋 속성 사용

		// 회원 여부 확인	
		let us_id = commentRow.data('us_id'); // 회원 아이디 데이터셋 속성 사용
		console.log("회원 아이디:", us_id);
		console.log("사용자명:", commentRow.find('.comment-user').text().trim());
		let isMemberComment = (us_id != undefined && us_id.trim() !== ''); // 회원 댓글 여부
		let isCurrentUserMember = $("#us_id").val() != null; // 현재 사용자가 회원인지 여부
		console.log("회원 댓글 여부:", isMemberComment);
		console.log("현재 사용자가 회원인지 여부:", isCurrentUserMember);

		// 비회원이 회원 댓글 삭제 시도 시 차단
		if (isMemberComment && !isCurrentUserMember) {
			alert("비회원은 회원의 댓글을 삭제할 수 없습니다.");
			return;
		}

		// 삭제를 위한 데이터를 모달의 확인 버튼에 바인딩
		$('#confirmDelete').data('cm_code', cm_code); // 댓글 코드 데이터 바인딩

		// 댓글 삭제 요청에 사용되는 데이터 객체로 JSON 형식으로 변환되어 서버에 전송
		let commentDeleteData = { cm_code: cm_code };
		// 회원 댓글인 경우
		if (us_id) {
			commentDeleteData.us_id = us_id; // 회원 아이디 추가

			if (confirm('댓글을 정말로 삭제하시겠습니까?')) {
				deleteComment(commentDeleteData); // 회원 아이디를 포함하여 삭제 요청
			}
		} else {
			// 비회원 댓글인 경우, 모달 팝업 표시
			$('#deleteCommentModal').modal('show');
		}
	});

	// 모달 내 삭제 확인 버튼 클릭 이벤트
	$('#confirmDelete').on('click', function () {
		let cm_code = $(this).data('cm_code'); // 댓글 코드 가져오기
		let guest_pw = $('#commentDeletePw').val();

		// 댓글 삭제 요청에 사용되는 데이터 객체로 JSON 형식으로 변환되어 서버에 전송
		let commentDeleteData = { cm_code: cm_code };

		let currentUserId = $("#us_id").val(); // 현재 로그인한 회원의 아이디
		let commentRow = $('tr[data-cm_code="' + cm_code + '"]');
		let commentUserId = commentRow.data('us_id');

		console.log("현재 사용자: " + currentUserId);
		console.log("댓글 사용자: " + commentUserId);

		// 회원이든 비회원이든 비회원 댓글을 삭제할 때는 비밀번호 확인 필요
		if (!commentUserId) {
			// 비회원이 비회원 댓글 삭제 시 비밀번호 확인 및 설정 등
			if (!guest_pw || guest_pw.trim() == '') {
				alert("댓글 작성 시 입력했던 비밀번호를 입력해 주세요.");
				$("#commentDeletePw").focus();
				return;
			}
			commentDeleteData.cm_guest_pw = guest_pw; // 비회원 비밀번호 전송
			commentDeleteData.us_id = currentUserId ? null : undefined; // 회원 아이디를 null로 설정
		} else if (currentUserId) {
			// 회원이 회원 댓글을 삭제하는 경우		
			commentDeleteData.us_id = currentUserId; // 회원 아이디를 로그인한 아이디로 설정
		}

		deleteComment(commentDeleteData); // 삭제 요청 함수 호출								
		$('#commentDeletePw').val(""); // 비밀번호 입력 필드 초기화
	});

	// 공통 삭제 로직: 매개변수에 기본값을 지정하면 호출 시 생략 가능(생략된 경우 기본값 적용)
	// 회원은 아이디를, 비회원은 비밀번호를 이용하여 댓글 삭제 처리
	function deleteComment(commentDeleteData) {

		console.log("삭제 요청 데이터:", commentDeleteData);

		$.ajax({
			url: '/comment/manageComments?action=delete',
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify(commentDeleteData),
			success: function (response) {
				if (response.status == 'ok') {
					// 모달 닫힘 이벤트에 함수 바인딩
					$('#deleteCommentModal').off('hidden.bs.modal').on('hidden.bs.modal', function () {
						alert('댓글이 정상적으로 삭제되었습니다.');
						loadComments(bd_number, currentPage); // 댓글 목록 새로고침
						$('#deleteCommentModal').off('hidden.bs.modal'); // 이벤트 핸들러 제거
					});
					$('#deleteCommentModal').modal('hide'); // 삭제 성공시 모달 닫기
					$('#commentDeletePw').val(""); // 비밀번호 입력 필드 초기화
				} else {
					alert("오류가 발생했습니다. 나중에 다시 시도해 주세요.");
				}
			},
			error: function (xhr, status, error) {
				if (xhr.status == 401) {
					alert(xhr.responseJSON.message); // "권한 없음" 메시지 출력
				} else if (xhr.status == 403) {
					alert(xhr.responseJSON.message); // "비밀번호 불일치" 메시지 출력
					$('#deleteCommentModal').modal('show');
					$("#commentDeletePw").focus();
				}
			}
		});
	}

}); // ready-end