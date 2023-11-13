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
				let msg = '${msg}'; // ${msg}: MemberController의 rttr.addFlashAttribute("msg", msg);에서 앞의 "msg"
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
							<form role="form" id="btnJoin" method="post" action="/member/login">
								<div class="box-body">
									<div class="form-group">
										<input type="text" class="form-control" name="mem_id" id="mem_id" placeholder="아이디">
									</div>
									<div class="form-group">
										<input type="password" class="form-control" name="mem_pw" id="mem_pw" placeholder="비밀번호">
									</div>
									<div>
									</div>
								</div>
								<div class="box-footer">
									<div class="form-group row">
										<div class="col-2">
											<input type="checkbox" class="form-control" name="" id="keep_login">
										</div>
										<label for="keep_login" class="col-7">로그인 상태 유지</label>
									</div>	
									<button type="submit" class="btn btn-primary login-btn" id="btnJoin">로그인</button>
								</div>
							</form>
							<div class="login-footer">
								<a href="/member/findId">아이디 찾기</a> | <a href="/member/confirmInfo">비밀번호 찾기</a> | <a href="/member/join">회원가입</a>
							</div>
						</div>
					</div>
				</div>
			</div>

			<%@include file="/WEB-INF/views/comm/footer.jsp" %>
				<%@include file="/WEB-INF/views/comm/postCode.jsp" %>
					<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>


	</body>

	</html>