<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!-- JSTL Core 라이브러리 -->
    <!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
    <html>

    <head>
      <meta charset="utf-8" />
      <meta http-equiv="X-UA-Compatible" content="IE=edge" />
      <title>데브데이&#40;관리자&#41;&#58;&nbsp;주문조회</title>
      <!-- Tell the browser to be responsive to screen width -->
      <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />

      <!-- CSS 파일 링크 -->
			<link rel="stylesheet" href="/css/admin/common/mainText.css">

      <style>
        #orderSearchForm select,
        #orderSearchForm input[type="text"],
        #orderSearchForm input[type="date"],
        #orderSearchForm button {
          height: 35px;
          /* 높이 설정 */
          padding: 5px 10px;
          /* 내부 여백 설정 */
          font-size: 14px;
          /* 글자 크기 설정 */
          border: 1px solid #ccc;
          /* 테두리 설정 */
          vertical-align: middle;
          /* 수직 정렬 */
        }

        .box-body .order-table th,
        .box-body .order-table td {
          vertical-align: middle;
          /* 셀의 내용을 수직 중앙에 정렬 */
          text-align: center;
          /* 텍스트를 가운데 정렬 */
        }

        .box-body .order-table th {
          background-color: lightslategray;
          color: whitesmoke;
          font-size: 15px;
          font-weight: bold;
        }

        .box-body .order-table td {
          height: 35px;
          /* 높이 설정 */
          padding: 5px 10px;
          /* 내부 여백 설정 */
          font-size: 14px;
          /* 글자 크기 설정 */
          border: 1px solid #ccc;
          /* 테두리 설정 */
          vertical-align: middle;
        }

        /* Important part */
        .modal-content {
          overflow-y: initial !important;
        }

        .modal-body {
          height: 250px;
          overflow-y: auto;
        }
      </style>

      <%@ include file="/WEB-INF/views/admin/include/plugin1.jsp" %>

        <!-- Handlebars(자바스크립트 템플릿 엔진): 서버에서 보내온 JSON 형태의 데이터를 사용하여 작업을 편하게 할 수 있는 특징 -->
        <script src="/js/handlebars.js"></script>
        <script id="orderDetailTemplate" type="text/x-handlebars-template">

          <tr class="tr_detail_info">
            <td colspan="9">
              <table class="table table-sm">
                <caption style="display: table-caption; text-align: center; color: red; font-weight: bold;">[주문상세 정보]</caption>
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
                  {{#each .}}
                  <tr>
                    <th scope="row">{{od_number}}</th>
                    <td>{{pd_number}}</td>
                    <td>
                      <img src='/admin/order/imageDisplay?dateFolderName={{pd_image_folder}}&fileName={{pd_image}}'
                        width="100px" height="200px">
                    </td>
                    <td>{{pd_name}}</td> 
                    <td>{{od_amount}}</td>
                    <td>{{od_price}}</td>
                    <!-- 두 개의 기본키 성격을 가지는 데이터를 복합키로 설정한 경우 두 개의 데이터를 모두 사용해야 한다. -->
                    <!-- od_number 사용 시 상품 일부 삭제가 아닌 전체 삭제, pd_number 사용 시 타인의 주문까지 삭제 -->
                    <td><button type="button" name="btn_order_delete" class="btn btn-danger" data-od_number="{{od_number}}" data-pd_number="{{pd_number}}">delete</button></td>
                  </tr>
                  {{/each}}
                </tbody>
              </table>
          </td>
        </tr>
      </script>
    </head>
    <!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->

    <body class="hold-transition skin-blue sidebar-mini">
      <div class="wrapper">
        <!-- Main Header -->
        <%@ include file="/WEB-INF/views/admin/include/header.jsp" %>

          <!-- Left side column. contains the logo and sidebar -->
          <%@ include file="/WEB-INF/views/admin/include/nav.jsp" %>

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
              <!-- Content Header (Page header) -->
              <section class="content-header">
                <h1 style="font-weight: bold;">관리자 페이지 ─ 주문 목록</h1>
                <ol class="breadcrumb">
                  <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
                  <li class="active">Here</li>
                </ol>
              </section>

              <!-- Main content -->
              <section class="content container-fluid">
                <div class="row">
                  <!-- 합이 12까지 사용 가능. 반드시 고정될 필요는 없음 -->
                  <!-- <div class="col-해상도-숫자"></div>  -->
                  <div class="col-md-12">
                    <div class="box">
                      <div class="box-header with-border">
                        <h2 class="box-title">Order List</h2>
                      </div>

                      <div class="box-body">
                        <div style="text-align: right;">
                          <form action="/admin/order/orderList" method="get" id="orderSearchForm">
                            <select name="type" id="type">
                              <option value="" selected>&#45;&#45;&#45; 검색 종류 선택 &#45;&#45;&#45;</option>
                              <option value="N" ${pageMaker.cri.type=='N' ? 'selected' : '' }>주문자</option>
                              <option value="C" ${pageMaker.cri.type=='C' ? 'selected' : '' }>주문코드</option>
                            </select>
                            <input type="text" name="keyword" id="keyword" value="${pageMaker.cri.keyword}"
                              placeholder="검색 키워드 입력" />
                            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
                            <input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
                            <input type="date" name="start_date" value="${start_date}" style="text-align: center;">
                              &nbsp;&#126;&nbsp;
                            <input type="date" name="end_date" value="${end_date}" style="text-align: center;">
                            <button type="submit" class="btn btn-primary" id="btn_orderSearch">검색</button>
                          </form>
                        </div><br />
                        <table class="table table-bordered order-table" id="order_info_tbl">
                          <tbody>
                            <tr>
                              <th style="width: 10%">주문번호</th>
                              <th style="width: 10%">주문자</th>
                              <th style="width: 10%">주문일시</th>
                              <th style="width: 10%">주문상태</th>
                              <th style="width: 10%">결제상태</th>
                              <th style="width: 10%">배송비</th>
                              <th style="width: 20%">주문금액</th>
                              <th style="width: 20%">비고</th>
                            </tr>
                            <!-- BoardController에서 작성한 이름과 동일한 이름을 items로 작성 -->
                            <!-- 목록이 출력되는 부분 -->
                            <c:forEach items="${list}" var="ob_vo">
                              <tr>
                                <td><span class="btn_order_detail">${ob_vo.od_number}</span></td>
                                <td>${ob_vo.od_name}</td>
                                <td>
                                  <fmt:formatDate value="${ob_vo.od_pay_date}" pattern="yyyy-MM-dd hh:mm:ss" />
                                </td>
                                <td>${ob_vo.od_status}</td>
                                <td>${ob_vo.pm_status}</td>
                                <td>
                                  <fmt:formatNumber value="2500" groupingUsed="true" />원
                                </td>
                                <td>
                                  <fmt:formatNumber value="${ob_vo.od_total_price}" groupingUsed="true" />원
                                </td>
                                <td>
                                  <button type="button" class="btn btn-info btn_order_detail1"
                                    data-od_number="${ob_vo.od_number}">주문상세1</button>
                                  <button type="button" class="btn btn-info btn_order_detail2"
                                    data-od_number="${ob_vo.od_number}">주문상세2</button>
                                </td>
                              </tr>
                            </c:forEach>
                          </tbody>
                        </table>
                      </div>
                      <div class="box-footer clearfix">
                        <div class="row">
                          <div class="col-md-3">
                            <!-- <form id="actionForm">의 용도 -->
                            <!-- 1) 페이지 번호([이전] 1 2 3 4 5 ... [다음])를 클릭할 때 사용 -->
                            <!-- 2) 목록에서 상품 이미지 또는 상품명을 클릭할 때 사용 -->
                            <form id="actionForm" action="" method="get"> <!-- JS에서 자동 입력 -->
                              <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
                              <input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
                              <input type="hidden" name="type" value="${pageMaker.cri.type}" />
                              <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}" />
                            </form>
                          </div>
                          <div class="col-md-6 text-center">
                            <nav aria-label="...">
                              <ul class="pagination">
                                <!-- 맨 처음 표시 여부 -->
                                <c:if test="${pageMaker.foremost}">
                                  <li class="page-item">
                                    <a href="${pageMaker.startPage}" class="page-link movepage">처음</a>
                                  </li>
                                </c:if>
                                <!-- 이전 표시 여부 -->
                                <c:if test="${pageMaker.prev}">
                                  <li class="page-item">
                                    <a href="${pageMaker.startPage - 1}" class="page-link movepage">이전</a>
                                  </li>
                                </c:if>
                                <!-- 페이지 번호 출력 작업 -->
                                <!--  1 2 3 4 5 6 7 8 9 10 [다음] -->
                                <!--  [이전] 11 12 13 14 15 16 17 18 19 20 [다음] -->
                                <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="number">
                                  <li class='page-item ${pageMaker.cri.pageNum == number ? "active" : "" }'
                                    aria-current="page">
                                    <a class="page-link movepage" href="${number}" data-page="${number}">${number}</a>
                                    <!-- 임의로 만든 클래스명 movepage는 페이지 번호와 관련 -->
                                  </li>
                                </c:forEach>
                                <!-- 다음 표시 여부 -->
                                <c:if test="${pageMaker.next}">
                                  <li class="page-item">
                                    <a href="${pageMaker.endPage + 1}" class="page-link movepage">다음</a>
                                  </li>
                                </c:if>
                                <!-- 맨 끝 표시 여부 -->
                                <c:if test="${pageMaker.rearmost}">
                                  <li class="page-item">
                                    <a href="${pageMaker.readEnd}" class="page-link movepage">끝</a>
                                  </li>
                                </c:if>
                              </ul>
                            </nav>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </section>

              <!--------------------------
        | Your Page Content Here |
        -------------------------->

              <!-- /.content -->
            </div>
            <!-- /.content-wrapper -->

            <!-- Main Footer -->
            <%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>

              <!-- Control Sidebar -->
              <aside class="control-sidebar control-sidebar-dark">
                <!-- Create the tabs -->
                <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
                  <li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i
                        class="fa fa-home"></i></a></li>
                  <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
                </ul>
                <!-- Tab panes -->
                <div class="tab-content">
                  <!-- Home tab content -->
                  <div class="tab-pane active" id="control-sidebar-home-tab">
                    <h3 class="control-sidebar-heading">Recent Activity</h3>
                    <ul class="control-sidebar-menu">
                      <li>
                        <a href="javascript:;"><i class="menu-icon fa fa-birthday-cake bg-red"></i>
                          <div class="menu-info">
                            <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>
                            <p>Will be 23 on April 24th</p>
                          </div>
                        </a>
                      </li>
                    </ul>
                    <!-- /.control-sidebar-menu -->

                    <h3 class="control-sidebar-heading">Tasks Progress</h3>
                    <ul class="control-sidebar-menu">
                      <li>
                        <a href="javascript:;">
                          <h4 class="control-sidebar-subheading">Custom Template Design
                            <span class="pull-right-container">
                              <span class="label label-danger pull-right">70%</span>
                            </span>
                          </h4>
                          <div class="progress progress-xxs">
                            <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
                          </div>
                        </a>
                      </li>
                    </ul>
                    <!-- /.control-sidebar-menu -->
                  </div>
                  <!-- /.tab-pane -->
                  <!-- Stats tab content -->
                  <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
                  <!-- /.tab-pane -->
                  <!-- Settings tab content -->
                  <div class="tab-pane" id="control-sidebar-settings-tab">
                    <form method="post">
                      <h3 class="control-sidebar-heading">General Settings</h3>
                      <div class="form-group">
                        <label class="control-sidebar-subheading">Report panel usage
                          <input type="checkbox" class="pull-right" checked />
                        </label>
                        <p>Some information about this general settings option</p>
                      </div>
                      <!-- /.form-group -->
                    </form>
                  </div>
                  <!-- /.tab-pane -->
                </div>
              </aside>
              <!-- /.control-sidebar -->
              <!-- Add the sidebar's background. This div must be placed immediately after the control sidebar -->
              <div class="control-sidebar-bg"></div>
      </div>
      <!-- ./wrapper -->

      <!-- REQUIRED JS SCRIPTS -->
      <%@ include file="/WEB-INF/views/admin/include/plugin2.jsp" %>

        <script>
          $(document).ready(function () {


            // 전역 변수 초기화
            let orderSearchForm = $("#orderSearchForm");
            let actionForm = $("#actionForm");  // 액션폼 참조

            btn_orderSearch
            // 검색 버튼 클릭 이벤트
            $("#btn_orderSearch").on("click", function (e) {

              e.preventDefault();

              let type = $('#type').val();
              let keyword = $('#keyword').val();

              if (!type || type == '') {
                alert("검색 종류를 선택해 주세요.");
                $('#type').focus();
                return;
              }

              if (!keyword || keyword.trim() == '') {
                alert("키워드를 입력해 주세요.");
                $('#keyword').focus();
                return;
              }

              orderSearchForm.submit();
            });

            // [이전] 1 2 3 4 5 ... [다음] 클릭 이벤트 설정. <a> 태그
            $(".movepage").on("click", function (e) {
              e.preventDefault(); // a 태그의 href 링크 기능을 제거. href 속성에 페이지 번호를 숨겨둠

              actionForm.attr("action", "/admin/order/orderList");
              // actionForm.find("input[name='pageNum']").val(선택한 페이지 번호);
              actionForm.find("input[name='pageNum']").val($(this).attr("href"));

              // <input type="date" name="start_date" value="${start_date}">
              // <input type="date" name="end_date" value="${end_date}">
              actionForm.append('<input type="date" name="start_date" value="${start_date}">');
              actionForm.append('<input type="date" name="end_date" value="${end_date}">');

              actionForm.submit(); // 페이지 이동 시 actionForm이 동작
            });

            // 주문상세 방법1 이벤트: 바로 하단에 표시
            $(".btn_order_detail1").on("click", function () {
              let cur_tr = $(this).parent().parent();
              let od_number = $(this).data("od_number");

              console.log("주문번호", od_number);
              let url = "/admin/order/order_detail_info1/" + od_number;
              getOrderDetailInfo(url, cur_tr);
            });

            function getOrderDetailInfo(url, cur_tr) {
              $.getJSON(url, function (data) {

                console.log("상세정보", data[0].od_number);

                // data: 주문상세 정보
                printOrderDetailList(data, cur_tr, $("#orderDetailTemplate"));

              });
            }

            let printOrderDetailList = function (orderDetailData, target, template) {
              let templateObj = Handlebars.compile(template.html());
              let orderDetailHtml = templateObj(orderDetailData);

              // 상품후기 목록 위치를 참조하여 추가 작업
              // target.children().remove(); 
              // target.find(".tr_detail_info").css("display", "none");
              // (".tr_detail_info").css("display", "none");
              // target.find(".tr_detail_info").css("display", "");

              // table 태그에서 추가된 주문상세 tr을 모두 제거
              target.parent().find(".tr_detail_info").remove();
              // 선택된 주문상세 tr이 바로 아래 추가된다.
              target.after(orderDetailHtml); // target: 주문상세 버튼에 존재하고 있던 tr 태그 -> after: 같은 레벨의 tr 태그
            }

            // 주문상세에서 개별 삭제
            $("table#order_info_tbl").on("click", "button[name='btn_order_delete']", function () {

              console.log("개별 삭제");

              // 주문상세 테이블은 PK가 2개 컬럼을 대상으로 복합키 설정이 되어 있다.
              // $(this): "button[name='btn_order_delete']"
              let od_number = $(this).data("od_number");
              let pd_number = $(this).data("pd_number");

              if (!confirm("상품코드 " + pd_number + " 번을 삭제하시겠습니까?")) return;

              // console.log("주문번호", od_number);
              // console.log("상품코드", pd_number);

              // <input type='hidden' name='od_number' value=''>
              // <input type='hidden' name='pd_number' value=''>
              actionForm.append("<input type='hidden' name='od_number' value='" + od_number + "'>");
              actionForm.append("<input type='hidden' name='pd_number' value='" + pd_number + "'>");

              actionForm.attr("action", "/admin/order/order_product_delete");

              actionForm.submit();
            })

            // 주문상세 방법2 이벤트: 팝업창으로 표시
            $(".btn_order_detail2").on("click", function () {

              let od_number = $(this).data("od_number");

              console.log("주문번호", od_number);

              let url = "/admin/order/order_detail_info2/" + od_number;

              // AJAX 기능을 요청 시 설정을 위한 메서드
              $.ajaxSetup({
                'headers': {
                  'AJAX': 'true'
                }
              });

              $("#order_detail_content").load(url, function (response, status, xhr) {
                if (status == "error") {
                  alert("관리자 로그인 페이지로 이동");
                  location.href = "/admin/intro";
                }
              })

              // modal(): 부트스트랩 4.6 메서드(제이쿼리 메서드 아님)
              $("#order_detail_modal").modal('show');
            });

          }); // ready 이벤트
        </script>

        <div class="modal fade" id="order_detail_modal" tabindex="-1" aria-labelledby="exampleModalLabel"
          aria-hidden="true">
          <div class="modal-dialog modal-dialog-scrollable">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalScrollableTitle">Modal title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">×</span>
                </button>
              </div>
              <div class="modal-body" id="order_detail_content"> <!-- $("#order_detail_content").load(url) -->

              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
              </div>
            </div>
          </div>
        </div>

    </body>

    </html>