<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<!DOCTYPE html>
	<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="">
		<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
		<meta name="generator" content="Hugo 0.101.0">
		<title>데브데이&#58;&nbsp;회원정보찾기</title>

		<%@include file="/WEB-INF/views/comm/plugIn1.jsp" %>

			<!-- CSS 파일 링크 -->
			<link rel="stylesheet" href="/css/common/header.css">
			<link rel="stylesheet" href="/css/member/login.css">

			<style>
				/* #findIdSections, #findPwSections {
					width: auto;
				} */

				#btnConfirmId,
				#btnDoLogin,
				#btnFindPw,
				#btnIdCheck,
				#btnNameEmail,
				#btnResetPw {
					width: 80px;
					height: 40px;
					padding: 5px 10px;
					/* 외부 여백 설정 */
					font-size: 20px;
					/* 글자 크기 설정 */
					vertical-align: middle;
					/* 수직 정렬 */
				}

				input[readonly] {
					background-color: white !important;
				}
			</style>

	</head>

	<body>

		<%@include file="/WEB-INF/views/comm/header.jsp" %>

			<div class="container login-container">
				<div class="text-center">
					<div class="box box-primary login-box">
						<div class="box-header with-border">
							<!-- 아이디 찾기 -->
							<form role="form" id="findIdForm" method="post" action="/member/find_id">
								<div id="findIdSections">
									<h3 class="box-title login-title">아이디 찾기</h3>
									<!-- 제1단계: 이름과 이메일을 통한 아이디 찾기 -->
									<div id="confirmSection">
										<div>
											<p><span><b>[제1단계]</b> </span>본인확인 이메일과 입력한 이메일이 같아야, 인증번호를 받을 수 있습니다.</p>
										</div>
										<div class="box-body">
											<div class="form-group row">
												<label for="us_name" class="col-2">이름</label>
												<div class="col-10">
													<input type="text" class="form-control" name="us_name" placeholder="이름을 입력해 주세요.">
												</div>
											</div>
											<div class="form-group row">
												<label for="us_email" class="col-2">이메일</label>
												<div class="col-7">
													<input type="email" class="form-control" name="us_email" placeholder="이메일을 입력해 주세요.">
												</div>
												<div class="col-3">
													<button type="button" class="btn btn-outline-info" name="btnMailAuth">인증번호 발송</button>
												</div>
											</div>
											<div class="form-group row">
												<label for="authCode" class="col-2"></label>
												<div class="col-7">
													<input type="text" class="form-control" name="authCode" placeholder="인증번호(6자리)를 입력해 주세요.">
												</div>
												<div class="col-3">
													<button type="button" class="btn btn-outline-info" name="btnConfirmAuth">인증번호 확인</button>
												</div>
											</div>
										</div>
										<div class="box-footer">
											<button type="button" class="btn btn-primary login-btn" id="btnConfirmId">다음</button>
										</div>
									</div>

									<!-- 제2단계: 아이디 도출-->
									<div id="showIdSection" style="display: none;">
										<div>
											<p><span><b>[제2단계]</b> </span>회원님의 정보와 일치하는 아이디입니다.</p>
										</div>
										<div class="box-body">
											<div class="form-group row">
												<label for="us_id" class="col-3">아이디</label>
												<div class="col-9">
													<input type="text" class="form-control" name="us_id" readonly>
												</div>
											</div>
											<div class="form-group row">
												<label for="" class="col-3">가입일</label>
												<div class="col-9">
													<input type="text" class="form-control" name="us_join_date" readonly>
												</div>
											</div>
										</div>
										<div class="box-footer">
											<div class="form-group row">
												<div class="col-6">
													<button type="button" class="btn btn-success login-btn" name="btnDoLogin" 
														style="background-color: green !important;">로그인하기</button>
												</div>
												<div class="col-6">
													<button type="button" class="btn btn-primary login-btn" name="btnFindPw">비밀번호 찾기</button>
												</div>
											</div>
										</div>
									</div>

								</div>
							</form>

							<!-- 비밀번호 찾기 -->
							<form role="form" id="findPwForm" method="post" action="/member/find_pw">
								<div id="findPwSections">
									<h3 class="box-title login-title">비밀번호 찾기</h3>
									<!--제1단계: 아이디 존재 유무 확인-->
									<div id="idCheckSection">
										<div>
											<p><span><b>[제1단계]</b> </span>비밀번호를 찿기 위한 아이디를 입력하세요.</p>
										</div>
										<div class="form-group row">
											<label for="idCheck" class="col-sm-3">아이디</label>
											<div class="col-sm-9">
												<input type="text" class="form-control" name="us_id" id="idCheck">
											</div>
										</div>
										<div class="box-footer">
											<button type="button" class="btn btn-primary login-btn" id="btnIdCheck">다음</button>
										</div>
									</div>

									<!-- 제2단계: 이름과 이메일 인증 후 임시 비밀번호 생성-->
									<div id="nameEmailSection" style="display: none;">
										<div>
											<p><span><b>[제2단계]</b> </span>본인확인 이메일과 입력한 이메일이 같아야, 인증번호를 받을 수 있습니다.</p>
										</div>
										<div class="form-group row">
											<label for="us_name" class="col-2">이름</label>
											<div class="col-10">
												<input type="text" class="form-control" name="us_name" placeholder="이름을 입력해 주세요.">
											</div>
										</div>
										<div class="form-group row">
											<label for="us_email" class="col-2">이메일</label>
											<div class="col-7">
												<input type="email" class="form-control" name="us_email" placeholder="이메일을 입력해 주세요.">
											</div>
											<div class="col-3">
												<button type="button" class="btn btn-outline-info" name="btnMailAuth">인증번호 발송</button>
											</div>
										</div>
										<div class="form-group row">
											<label for="authCode" class="col-2"></label>
											<div class="col-7">
												<input type="text" class="form-control" name="authCode" placeholder="인증번호(6자리)를 입력해 주세요.">
											</div>
											<div class="col-3">
												<button type="button" class="btn btn-outline-info" name="btnConfirmAuth">인증번호 확인</button>
											</div>
										</div>
										<div class="box-footer">
											<button type="button" class="btn btn-primary login-btn" id="btnNameEmail">다음</button>
										</div>
									</div>

									<!-- 제3단계: 모든 인증절차를 거친 뒤 비밀번호 재설정 -->
									<div id="pwResetSection" style="display: none;">
										<div>
											<p><span><b>[제3단계]</b> </span>재설정을 위한 비밀번호를 입력해 주세요.</p>
										</div>
										<div class="form-group row">
											<label for="us_pw1" class="col-4">새 비밀번호</label>
											<div class="col-8">
												<input type="password" class="form-control" name="us_pw" id="us_pw1" placeholder="새 비밀번호를 입력해 주세요.">
											</div>
											<label for="us_pw2" class="col-4">새 비밀번호 확인</label>
											<div class="col-8">
												<input type="password" class="form-control" id="us_pw2" placeholder="새 비밀번호를 다시 입력해 주세요.">
											</div>
										</div>
										<div class="box-footer">
											<button type="button" class="btn btn-primary login-btn" id="btnResetPw">완료</button>
										</div>
									</div>
								</div>
							</form>

							<div class="login-footer">
								<a href="/member/info/find" id="linkFindId">아이디 찾기</a> | <a href="/member/info/find"
									id="linkFindPw">비밀번호
									찾기</a> | <a href="/member/join">회원가입</a>
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

								// 초기 설정: 모든 섹션 숨기기
								$("#findIdSections").hide(); // 아이디 찾기 섹션
								$("#findPwSections").hide(); // 비밀번호 찾기 섹션

								let activeSection = sessionStorage.getItem('activeSection');
								if (activeSection == 'findId') {
									$('#findIdSections').show();
								} else if (activeSection == 'findPw') {
									$('#findPwSections').show();
								}
								// sessionStorage.removeItem('activeSection'); // 사용 후 정보 제거
								

								// 아이디 찾기 링크 클릭 이벤트
								// <a href="/member/findId" id="linkFindId">
								$("#linkFindId").on("click", function (e) {

									e.preventDefault(); // 기본 이벤트 방지
									
									us_id = $('#idCheck').val('');

									$("#findPwSections").hide(); // 비밀번호 찾기 섹션 숨기기
									$("#findIdSections").show(); // 아이디 찾기 섹션 보이기

									// 비밀번호 찾기 섹션의 입력 필드 초기화
									$('#findPwSections input[type="text"], #findPwSections input[type="email"]').val('');

									// 비밀번호 찾기 섹션의 상태 초기화 로직
									$("#idCheckSection").show();
									$("#nameEmailSection").hide();
									$("#pwResetSection").hide();
								});

								// 비밀번호 찾기 링크 클릭 이벤트
								// <a href="/member/findPw" id="linkFindPw">
								$("#linkFindPw").on("click", function (e) {

									e.preventDefault(); // 기본 이벤트 방지

									$("#findIdSections").hide(); // 아이디 찾기 섹션 숨기기
									$("#findPwSections").show(); // 비밀번호 찾기 섹션 보이기
									
									// 아이디 찾기 섹션의 입력 필드 초기화
									$('#findIdSections input[type="text"], #findIdSections input[type="email"]').val('');

									// 아이디 찾기 섹션의 상태 초기화 로직
									$("#confirmSection").show();
									$("#showIdSection").hide();
								});

								// 전역 변수(아이디 및 비밀번호 찾기용)
								let us_name = ""; 
								let us_email = ""; 
								let authCode = ""; 
								let us_id = $("#idCheck").val(); // 비밀번호 찾기용

								// 입력 필드의 값이 변경될 때마다 해당 필드 업데이트
								$("input[name='us_name']").on('input', function () {
									us_name = $(this).val();
								});
								$("input[name='us_email']").on('input', function () {
									us_email = $(this).val();
								});
								$("input[name='authCode']").on('input', function () {
									authCode = $(this).val();
								});
								$("#idCheck").on('input', function () {
									us_id = $(this).val();
								});

								// 이하 아이디 찾기 관련

								// 아이디 찾기 제1단계: 이름과 이메일을 통한 아이디 찾기
								$("#btnConfirmId").click(function () {

									if (us_name == "") {
										alert("이름을 입력해 주세요.");
										$("input[name='us_name']").focus();
										return;
									}
									if (us_email == "") {
										alert("이메일을 입력해 주세요.");
										$("input[name='us_email']").focus();
										return;
									}
									if (authCode == "") {
										alert("인증번호를 입력해 주세요.");
										$("input[name='authCode']").focus();
										return;
									}
									if (!isConfirmAuth) {
										alert("입력한 인증번호를 확인해 주세요.");
										return;
									}
									$.ajax({
										url: '/member/find_id',
										type: 'post',
										dataType: 'json',
										data: { us_name: us_name, us_email: us_email },
										success: function (response) {
											// 사용자를 찾은 경우의 처리
											$("input[name='us_id']").val(response.us_id)
											$("#confirmSection").hide();
											$("#showIdSection").show();
											let joinDate = new Date(response.us_join_date);
											let formatDate = joinDate.getFullYear() + '년 ' +
												(joinDate.getMonth() + 1) + '월 ' + // getMonth()는 0부터 시작
												joinDate.getDate() + '일';
											$("input[name='us_join_date']").val(formatDate);
										}
									});
								});

								// 아이디 찾기 제2단계: 아이디 확인
								$("button[name='btnDoLogin']").click(function () {
									location.href = "/member/login"
								});

								$("button[name='btnFindPw']").click(function () {
									// location.href = "/member/info/find"
									$("#findIdSections").hide(); // 아이디 찾기 섹션 숨기기
									$("#findPwSections").show(); // 비밀번호 찾기 섹션 보이기

									// 아이디 찾기 섹션의 입력 필드 초기화
									$('#findIdSections input[type="text"], #findIdSections input[type="email"]').val('');
									// 비밀번호 찾기 섹션의 입력 필드 초기화
									$('#findPwSections input[type="text"], #findPwSections input[type="email"]').val('');

									// 아이디 찾기 섹션의 상태 초기화 로직
									$("#confirmSection").show();
									$("#showIdSection").hide();
								});

								// 이하 비밀번호 찾기 관련

								// 비밀번호 찾기 제1단계: 아이디 존재 유무 확인
								// 다음 버튼을 클릭 시 아이디가 빈 칸인 경우 동작
								$("#btnIdCheck").click(function () {
									if (us_id == "") {
										alert("아이디를 입력해 주세요.");
										$("#idCheck").focus();
										return; // 빈 칸일 때 함수 실행을 멈춤(존재하지 않는 경우)
									}
									$.ajax({
										url: '/member/find_pw',
										type: 'post',
										dataType: 'text',
										data: { us_id: us_id }, // let us_id = "";
										success: function (response) {
											if (response == "yes") {
												$("#idCheckSection").hide();
												$("#nameEmailSection").show();
												// 서버: 해당 아이디의 존재 여부만 확인 <-> 클라이언트: 다음 단계로의 페이지 이동을 처리
												// location.href = "/member/findPw"; // 아이디가 존재하는 경우 바로 비밀번호 찾기 페이지로 이동
												// confirmInfoForm.submit(); // 세션에 아이디를 저장하고 비밀번호 찾기 페이지로 이동
												// submit()은 서버에서 데이터 처리가 필요할 때. window.location.href는 단순 페이지 이동
											} else if (response == "no") {
												alert("존재하지 않는 아이디입니다. 확인 후 다시 시도해 주세요.");
												$("#idCheck").var("");
											}
										}
									});
								});

								// 비밀번호 찾기 제2단계: 이름 및 이메일 확인
								// 메일 인증번호 용도: 회원가입, 아이디 및 비밀번호 찾기 
								// $("button[name='btnMailAuth']").click(function () 같음
								$("button[name='btnMailAuth']").on("click", function () {
									// 이름을 입력하지 않고 발송 버튼을 누를 시에도 작동하게끔 하기 위함
									if (us_name == "") {
										alert("이름을 입력해 주세요.");
										$("input[name='us_name']").focus();
										return;
									}
									if (us_email == "") {
										alert("이메일을 입력해 주세요.");
										$("input[name='us_email']").focus();
										return;
									}

									let data = { us_name: us_name, receiverMail: us_email };

									if (activeSection == 'findPw') {
										data.us_id = us_id; // 비밀번호 찾기의 경우
									}

									$.ajax({
										url: '/email/authCode', // @GetMapping("/authCode")
										type: 'get',
										dataType: 'text', // 스프링에서 보내는 데이터의 타입 ─ <String> -> "success" -> text
										data: data, // let data = { us_name: us_name, receiverMail: us_email };
										success: function (result) {
											if (result == 'success') {
												alert("인증번호가 이메일로 발송되었습니다. 이메일을 확인해 주세요.")
											} else if (result == 'noUserForId') {
												// 아이디 찾기 요청에서 사용자를 찾지 못한 경우
												alert("입력하신 정보로 등록된 사용자를 찾을 수 없습니다.");
											} else if (result == 'noUserForPw') {
												// 비밀번호 찾기 요청에서 사용자를 찾지 못한 경우
												alert("이름이나 이메일이 잘못 입력되었습니다. 확인 후 다시 입력해 주세요.");
											}
										}
									});
								});

								// 인증을 하지 않은 상태(가입하기 버튼 클릭 시 동작히기 위함)
								let isConfirmAuth = false;
								$("button[name='btnConfirmAuth']").click(function () {
									if (authCode == "") {
										alert("발송된 인증번호를 입력해 주세요.");
										$("input[name='authCode']").focus();
										return;
									}
									// 인증확인 요청
									$.ajax({
										url: '/email/confirmAuthCode',
										type: 'get',
										dataType: 'text', // / 스프링에서 보내는 데이터의 타입 ─ <String>
										data: { authCode: authCode },
										success: function (result) {
											if (result == "success") { // 인증 성공 시
												alert("인증이 정상적으로 처리되었습니다. 다음 버튼을 클릭해 주세요.");
												isConfirmAuth = true;
											} else if (result == "fail") { // 인증 실패 시
												alert("인증에 실패하였습니다. 인증번호 확인 후 다시 시도해 주세요.");
												$("input[name='authCode']").val("");
												isConfirmAuth = false;
											} else if (result == "request") { // 세션 종료 시(Default: 30분)
												alert("인증에 실패하였습니다. 인증번호 발송을 다시 요청해 주세요.");
												$("input[name='authCode']").val("");
												isConfirmAuth = false;
											}
										}
									});
								});

								// 다음 버튼을 클릭 시 이름과 이메일이 빈 칸인 경우 동작
								$("#btnNameEmail").click(function () {
									if (us_name == "") {
										alert("이름을 입력해 주세요.");
										$("input[name='us_name']").focus();
										return;
									}
									if (us_email == "") {
										alert("이메일을 입력해 주세요.");
										$("input[name='us_email']").focus();
										return;
									}
									if (authCode == "") {
										alert("발송된 인증번호를 입력해 주세요.")
										$("input[name='authCode']").focus();
										return;
									}
									if (!isConfirmAuth) {
										alert("입력한 인증번호를 확인해 주세요.");
										return;
									}
									// 임시 비밀번호 발송
									$.ajax({
										url: '/member/find_pw',
										type: 'post',
										data: {
											us_id: us_id, // let us_id = "";
											us_name: us_name,
											us_email: us_email
										},
										success: function (response) {
											if (response == "yes") {
												if (!confirm("임시 비밀번호가 이메일로 전송되었습니다. 임시 비밀번호로 로그인을 원하시면 확인을, 재설정을 원하시면 취소를 클릭해 주세요.")) {
													$("#idCheckSection").hide();
													$("#nameEmailSection").hide();
													$("#pwResetSection").show();
												} else {
													location.href = "/member/login";
												}
											}
										}
									});
								});

								// 비밀번호 찾기 제3단계: 비밀번호 재설정 처리
								$("#btnResetPw").click(function () {

									let resetPw = $("#us_pw1").val().trim();
									let confirmPw = $("#us_pw2").val().trim();
									
									let hasLetter = /[A-Za-z]/.test(resetPw); // 영문자 포함 (대문자 또는 소문자)
									let hasNumbers = /\d/.test(resetPw); // 숫자 포함
									let hasSpecialChars = /[!@#$%^&*]/.test(resetPw); // 특수문자 포함
									let isValidLength = resetPw.length >= 8 && resetPw.length <= 16; // 길이 확인

									if (!resetPw) {
										alert("새 비밀번호를 입력해 주세요.");
										$("#us_pw1").val('');
										$("#us_pw1").focus();
										return;
									}
									if (!confirmPw) {
										alert("새 비밀번호를 다시 입력해 주세요.");
										$("#us_pw2").val('');
										$("#us_pw2").focus();
										return;
									}
									if (resetPw != confirmPw) {
										alert("비밀번호가 일치하지 않습니다. 다시 입력해 주세요.");
										$("#us_pw1").val('');
										$("#us_pw2").val('');
										$("#us_pw1").focus();
										return;
									}
									// 비밀번호 유효성 검사
									if (!hasLetter || !hasNumbers || !hasSpecialChars || !isValidLength) {
										alert("비밀번호는 8~16자의 영문자, 숫자 및 특수문자(!@#$%^&*)를 모두 포함해야 합니다.");
										$('#us_pw1').val('');
										$('#us_pw2').val('');
										$('#us_pw1').focus();
										return;
									}
									
									$.ajax({
										url: '/member/resetPw',
										type: 'post',
										data: { us_id: us_id, us_pw: resetPw },
										success: function (response) {
											if (response == "success") {
											// 비밀번호 재설정에 성공했을 때의 처리
											alert("비밀번호가 정상적으로 재설정되었습니다.");
											location.href = "/member/login";
											}
										}
									}); // AJAX 요청
								}); // btnResetPw click 이벤트 핸들러

							}); // $(document).ready 함수

						</script>
	</body>

	</html>