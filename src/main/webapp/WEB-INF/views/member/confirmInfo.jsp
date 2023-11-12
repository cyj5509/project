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

			<script>
				let msg = '${msg}'; // ${msg}: MemberController의 rttr.addFlashAttribute("msg", msg);에서 앞의 "msg"
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
							<br>
							<h3 class="box-title">회원탈퇴 인증 확인</h3>
							<br>
							<form role="form" id="confirmInfoForm" method="post" action="/member/delete">
								<div class="box-body">
									<div class="form-group row">
										<label for="mbsp_id" class="col-2">아이디</label>
										<div class="col-10">
											<input type="text" class="form-control" name="mbsp_id" id="mbsp_id" placeholder="아이디 입력...">
										</div>
									</div>
									<div class="form-group row">
										<label for="mbsp_password" class="col-2">비밀번호</label>
										<div class="col-10">
											<input type="password" class="form-control" name="mbsp_password" id="mbsp_password"
												placeholder="비밀번호 입력...">
										</div>
									</div>
								</div>

								<div class="box-footer">
									<button type="submit" class="btn btn-primary" id="btnDelete">탈퇴하기</button>
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
						$("#btnDelete").click(function () {
							if (confirm("정말 탈퇴하시겠습니까?")) {
								$.ajax({
									url: "/member/delete",
									type: "post",
									data: { mem_id: $("#mem_id").val() }, // 로그인한 사용자의 ID를 전송
									success: function (response) {
										alert(response);
										location.href = "/";
									}
									// ,
									// error: function (xhr, status, error) {
									// 	alert("탈퇴 처리 중 오류가 발생했습니다.");
									// }
								});
							}
						});
					});
				</script>

	</body>

	</html>