<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!-- JSTL Core태그 라이브러리 -->
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <table class="table table-sm">
                <caption style="display: table-caption; text-align: center; color: red; font-weight: bold;">
                    [주문상세 정보]</caption>
                <thead>
                    <tr>
                        <th scope="col">주문번호</th>
                        <th scope="col">상품코드</th>
                        <th scope="col">상품이미지</th>
                        <th scope="col">상품명</th>
                        <th scope="col">주문수량</th>
                        <th scope="col">주문금액</th>
                        <th scope="col">비고</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- ${orderProductList}: Model로 전달한 값, orderProductVO는 OrderDetailProductVO를 가리킴 -->
                    <c:forEach items="${orderProductList}" var="orderProductVO">
                        <tr>
                            <th scope="row">${orderProductVO.orderDetailVO.od_number}</th>
                            <td>${orderProductVO.productVO.pd_number}</td>
                            <td><img
                                    src="/admin/order/imageDisplay?dateFolderName=${orderProductVO.productVO.pd_image_folder}&fileName=${orderProductVO.productVO.pd_image}">
                            </td>
                            <td>${orderProductVO.productVO.pd_name}</td>
                            <td>${orderProductVO.orderDetailVO.od_amount}</td>
                            <td>${orderProductVO.orderDetailVO.od_amount * orderProductVO.productVO.pd_price}</td>
                            <!-- 두 개의 기본키 성격을 가지는 데이터를 복합키로 설정한 경우 두 개의 데이터를 모두 사용해야 한다. -->
                            <!-- od_number만 사용 시 상품 일부 삭제가 아닌 전체 삭제, pd_number만 사용 시 타인의 주문까지 삭제 -->
                            <td><button type="button" name="btn_order_delete" class="btn btn-danger"
                                    data-od_number="${orderProductVO.orderDetailVO.od_number}"
                                    data-pd_number="${orderProductVO.productVO.pd_number}">delete</button></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>