<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<!DOCTYPE html>
	<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="">
		<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
		<meta name="generator" content="Hugo 0.101.0">
		<title>데브데이&#58;&nbsp;회원가입</title>

		<%@include file="/WEB-INF/views/comm/plugIn1.jsp" %>

			<!-- CSS 파일 링크 -->
			<link rel="stylesheet" href="/css/common/header.css">
			<link rel="stylesheet" href="/css/member/join.css">

			<script>
				// 회원가입 후 환영 인사(@PostMapping("/join") 참고)
				let msg = '${msg}';
				if (msg != "") {
					alert(msg);
				}
			</script>
	</head>

	<body>

		<%@include file="/WEB-INF/views/comm/header.jsp" %>

			<div class="container">
				<div class="text-center">
					<div class="box box-primary">
						<div class="box-header with-border">
							<h1 class="box-title mt-5" id="joinMembership" style="text-align: center; margin-bottom: 60px;">
								<b>정보 입력</b>
							</h1>
							<form role="form" id="joinForm" method="post" action="/member/join">
								<div class="box-body">
									<div class="login-info">
										<h3>로그인 정보</h3><br>
										<div class="form-group row">
											<label for="us_id" class="col-2">아이디</label>
											<div class="col-4">
												<input type="text" class="form-control" name="us_id" id="us_id" placeholder="아이디를 입력해 주세요.">
											</div>
											<div class="col-2">
												<button type="button" class="btn btn-outline-info" id="idCheck">ID 중복검사</button>
											</div>
											<div class="col-4">
												<span class="yes_us_id">사용 가능한 아이디입니다.</span>
												<span class="no_us_id">이미 존재하는 아이디입니다.</span>
											</div>
										</div>
										<div class="form-group row">
											<label for="us_pw1" class="col-2">비밀번호</label>
											<div class="col-4">
												<input type="password" class="form-control" name="us_pw" id="us_pw1" placeholder="비밀번호를 입력해 주세요.">
											</div>
											<label for="us_pw2" class="col-2">비밀번호 확인</label>
											<div class="col-4">
												<input type="password" class="form-control" id="us_pw2" placeholder="비밀번호를 다시 입력해 주세요.">
											</div>
										</div>
									</div>

									<div class="member-info">
										<h3>회원 정보</h3><br>
										<div class="form-group row">
											<label for="us_name" class="col-2">이름</label>
											<div class="col-10">
												<input type="text" class="form-control" name="us_name" id="us_name" placeholder="이름을 입력해 주세요.">
											</div>
										</div>
										<div class="form-group row">
											<label for="us_phone" class="col-2">전화번호</label>
											<div class="col-10">
												<input type="text" class="form-control" name="us_phone" id="us_phone"
													placeholder="전화번호를 '-' 없이 입력해 주세요.">
											</div>
										</div>
										<div class="form-group row">
											<label for="us_email" class="col-2">이메일</label>
											<div class="col-7">
												<input type="email" class="form-control" name="us_email" id="us_email"
													placeholder="이메일을 입력해 주세요.">
											</div>
											<div class="col-3">
												<button type="button" class="btn btn-outline-info" id="mailAuth">인증번호 발송</button>
											</div>
										</div>
										<div class="form-group row">
											<label for="authCode" class="col-2"></label>
											<div class="col-7">
												<input type="text" class="form-control" name="authCode" id="authCode"
													placeholder="발송된 인증번호를 입력해 주세요.">
											</div>
											<div class="col-3">
												<button type="button" class="btn btn-outline-info" id="btnConfirmAuth">인증번호 확인</button>
											</div>
										</div>
										<div class="form-group row">
											<label for="sample2_postcode" class="col-2">우편번호</label>
											<div class="col-7">
												<input type="text" class="form-control" name="us_postcode" id="sample2_postcode"
													placeholder="우편번호를 입력해 주세요.">
											</div>
											<div class="col-3">
												<button type="button" onclick="sample2_execDaumPostcode()" class="btn btn-outline-info">우편번호
													찾기</button>
											</div>
										</div>
										<div class="form-group row">
											<label for="sample2_address" class="col-2">주소</label>
											<div class="col-10">
												<input type="text" class="form-control" name="us_addr_basic" id="sample2_address"
													placeholder="기본주소를 입력해 주세요.">
											</div>
										</div>
										<div class="form-group row">
											<label for="sample2_detailAddress" class="col-2">상세주소</label>
											<div class="col-10">
												<input type="text" class="form-control" name="us_addr_detail" id="sample2_detailAddress"
													placeholder="상세주소를 입력해 주세요.">
												<input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
											</div>
										</div>
									</div>
								</div>
								<div class="box-footer">
									<button type="button" class="btn btn-primary" id="btnJoin">가입하기</button>
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

							$(document).ready(function () {

								let userIdCheck = false; // 아이디 중복 사용 유무 확인

								// JS 문법: document.getElementById("idCheck");
								$("#idCheck").click(function () {
									// alert("아이디 중복 확인");
									if ($("#us_id").val() == "") {
										alert("아이디가 입력되지 않았습니다. 아이디를 입력해 주세요.");
										$("#us_id").focus();
										return;
									}

									// 아이디 중복 검사 기능 구현
									$.ajax({
										url: '/member/idCheck', // url : '아이디'를 체크하는 매핑주소
										type: 'get', // get or post
										dataType: 'text', // <String>
										data: { us_id: $("#us_id").val() }, // 객체 리터럴(key: value) ─ data: { 파라미터명: 데이터 값 }
										success: function (result) { // success: function (매개변수명) { 
											if (result == "yes") {
												$('.yes_us_id').css("display", "inline-block");
												$('.no_us_id').css("display", "none");
												userIdCheck = true; // let userIdCheck = false;
											} else {
												$('.no_us_id').css("display", "inline-block");
												$('.yes_us_id').css("display", "none");
												userIdCheck = false;
												// $("#us_id").val()는 GETTER, $("#us_id").val("")는 SETTER
												$("#us_id").val(""); // 아이디 텍스트 박스의 값을 지움
												$("#us_id").focus(); // 포커스 기능
											}
										}
									});
								});

								let isMailAuth = false;
								let isConfirmAuth = false; // 인증번호를 입력하지 않은 상태

								// 메일 인증 요청
								$("#mailAuth").click(function () {

									if ($("#us_email").val() == "") {
										alert("이메일이 입력되지 않았습니다. 이메일을 입력해 주세요.");
										$("#us_email").focus();
										return;
									}

									$.ajax({
										url: '/email/authCode', // @GetMapping("/authCode")
										type: 'get',
										dataType: 'text',
										data: { receiverMail: $("#us_email").val() }, // EmailDTO ─ private String receiverMail;
										success: function (result) {
											if (result == "success") {
												alert("인증번호가 이메일로 발송되었습니다. 이메일을 확인해 주세요.")
												isMailAuth = true;
											}
										}
									});
								});


								// 인증 확인: <button type="button" class="btn btn-outline-info" id="btnConfirmAuth">인증 확인</button>
								$("#btnConfirmAuth").click(function () {

									if ($("#authCode").val() == "") {
										alert("발송된 인증번호를 입력해 주세요.");
										$("#authCode").focus();
										return;
									}

									// 인증확인 요청
									$.ajax({
										url: '/email/confirmAuthCode',
										type: 'get',
										dataType: 'text', // / 스프링에서 보내는 데이터의 타입 ─ <String>
										data: { authCode: $("#authCode").val() },
										success: function (result) {
											if (result == "success") {
												alert("회원 인증이 정상적으로 처리되었습니다.");
												isConfirmAuth = true;
											} else if (result == "fail") {
												alert("인증에 실패하였습니다. 나중에 다시 시도해 주세요.");
												$("#authCode").val("");
												isConfirmAuth = false;
											} else if (result == "request") { // 세션 종료 시(기본 30분)
												alert("인증에 실패하였습니다. 요청을 다시 시도해 주세요.");
												$("#authCode").val("");
												isConfirmAuth = false;
											}
										}
									});
								});

								let joinForm = $("#joinForm"); // form 태그 참조: <form role="form" id="joinForm" method="post" action="/member/join">
								
								// 회원가입 버튼 클릭 시 동작
								$("#btnJoin").click(function () {

									let us_id = $('#us_id').val().trim();
									let us_pw1 = $('#us_pw1').val().trim();
									let us_pw2 = $('#us_pw2').val().trim();
									let us_name = $('#us_name').val().trim();
									let us_phone = $('#us_phone').val().trim();
									let us_email = $('#us_email').val().trim();
									let authCode = $('#authCode').val().trim();
									let sample2_postcode = $('#sample2_postcode').val().trim();
									let sample2_address = $('#sample2_address').val().trim();
									let sample2_detailAddress = $('#sample2_detailAddress').val().trim();

									// 회원가입 유효성 검사(JS 이용)
									if (!us_id) {
										alert("아이디를 입력해 주세요.");
										$('#us_id').focus();
										return;
									}
									if (!userIdCheck) {
										alert("입력한 아이디의 사용 가능 여부를 확인해 주세요.");
										return;
									}
									if (!us_pw1) {
										alert("비밀번호를 입력해 주세요.");
										$('#us_pw1').focus();
										return;
									}
									if (!us_pw2) {
										alert("비밀번호를 입력해 주세요.");
										$('#us_pw2').focus();
										return;
									}
									if (us_pw1 != us_pw2) {
										alert("비밀번호가 일치하지 않습니다. 다시 입력해 주세요.");
										$('#us_pw2').focus();
										return;
									}
									if (!us_name) {
										alert("이름을 입력해 주세요.");
										$('#us_name').focus();
										return;
									}
									if (!us_phone) {
										alert("전화번호를 입력해 주세요.");
										$('#us_phone').focus();
										return;
									}
									if (!us_email) {
										alert("이메일을 입력해 주세요.");
										$('#us_email').focus();
										return;
									}
									if (!isMailAuth) {
										alert("이메일로 인증번호를 발송해 주세요.");
										return;
									}
									if (!authCode) {
										alert("인증번호를 입력해 주세요.");
										$('#authCode').focus();
										return;
									}
									if (!isConfirmAuth) {
										alert("입력한 인증번호를 확인해 주세요.");
										return;
									}
									if (!sample2_postcode) {
										alert("우편번호를 입력해 주세요.");
										$('#sample2_postcode').focus();
										return;
									}
									if (!sample2_address) {
										alert("기본주소를 입력해 주세요.");
										$('#sample2_address').focus();
										return;
									}
									if (!sample2_detailAddress) {
										alert("상세주소를 입력해 주세요.");
										$('#sample2_detailAddress').focus();
										return;
									}

									// 폼 전송 작업(스프링 작업 이후)
									joinForm.submit(); // let joinForm = $("#joinForm");
								})

							});
						</script>

	</body>

	</html>