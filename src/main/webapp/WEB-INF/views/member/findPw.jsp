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
							<h3 class="box-title login-title">비밀번호 찾기</h3>
							<form role="form" id="findPwForm" method="post" action="/member/findPw">
								<div class="box-body">
									<input type="hidden" name="mem_id" value="${sessionScope.mem_id}">
									<div class="form-group row">
										<label for="mem_name" class="col-2">이름</label>
										<div class="col-10">
											<input type="text" class="form-control" name="mem_name" id="mem_name" placeholder="이름을 입력해주세요">
										</div>
									</div>
									<div class="form-group row">
										<label for="mem_email" class="col-2">이메일</label>
										<div class="col-7">
											<input type="email" class="form-control" name="mem_email" id="mem_email"
												placeholder="이메일을 입력해주세요">
										</div>
										<div class="col-3">
											<button type="button" class="btn btn-outline-info" id="mailAuth">인증번호 발송</button>
										</div>
									</div>
									<div class="form-group row">
										<label for="authCode" class="col-2">이메일 인증</label>
										<div class="col-7">
											<input type="text" class="form-control" name="authCode" id="authCode" placeholder="인증번호를 입력해주세요">
										</div>
										<div class="col-3">
											<button type="button" class="btn btn-outline-info" id="btnConfirmAuth">인증번호 확인</button>
										</div>
									</div>
								</div>
								<div class="box-footer">
									<button type="button" class="btn btn-primary login-btn" id="btnFindPw">다음</button>
								</div>
							</form>
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



							});
						</script>
	</body>

	</html>