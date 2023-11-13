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
			<link rel="stylesheet" href="/css/header.css">
			<link rel="stylesheet" href="/css/member/login.css">

	</head>

	<body>

		<%@include file="/WEB-INF/views/comm/header.jsp" %>

			<div class="container login-container">
				<div class="text-center">
					<div class="box box-primary login-box">
						<div class="box-header with-border">
							<h3 class="box-title login-title">비밀번호 찾기</h3>
							
								<!-- 제1단계: 아이디 존재 유무 확인-->
								<div class="idCheckSection">
									<div>
										<p><span><b>[제1단계]</b> </span>비밀번호를 찿기 위한 아이디를 입력하세요.</p>
									</div>
									<div class="form-group row">
										<label for="id_check" class="col-sm-3">아이디</label>
										<div class="col-sm-9">
											<input type="text" class="form-control" name="mem_id" id="id_check">
										</div>
									</div>
									<div class="box-footer">
										<button type="button" class="btn btn-primary login-btn" id="btnIdCheckSection">다음</button>
									</div>
								</div>

								<!-- 제2단계: 아이디 확인 후 이름과 이메일 인증 -->
								<div id="nameEmailSection" style="display:none;">
									<div>
										<p><span><b>[제2단계]</b> </span>본인확인 이메일과 입력한 이메일이 같아야, 인증번호를 받을 수 있습니다.</p>
									</div>
									<div class="form-group row">
										<label for="mem_name" class="col-sm-3">이름</label>
										<div class="col-sm-9">
											<input type="text" class="form-control" name="mem_name" id="mem_name" placeholder="이름을 입력해주세요">
										</div>
									</div>
									<div class="form-group row">
										<label for="mem_email" class="col-sm-3">이메일</label>
										<div class="col-sm-7">
											<input type="email" class="form-control" name="mem_email" id="mem_email"
												placeholder="이메일을 입력해주세요">
										</div>
										<div class="col-sm-2">
											<button type="button" class="btn btn-outline-info" id="btnMailAuth">인증번호 발송</button>
										</div>
									</div>
									<div class="form-group row">
										<label for="authCode" class="col-sm-3">이메일 인증</label>
										<div class="col-sm-7">
											<input type="text" class="form-control" name="authCode" id="authCode" placeholder="인증번호를 입력해주세요">
										</div>
										<div class="col-sm-2">
											<button type="button" class="btn btn-outline-info" id="btnConfirmAuth">인증번호 확인</button>
										</div>
									</div>
									<div class="box-footer">
										<button type="button" class="btn btn-primary login-btn" id="btnNameEmailSection">다음</button>
									</div>
									<!-- 나중에 쓸 일이 있을 것 같아서 hidden 속성 잡아둠 -->
									<input type="hidden" class="form-control" name="mem_id" id="mem_id">
								</div>

								<!-- 제3단계: 모든 인증절차를 거친 뒤 비밀번호 재설정 -->
								<div id="pwResetSection" style="display:none;">
									<div>
										<p><span><b>[제3단계]</b> </span>재설정을 위한 비밀번호를 입력해주세요</p>
									</div>
									<div class="form-group row">
										<label for="mem_pw1" class="col-2">비밀번호 </label>
										<div class="col-10">
											<input type="password" class="form-control" name="mem_pw" id="mem_pw1" placeholder="비밀번호를 입력해주세요">
										</div>
										<label for="mem_pw2" class="col-2">비밀번호 확인</label>
										<div class="col-10">
											<input type="password" class="form-control" id="mem_pw2" placeholder="동일한 비밀번호를 다시 입력해주세요">
										</div>
									</div>
									<div class="form-group">
										<button type="button" class="btn btn-primary login-btn" id="btnResetPw">비밀번호 재설정</button>
									</div>
									<div class="box-footer">
										<button type="button" class="btn btn-primary login-btn" id="btnPwResetSection">완료</button>
									</div>
								</div>

							<div class="login-footer">
								<a href="/member/findId">아이디 찾기</a> | <a href="/member/confirmInfo">비밀번호 찾기</a> | <a
									href="/member/join">회원가입</a>
							</div>
						</div>
					</div>
				</div>
			</div>

			<%@include file="/WEB-INF/views/comm/footer.jsp" %>
				<%@include file="/WEB-INF/views/comm/postCode.jsp" %>
					<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>


						<script>
							$(document).ready(function () {

								// 제1단계: 아이디 존재 유무 확인
								$("#btnIdCheckSection").click(function () {
									let mem_id = $("#id_check").val();
									if (mem_id == "") {
										alert("아이디가 입력되지 않았습니다.");
										$("#id_check").focus();
										return; // 빈칸일 때 함수 실행을 멈춤(존재하지 않는)
									}
									$.ajax({
										url: '/member/confirmInfo',
										type: 'post',
										dataType: 'text',
										data: { mem_id: mem_id },
										success: function (response) {
											// 서버: 해당 아이디의 존재 여부만 확인 <-> 클라이언트: 다음 단계로의 페이지 이동을 처리
											// submit()은 서버에서 데이터 처리가 필요할 때. window.location.href는 단순 페이지 이동
											if (response == "yes") {
												$("#nameEmailSection").show();
												$("#idCheckSection").hide();

												// location.href = "/member/findPw"; // 아이디가 존재하는 경우 바로 비밀번호 찾기 페이지로 이동
												// confirmInfoForm.submit(); // 세션에 아이디를 저장하고 비밀번호 찾기 페이지로 이동
											} else if (response == "no") {
												alert("존재하지 않는 아이디입니다.");
											}
										}
									});
								});

								$("#btnNameEmailSection").click(function() {
									let mem_name = $("mem_name").val();
									let mem_email = $("mem_email").val();
									if(mem_name == "" || mem_email == "") {
										alert("이름과 이메일을 모두 입력해주세요.");
										return;
									}
									
								});

								// 메일 인증 요청
								$("#btnMailAuth").click(function () {
									let mem_email = $("#mem_email").val();
									if (mem_email == "") {
										alert("이메일이 입력되지 않았습니다.");
										$("#mem_email").focus();
										return;
									}
									$.ajax({
										url: '/email/authCode', // @GetMapping("/authCode")
										type: 'get',
										dataType: 'text', // 스프링에서 보내는 데이터의 타입 ─ <String> -> "success" -> text
										data: { receiverMail: mem_email }, // EmailDTO ─ private String receiverMail;
										success: function (result) {
											if (result == "success") {
												alert("인증 메일이 발송되었습니다. 메일을 확인해 주세요.")
											} else {
												// 에러 처리
												alert("메일 발송에 실패했습니다. 다시 시도해 주세요.");
											}
										}
									});
								});

								let isConfirmAuth = false; // 메일 인증을 하지 않은 상태

								// 인증 확인
								// <button type="button" class="btn btn-outline-info" id="btnConfirmAuth">인증 확인</button>
								$("#btnConfirmAuth").click(function () {
									let authCode = $("#authCode").val();
									if (authCode == "") {
										alert("인증번호를 입력하세요.");
										$("#authCode").focus();
										return;
									}

									// 인증확인 요청
									$.ajax({
										url: '/email/confirmAuthcode',
										type: 'get',
										dataType: 'text', // / 스프링에서 보내는 데이터의 타입 ─ <String>
										data: { authCode: authCode },
										success: function (result) {
											if (result == "success") {
												alert("인증에 성공하였습니다.");
												isConfirmAuth = true;
												$("#idCheckSection").hide();
												$("#nameEmailSection").hide();
												$("#pwResetSection").show(); // 비밀번호 재설정 섹션

											} else if (result == "fail") {
												alert("인증에 실패하였습니다. 다시 확인해 주세요.");
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

								// 비밀번호 재설정 처리
								$("#btnPwResetSection").click(function () {
									let resetNewPw = $("#mem_pw1").val();
									let confirmPw = $("#mem_pw2").val();
									if (resetNewPw !== confirmPw) {
										alert("비밀번호가 일치하지 않습니다.");
										$("#mem_pw1").focus();
										return; // 여기서 return을 사용해 함수를 종료해야 합니다.
									}
									// AJAX 요청으로 비밀번호 재설정
									$.ajax({
										url: '/member/findPw', // 서버의 비밀번호 재설정 경로를 입력하세요.
										type: 'POST',
										data: {
											// 요청과 함께 보낼 데이터
											mem_id: $("#mem_id").val(),
											new_pw: newPassword
										},
										success: function (response) {
											// 비밀번호 재설정에 성공했을 때의 처리
											alert("비밀번호가 재설정되었습니다.");
											location.href = "/member/login";
										}
									}); // AJAX 요청의 중괄호
								}); // btnResetPw click 이벤트 핸들러의 중괄호

							}); // $(document).ready 함수의 중괄호
						</script>
	</body>

	</html>