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
								<form role="form" id="modifyForm" method="post" action="/member/modify">
									<div class="box-body">
										<div class="form-group row">
											<label for="mem_id" class="col-2">아이디</label>
											<div class="col-10">
												<input type="text" class="form-control" name="mem_id" id="mem_id" value="${memberVO.mem_id}"
													readonly>
											</div>
										</div>
										<div class="form-group row">
											<label for="mem_name" class="col-2">이름</label>
											<div class="col-10">
												<input type="text" class="form-control" name="mem_name" id="mem_name"
													value="${memberVO.mem_name}" readonly>
											</div>
										</div>
										<div class="form-group row">
											<label for="mem_phone" class="col-2">전화번호</label>
											<div class="col-10">
												<input type="text" class="form-control" name="mem_phone" id="mem_phone"
													value="${memberVO.mem_phone}" placeholder="전화번호 입력...">
											</div>
										</div>
										<div class="form-group row">
											<label for="mem_email" class="col-2">이메일</label>
											<div class="col-10">
												<input type="email" class="form-control" name="mem_email" id="mem_email"
													value="${memberVO.mem_email}" placeholder="전자우편 입력...">
											</div>
										</div>

										<div class="form-group row">
											<label for="sample2_postcode" class="col-2">우편번호</label>
											<div class="col-8">
												<input type="text" class="form-control" name="mem_postcode" id="sample2_postcode"
													value="${memberVO.mem_postcode}" placeholder="우편번호 입력...">
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
													value="${memberVO.mem_addr}" placeholder="기본주소 입력...">
											</div>
										</div>
										<div class="form-group row">
											<label for="sample2_detailAddress" class="col-2">상세주소</label>
											<div class="col-10">
												<input type="text" class="form-control" name="mem_deaddr" id="sample2_detailAddress"
													value="${memberVO.mem_deaddr}" placeholder="상세주소 입력...">
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

							let useIDCheck = false; // 아이디 중복 체크 사용 유무 확인

							// JS 문법: document.getElementById("idCheck");
							$("#idCheck").click(function () {
								//	alert("아이디 중복 체크");
								if ($("#mem_id").val() == "") {
									alert("아이디를 입력하세요.");
									$("#mem_id").focus();
									return;
								}

								// 아이디 중복 체크 기능 구현
								$.ajax({
									url: '/member/idCheck', // url : '아이디'를 체크하는 매핑주소
									type: 'get', // get or post
									dataType: 'text', // <String>
									data: { mem_id: $("#mem_id").val() }, // data: {파라미터명: 데이터 값}
									success: function (result) { // success: function (매개변수명) { 
										if (result == "yes") {
											alert("아이디 사용 가능");
											useIDCheck = true;
										} else {
											alert("아이디 사용 불가능");
											useIDCheck = false;
											// $("#mem_id").val()는 GETTER, $("#mem_id").val("")는 SETTER
											$("#mem_id").val(""); // 아이디 텍스트 박스의 값을 지움
											$("#mem_id").focus(); // 포커스 기능
										}
									}
								});
							});
							// 메일 인증 요청
							$("#mailAuth").click(function () {
								if ($("#mem_email").val() == "") {
									alert("이메일을 입력하세요");
									$("#mem_email").focus();
									return;
								}

								$.ajax({
									url: '/email/authCode', // @GetMapping("/authCode")
									type: 'get',
									dataType: 'text', // 스프링에서 보내는 데이터의 타입 ─ <String> -> "success" -> text
									data: { receiverMail: $("#mem_email").val() }, // EmailDTO ─ private String receiverMail;
									success: function (result) {
										if (result == "success") {
											alert("인증 메일이 발송되었습니다. 메일 확인 바랍니다.")
										}
									}
								});
							});

							let isConfirmAuth = false; // 메일 인증을 하지 않은 상태

							// 인증 확인: <button type="button" class="btn btn-outline-info" id="btnConfirmAuth">인증 확인</button>
							$("#btnConfirmAuth").click(function () {

								if ($("#authCode").val() == "") {
									alert("인증코드를 입력하세요.");
									$("#authCode").focus();
									return;
								}

								// 인증확인 요청
								$.ajax({
									url: '/email/confirmAuthcode',
									type: 'get',
									dataType: 'text', // / 스프링에서 보내는 데이터의 타입 ─ <String>
									data: { authCode: $("#authCode").val() },
									success: function (result) {
										if (result == "success") {
											alert("인증에 성공하였습니다.");
											isConfirmAuth = true;
										} else if (result == "fail") {
											alert("인증에 실패하였습니다. 다시 확인바랍니다..");
											$("#authCode").val("");
											isConfirmAuth = false;
										} else if (result == "request") { // 세션 종료 시(기본 30분)
											alert("메일 인증 요청을 다시 해주세요.");
											$("#authCode").val("");
											isConfirmAuth = false;
										}
									}
								});
							});

							// form 태그 참조: <form role="form" id="modifyForm" method="post" action="/member/modify">
							let modifyForm = $("#modifyForm");

							// 회원수정 버튼
							$("#btnModify").click(function () {

								// 회원가입 유효성 검사(JS 이용)

								// 폼 전송 작업(스프링 작업 이후)
								modifyForm.submit();
							})
							
						
						});
					</script>

		</body>

		</html>