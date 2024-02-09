<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<!DOCTYPE html>
	<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="">
		<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
		<meta name="generator" content="Hugo 0.101.0">
		<title>데브데이&#58;&nbsp;마이페이지</title>

		<%@include file="/WEB-INF/views/comm/plugIn1.jsp" %>

			<!-- CSS 파일 링크 -->
			<link rel="stylesheet" href="/css/common/header.css">

			<style>
				input[readonly] {
					background-color: white !important;
				}
			</style>
	</head>

	<body>

		<%@include file="/WEB-INF/views/comm/header.jsp" %>

			<div class="container">
				<div class="text-center">
					<div class="box box-primary">
						<div class="box-header with-border">
							<h1 class="box-title mt-5" id="getMemberInfo" style="text-align: center; margin-bottom: 60px;">
								<b>정보&nbsp;조회</b>
							</h1>
							<form role="form" id="myPageForm" method="get" action="/member/myPage">
								<div id="modifyInfoSection">
									<div class="box-body">
										<div class="login-info">
											<div class="form-group row">
												<label for="us_id" class="col-2">아이디</label>
												<div class="col-7">
													<input type="text" class="form-control" name="us_id" id="us_id" value="${us_vo.us_id}"
														readonly>
												</div>
												<div class="col-3">
													<button type="button" class="btn btn-outline-info" id="btnChangePw">비밀번호 변경</button>
												</div>
											</div>
										</div>
										<div class="member-info">
											<div class="form-group row">
												<label for="us_phone" class="col-2">전화번호</label>
												<div class="col-10">
													<input type="text" class="form-control" name="us_phone" id="us_phone"
														value="${us_vo.us_phone}" readonly>
												</div>
											</div>
											<div class="form-group row">
												<label for="us_email" class="col-2">이메일</label>
												<div class="col-10">
													<input type="email" class="form-control" name="us_email" id="us_email"
														value="${us_vo.us_email}" readonly>
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
									</div><br />
									<div class="box-footer">
										<button type="button" class="btn btn-primary" id="btnModify">수정하기</button>
										<button type="button" class="btn btn-danger" id="btnDelete">탈퇴하기</button>
									</div>
								</div>
							</form>

							<form role="form" id="ResetPwForm" method="post" action="/member/reset_Pw">
								<div id="pwResetSection" style="display: none;">
									<h1 class="box-title mt-5" id="getMemberInfo" style="text-align: center; margin-bottom: 60px;">
										<b>비밀번호&nbsp;변경</b>
									</h1>
									<div class="form-group row">
										<label for="currentPw" class="col-2">현재&nbsp;비밀번호&nbsp;</label>
										<div class="col-10">
											<input type="password" class="form-control" name="currentPw" placeholder="현재 비밀번호를 입력해 주세요.">
										</div>
									</div>
									<div class="form-group row">
										<label for="newPw1" class="col-2">새&nbsp;비밀번호&nbsp;</label>
										<div class="col-10">
											<input type="password" class="form-control" name="newPw1" placeholder="새 비밀번호를 입력해 주세요.">
										</div>
									</div>
									<div class="form-group row">
										<label for="newPw2" class="col-2">새&nbsp;비밀번호&nbsp;확인&nbsp;</label>
										<div class="col-10">
											<input type="password" class="form-control" name="newPw2" placeholder="새 비밀번호를 한 번 더 입력해 주세요.">
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

							// 비밀번호 재설정 처리
							$("#btnChangePw").click(function () {
								$("#getMemberInfo").hide();
								$("#modifyInfoSection").hide();
								$("#pwResetSection").show();
							});

							$("#btnResetPw").click(function () {

								let us_id = $("#us_id").val(); // 현재 로그인한 사용자의 아이디로 초기화
								let currentPw = $("input[name='currentPw']").val().trim();
								let resetPw = $("input[name='newPw1']").val().trim();
								let confirmPw = $("input[name='newPw2']").val().trim();

								if (!currentPw) {
									alert("기존 비밀번호를 입력해 주세요.")
									$("input[name='currentPw']").focus();
									return;
								}
								if (!resetPw) {
									alert("변경할 비밀번호를 입력해 주세요.")
									$("input[name='newPw1']").focus();
									return;
								}
								if (!confirmPw) {
									alert("변경할 비밀번호를 한 번 더 입력해 주세요.")
									$("input[name='newPw2']").focus();
									return;
								}
								if (resetPw == confirmPw && (currentPw == resetPw || currentPw == confirmPw)) {
									alert("현재 비밀번호와 변경할 비밀번호가 동일합니다. 다른 비밀번호를 입력해 주세요.");
									$("input[name='newPw1']").val("");
									$("input[name='newPw2']").val("");
									$("input[name='newPw1']").focus();
									return;
								}
								if (resetPw != confirmPw) {
									alert("변경할 비밀번호가 일치하지 않습니다.");
									$("input[name='newPw1']").val("");
									$("input[name='newPw2']").val("");
									$("input[name='newPw1']").focus();
									return;
								}
								$.ajax({
									url: '/member/reset_pw',
									type: 'post',
									data: { us_id: us_id, currentPw: currentPw, us_pw: resetPw },
									success: function (response) {
										if (response == "success") {
											// 비밀번호 재설정에 성공했을 때의 처리
											alert("비밀번호가 정상적으로 재설정되었습니다.");
											location.href = "/member/login";
										} else if (response == "request") {
											alert("현재 비밀번호가 회원가입 시 작성했던 비밀번호와 일치하지 않습니다.");
											$("input[name='currentPw']").val("");
											$("input[name='currentPw']").focus();
										}
									}
								}); // AJAX 요청
							}); // btnResetPw click 이벤트 핸들러

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