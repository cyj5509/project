<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- JSTL 문법 -->

		<!DOCTYPE html>
		<html lang="en">

		<head>
			<meta charset="utf-8">
			<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
			<meta name="description" content="">
			<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
			<meta name="generator" content="Hugo 0.101.0">
			<title>Pricing example · Bootstrap v4.6</title>

			<%@include file="/WEB-INF/views/comm/plugIn1.jsp" %>

				<!-- CSS 파일 링크 -->
				<link rel="stylesheet" href="/css/header.css">

				<style>
					.bd-placeholder-img {
						font-size: 1.125rem;
						text-anchor: middle;
						-webkit-user-select: none;
						-moz-user-select: none;
						-ms-user-select: none;
						user-select: none;
					}

					@media (min-width: 768px) {
						.bd-placeholder-img-lg {
							font-size: 3.5rem;
						}
					}
				</style>
		</head>

		<body>

			<%@include file="/WEB-INF/views/comm/header.jsp" %>

				<div class="container">
					<div class="text-center">
						<div class="box box-primary">
							<div class="box-header with-border">
								<br>
								<h3 class="box-title">회원수정</h3>
								<br>
								<form role="form" id="modifyInfoForm" method="post" action="/member/modifyInfo">
									<div class="box-body">
										<div class="form-group row">
											<label for="mem_id" class="col-2">아이디</label>
											<div class="col-10">
												<input type="text" class="form-control" name="mem_id" id="mem_id" value="${vo.mem_id}" readonly>
											</div>
										</div>
										<div class="form-group row">
											<label for="mem_name" class="col-2">이름</label>
											<div class="col-10">
												<input type="text" class="form-control" name="mem_name" id="mem_name" value="${vo.mem_name}"
													readonly>
											</div>
										</div>
										<div class="form-group row">
											<label for="mem_phone" class="col-2">전화번호</label>
											<div class="col-10">
												<input type="text" class="form-control" name="mem_phone" id="mem_phone" value="${vo.mem_phone}"
													placeholder="전화번호 입력...">
											</div>
										</div>
										<div class="form-group row">
											<label for="mem_email" class="col-2">이메일</label>
											<div class="col-10">
												<input type="email" class="form-control" name="mem_email" id="mem_email" value="${vo.mem_email}"
													placeholder="전자우편 입력...">
											</div>
										</div>

										<div class="form-group row">
											<label for="sample2_postcode" class="col-2">우편번호</label>
											<div class="col-8">
												<input type="text" class="form-control" name="mem_postcode" id="sample2_postcode"
													value="${vo.mem_postcode}" placeholder="우편번호 입력...">
											</div>
											<div class="col-2">
												<button type="button" onclick="sample2_execDaumPostcode()" class="btn btn-outline-info">우편번호
													찾기</button>
											</div>
										</div>
										<div class="form-group row">
											<label for="sample2_address" class="col-2">주소</label>
											<div class="col-10">
												<input type="text" class="form-control" name="mem_addr" id="sample2_address"
													value="${vo.mem_addr}" placeholder="기본주소 입력...">
											</div>
										</div>
										<div class="form-group row">
											<label for="sample2_detailAddress" class="col-2">상세주소</label>
											<div class="col-10">
												<input type="text" class="form-control" name="mem_deaddr" id="sample2_detailAddress"
													value="${vo.mem_deaddr}" placeholder="상세주소 입력...">
												<input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
											</div>
										</div>

									</div>
									<div class="box-footer">
										<button type="button" class="btn btn-primary" id="btnModify">수정하기</button>
									</div>
								</form>
							</div>
						</div>
					</div>

					<%@include file="/WEB-INF/views/comm/footer.jsp" %>

				</div>

				<%@include file="/WEB-INF/views/comm/postCode.jsp" %>

					<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>

						<script>
							// jquery.slim.min.js 파일에 jQuery 명령어가 정의되어 있음
							// $(): JQuery() 함수 사용 별칭
							// ready(): 브라우저가 html 태그를 모두 읽고난 후에 동작하는 이벤트 메서드
							// JS 이벤트 등록: https://www.w3schools.com/js/js_htmldom_eventlistener.asp 
							$(document).ready(function () {

								// form 태그 참조: <form role="form" id="modifyInfoForm" method="post" action="/member/modifyInfo">
								let modifyInfoForm = $("#modifyInfoForm");
								// 회원수정 버튼 클릭 시 동작
								$("#btnModify").click(function () {

									// 회원가입 유효성 검사(JS 이용)

									// 폼 전송 작업(스프링 작업 이후)
									modifyInfoForm.submit();
								})
							});
						</script>

		</body>

		</html>