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

			<div class="container login-container">
				<div class="text-center">
					<div class="box box-primary login-box">
						<div class="box-header with-border">
							<h3 class="box-title login-title">로그인</h3>
							<form role="form" method="post" action="/member/login">
								<div class="box-body">
									<div class="form-group">
										<input type="text" class="form-control" name="us_id" id="us_id" placeholder="아이디">
									</div>
									<div class="form-group">
										<input type="password" class="form-control" name="us_pw" id="us_pw" placeholder="비밀번호">
									</div>
									<div></div>
								</div>
								<div class="box-footer">
									<div class="form-group row">
										<div class="col-6">
											<input type="checkbox" name="isRememberId" id="idSaveCheck" value="true" checked="checked" /> 아이디
											저장
										</div>
										<div class="col-6">
											<input type="checkbox" name="isRememberLogin" value="true" />
											로그인 유지
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
				<%@include file="/WEB-INF/views/comm/postCode.jsp" %>
					<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>

						<script>
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