<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- JSTL 문법 -->
		<!DOCTYPE html>
		<html lang="en">

		<head>
			<meta charset="utf-8">
			<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
			<meta name="description" content="">
			<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
			<meta name="generator" content="Hugo 0.101.0">
			<title>데브데이&#58;&nbsp;회원수정</title>

			<%@include file="/WEB-INF/views/comm/plugIn1.jsp" %>

				<!-- CSS 파일 링크 -->
				<link rel="stylesheet" href="/css/common/header.css">
				<!-- <link rel="stylesheet" href="/css/member/login.css"> -->

				<style>
					input[readonly] {
						background-color: white !important;
					}
				</style>

				<script>
					// jQuery의 $(document).ready(function () { ... });과 동일한 역할
					document.addEventListener('DOMContentLoaded', (event) => {
						let msg = '${msg}';
						if (msg == 'pwError') {
							alert("회원가입 시 작성했던 비밀번호와 일치하지 않습니다. 다시 입력해 주세요.");
							$("input[name='currentPw']").val("");
							$("input[name='currentPw']").focus();
						}
					});
				</script>

		</head>

		<body>

			<%@include file="/WEB-INF/views/comm/header.jsp" %>

				<div class="container">
					<div class="text-center">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h1 class="box-title mt-5" id="getMemberInfo" style="text-align: center; margin-bottom: 60px;">
									<b>정보&nbsp;수정</b>
								</h1>
								<div style="text-align: right; color: red; font-weight: bold; margin-bottom: 15px;">
									&#42;&nbsp;✔는&nbsp;변경&nbsp;불가
								</div>
								<form role="form" id="modifyInfoForm" method="post" action="/member/info/modify">
									<div class="box-body">
										<div class="login-info">
											<div class="form-group row">
												<label for="us_id" class="col-2">아이디✔</label>
												<div class="col-10">
													<input type="text" class="form-control" name="us_id" id="us_id" value="${us_vo.us_id}"
														readonly>
												</div>
											</div>
											<div class="form-group row">
												<label for="currentPw" class="col-2">비밀번호</label>
												<div class="col-10">
													<input type="password" class="form-control" name="currentPw" placeholder="현재 비밀번호를 입력해 주세요.">
												</div>
											</div>
										</div>
										<div class="member-info">
											<div class="form-group row">
												<label for="us_name" class="col-2">이름✔</label>
												<div class="col-10">
													<input type="text" class="form-control" name="us_name" id="us_name" value="${us_vo.us_name}"
														readonly>
												</div>
											</div>
											<div class="form-group row">
												<label for="us_phone" class="col-2">전화번호</label>
												<div class="col-2">
													<select class="form-control" name="us_phone_prefix" id="us_phone_prefix">
														<option value="010">010</option>
														<option value="011">011</option>
														<option value="016">016</option>
														<option value="017">017</option>
														<option value="018">018</option>
														<option value="019">019</option>
													</select>
												</div>
												<div class="col-8">
													<input type="text" class="form-control" name="us_phone" id="us_phone"
														value="${us_vo.us_phone}" placeholder="나머지 번호를 '-' 없이 입력해 주세요.">
												</div>
											</div>
											<div class="form-group row">
												<label for="us_email" class="col-2">이메일✔</label>
												<div class="col-10">
													<input type="email" class="form-control" name="us_email" id="us_email"
														value="${us_vo.us_email}" readonly>
												</div>
											</div>
											<div class="form-group row">
												<label for="sample2_postcode" class="col-2">우편번호</label>
												<div class="col-8">
													<input type="text" class="form-control" name="us_postcode" id="sample2_postcode"
														value="${us_vo.us_postcode}" placeholder="우편번호를 입력해 주세요.">
												</div>
												<div class="col-2">
													<button type="button" onclick="sample2_execDaumPostcode()" class="btn btn-outline-info">우편번호
														찾기</button>
												</div>
											</div>
											<div class="form-group row">
												<label for="sample2_address" class="col-2">기본 주소</label>
												<div class="col-5">
													<input type="text" class="form-control" name="us_addr_basic" id="sample2_address"
														value="${us_vo.us_addr_basic}" placeholder="기본 주소를 입력해 주세요.">
												</div>
												<div class="col-5">
													<input type="text" class="form-control" name="us_addr_detail" id="sample2_detailAddress"
														value="${us_vo.us_addr_detail}" placeholder="상세 주소를 입력해 주세요.">
													<input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
												</div>
											</div>
											<div class="box-footer">
												<button type="button" class="btn btn-success" id="btnSave">저장</button>
												<button type="button" class="btn btn-secondary" id="btnCancel">취소</button>
											</div>
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

								let us_phone = $("#us_phone").val(); // 서버에서 전달받은 전화번호
								if (us_phone.length >= 10) {
									let prefix = us_phone.substring(0, 3); // 전화번호 앞자리 추출
									let rest = us_phone.substring(3); // 나머지 번호 추출

									// 전화번호 앞자리 선택
									$("#us_phone_prefix").val(prefix);

									// 나머지 번호 설정
									$("#us_phone").val(rest);
								}

								// 취소 버튼 클릭 이벤트
								$("#btnCancel").click(function () {
									location.href = "/member/myPage";
								});

								// 저장 버튼 클릭 이벤트
								$("#btnSave").click(function () {

									// form 태그 참조: <form role="form" id="modifyInfoForm" method="post" action="/member/modifyInfo">
									let modifyInfoForm = $("#modifyInfoForm");
									let currentPw = $("input[name='currentPw']").val().trim();
									let us_phone = $('#us_phone').val().trim();
									let sample2_postcode = $('#sample2_postcode').val().trim();
									let sample2_address = $('#sample2_address').val().trim();
									let sample2_detailAddress = $('#sample2_detailAddress').val().trim();

									// 나머지 번호에 해당하는 부분을 숫자만 가능하게끔 처리
									let regexPhone = /^\d{7,8}$/; // 전화번호 검사식

									if (!currentPw) {
										alert("회원정보를 수정하려면 비밀번호를 입력해 주세요.");
										$("input[name='currentPw']").focus();
										return;
									}
									if (!us_phone) {
										alert("전화번호를 입력해 주세요.");
										$('#us_phone').focus();
										return;
									}
									// 전화번호 유효성 검사
									if (!regexPhone.test(us_phone)) {
										alert("전화번호는 앞자리를 제외한 나머지 7~8자의 숫자만 입력해야 합니다.");
										$('#us_phone').val('');
										$('#us_phone').focus();
										return;
									}
									if (!sample2_postcode) {
										alert("우편번호를 입력해 주세요.");
										$('#sample2_postcode').focus();
										return;
									}
									if (!sample2_address) {
										alert("기본주소를 입력해 주세요.");
										$('#sample2_address').focus();
										return;
									}
									if (!sample2_detailAddress) {
										alert("상세주소를 입력해 주세요.");
										$('#sample2_detailAddress').focus();
										return;
									}

									// 폼 전송 작업(스프링 작업 이후)
									modifyInfoForm.submit();
								});

							}); // ready-end
						</script>

		</body>

		</html>