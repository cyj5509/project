<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <div class="header-container">
                <!-- 메뉴바 -->
                <div class="nav-links">
                    <!-- 로그인 상태에 따른 메뉴바 -->
                    <c:if test="${sessionScope.loginStatus == null}">
                        <a href="/member/login" class="nav-item">로그인</a>
                        <a href="/member/join" class="nav-item">회원가입</a>
                    </c:if>
                    <c:if test="${sessionScope.loginStatus != null}">
	                    <c:if test="${sessionScope.isAdmin}">
	                    	<a href="/admin/intro" class="nav-item">[Admin]</a>
	                    </c:if>
                        <a href="/member/logout" class="nav-item">로그아웃(${sessionScope.loginStatus.mem_id} 님)</a>
                        <a href="/member/confirmPw" class="nav-item">회원수정</a>
                    </c:if>
                        <a href="/member/myPage" class="nav-item">마이페이지</a>
                        <a href="#" class="nav-item">주문조회</a>
                        <a href="#" class="nav-item">장바구니</a>
                    	<a href="/user/community" class="nav-item">커뮤니티</a>
					
                    
                </div>

                <!-- 상단 로고 및 정보 행 -->
                <div class="header-top-row">
                    <!-- 로고와 상호명 -->
                    <div class="header-logo">
                        <a href="/">
                            <img src="/images/devday_logo.png" class="img-fluid" />
                        </a>
                        <h3 class="my-0" style="margin-left: 10px;">DevDay</h3>
                    </div>
                    <!-- 환영인사 및 최근 접속시간 -->
                    <div class="header-info-section">
                        <c:if test="${sessionScope.loginStatus != null}">
                            <b>최근 접속일자:
                                <fmt:formatDate value="${sessionScope.loginStatus.mem_lastlogin}"
                                    pattern="yyyy-MM-dd HH:mm:ss" />
                            </b>
                        </c:if>
                    </div>
                </div>
            </div>
