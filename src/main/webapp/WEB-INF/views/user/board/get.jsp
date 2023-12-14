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

					<script>
						// 비회원 게시물 수정 및 삭제 시 비밀번호가 불일치하면 동작(checkPw 메서드)
						let msg = '${msg}';
						if (msg != "") {
							alert(msg);
						}
					</script>
			</head>

			<body>

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
													<input type="text" class="form-control" name="bd_content" value="${bd_vo.bd_content}"
														style="height: 500px; width: 100%;" readonly>
												</div>
											</div>
											<br />
											<!-- HTML 요소에 데이터 속성 추가 -->
											<div class="box-footer" data-isGuestPost="${bd_vo.us_id == null || bd_vo.us_id eq ''}">
												<!-- BoardController의 @ModelAttribute("cri") Criteria cri -->
												<!-- Modify, Delete, List 버튼 클릭 시 아래 form 태그를 전송-->
												<form id="curListInfo" action="" method="get">
													<input type="hidden" name="pageNum" id="pageNum" value="${cri.pageNum}" />
													<input type="hidden" name="amount" id="amount" value="${cri.amount}" />
													<input type="hidden" name="type" id="type" value="${cri.type}" />
													<input type="hidden" name="keyword" id="keyword" value="${cri.keyword}" />
													<input type="hidden" name="bd_number" id="bd_number" value="${bd_vo.bd_number}" />
													<!-- <input type="hidden" name="bd_type" id="bd_type" value="${bd_vo.bd_type}" /> -->
												</form>
												<c:choose>
													<c:when
														test="${sessionScope.userStatus != null && sessionScope.userStatus.us_id == bd_vo.us_id}">
														<!-- 로그인한 회원이 작성한 게시물일 경우 -->
														<button type="button" id="btn_modify" class="btn btn-primary">수정</button>
														<button type="button" id="btn_delete" class="btn btn-primary">삭제</button>
													</c:when>
													<c:when
														test="${bd_vo.us_id == null && bd_vo.bd_guest_nickname != null && !empty bd_vo.bd_guest_nickname}">
														<!-- 비회원이 작성한 게시물일 경우 -->
														<button type="button" id="btn_modify" class="btn btn-primary">수정</button>
														<button type="button" id="btn_delete" class="btn btn-primary">삭제</button>
													</c:when>
												</c:choose>
												<button type="button" id="btn_list" class="btn btn-primary">목록</button>
											</div>

										</div>
									</div>
								</div>
								<footer class="footer mt-auto py-3">
									<%@include file="/WEB-INF/views/comm/footer.jsp" %>
										<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>
								</footer>
							</section>
						</div>
					</main>

					<script>

						// HTML 요소에서 데이터 속성 값을 읽기
						let isGuestPost = document.querySelector('.box-footer').getAttribute('data-isGuestPost') == 'true';

						// <form id="curListInfo" action="" method="get">를 참조
						let curListInfo = document.getElementById("curListInfo");

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
								let password = prompt("게시물 수정을 위해 작성했던 비밀번호를 입력하세요.");
								if (password != null && password != "") {
									// 서버로 비밀번호 전송 및 확인 요청
									let form = document.createElement("form");
									form.method = "post";
									form.action = "/user/board/checkPw";

									let inputNumber = document.createElement("input");
									inputNumber.type = "hidden";
									inputNumber.name = "bd_number";
									inputNumber.value = "${bd_vo.bd_number}";

									let inputPassword = document.createElement("input");
									inputPassword.type = "hidden";
									inputPassword.name = "bd_guest_pw";
									inputPassword.value = password;

									let inputAction = document.createElement("input");
									inputAction.type = "hidden";
									inputAction.name = "action";
									inputAction.value = "modify"; // 'modify' 또는 'delete'로 설정

									form.appendChild(inputNumber);
									form.appendChild(inputPassword);
									form.appendChild(inputAction);

									document.body.appendChild(form);
									form.submit();
								}
							} else {
								// 회원 게시물의 경우 기존 로직 실행
								curListInfo.setAttribute("action", "/user/board/modify/${bd_vo.bd_type}");
								curListInfo.submit();
							}
						}

						// 삭제 버튼 클릭
						let btn_delete = document.getElementById("btn_delete");
						if (btn_delete) {
							btn_delete.addEventListener("click", fn_delete); // 함수의 괄호는 제외
						}
						function fn_delete() {
							console.log("삭제 버튼 클릭");

							// 비회원 게시물인 경우
							if (isGuestPost) {
								let password = prompt("게시물 삭제를 위해 작성했던 비밀번호를 입력하세요.");
								if (password != null && password != "") {
									// 서버로 비밀번호 전송 및 확인 요청
									let form = document.createElement("form");
									form.method = "post";
									form.action = "/user/board/checkPw";

									let inputNumber = document.createElement("input");
									inputNumber.type = "hidden";
									inputNumber.name = "bd_number";
									inputNumber.value = "${bd_vo.bd_number}";

									let inputPassword = document.createElement("input");
									inputPassword.type = "hidden";
									inputPassword.name = "bd_guest_pw";
									inputPassword.value = password;

									form.appendChild(inputNumber);
									form.appendChild(inputPassword);

									document.body.appendChild(form);
									form.submit();
								}
							} else {
								// 회원 게시물의 경우
								if (!confirm("게시물을 삭제하시겠습니까?")) return;
								curListInfo.setAttribute("action", "/user/board/delete/${bd_vo.bd_type}");
								curListInfo.submit();
							}
						}


						// 리스트 클릭
						// c:if 태그에 의해 수정 및 삭제 버튼이 존재하지 않는 경우, 목록 버튼에 영향을 주어 에러 발생 
						document.getElementById("btn_list").addEventListener("click", fn_list); // 함수의 괄호는 제외

						function fn_list() {
							console.log("목록 버튼 클릭");
							curListInfo.setAttribute("action", "/user/board/list/${bd_vo.bd_type}"); // /user/board/list -> /user/board/get 전송
							curListInfo.submit();
						}
					</script>

			</body>

			</html>