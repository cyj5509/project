<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.101.0">
<title>DevDay</title>

<%@include file="/WEB-INF/views/comm/plugIn1.jsp"%>

<style>
.bd-placeholder-img {
    font-size: 1.125rem;
    text-anchor: middle;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

@media (min-width: 768px) {
    .bd-placeholder-img-lg {
        font-size: 3.5rem;
    }
}

.carousel-control-prev,
.carousel-control-next {
    display: block;
    top: 62.5%;
    transform: translateY(-50%);
}

.carousel-control-prev {
    left: 0;
}

.carousel-control-next {
    right: 0;
}

.custom-btn {
    border: 2px solid black;
    background-color: rgba(192, 192, 192, 0.5);
    color: black;
    transition: background-color 0.3s ease;
}

.custom-btn:hover {
    background-color: black;
    color: white;
}
.carousel-item img {
    opacity: 0.7;
}

.carousel-caption h2,
.carousel-caption p {
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
}
</style>

</head>
<body>

	<%@include file="/WEB-INF/views/comm/header.jsp"%>
	
	<!-- Begin page content -->
	<main role="main" class="flex-shrink-0">
	  <div class="container">
	   	<section>
	   		<div class="row"> <!-- 합이 12까지 사용 가능. 반드시 고정될 필요는 없음 -->
	   			<!-- <div class="col-해상도-숫자"></div>  -->
	   			<div class="col-md-12">
		   			<div class="box box-primary">
						<div class="box-header with-border">
							<h2 class="box-title" style="margin: 20px;">조회하기</h2>
						</div>
						
						<div class="box-body"><br />
							<div class="form-group row">
								<label for="bd_number" class="col-2">No.</label>
								<div class="col-4">
									<input type="text" class="form-control" name="bd_number" id="bd_number"
										value="${board.bd_number}" readonly="readonly">
								</div>
								<label for="us_id" class="col-2">작성자</label>
								<div class="col-4">
									<input type="text" class="form-control" name="us_id" id="us_id"
										value="${board.us_id}" readonly>
								</div>
							</div>
							
							<div class="form-group">
								<label for="bd_title">제목</label>
								<!-- readonly="readonly"와 같이 속성명과 값이 같은 경우 값을 생략할 수 있다. -->
								<input type="text" class="form-control" name="bd_title" id="bd_title" value="${board.bd_title}" readonly>
							</div>
							<div class="form-group">
								<label for="bd_content">내용</label>
								<input type="text" class="form-control" name="bd_content" value="${board.bd_content}"
									style="height: 500px; width: 100%;" readonly="readonly">
							</div>
							<div class="form-group row">
								<label for="bd_register_date" class="col-2">등록일</label>
								<div class="col-4">
									<input type="text" class="form-control" name="bd_register_date" id="bd_register_date" value='<fmt:formatDate value="${board.bd_register_date}" pattern="yyyy년 MM월 dd일 HH시 mm분" />' readonly>
								</div>
								<label for="bd_update_date" class="col-2">수정일</label>
								<div class="col-4">
									<input type="text" class="form-control" name="bd_update_date" id="bd_update_date" value='<fmt:formatDate value="${board.bd_update_date}" pattern="yyyy년 MM월 dd일 HH시 mm분" />' readonly>
								</div>	
							</div>
						</div>
						<br />
						<div class="box-footer">
							<!-- BoardController의 @ModelAttribute("cri") Criteria cri -->
							<!-- Modify, Delete, List 버튼 클릭 시 아래 form 태그를 전송-->
							<form id="curListInfo" action="" method="get">
								<input type="hidden" name="pageNum" id="pageNum" value="${cri.pageNum}" />
								<input type="hidden" name="amount" id="amount" value="${cri.amount}" />
								<input type="hidden" name="type" id="type" value="${cri.type}" />
								<input type="hidden" name="keyword" id="keyword" value="${cri.keyword}" />
								<input type="hidden" name="bd_number" id="bd_number" value="${board.bd_number}" />
							</form>
							<button type="button" id="btn_modify" class="btn btn-primary">수정</button>
							<button type="button" id="btn_delete" class="btn btn-primary">삭제</button>
							<button type="button" id="btn_list" class="btn btn-primary">목록</button>
						</div>
						
					</div>	
	   			</div>
	   		</div>
	   	</section>
	  </div>
	</main>

	<footer class="footer mt-auto py-3">
		<%@include file="/WEB-INF/views/comm/footer.jsp" %>
	</footer>
	
		<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>
	
	<script>

		// <form id="curListInfo" action="" method="get">를 참조
		let curListInfo = document.getElementById("curListInfo");

		// 수정 버튼 클릭
		// document.getElementById("btn_modify").addEventListener("click", 함수명);
		document.getElementById("btn_modify").addEventListener("click", fn_modify);

		function fn_modify() {
			// alert('수정');

			// location.href = "/user/board/modify?bno=${board.bno}"; // location.href = "URL 매핑 주소";
			curListInfo.setAttribute("action", "/user/board/modify"); // /user/board/list -> /user/board/get 전송
			curListInfo.submit(); 
		}

		// 삭제 버튼 클릭
		document.getElementById("btn_delete").addEventListener("click", fn_delete); // 괄호는 제외

		function fn_delete() {

			if(!confirm("삭제를 하시겠습니까?")) return;
			// 페이지(주소) 이동
			// location.href = "/user/board/delete?bno=${board.bno}";
			curListInfo.setAttribute("action", "/user/board/delete"); // /user/board/list -> /user/board/get 전송
			curListInfo.submit(); 
		}

		// 리스트 클릭
		document.getElementById("btn_list").addEventListener("click", fn_list); // 괄호는 제외

			function fn_list() {

				curListInfo.setAttribute("action", "/user/board/list"); // /user/board/list -> /user/board/get 전송
				curListInfo.submit(); 
			}
	</script>
	
	<%@include file="/WEB-INF/views/comm/plugIn2.jsp"%>
	
</body>
</html>
