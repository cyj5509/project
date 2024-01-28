<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <div class="header-container">
                <!-- 메뉴바 -->
                <div class="nav-links">
                    <!-- 로그인 상태에 따른 메뉴바 -->
                    <c:if test="${sessionScope.userStatus == null}">
                        <a href="/member/login" class="nav-item">로그인</a>
                        <a href="/member/join" class="nav-item">회원가입</a>
                    </c:if>
                    <c:if test="${sessionScope.userStatus != null}">
                        <a href="/member/logout" class="nav-item">로그아웃(${sessionScope.userStatus.us_id}님)</a>
                    </c:if>
                    <a href="/member/my_page" class="nav-item">마이페이지</a>
                    <a href="/user/cart/cart_list" class="nav-item">장바구니</a>
                    <a href="/user/order/order_info" class="nav-item">주문조회</a>
                    <a href="/user/board/list" class="nav-item">커뮤니티</a>
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
                        <c:if test="${sessionScope.userStatus != null}">
                            <b>최근 접속 일자:
                                <fmt:formatDate value="${sessionScope.userStatus.us_last_login}"
                                    pattern="yyyy-MM-dd HH:mm:ss" />
                            </b>
                            <c:if test="${not empty sessionScope.adminStatus}">
                                <a href="/admin/ad_menu" class="admin-section">[관리자 페이지]</a>
                            </c:if>
                        </c:if>
                    </div>
                </div>
            </div>