<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- JSTL Core태그 라이브러리 -->


		<!doctype html>
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
					let msg = '${msg}';
					if (msg == 'success') {
						alert("회원정보가 수정되었습니다.");
					}
				</script>
		</head>

		<body>

			<%@include file="/WEB-INF/views/comm/header.jsp" %>
				<%@include file="/WEB-INF/views/comm/category_menu.jsp" %>

					<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
						<h1 class="display-4">DevDay</h1>
						<p class="lead"></p>
					</div>

					<div class="container">
						<div class="card-deck mb-3 text-center">
							<div class="card mb-4 shadow-sm">
								<div class="card-header">
									<h4 class="my-0 font-weight-normal">Free</h4>
								</div>
								<div class="card-body">
									<h1 class="card-title pricing-card-title">
										$0 <small class="text-muted">/ mo</small>
									</h1>
									<ul class="list-unstyled mt-3 mb-4">
										<li>10 users included</li>
										<li>2 GB of storage</li>
										<li>Email support</li>
										<li>Help center access</li>
									</ul>
									<button type="button" class="btn btn-lg btn-block btn-outline-primary">Sign up
										for free</button>
								</div>
							</div>
							<div class="card mb-4 shadow-sm">
								<div class="card-header">
									<h4 class="my-0 font-weight-normal">Pro</h4>
								</div>
								<div class="card-body">
									<h1 class="card-title pricing-card-title">
										$15 <small class="text-muted">/ mo</small>
									</h1>
									<ul class="list-unstyled mt-3 mb-4">
										<li>20 users included</li>
										<li>10 GB of storage</li>
										<li>Priority email support</li>
										<li>Help center access</li>
									</ul>
									<button type="button" class="btn btn-lg btn-block btn-primary">Get
										started</button>
								</div>
							</div>
							<div class="card mb-4 shadow-sm">
								<div class="card-header">
									<h4 class="my-0 font-weight-normal">Enterprise</h4>
								</div>
								<div class="card-body">
									<h1 class="card-title pricing-card-title">
										$29 <small class="text-muted">/ mo</small>
									</h1>
									<ul class="list-unstyled mt-3 mb-4">
										<li>30 users included</li>
										<li>15 GB of storage</li>
										<li>Phone and email support</li>
										<li>Help center access</li>
									</ul>
									<button type="button" class="btn btn-lg btn-block btn-primary">Contact
										us</button>
								</div>
							</div>
						</div>

						<%@include file="/WEB-INF/views/comm/footer.jsp" %>

					</div>

					<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>

						<!-- 카테고리 메뉴 자바스크립트 작업 소스-->
						<script src="/js/category_menu.js"></script>

		</body>

		</html>