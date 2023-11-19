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
			<title>데브데이</title>

			<%@include file="/WEB-INF/views/comm/plugIn1.jsp" %>

				<!-- CSS 파일 링크 -->
				<link rel="stylesheet" href="/css/header.css">
				<link rel="stylesheet" href="/css/member/login.css">

				<style>
					.captcha {
						overflow: hidden;
					}

					.captcha_child {
						float: left;
					}

					.captcha_child_two {
						float: right;
					}

					.refreshBtn:hover {
						background-color: #a8a8a8;
						color: white;
						border: 1px solid #a6a6a6;
					}

					.refreshBtn {
						color: black;
						border: 1px solid #888;
						width: 110px;
						border-radius: 5px;
						height: 25px;
						display: block;
						padding: 2px 15px;
						margin: 5px 0px;
					}
				</style>

		</head>

		<body>

			<%@include file="/WEB-INF/views/comm/header.jsp" %>

				<div class="container">
					<div class="text-center">
						<div class="box box-primary">
							<div class="box-header with-border">


								<form role="form" id="modifyInfoForm" method="post" action="/member/modify">
									<div id="modifyInfoSection">
										<h3 class="box-title">회원수정</h3>
										<div class="box-body">
											<div class="form-group row">
												<label for="mem_id" class="col-2">아이디</label>
												<div class="col-10">
													<input type="text" class="form-control" name="mem_id" id="mem_id" value="${vo.mem_id}"
														readonly>
												</div>
											</div>
											<div class="form-group row">
												<label for="mem_pw1" class="col-2">비밀번호</label>
												<div class="col-3">
													<input type="password" class="form-control" value="${vo.mem_pw}" readonly>
												</div>
												<label for="mem_pw2" class="col-2">비밀번호 확인</label>
												<div class="col-3">
													<input type="password" class="form-control" value="${vo.mem_pw}" readonly>
												</div>
												<div class="col-2">
													<button type="button" class="btn btn-outline-info" id="btnChangePw">비밀번호 변경</button>
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
													<input type="text" class="form-control" name="mem_phone" id="mem_phone"
														value="${vo.mem_phone}" placeholder="전화번호 입력...">
												</div>
											</div>
											<div class="form-group row">
												<label for="mem_email" class="col-2">이메일</label>
												<div class="col-10">
													<input type="email" class="form-control" name="mem_email" id="mem_email"
														value="${vo.mem_email}" placeholder="전자우편 입력...">
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
											<div class="box-footer">
												<button type="button" class="btn btn-primary" id="btnModify">수정하기</button>
											</div>
										</div>
									</div>
								</form>

								<form role="form" id="ResetPwForm" method="post" action="/member/resetPw">
									<div id="pwResetSection" style="display: none;">
										<h3 class="box-title">비밀번호 변경</h3>
										<div>
											<p><span><b></b> </span>재설정을 위한 비밀번호를 입력해주세요</p>
										</div>
										<div class="form-group row">
											<label for="mem_pw1" class="col-2">비밀번호 </label>
											<div class="col-10">
												<input type="password" class="form-control" name="mem_pw1" placeholder="비밀번호를 입력해주세요">
											</div>
											<label for="mem_pw2" class="col-2">비밀번호 확인</label>
											<div class="col-10">
												<input type="password" class="form-control" name="mem_pw2" placeholder="동일한 비밀번호를 다시 입력해주세요">
											</div>
										</div>

										<div class="box-footer">
											<button type="button" class="btn btn-primary login-btn" id="btnResetPw">완료</button>
										</div>
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

								// 중복되는 부분이 있어 전역 변수로 해당 변수 설정
								mem_id = $("#mem_id").val(); // 현재 로그인한 사용자의 아이디로 초기화
							
								// 비밀번호 재설정 처리
								$("#btnChangePw").click(function () {
									$("#modifyInfoSection").hide();
									$("#pwResetSection").show();
								});

								$("#btnResetPw").click(function () {
									let resetPw = $("input[name='mem_pw1']").val();
									let confirmPw = $("input[name='mem_pw2']").val();
									if (resetPw == "" || confirmPw == "") {
										alert("비밀번호를 입력해 주세요.")
										return;
									}
									if (resetPw !== confirmPw) {
										alert("비밀번호가 일치하지 않습니다.");
										$("input[name='mem_pw1']").val("");
										$("input[name='mem_pw2']").val("");
										$("input[name='mem_pw1']").focus();
										return;
									}
									$.ajax({
										url: '/member/resetPw',
										type: 'post',
										data: { mem_id: mem_id, mem_pw: resetPw },
										success: function (response) {
											if (response == "success") {
												// 비밀번호 재설정에 성공했을 때의 처리
												alert("비밀번호가 정상적으로 재설정되었습니다.");
												location.href = "/member/login";
											}
										}
									}); // AJAX 요청
								}); // btnResetPw click 이벤트 핸들러

							});


						</script>

		</body>

		</html>