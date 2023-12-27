<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

			<!doctype html>
			<html lang="en">

			<head>
				<meta charset="utf-8">
				<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
				<meta name="description" content="">
				<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
				<meta name="generator" content="Hugo 0.101.0">
				<title>데브데이: 커뮤니티</title>

				<%@include file="/WEB-INF/views/comm/plugIn1.jsp" %>

					<!-- CSS 파일 링크 -->
					<link rel="stylesheet" href="/css/common/header.css">
					<link rel="stylesheet" href="/css/user/board/main_text.css">
					<link rel="stylesheet" href="/css/user/board/pw_modal.css">

					<style>
						.choiceNotice {
							font-size: 14px;
						}

						.like-active {
							color: white;
							background-color: blue;
						}

						.dislike-active {
							color: white;
							background-color: red;
						}
					</style>

					<script>
						// 비회원 게시물 수정 및 삭제 시 비밀번호가 불일치하면 동작(checkPw 메서드)
						let msg = '${msg}';
						if (msg != "") {
							alert(msg);
						}
					</script>
			</head>

			<body data-bd_number="${bd_vo.bd_number}">

				<%@include file="/WEB-INF/views/comm/header.jsp" %>

					<!-- Begin page content -->
					<main role="main" class="flex-shrink-0">
						<div class="container">
							<section>
								<div class="row"> <!-- 합이 12까지 사용 가능. 반드시 고정될 필요는 없음 -->
									<!-- <div class="col-해상도-숫자"></div>  -->
									<div class="col-md-12">
										<div class="box box-primary">
											<div class="box-header with-border">
												<h2 class="box-title mt-5"><b>조회하기</b></h2>
											</div><br />

											<div class="box-body">
												<div class="form-group row">
													<label for="us_id" class="col-2">작성자</label>
													<div class="col-4">
														<c:choose>
															<c:when test="${not empty bd_vo.us_id}">
																<input type="text" class="form-control" name="us_id" id="us_id" value="${bd_vo.us_id}"
																	readonly>
															</c:when>
															<c:otherwise>
																<input type="text" class="form-control" name="bd_guest_nickname" id="bd_guest_nickname"
																	value="${bd_vo.bd_guest_nickname}" readonly>
															</c:otherwise>
														</c:choose>
													</div>
													<label for="bd_register_date" class="col-2">작성일</label>
													<div class="col-4">
														<input type="text" class="form-control" id="bd_register_date"
															value='<fmt:formatDate value="${bd_vo.bd_register_date}" pattern="yyyy년 MM월 dd일" />'
															readonly>
													</div>
												</div>
												<div class="form-group row">
													<label for="bd_title" class="col-2">제목</label>
													<div class="col-4">
														<input type="text" class="form-control" name="bd_title" id="bd_title"
															value="${bd_vo.bd_title}" readonly>
													</div>
													<label for="bd_type" class="col-2">카테고리</label>
													<div class="col-4">
														<select class="form-control" name="bd_type" id="bd_type">
															<option value="notice" ${bd_vo.bd_type=='notice' ? 'selected' : '' }
																style="display: none;">공지사항</option>
															<option value="free" ${bd_vo.bd_type=='free' ? 'selected' : '' }>자유 게시판</option>
															<option value="info" ${bd_vo.bd_type=='info' ? 'selected' : '' }>정보 공유</option>
															<option value="study" ${bd_vo.bd_type=='study' ? 'selected' : '' }>스터디원 모집</option>
															<option value="project" ${bd_vo.bd_type=='project' ? 'selected' : '' }>플젝팀원 모집</option>
															<option value="inquery" ${bd_vo.bd_type=='inquery' ? 'selected' : '' }>Q&#38;A(문의)
															</option>
														</select>
													</div>
												</div>
												<div class="form-group">
													<label for="bd_content">내용</label>
													<div class="form-control readonly-div" style="height: 500px; width: 100%; overflow-y: auto;"
														readonly>
														${bd_vo.bd_content}
													</div>
												</div><br />
												<div class="form-group" style="text-align: center;">
													<button class="likeCount btn_vote" id="btn_like" data-vt_status="like">
														좋아요!
													</button>
													<button class="dislikeCount btn_vote" id="btn_dislike" data-vt_status="dislike">
														싫어요!
													</button>
													<div>
														추천: <span id="likes">0</span>
														/ 비추천: <span id="dislikes">0</span>
													</div>
													<div>
														<p class="choiceNotice">&#42; 1일 1회 선택 가능&#40;변경&#47;취소 시 해당 버튼 클릭&#41;</p>
													</div>
												</div>
											</div>
											<br />
											<!-- HTML 요소에 데이터 속성 추가 -->
											<div class="box-footer" data-isGuestPost="${bd_vo.us_id == null || bd_vo.us_id eq ''}">
												<!-- BoardController의 @ModelAttribute("cri") Criteria cri -->
												<!-- 회원이 Modify, Delete, List 버튼 클릭 시 아래 form 태그를 전송-->
												<form id="curListInfo" action="" method="get">
													<!-- <input type="hidden" name="bd_type" id="bd_type" value="${bd_vo.bd_type}" /> -->
													<input type="hidden" name="pageNum" id="pageNum" value="${cri.pageNum}" />
													<input type="hidden" name="amount" id="amount" value="${cri.amount}" />
													<input type="hidden" name="type" id="type" value="${cri.type}" />
													<input type="hidden" name="keyword" id="keyword" value="${cri.keyword}" />
													<input type="hidden" name="bd_number" id="bd_number" value="${bd_vo.bd_number}" />
												</form>
												<div style="display: flex; align-items: center;">
													<c:choose>
														<c:when
															test="${sessionScope.userStatus != null && sessionScope.userStatus.us_id == bd_vo.us_id}">
															<!-- 로그인한 회원이 작성한 게시물일 경우 -->
															<button type="button" id="btn_modify" class="btn btn-primary"
																style="margin-right: 7.5px;">수정</button>
															<button type="button" id="btn_delete" class="btn btn-danger"
																style="margin-right: 7.5px;">삭제</button>
														</c:when>
														<c:when
															test="${bd_vo.us_id == null && bd_vo.bd_guest_nickname != null && !empty bd_vo.bd_guest_nickname}">
															<!-- 비회원이 작성한 게시물일 경우 -->
															<button type="button" id="btn_modify" class="btn btn-primary"
																style="margin-right: 7.5px;">수정</button>
															<button type="button" id="btn_delete" class="btn btn-danger"
																style="margin-right: 7.5px;">삭제</button>
														</c:when>
													</c:choose>
													<button type="button" id="btn_list" class="btn btn-success">목록</button>
													<!-- 비밀번호 입력 커스텀 모달(초기에는 숨겨져 있음) -->
													<div id="passwordModal" class="pw-modal" style="display:none;">
														<div class="pw-modal-content">
															<div class="pw-modal-header">
																<span id="pwModalMessage1"></span>
																<span class="pw-close-button" onclick="closePasswordModal()">&times;</span>
															</div>
															<div class="pw-modal-body">
																<form id="passwordForm" method="post" action="/user/board/checkPw">
																	<input type="hidden" name="bd_number" value="${bd_vo.bd_number}">
																	<input type="hidden" id="formAction" name="action" value="">
																	<input type="password" id="bd_guest_pw" name="bd_guest_pw" placeholder="비밀번호를 입력하세요.">
																</form>
																<p id="pwModalMessage2"></p>
															</div>
															<div class="pw-modal-footer">
																<button type="submit" form="passwordForm">확인</button>
																<button type="button" onclick="closePasswordModal()">취소</button>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<footer class="footer mt-auto py-3">
									<%@include file="/WEB-INF/views/comm/footer.jsp" %>
										<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>
								</footer>
							</section>
							<!-- 투표 변경/취소 부트스트랩 모달 -->
							<div class="modal fade" id="voteChangeModal" tabindex="-1" aria-labelledby="voteChangeModalLabel"
								aria-hidden="true" data-backdrop="static" data-keyboard="false">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="voteChangeModalLabel"></h5>
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body"></div>
										<div class="modal-footer">
											<button type="button" class="btn btn-primary" id="btn_change">변경</button>
											<button type="button" class="btn btn-danger" id="btn_cancel">취소</button>
											<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</main>

					<!-- JS 파일 링크 -->
					<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>
					<script src="/js/user/board/pw_modal.js"></script>

					<!-- 기존 순수 자바스크립트 로직 -->
					<script>

						// 비밀번호 입력 모달을 보여주는 함수
						function showPasswordModal(action) {
							let pwModalMessage1 = document.getElementById('pwModalMessage1'); // <span id="pwModalMessage1"></span>
							let pwModalMessage2 = document.getElementById('pwModalMessage2');// <p id="pwModalMessage2"></p>

							if (action == 'modify') {
								// 수정 버튼 클릭 시 동작
								pwModalMessage1.textContent = '[비회원/수정]';
								pwModalMessage2.textContent = '* 게시물 수정 시 비밀번호 입력'
							} else if (action == 'delete') {
								// 삭제 버튼 클릭 시 동작
								pwModalMessage1.textContent = '[비회원/삭제]';
								pwModalMessage2.textContent = '* 게시물 삭제 시 비밀번호 입력'
							}

							document.getElementById('formAction').value = action;
							document.getElementById('passwordModal').style.display = 'block';
						}

						// 비밀번호 입력 모달을 닫는 함수
						function closePasswordModal() {
							let modalContent = document.getElementById('passwordModal').querySelector('.modal-content');
							// 모달 컨텐츠 위치 초기화
							modalContent.style.top = "50%";
							modalContent.style.left = "50%";
							modalContent.style.transform = "translate(-50%, -50%)";

							// 비밀번호 입력 필드 초기화
							document.getElementById('bd_guest_pw').value = '';
							// 모달 숨기기
							document.getElementById('passwordModal').style.display = 'none';
						}

						// HTML 요소에서 데이터 속성 값을 읽기
						let isGuestPost = document.querySelector('.box-footer').getAttribute('data-isGuestPost') == 'true';
						let curListInfo = document.getElementById("curListInfo"); // <form id="curListInfo" action="" method="get">를 참조

						// 수정 버튼 클릭
						// document.getElementById("btn_modify").addEventListener("click", 함수명);
						let btn_modify = document.getElementById("btn_modify");
						if (btn_modify) {
							btn_modify.addEventListener("click", fn_modify); // 함수의 괄호는 제외
						}
						function fn_modify() {
							console.log("수정 버튼 클릭");

							// 비회원 게시물인 경우
							if (isGuestPost) {
								showPasswordModal('modify');
							} else {

								// 회원 게시물의 경우 기존 로직 실행
								curListInfo.setAttribute("action", "/user/board/modify/${bd_vo.bd_type}");
								curListInfo.submit();
							}
						}

						// 비밀번호 입력 폼에 대한 이벤트 핸들러 추가
						document.getElementById('passwordForm').onsubmit = function () {
							// 비회원 게시물인 경우에만 삭제 확인을 진행
							if (isGuestPost && document.getElementById('formAction').value == 'delete') {
								let isConfirmed = confirm("게시물을 정말로 삭제하시겠습니까?");
								if (!isConfirmed) {
									// 사용자가 '취소'를 선택한 경우, 모달창 닫기
									closePasswordModal();
									return false; // 폼 제출 중단
								}
								return true; // '확인'을 선택한 경우, 폼 제출 진행
							}
							return true; // 회원 게시물이거나, 수정 작업인 경우 폼 제출 진행
						};

						// 삭제 버튼 클릭
						let btn_delete = document.getElementById("btn_delete");
						if (btn_delete) {
							btn_delete.addEventListener("click", fn_delete); // 함수의 괄호는 제외
						}
						function fn_delete() {
							console.log("삭제 버튼 클릭");

							// 비회원 게시물인 경우
							if (isGuestPost) {
								showPasswordModal('delete');
							} else {
								// 회원 게시물의 경우
								if (!confirm("게시물을 정말로 삭제하시겠습니까?")) return;
								curListInfo.setAttribute("action", "/user/board/delete/${bd_vo.bd_type}");
								curListInfo.submit();
							}
						}

						// 리스트 클릭
						// c:if 태그에 의해 수정 및 삭제 버튼이 존재하지 않는 경우, 목록 버튼에 영향을 주어 에러 발생 
						document.getElementById("btn_list").addEventListener("click", fn_list); // 함수의 괄호는 제외
						function fn_list() {
							console.log("목록 버튼 클릭");
							document.getElementById("bd_number").remove();
							curListInfo.setAttribute("action", "/user/board/list/${bd_vo.bd_type}"); // /user/board/list -> /user/board/get 전송
							curListInfo.submit();
						}
					</script>

					<!-- jQuery 기반 추가 스크립트 -->
					<script>
						$(document).ready(function () {

							// 전역변수
							let bd_number = $('body').data('bd_number'); // 게시물 번호
							// console.log("게시물 번호:", bd_number);

							let currentType = null; // 현재 사용자의 투표 타입 초기화

							// 페이지 로딩 시 현재 투표 상태와 투표 수 확인
							checkAndApplyVoteStatus();

							// lodash 라이브러리의 debounce 함수 사용(함수 표현식 형태는 호이스팅 불가)
							const debouncedAction = _.debounce(function (bd_number, actionType) {

								// "falsy"(빈 문자열, null, undefined, 0, false, NaN) 중 하나일 때 체크
								if (!actionType) {
									// alert("투표 타입이 올바르지 않습니다.");
									return; // 함수 실행을 종료하여 서버로의 AJAX 요청 방지
								}

								// '좋아요/싫어요' 버튼 비활성화
								$('#btn_like').prop('disabled', true);
								$('#btn_dislike').prop('disabled', true);

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
										// 버튼 활성화
										$('#btn_like').prop('disabled', false);
										$('#btn_dislike').prop('disabled', false);
										// 401 Unauthorized 상태 처리
										if (xhr.status === 401) {
											alert("로그인이 필요한 기능입니다.");
										} else {
											alert("오류가 발생했습니다: " + error);
										}
									}
								});
							}, 1000); // 1초(1000ms) 동안 연속 클릭 방지

							// 추천 및 비추천 액션 처리 함수
							function handleLikeDislikeAction(response) {
								// '좋아요/싫어요' 버튼 활성화
								$('#btn_like').prop('disabled', false);
								$('#btn_dislike').prop('disabled', false);

								if (response.result == 'success') {
									// 투표 성공 처리
									// 객체 접근법으로서 점 표기법(Dot Notation)을 사용하여 고정된 속성 이름에 접근
									currentType = response.actionType; // 투표 상태 업데이트
									updateButtonState(response.actionType);
									updateVoteCounts(response.likes, response.dislikes)
								} 
								// else if (response.result === 'alreadyVoted') {
								// 	// 사용자가 이미 투표한 경우
								// 	alert("이미 선택하셨습니다. 내일 다시 시도해 주세요.");
								// }
							}

							// 버튼 활성화/비활성화 처리 함수
							function updateButtonState(actionType) {
								if (actionType === 'like') {
									$('#btn_like').addClass('like-active');
									$('#btn_dislike').removeClass('dislike-active');
								} else if (actionType === 'dislike') {
									$('#btn_dislike').addClass('dislike-active');
									$('#btn_like').removeClass('like-active');
								} else {
									$('#btn_like').removeClass('like-active');
									$('#btn_dislike').removeClass('dislike-active');
								}
							}

							function updateVoteCounts(likes, dislikes) {
								// 추천 및 비추천 수 업데이트
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
									// 버튼 스타일 초기화
									$('#btn_like').removeClass('like-active');
									$('#btn_dislike').removeClass('dislike-active');

									// 현재 투표 상태가 null이 아니면 취소 요청
									if (currentType) {
										handleVoteAction(bd_number, currentType);  // 취소하려는 투표 유형
										currentType = null;  // 현재 투표 상태 초기화
									}
								});

								$('#voteChangeModal').modal('show');
							}

							// 투표 변경 및 취소 로직을 실행하는 함수(함수 선언식 형태는 호이스팅 가능)
							function handleVoteAction(bd_number, voteType) {

								debouncedAction(bd_number, voteType); // 실제 투표 처리
								$('#voteChangeModal').modal('hide'); // 모달 닫기
							}

							// 현재 투표 상태를 확인하고 버튼 스타일을 적용하는 함수
							function checkAndApplyVoteStatus() {

								$.ajax({
									url: '/user/board/getCurrentVoteStatus',
									type: 'GET',
									data: { bd_number: bd_number },
									dataType: 'json', // JSON 형식의 응답(map)
									success: function (data) {
										currentType = data.voteStatus;
										updateButtonState(data.voteStatus);
										updateVoteCounts(data.like, data.dislike);
									},
									error: function (xhr, status, error) {
										// 버튼 활성화
										$('#btn_like').prop('disabled', false);
										$('#btn_dislike').prop('disabled', false);
										// 401 Unauthorized 상태 처리
										if (xhr.status === 401) {
											alert("로그인이 필요한 기능입니다.");
										} else {
											alert("오류가 발생했습니다: " + error);
										}
									}
								});
							}

							// '좋아요/싫어요' 버튼 클릭 이벤트
							// 기존에 등록된 모든 이벤트 핸들러 제거 후 새로운 이벤트 핸들러 추가
							$('.btn_vote').off("click").on("click", function () {
								// "Maximum call stack size exceeded" 오류
								// 클릭된 버튼의 투표 타입 저장
								let attemptType = $(this).data('vt_status');

								// 사용자의 현재 투표 상태와 클릭된 버튼의 투표 타입에 따라 서버 요청
								if (currentType == null) {
									// 처음 투표하는 경우 ─ 즉시 서버 요청
									debouncedAction(bd_number, attemptType);
								} else if (currentType == attemptType) {
										// 이미 같은 타입으로 투표한 경우 ─ '취소' 모달 표시
										showVoteModal('cancel', '기존 선택을 취소하시겠습니까?');
									} else if (currentType != attemptType) {
										// 다른 타입으로 변경하는 경우 ─ '변경' 모달 표시
										showVoteModal('change', '기존 선택을 변경하시겠습니까?');
									}
							});

						}); // ready-end
					</script>

			</body>

			</html>