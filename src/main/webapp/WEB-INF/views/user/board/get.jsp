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
				<title>데브데이&#58; 커뮤니티</title>

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

						.button-container {
							display: flex;
							justify-content: space-between;
							/* 양 끝에 요소를 배치 */
							align-items: center;
							/* 세로 방향 가운데 정렬 */
						}

						.comment-table th,
						.comment-table td {
							vertical-align: middle;
							/* 셀의 내용을 수직 중앙에 정렬 */
							text-align: center;
							/* 텍스트를 가운데 정렬 */
						}

						.menu-items {
							position: absolute;
							right: 0;
							background-color: white;
							border: 1px solid #ccc;
							border-radius: 4px;
							padding: 5px;
							z-index: 1000;
						}

						.menu-items button {
							display: block;
							width: 100%;
							text-align: left;
							margin-bottom: 5px;
							/* 버튼과 버튼 사이의 아래쪽 간격을 추가 */
						}

						/* 마지막 버튼의 마진 제거 */
						.menu-items button:last-child {
							margin-bottom: 0;
						}

						.commentInfo {
							font-size: 14px;
							color: red;
							text-align: center;
							margin-top: 15px;
						}
					</style>

					<script>
						// 비회원 게시물 수정 및 삭제 시 비밀번호가 불일치하면 동작(checkPw 메서드)
						let msg = '${msg}';
						if (msg != "") {
							alert(msg);
						}
					</script>
					<!-- Handlebars(핸들바 템플릿 엔진) -->
					<!-- <script src="https://cdn.jsdelivr.net/npm/handlebars/dist/handlebars.min.js"></script> -->
					<script src="/js/handlebars.js"></script>
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
																<input type="text" class="form-control" name="us_id" value="${bd_vo.us_id}" readonly>
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
														<select class="form-control" name="bd_type" id="bd_type" disabled>
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
														<c:choose>
															<c:when test="${bd_vo.bd_type == 'free'}">
																<p class="choiceNotice">&#42; 1일 1회 선택&#40;당일에 한해 변경&#47;취소 가능&#41;</p>
															</c:when>
															<c:otherwise>
																<p class="choiceNotice">&#42; 계정당 1회 선택&#40;당일에 한해 변경&#47;취소 가능&#41;</p>
															</c:otherwise>
														</c:choose>
														<input type="hidden" id="isUserLogin" value="${sessionScope.userStatus}" />
													</div>
												</div>
											</div>
											<br />
											<!-- HTML 요소에 데이터 속성 추가 -->
											<div class="box-footer" data-isGuestPost="${bd_vo.us_id == null || bd_vo.us_id eq ''}">
												<!-- 수정 및 삭제, 목록 버튼 클릭 시 아래 form 태그 전송-->
												<form id="curListInfo" method="get" action=""> <!-- action의 기본값은 현재 페이지의 URL -->
													<input type="hidden" name="bd_number" id="bd_number" value="${bd_vo.bd_number}" />
													<input type="hidden" name="pageNum" id="pageNum" value="${cri.pageNum}" />
													<input type="hidden" name="amount" id="amount" value="${cri.amount}" />
													<input type="hidden" name="type" id="type" value="${cri.type}" />
													<input type="hidden" name="keyword" id="keyword" value="${cri.keyword}" />
												</form>
												<div class="button-container">
													<div class="left-buttons">
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
													</div>
													<div class="right-buttons">
														<button type="button" class="btn btn-secondary btn_commentWrite">댓글 작성</button>
														<button type="button" class="btn btn-dark btn_allCommentToggle">닫기 ▲</button>
													</div>
													<!-- 게시물 수정/삭제 시의 비밀번호 입력 커스텀 모달(초기에는 숨겨져 있음) -->
													<div id="boardPwModal" class="pw-modal" style="display:none;">
														<div class="pw-modal-content">
															<div class="pw-modal-header">
																<span id="pwModalMessage1"></span>
																<span class="pw-close-button" onclick="closePasswordModal()">&times;</span>
															</div>
															<div class="pw-modal-body">
																<form id="passwordForm" method="post" action="/user/board/checkPw">
																	<input type="hidden" name="bd_number" value="${bd_vo.bd_number}">
																	<input type="password" id="bd_guest_pw" name="bd_guest_pw"
																		placeholder="비밀번호를 입력해 주세요.">
																	<input type="hidden" id="formAction" name="action" value="">
																</form>
																<p id="pwModalMessage2"></p>
															</div>
															<div class="pw-modal-footer">
																<button type="submit" form="passwordForm" class="modal-button">확인</button>
																<button type="button" onclick="closePasswordModal()" class="modal-button">취소</button>
															</div>
														</div>
													</div>
												</div>
											</div>
											<!-- 댓글 입력 폼 -->
											<div class="comment-register-form" style="display:none;">
												<form id="commentRegisterForm" class="comment-register-form">
													<div class="user-inputs">
														<!-- 회원 여부에 따른 필드 출력 -->
														<c:choose>
															<c:when test="${not empty sessionScope.userStatus}">
																<!-- 회원 댓글인 경우: 아이디 필드만 출력 -->
																<input type="text" class="form-control userId" name="us_id" id="us_id"
																	value="${sessionScope.userStatus.us_id}" readonly>
															</c:when>
															<c:otherwise>
																<!-- 비회원 댓글인 경우: 닉네임과 비밀번호 필드 출력 -->
																<input type="text" class="form-control nickname" name="cm_guest_nickname"
																	id="cm_guest_nickname" placeholder="닉네임(미입력 시 guest)">
																<input type="password" class="form-control password" name="cm_guest_pw" id="cm_guest_pw"
																	placeholder="비밀번호">
															</c:otherwise>
														</c:choose>
													</div>
													<div class="comment-input">
														<textarea id="cm_content" class="form-control content" placeholder="댓글을 입력하세요."></textarea>
													</div>
													<div class="comment-buttons">
														<input type="hidden" name="bd_number" value="${bd_vo.bd_number}">
														<button type="button" id="btn_newCommentRegister" class="btn_commentRegister">등록</button>
														<button type="button" id="btn_newCommentCancel" class="btn_commentCancel">취소</button>
													</div>
												</form>
											</div>
											<!-- 댓글 목록 영역 -->
											<div id="commentsArea">
												<p style="font-size: 14px; text-align: right;">* 댓글 내용 클릭 시 수정&#47;삭제&#47;답글 가능</p>
												<!-- 댓글 목록 테이블 -->
												<table id="commentTable" class="table table-sm table-bordered comment-table">
													<thead class="thead-dark">
														<tr>
															<th style="width: 20%">사용자명</th>
															<th style="width: 60%">내용</th>
															<th style="width: 10%">등록일</th>
															<th style="width: 10%">수정일</th>
														</tr>
													</thead>
													<tbody><!-- 댓글 목록 동적 생성 --></tbody>
												</table>
												<div id="commentPaging"><!-- 댓글 페이징 동적 생성 --></div>
											</div>
											<!-- 댓글 목록용 Handlebars 템플릿 -->
											<script id="comment-list-template" type="text/x-handlebars-template">
												<tr class="{{#if isReply}}reply{{else}}comment{{/if}}" data-cm_code="{{cm_code}}" 
													{{#if us_id}}data-us_id="{{us_id}}"{{/if}}>
														<td class="comment-user">
															{{#if us_id}}{{us_id}}{{else}}{{cm_guest_nickname}}{{/if}}															
														</td>
														<td class="comment-content" style="text-align: justify;">
															{{cm_content}} 
																<div class="menu-items" style="display: none;">
																	<button class="btn_commentModify">수정</button>
																	<button class="btn_commentDelete">삭제</button>
																	<button class="btn_commentReply">답글</button>
																</div>
														</td>
														<td class="comment-date">{{formatDate cm_register_date}}</td>
														<td class="comment-date">{{formatDate cm_update_date}}</td>	
												</tr>
											</script>
											<!-- 댓글 수정용 Handlebars 템플릿 -->
											<script id="comment-edit-template" type="text/x-handlebars-template">
												<tr class="comment-edit-form" data-cm_code="{{cm_code}}" {{#if us_id}}data-us_id="{{us_id}}"{{/if}}>
														<td colspan="4">
																<form class="edit-form">
																		{{#if isMember}}
																				<!-- 회원 댓글인 경우: 아이디 필드만 출력 -->
																				<input type="text" class="form-control userId" name="us_id" value="{{us_id}}" readonly>
																		{{else}}
																				<!-- 비회원 댓글인 경우: 닉네임과 비밀번호 필드 출력 -->
																				<input type="text" class="form-control nickname" name="cm_guest_nickname" value="{{cm_guest_nickname}}" readonly>
																				<input type="password" class="form-control password" name="cm_guest_pw" placeholder="비밀번호">
																		{{/if}}
																		<textarea name="cm_content" class="form-control content">{{cm_content}}</textarea>
																		<button type="button" class="btn-save-edit">저장</button>
																		<button type="button" class="btn-cancel-edit">취소</button>
																</form>
														</td>
												</tr>
											</script>
											<!-- 댓글 삭제용 모달 -->
											<div class="modal fade" id="deleteCommentModal" tabindex="-1"
												aria-labelledby="deleteCommentModalLabel" aria-hidden="true" data-backdrop="static"
												data-keyboard="false">
												<div class="modal-dialog" role="document">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title" id="deleteCommentModalLabel">[비회원/삭제] 댓글 삭제 확인</h5>
															<button type="button" class="close" data-dismiss="modal" aria-label="Close">
																<span aria-hidden="true">&times;</span>
															</button>
														</div>
														<div class="modal-body">
															<p>댓글을 정말로 삭제하시겠습니까?</p>
															<input type="password" class="form-control" id="commentDeletePw"
																placeholder="비밀번호를 입력해 주세요.">
															<p class="commentInfo">* 댓글 작성 시의 비밀번호 입력</p>
														</div>
														<div class="modal-footer">
															<button type="button" class="btn btn-danger" id="confirmDelete">삭제</button>
															<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
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
											<button type="button" class="btn btn-primary" id="btn_voteChange">변경</button>
											<button type="button" class="btn btn-danger" id="btn_voteCancel">취소</button>
											<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</main>

					<!-- 기존 순수 자바스크립트 로직 -->
					<script>

						// 전역 변수 초기화 작업
						// 게시판 유형과 게시물 번호를 가져옴(자바스크립트 및 제이쿼리 로직 내에서 사용)
						let boardType = document.getElementById('bd_type').value; // $('#bd_type').val()
						let bd_number = document.body.getAttribute('data-bd_number'); // $('body').data('bd_number')
						console.log("게시물 번호:", bd_number);

						let curListInfo = document.getElementById("curListInfo");
						// HTML 요소에서 데이터 속성 값을 읽기
						let isGuestPost = document.querySelector('.box-footer').getAttribute('data-isGuestPost') == 'true';

						// 비밀번호 입력 모달을 보여주는 함수
						function showPasswordModal(action) {
							let pwModalMessage1 = document.getElementById('pwModalMessage1'); // <span id="pwModalMessage1"></span>
							let pwModalMessage2 = document.getElementById('pwModalMessage2');// <p id="pwModalMessage2"></p>

							if (action == 'modify') {
								// 수정 버튼 클릭 시 동작
								pwModalMessage1.textContent = '[비회원/수정] 게시물 수정 확인';
								pwModalMessage2.textContent = '* 게시물 수정 시 비밀번호 입력'
							} else if (action == 'delete') {
								// 삭제 버튼 클릭 시 동작
								pwModalMessage1.textContent = '[비회원/삭제] 게시물 삭제 확인';
								pwModalMessage2.textContent = '* 게시물 삭제 시 비밀번호 입력'
							}

							document.getElementById('formAction').value = action;
							document.getElementById('boardPwModal').style.display = 'block';
						}

						// 비밀번호 입력 모달을 닫는 함수
						function closePasswordModal() {
							let modalContent = document.getElementById('boardPwModal').querySelector('.pw-modal-content');
							// 모달 컨텐츠 위치 초기화
							modalContent.style.top = "50%";
							modalContent.style.left = "50%";
							modalContent.style.transform = "translate(-50%, -50%)";

							document.getElementById('bd_guest_pw').value = ''; // 비밀번호 입력 필드 초기화
							document.getElementById('boardPwModal').style.display = 'none'; // 모달 숨기기
						}

						// 수정 버튼 클릭 시 이벤트 핸들러
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

						// 삭제 버튼 클릭 시 이벤트 핸들러
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

						// 목록 버튼 클릭 시 이벤트 핸들러
						// c:if 태그에 의해 수정 및 삭제 버튼이 존재하지 않는 경우, 목록 버튼에 영향을 주어 에러 발생 
						document.getElementById("btn_list").addEventListener("click", fn_list); // 함수의 괄호는 제외
						function fn_list() {
							console.log("목록 버튼 클릭");

							let url = "/user/board/list/${bd_vo.bd_type}"

							document.getElementById("bd_number").remove();
							curListInfo.setAttribute("action", url); // /user/board/list -> /user/board/get 전송
							curListInfo.submit();
						}
					</script>

					<!-- JS 파일 링크 -->
					<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>
					<script src="/js/user/board/voteAction.js"></script> <!-- jQuery 기반 추가 스크립트 -->
					<script src="/js/user/board/dragModal.js"></script>

					<script>
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
								let insertData = {
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
									data: JSON.stringify(insertData),
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

										// 각 댓글에 대해 HTML 생성 및 추가
										response.comments.forEach(function (comment) {
											// 댓글 데이터를 위한 컨텍스트 생성
											let commentContext = {
												cm_code: comment.cm_code,
												us_id: comment.us_id,
												cm_guest_nickname: comment.cm_guest_nickname,
												cm_content: comment.cm_content,
												cm_register_date: comment.cm_register_date,
												cm_update_date: comment.cm_update_date
											};
											// 핸들바 템플릿을 사용하여 댓글 HTML 생성
											let commentHtml = template(commentContext);
											commentsArea.append(commentHtml); // 생성된 HTML을 댓글 목록에 추가

											// 대댓글 처리
											if (comment.replies) {
												// 각 대댓글에 대해 HTML 생성 및 추가
												comment.replies.forEach(function (reply) {
													let replyContext = { ...commentContext, isReply: true };
													let replyHtml = template(replyContext);
													commentsArea.append(replyHtml); // 생성된 HTML을 댓글 목록에 추가
												});
											}

										});
										// 페이징 컨트롤을 화면에 표시하는 함수 호출
										printPagination(response.pageInfo, $('#commentPaging'))
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

							// 댓글 클릭 시 대댓글 표시/숨김
							$(document).on('click', '.comment', function () {
								// 대댓글 요소를 선택하여 토글
								$(this).next('.reply').toggle();
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
								commentsArea.toggle();

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
									.children().remove().end() // 자식 요소(메뉴 항목) 제거
									.text().trim(); // 텍스트 추출

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
								let modifyData = {
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
									modifyData.cm_guest_pw = guest_pw; // 비회원 비밀번호 추가
								}


								// AJAX 요청을 통해 서버에 수정 요청을 보냄
								$.ajax({
									url: '/comment/manageComments?action=modify',
									type: 'POST',
									contentType: 'application/json',
									data: JSON.stringify(modifyData),
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
								let deleteData = { cm_code: cm_code };
								// 회원 댓글인 경우
								if (us_id) {
									deleteData.us_id = us_id; // 회원 아이디 추가

									if (confirm('댓글을 정말로 삭제하시겠습니까?')) {
										deleteComment(deleteData); // 회원 아이디를 포함하여 삭제 요청
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
								let deleteData = { cm_code: cm_code };

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
									deleteData.cm_guest_pw = guest_pw; // 비회원 비밀번호 전송
									deleteData.us_id = currentUserId ? null : undefined; // 회원 아이디를 null로 설정
								} else if (currentUserId) {
									// 회원이 회원 댓글을 삭제하는 경우		
									deleteData.us_id = currentUserId; // 회원 아이디를 로그인한 아이디로 설정
								}

								deleteComment(deleteData); // 삭제 요청 함수 호출								
								$('#commentDeletePw').val(""); // 비밀번호 입력 필드 초기화
							});

							// 공통 삭제 로직: 매개변수에 기본값을 지정하면 호출 시 생략 가능(생략된 경우 기본값 적용)
							// 회원은 아이디를, 비회원은 비밀번호를 이용하여 댓글 삭제 처리
							function deleteComment(deleteData) {

								console.log("삭제 요청 데이터:", deleteData);

								$.ajax({
									url: '/comment/manageComments?action=delete',
									type: 'POST',
									contentType: 'application/json',
									data: JSON.stringify(deleteData),
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
					</script>

			</body>

			</html>