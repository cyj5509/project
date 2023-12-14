<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<!DOCTYPE html>
	<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="">
		<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
		<meta name="generator" content="Hugo 0.101.0">
		<title>데브데이</title>

		<%@include file="/WEB-INF/views/comm/plugIn1.jsp" %>

			<!-- CSS 파일 링크 -->
			<link rel="stylesheet" href="/css/common/header.css">
			<link rel="stylesheet" href="/css/member/login.css">

	</head>

	<body>

		<%@include file="/WEB-INF/views/comm/header.jsp" %>

			<div class="container">
				<div class="text-center">
					<div class="box box-primary">
						<div class="box-header with-border">
							<br>
							<h3 class="box-title">정보 조회</h3>
							<br>

							<form role="form" id="myPageForm" method="get" action="/member/my_page">
								<div class="box-body">
									<div class="login-info">
										<h3>로그인 정보</h3><br>
										<div class="form-group row">
											<label for="us_id" class="col-2">아이디</label>
											<div class="col-10">
												<input type="text" class="form-control" name="us_id" id="us_id" value="${us_vo.us_id}" readonly>
											</div>
										</div>
									</div>

									<div class="member-info">
										<h3>회원 정보</h3><br>
										<div class="form-group row">
											<label for="us_name" class="col-2">이름</label>
											<div class="col-10">
												<input type="text" class="form-control" name="us_name" id="us_name" value="${us_vo.us_name}"
													readonly>
											</div>
										</div>
										<div class="form-group row">
											<label for="us_phone" class="col-2">전화번호</label>
											<div class="col-10">
												<input type="text" class="form-control" name="us_phone" id="us_phone" value="${us_vo.us_phone}"
													readonly>
											</div>
										</div>
										<div class="form-group row">
											<label for="us_email" class="col-2">이메일</label>
											<div class="col-10">
												<input type="email" class="form-control" name="us_email" id="us_email" value="${us_vo.us_email}"
													readonly>
											</div>
										</div>

										<div class="form-group row">
											<label for="sample2_postcode" class="col-2">우편번호</label>
											<div class="col-2">
												<input type="text" class="form-control" name="us_postcode" id="sample2_postcode"
													value="${us_vo.us_postcode}" readonly>
											</div>
											<label for="sample2_address" class="col-2">주소</label>
											<div class="col-6">
												<input type="text" class="form-control" name="" id="sample2_address"
													value="${us_vo.us_addr_basic}, ${us_vo.us_addr_detail}" readonly>
												<input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
											</div>
										</div>
									</div>

								</div>
								<div class="box-footer">
									<button type="button" class="btn btn-primary" id="btnModify">회원수정</button>
									<button type="button" class="btn btn-danger" id="btnDelete">회원탈퇴</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>

			<%@include file="/WEB-INF/views/comm/footer.jsp" %>
			<%@include file="/WEB-INF/views/comm/postCode.jsp" %>
			<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>

					<script>
						// jquery.slim.min.js 파일에 jQuery 명령어가 정의되어 있음
						// $(): JQuery() 함수 사용 별칭
						// ready(): 브라우저가 html 태그를 모두 읽고난 후에 동작하는 이벤트 메서드
						// JS 이벤트 등록: https://www.w3schools.com/js/js_htmldom_eventlistener.asp 
						$(document).ready(function () {

							// 회원수정 버튼 클릭 이벤트
							$("#btnModify").click(function () {
								location.href = "/member/info/modify"; // 회원수정 페이지로 이동
							});

							// 회원탈퇴 버튼 클릭 이벤트
							$("#btnDelete").click(function () {
								location.href = "/member/info/delete"; // 회원탈퇴 전 회원정보 재확인
							});

						});
					</script>

	</body>

	</html>