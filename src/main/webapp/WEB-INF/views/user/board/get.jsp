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
					<link rel="stylesheet" href="/css/header.css">

					<style>
						.box-title {
							font-size: 40px;
							margin-bottom: 20px;
						}

						.box-body {
							font-size: 20px;
							padding: 20px;
						}
					</style>
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
														<input type="text" class="form-control" name="us_id" id="us_id"
															value="${sessionScope.loginStatus.us_id}" readonly>
													</div>
													<label for="bd_register_date" class="col-2">작성일</label>
													<div class="col-4">
														<input type="text" class="form-control" id="bd_register_date"
															value='<fmt:formatDate value="${boardVO.bd_register_date}" pattern="yyyy년 MM월 dd일" />'
															readonly>
													</div>
												</div>
												<div class="form-group row">
													<label for="bd_title" class="col-2">제목</label>
													<div class="col-4">
														<input type="text" class="form-control" name="bd_title" id="bd_title"
															value="${boardVO.bd_title}" readonly>
													</div>
													<label for="bd_type" class="col-2">카테고리</label>
													<div class="col-4">
														<select class="form-control" name="bd_type" id="bd_type" readonly>
															<option value="notice" ${boardVO.bd_type=='notice' ? 'selected' : '' }
																style="display: none;">공지사항</option>
															<option value="free" ${boardVO.bd_type=='free' ? 'selected' : '' }>자유 게시판</option>
															<option value="info" ${boardVO.bd_type=='info' ? 'selected' : '' }>정보 공유</option>
															<option value="study" ${boardVO.bd_type=='study' ? 'selected' : '' }>스터디원 모집</option>
															<option value="project" ${boardVO.bd_type=='project' ? 'selected' : '' }>플젝팀원 모집</option>
															<option value="inquery" ${boardVO.bd_type=='inquery' ? 'selected' : '' }>Q&A(문의)</option>
														</select>
													</div>
												</div>
												<div class="form-group">
													<label for="bd_content">내용</label>
													<input type="text" class="form-control" name="bd_content" value="${boardVO.bd_content}"
														style="height: 500px; width: 100%;" readonly>
												</div>
											</div>
											<br />
											<div class="box-footer">
												<!-- BoardController의 @ModelAttribute("cri") Criteria cri -->
												<!-- Modify, Delete, List 버튼 클릭 시 아래 form 태그를 전송-->
												<form id="curListInfo" action="" method="get">
													<input type="hidden" name="pageNum" id="pageNum" value="${cri.pageNum}" />
													<input type="hidden" name="amount" id="amount" value="${cri.amount}" />
													<input type="hidden" name="type" id="type" value="${cri.type}" />
													<input type="hidden" name="keyword" id="keyword" value="${cri.keyword}" />
													<input type="hidden" name="bd_number" id="bd_number" value="${boardVO.bd_number}" />
													<!-- <input type="hidden" name="bd_type" id="bd_type" value="${boardVO.bd_type}" /> -->
												</form>
												<button type="button" id="btn_modify" class="btn btn-primary">수정</button>
												<button type="button" id="btn_delete" class="btn btn-primary">삭제</button>
												<button type="button" id="btn_list" class="btn btn-primary">목록</button>
											</div>

										</div>
									</div>
								</div>
							</section>
						</div>
					</main>

					<footer class="footer mt-auto py-3">
						<%@include file="/WEB-INF/views/comm/footer.jsp" %>
							<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>
					</footer>


					<script>

						// <form id="curListInfo" action="" method="get">를 참조
						let curListInfo = document.getElementById("curListInfo");

						// 수정 버튼 클릭
						// document.getElementById("btn_modify").addEventListener("click", 함수명);
						document.getElementById("btn_modify").addEventListener("click", fn_modify);

						function fn_modify() {
							console.log("수정 버튼 클릭");
							// alert('수정');
							// location.href = "/user/board/modify?bno=${board.bno}"; // location.href = "URL 매핑 주소";
							curListInfo.setAttribute("action", "/user/board/modify/${boardVO.bd_type}"); // /user/board/list -> /user/board/get 전송
							curListInfo.submit();
						}

						// 삭제 버튼 클릭
						document.getElementById("btn_delete").addEventListener("click", fn_delete); // 괄호는 제외

						function fn_delete() {
							console.log("삭제 버튼 클릭");
							if (!confirm("게시물을 삭제하시겠습니까?")) return;
							// 페이지(주소) 이동
							// location.href = "/user/board/delete?bno=${board.bno}";
							curListInfo.setAttribute("action", "/user/board/delete/${boardVO.bd_type}"); // /user/board/list -> /user/board/get 전송
							curListInfo.submit();
						}

						// 리스트 클릭
						document.getElementById("btn_list").addEventListener("click", fn_list); // 괄호는 제외

						function fn_list() {
							console.log("목록 버튼 클릭");
							curListInfo.setAttribute("action", "/user/board/list/${boardVO.bd_type}"); // /user/board/list -> /user/board/get 전송
							curListInfo.submit();
						}
					</script>
			</body>

			</html>