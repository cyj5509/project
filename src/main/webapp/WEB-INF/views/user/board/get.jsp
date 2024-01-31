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
					<link rel="stylesheet" href="/css/user/board/mainText.css">
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

						#commentsArea {
							display: flex;
							flex-direction: column;
							align-items: center;
						}

						#commentsArea>p {
							font-size: 14px;
							align-self: flex-end;
							text-align: right;
							width: 100%;
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
																		placeholder="비밀번호를 입력해 주세요." style="border: 1px solid;">
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
													<div class="right-buttons">
														<button type="button" class="btn btn-secondary btn_commentWrite">댓글 작성</button>
														<button type="button" class="btn btn-dark btn_allCommentToggle">닫기 ▲</button>
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
												<p>* 댓글 내용 클릭 시 수정&#47;삭제&#47;답글 가능</p>
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
												<tr class="comment" data-cm_code="{{cm_code}}" 
													{{#if us_id}}data-us_id="{{us_id}}"{{/if}}>
														<td class="comment-user">
															{{#if us_id}}{{us_id}}{{else}}{{cm_guest_nickname}}{{/if}}															
														</td>
														<td class="comment-content" style="text-align: justify;">
															{{cm_content}} 
																<div class="replies-count" style="display: none;"><!-- '답글 n개' 동적 생성 --></div>
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
																				<input type="text" class="form-control nickname" name="cm_guest_nickname" value="{{cm_guest_nickname}}" placeholder="닉네임(미입력 시 guest)">
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
								pwModalMessage1.textContent = '[비회원/수정] 비밀번호 확인';
								pwModalMessage2.textContent = '* 게시물 수정 시 비밀번호 입력'
							} else if (action == 'delete') {
								// 삭제 버튼 클릭 시 동작
								pwModalMessage1.textContent = '[비회원/삭제] 비밀번호 확인';
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

							let guest_pw = document.getElementById('bd_guest_pw').value;

							// 비밀번호 입력 필드가 비어있는지 확인
							if (!guest_pw || guest_pw.trim() == '') {
								alert("비밀번호를 입력해 주세요.");
								document.getElementById('bd_guest_pw').focus();
								return false; // 폼 제출 중단
							}

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

							let url = "/user/board/usBoardList/${bd_vo.bd_type}"

							document.getElementById("bd_number").remove();
							curListInfo.setAttribute("action", url); // /user/board/usBoardList -> /user/board/get 전송
							curListInfo.submit();
						}
					</script>

					<!-- JS 파일 링크 -->
					<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>
					<script src="/js/user/board/voteAction.js"></script> <!-- jQuery 기반 추가 스크립트 -->
					<script src="/js/user/board/dragModal.js"></script>
					<script src="/js/user/board/commentAction.js"></script>

			</body>

			</html>