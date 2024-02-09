<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<!DOCTYPE html>
	<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="">
		<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
		<meta name="generator" content="Hugo 0.101.0">
		<title>데브데이&#58;&nbsp;회원탈퇴</title>

		<%@include file="/WEB-INF/views/comm/plugIn1.jsp" %>

			<!-- CSS 파일 링크 -->
			<link rel="stylesheet" href="/css/common/header.css">

			<script>
				let msg = '${msg}';
				if (msg != '') {
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
							<h1 class="box-title mt-5" id="getMemberInfo" style="text-align: center; margin-bottom: 60px;">
								<b>탈퇴&nbsp;하기</b>
							</h1>
							<form role="form" id="deleteInfoForm" method="post" action="/member/info/delete">
								<div class="box-body">
									<div class="form-group row">
										<label for="us_id" class="col-2">아이디</label>
										<div class="col-10">
											<input type="text" class="form-control" name="us_id" id="us_id" placeholder="아이디를 입력해 주세요.">
										</div>
									</div>
									<div class="form-group row">
										<label for="us_pw" class="col-2">비밀번호</label>
										<div class="col-10">
											<input type="password" class="form-control" name="us_pw" id="us_pw" placeholder="비밀번호를 입력해 주세요.">
										</div>
									</div>
								</div>
								<div class="box-footer">
									<button type="button" class="btn btn-primary" id="btnCancel">취소</button>
									<button type="button" class="btn btn-danger" id="btnDelete">탈퇴</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<%@include file="/WEB-INF/views/comm/footer.jsp" %>
			</div>

			<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>

				<script>

					// jquery.slim.min.js 파일에 jQuery 명령어가 정의되어 있음
					// $(): JQuery() 함수 사용 별칭
					// ready(): 브라우저가 html 태그를 모두 읽고난 후에 동작하는 이벤트 메서드
					// JS 이벤트 등록: https://www.w3schools.com/js/js_htmldom_eventlistener.asp 
					$(document).ready(function () {

						let deleteInfoForm = $("#deleteInfoForm");

						// 취소 버튼 클릭 이벤트
						$("#btnCancel").click(function () {
							location.href = "/";
						});

						// 탈퇴 버튼 클릭 이벤트
						$("#btnDelete").click(function () {
							// e.preventDefault(); // button type="submit"인 경우 필요 

							let us_id = $("#us_id").val().trim();
							let us_pw = $("#us_pw").val().trim();

							if (!us_id) {
								alert("아이디를 입력해 주세요.")
								$("#us_id").focus();
								return;
							}
							if (!us_pw) {
								alert("비밀번호를 입력해 주세요.")
								$("#us_pw").focus();
								return;
							}

							if (confirm("데브데이를 정말로 탈퇴하시겠습니까?")) {
								deleteInfoForm.submit();
							}
						});
					});
				</script>

	</body>

	</html>