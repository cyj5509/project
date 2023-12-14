<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!-- pom.xml의 jstl 라이브러리 -->
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>     

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
				<link rel="stylesheet" href="/css/common/header.css">
				<link rel="stylesheet" href="/css/main.css">

				<script>
					let msg = '${msg}';
					if (msg == 'modify') {
						alert("회원정보가 정상적으로 수정되었습니다.");
					} else if (msg == "delete") {
						alert("회원탈퇴가 정상적으로 처리되었습니다.");
					}
				</script>
		</head>

		<body>

			<%@include file="/WEB-INF/views/comm/header.jsp" %>

				<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
					<h1 class="display-4">DevDay</h1>
					<p class="lead"></p>
				</div>

				<div id="myCarousel" class="carousel slide pointer-event" data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class=""></li>
						<li data-target="#myCarousel" data-slide-to="1" class=""></li>
						<li data-target="#myCarousel" data-slide-to="2" class="active"></li>
					</ol>
					<div class="carousel" style="width: 100%; overflow: hidden;">
						<div class="carousel-inner">
							<div class="carousel-item active">
								<img src="/images/goods.jpg" alt="Books"
									style="width: 100%; height: auto; max-height: 475px;">
								<div class="container">
									<div class="carousel-caption">
										<h2>개발자를 위한 다양한 상품</h2>
										<p>IT와 관련된 서적을 포함한 여러 상품을 판매합니다!</p>
										<p><a class="btn btn-lg btn-outline-dark custom-btn" href="/user/product/pd_list">더 알아보기</a></p>
									</div>
								</div>
							</div>
							<div class="carousel-item">
								<img src="/images/event.jpg" alt="Conference"
									style="width: 100%; height: auto; max-height: 475px;">
								<div class="container">
									<div class="carousel-caption">
										<h2>개발자를 위한 다양한 행사</h2>
										<p>각종 세미나, 컨퍼런스 등의 일정을 살펴볼 수 있습니다!</p>
										<p><a class="btn btn-lg btn-outline-dark custom-btn" href="#">더 알아보기</a></p>
									</div>
								</div>
							</div>
							<div class="carousel-item">
								<img src="/images/community.jpg" alt="Teamwalk"
									style="width: 100%; height: auto; max-height: 475px;">
								<div class="container">
									<div class="carousel-caption">
										<h2>개발자를 위한 다양한 정보와 각종 모임</h2>
										<p>스터디 등의 팀원을 모집하거나 여러 정보를 살펴볼 수 있습니다!</p>
										<p><a class="btn btn-lg btn-outline-dark custom-btn" href="/user/board/list">더 알아보기</a></p>
									</div>
								</div>
							</div>
						</div>
					</div>
					<a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a>
					<a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>

					<br />
					<!-- 기존 코드 -->
					<div class="container">
						<%@include file="/WEB-INF/views/comm/footer.jsp" %>
					</div>
					<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>


		</body>

		</html>