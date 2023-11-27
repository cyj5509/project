<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- JSTL Core태그 라이브러리 -->

		<!-- CSS 파일 링크 -->
		<link rel="stylesheet" href="/css/category_menu.css">

		<button class="hamburger-menu">
			<span></span>
			<span></span>
			<span></span>
		</button>

		<div id="category_menu">
			<ul class="nav justify-content-center" id="first_category">
				<!-- items="${firstCategoryList}": 1차 카테고리 목록 전부(GlobalControllerAdvice 참고) -->
				<!-- var="category": CategoryVO의 성격 -->
				<c:forEach items="${firstCategoryList}" var="category">
					<li class="nav-item">
						<!-- 1차 카테고리 표시 -->
						<!-- a 태그에 값을 숨기는 방법: href 또는 data- 속성 이용 -->
						<a class="nav-link active" href="#" data-cg_code="${category.cg_code}">${category.cg_name}</a>
						<!-- 2차 카테고리 드롭다운 -->
						<ul class="second-category" style="display: none;">
							<c:forEach items="${category.secondCategoryList}" var="subCategory">
								<li>${subCategory.cg_name}</li>
							</c:forEach>
						</ul>
					</li>
				</c:forEach>
			</ul>
		</div>

		<script src="/js/category_menu.js"></script>