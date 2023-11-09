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

				/* 추가된 스타일 */
				body {
					background-color: #f5f5f5;
					font-family: 'Noto Sans KR', sans-serif;
				}

				.login-container {
					display: flex;
					align-items: center;
					justify-content: center;
					height: 100vh;
					padding: 0 15px;
				}

				.login-box {
					width: 100%;
					max-width: 800px;
					/* 로그인 박스의 최대 너비를 늘림 */
					background: #fff;
					padding: 40px;
					/* 로그인 박스의 패딩을 늘림 */
					border-radius: 10px;
					/* 로그인 박스의 모서리를 더 둥글게 함 */
					box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
					/* 그림자 효과를 더 강조함 */
				}

				.login-title {
					text-align: center;
					margin-bottom: 24px;
					font-size: 32px;
					/* 제목 글꼴 크기를 늘림 */
					color: #333;
				}

				.form-group {
					margin-bottom: 20px;
					/* 각 입력 필드의 마진을 늘림 */
				}

				.form-control {
					width: 100%;
					height: 50px;
					/* 입력 필드의 높이를 늘림 */
					padding: 10px 20px;
					/* 입력 필드의 패딩을 늘림 */
					border: 1px solid #ddd;
					border-radius: 5px;
					/* 입력 필드의 모서리를 더 둥글게 함 */
					font-size: 18px;
					/* 입력 필드의 글꼴 크기를 늘림 */
				}

				.form-control:focus {
					border-color: #007bff;
					box-shadow: none;
				}

				.login-btn {
					width: 100%;
					background-color: #007bff;
					color: white;
					border: none;
					padding: 12px 20px;
					/* 버튼의 패딩을 늘림 */
					font-size: 20px;
					/* 버튼의 글꼴 크기를 늘림 */
					border-radius: 5px;
					/* 버튼의 모서리를 더 둥글게 함 */
					cursor: pointer;
				}

				.login-btn:hover {
					background-color: #0056b3;
				}

				.login-footer {
					text-align: center;
					margin-top: 24px;
					/* 하단 링크들의 마진을 늘림 */
				}

				.login-footer a {
					color: #007bff;
					text-decoration: none;
				}

				.login-footer a:hover {
					text-decoration: underline;
				}
			</style>

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
								</div>
								<div class="box-footer">
									<button type="submit" class="btn btn-primary login-btn" id="btnJoin">로그인</button>
								</div>
							</form>
							<div class="login-footer">
								<a href="/member/findId">아이디 찾기</a> | <a href="/member/findPw">비밀번호 찾기</a>
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