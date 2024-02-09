<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<!DOCTYPE html>
	<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="">
		<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
		<meta name="generator" content="Hugo 0.101.0">
		<title>데브데이&#58;&nbsp;로그인</title>

		<%@include file="/WEB-INF/views/comm/plugIn1.jsp" %>

			<!-- CSS 파일 링크 -->
			<link rel="stylesheet" href="/css/common/header.css">
			<link rel="stylesheet" href="/css/member/login.css">

			<script>
				// UserController의 join 메서드: 회원가입 후 환영인사
				// UserController의 login 메서드: 로그인 실패 시 동작
				let msg = '${msg}';
				if (msg != "") {
					alert(msg);
				}
			</script>
	</head>

	<body>

		<%@include file="/WEB-INF/views/comm/header.jsp" %>

			<div class="container">
				<div class="login-container">
					<div class="text-center">
						<div class="box box-primary login-box">
							<div class="box-header with-border">
								<p class="box-title login-title">로그인</p>
								<form role="form" id="loginForm" method="post" action="/member/login">
									<div class="box-body">
										<div class="form-group">
											<input type="text" class="form-control" name="us_id" id="us_id" value="${remember_id}"
												placeholder="아이디">
										</div>
										<div class="form-group">
											<input type="password" class="form-control" name="us_pw" id="us_pw" placeholder="비밀번호">
										</div>
										<div></div>
									</div>
									<div class="box-footer">
										<div class="form-group row">
											<div class="col-6">
												<input type="checkbox" name="rememberId" id="rememberId" value="true" /> 아이디 저장
											</div>
											<div class="col-6">
												<input type="checkbox" name="rememberLogin" id="rememberLogin" value="true" /> 로그인 유지
											</div>
										</div>
										<button type="submit" class="btn btn-primary login-btn" id="btn_login">로그인</button>
									</div>
								</form>
								<div class="login-footer">
									<a href="/member/info/find" id="linkFindId">아이디 찾기</a> | <a href="/member/info/find"
										id="linkFindPw">비밀번호 찾기</a> | <a href="/member/join">회원가입</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<%@include file="/WEB-INF/views/comm/footer.jsp" %>
			</div>
			<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>

				<script>
					// 페이지 로드 시 체크박스 상태 복원
					document.addEventListener('DOMContentLoaded', function () {
						reCheckboxState('rememberId');
					});

					// 로그인 폼 제출 시 체크박스 상태 저장
					document.getElementById('loginForm').addEventListener('submit', function () {
						checkboxState('rememberId');
					});

					// 체크박스 상태를 로컬 스토리지에 저장
					function checkboxState(rememberId) {
						let checkbox = document.getElementById(rememberId);
						localStorage.setItem(rememberId, checkbox.checked);
					}

					// 로컬 스토리지에서 체크박스 상태를 복원
					function reCheckboxState(rememberId) {
						let checkbox = document.getElementById(rememberId);
						let checked = localStorage.getItem(rememberId) == 'true';
						checkbox.checked = checked;
					}

					document.getElementById('linkFindId').addEventListener('click',
						function () {
							sessionStorage.setItem('activeSection', 'findId');
						});

					document.getElementById('linkFindPw').addEventListener('click',
						function () {
							sessionStorage.setItem('activeSection', 'findPw');
						});
				</script>
	</body>

	</html>