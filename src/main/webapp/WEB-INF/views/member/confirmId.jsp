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

	</head>

	<body>

		<%@include file="/WEB-INF/views/comm/header.jsp" %>

			<div class="container login-container">
				<div class="text-center">
					<div class="box box-primary login-box">
						<div class="box-header with-border">
							<h3 class="box-title login-title">비밀번호를 찾고자 하는 아이디를 입력하세요</h3>
							<form role="form" id="confirmIdForm" method="post" action="/member/confirmId">
								<div class="box-body">
								<div class="form-group">
										<div >
											<input type="text" class="form-control" name="mem_id" id="mem_id" placeholder="아이디를 입력해주세요">
										</div>
									</div>
				
								</div>
								<div class="box-footer">
									<button type="button" class="btn btn-primary login-btn" id="btnConfirmId">다음</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>

			<%@include file="/WEB-INF/views/comm/footer.jsp" %>
				<%@include file="/WEB-INF/views/comm/postCode.jsp" %>
					<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>


		<script>
		$(document).ready(function () {

			let msg = '${msg}'; // ${msg}: MemberController의 rttr.addFlashAttribute("msg", msg);에서 앞의 "msg"
			
			let mem_id = $("#mem_id");
			let confirmIdForm = $("#confirmIdForm");

			$("#btnConfirmId").click(function () {
				if (mem_id.val() == "") {
					alert("아이디가 입력되지 않았습니다.");
					mem_id.focus();
					return;
				} 
				$.ajax({
					url: '/member/confirmId',
					type: 'post', 
					dataType: 'text',
					data: {mem_id: mem_id.val()}, 
					success: function (response) { 
						// 서버: 해당 아이디의 존재 여부만 확인 <-> 클라이언트: 다음 단계로의 페이지 이동을 처리
						// submit()은 서버에서 데이터 처리가 필요할 때. window.location.href는 단순 페이지 이동
						if (response == "yes") {
							location.href = "/member/findPw"; // 아이디가 존재하면, 비밀번호 찾기 페이지로 이동
							// confirmIdForm.submit();
						} else if (response == "no"){
							alert("존재하지 않는 아이디입니다.");
						}
					}
				});
			});
		});
		</script>
	</body>

	</html>