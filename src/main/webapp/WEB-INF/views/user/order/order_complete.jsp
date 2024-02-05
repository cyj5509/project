<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- JSTL Core태그 라이브러리 -->
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
			<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

				<!doctype html>
				<html lang="en">

				<head>
					<meta charset="utf-8">
					<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
					<meta name="description" content="">
					<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
					<meta name="generator" content="Hugo 0.101.0">
					<title>데브데이:&nbsp;주문조회</title>

					<%@include file="/WEB-INF/views/comm/plugIn1.jsp" %>

					<!-- CSS 파일 링크 -->
					<link rel="stylesheet" href="/css/common/header.css">
											
				</head>

				<body>

					<%@include file="/WEB-INF/views/comm/header.jsp" %>

						<h1 class="box-title mt-5" style="text-align: center; margin-bottom: 40px;">
							<b>주문 정보</b>
						</h1>
						<div class="container">
							<div class="box box-primary">
								<div class="box-body">
									<h3>주문 및 결제가 완료되었습니다.</h3>
								</div>
							</div>
							<%@include file="/WEB-INF/views/comm/footer.jsp" %>
						</div> <!-- container 닫는 태그 -->

						<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>

				</body>

				</html>