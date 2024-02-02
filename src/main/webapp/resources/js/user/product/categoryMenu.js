
// 자바스크립트 코드와 jsp 문법이 혼합되어 있을 경우: views 폴더 하위에 파일 확장자는 jsp로 저장
// 순수 자바스크립트 코드만 사용되는 경우: resource 폴더 하위에 파일 확장자는 js로 저장

$(document).ready(function () {

  // 햄버거 메뉴 클릭 이벤트
  $("#hamburger_icon").on("click", function () {

    $(this).toggleClass("active"); // 햄버거 아이콘 토글
    $("#category_menu").toggleClass("show"); // 카테고리 메뉴 표시 토글

    // 카테고리 메뉴의 높이에 따라 h1 태그 이하의 내용의 여백 조절
    if ($("#category_menu").hasClass("show")) {
      let menuHeight = $("#category_menu").outerHeight(); // offsetHeight와 유사한 역할
      $("h1").css("margin-top", menuHeight);
    } else {
      $("h1").css("margin-top", 0);
    }

    // 햄버거 아이콘을 X로 변경
    if ($(this).hasClass("active")) {
      $(this).text("✕");
    } else {
      $(this).text("☰");
    }
  });

  // 1차 카테고리 마우스 오버 이벤트
  // $("1차 카테고리 태그를 참조하는 선택자").on();
  $("div#category_menu li a").on("mouseover", function (e) {
    e.preventDefault(); // a 태그의 링크 기능을 취소

    let sel_first_category = $(this);
    let cg_code = $(this).data("cg_code"); // data-cg_code -> $(this).data("cg_code")

    // console.log("1차 카테고리 코드: ", cg_code);

    // let url = '2차 카테고리 정보를 가져오는 주소';
    // $.getJSON을 사용한 경우
    let url = '/category/secondCategory/' + cg_code;
    $.getJSON(url, function (category) {
      // 2차 카테고리 목록 생성
      let str = '<ul class="nav justify-content-start" id="second_category">';
      for (let i = 0; i < category.length; i++) {
        str += '<li class="categoryNavbar">';
        // 바로 아래 부분이 2차 카테고리를 보여주는 부분. str += '2차 카테고리'
        // str += '<a class="nav-link active" href="#" data-cg_code="' + category[i].cg_code + '" data-cg_name="' + category[i].cg_name + '">' + category[i].cg_name + '</a>';
        str += '<a class="nav-link active" href="#" data-cg_code="' + category[i].cg_code + '" data-cg_parent_name="' + category[i].cg_parent_name + '" data-cg_name="' + category[i].cg_name + '">' + category[i].cg_name + '</a>';
        str += '</li>';
      }
      str += '</ul>';

      sel_first_category.parent().parent().next().remove();
      sel_first_category.parent().parent().after(str); // 2차 카테고리 목록 추가
      $("#second_category").css("display", "block"); // 2차 카테고리 목록 표시
    });

    /*
    // $.ajax를 사용한 경우
    $.ajax({
      url: '/category/secondCategory/' + cg_parent_code, // url 변수의 초기화 작업은 불필요
      type: 'GET',
      dataType: 'json', // 서버로부터 반환되는 응답 데이터
      success: function (category) {
        // 이때의 로직은 $.getJSON의 콜백 함수 내 로직과 동일
      },
      error: function (xhr, status, error) {
      }
    });
    */
  });

  // 1차 카테고리와 2차 카테고리 전체에 대한 마우스 아웃 이벤트
  $("div#category_menu").on("mouseleave", function () {
    // 2차 카테고리 목록을 숨김
    $("#second_category").css("display", "none");
  });

  // 2차 카테고리 선택
  // $("정적 태그 참조 선택자").on("이벤트명", "동적 태그 참조 선택자", function() {});
  $("div#category_menu").on("click", "ul#second_category li a", function (e) {
    console.log("2차 카테고리 작업");

    let cg_code = $(this).data("cg_code");
    let cg_parent_name = $(this).data("cg_parent_name"); // 1차 카테고리 이름
    let cg_name = $(this).data("cg_name");

    console.log("상위 카테고리명:", cg_parent_name);
    console.log("하위 카테고리명:", cg_name);

    location.href = `/user/product/usProductList?cg_code=${cg_code}&cg_parent_name=${cg_parent_name}&cg_name=${cg_name}`;
  });

  // URL에서 파라미터 값 추출
  const urlParams = new URLSearchParams(location.search);
  const cg_parent_name = urlParams.get('cg_parent_name');
  const cg_name = urlParams.get('cg_name');

  // 파라미터가 있으면 해당 내용으로 <p id="categoryName"> 업데이트
  if (cg_parent_name && cg_name) {
    // 한글이나 공백 등으로 오류 발생 시 encodeURIComponent()와 함께 decodeURIComponent()로 처리
    $("#categoryName").text("[대분류] " + cg_parent_name + " >>> [소분류] " + cg_name);
  } else {
    $("#categoryName").text("전체 상품(카테고리 미분류)");
  } 
  // 단일 스타일 변경 시에는 속성명과 속성값 간에 콤마(,)로 구분 -> $("#second_category").css("display", "none");
  // 2개 이상인 경우 중괄호로 감싼 뒤 콜론(:)으로 구분(단, 속성 간에는 콤마로 구분)
  $("#categoryName").css({ "font-size": 22, "font-weight": "bold", "font-style": "italic" });

}); // ready-end

