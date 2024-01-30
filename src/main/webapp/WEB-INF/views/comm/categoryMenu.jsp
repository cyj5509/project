<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- JSTL Core태그 라이브러리 -->

		<div id="hamburger_menu">
			<div id="hamburger_icon">☰</div>
			<div id="menu_links">
				<a href="/user/product/usProductList">전체상품</a>
				<a href="#">베스트</a>
				<a href="#">신상품</a>
			</div>
		</div>
		<div id="category_menu">
			<ul class="nav justify-content-start" id="first_category">
				<!-- items="${firstCategoryList}": 1차 카테고리 목록 전부(GlobalControllerAdvice 참고) -->
				<!-- var="category": CategoryVO의 성격 -->
				<!-- 1차 카테고리 표시. GlobalControllerAdvice -->
				<c:forEach items="${firstCategoryList}" var="category">
					<li class="categoryNavbar">
						<!-- 1차 카테고리 표시 -->
						<!-- a 태그에 값을 숨기는 방법: href 또는 data- 속성 이용 -->
						<a class="nav-link active" href="#" data-cg_code="${category.cg_code}">${category.cg_name}</a>
					</li>
				</c:forEach>
			</ul>

		</div>