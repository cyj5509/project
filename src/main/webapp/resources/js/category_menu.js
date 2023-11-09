// script 태그는 제외한다.

// 자바스크립트 코드와 jsp 문법이 혼합되어 있을 경우: views 폴더 하위에 파일 확장자는 jsp로 저장
// 순수 자바스크립트 코드만 사용되는 경우: resource 폴더 하위에 파일 확장자는 js로 저장

$(document).ready(function () {
  // 1차 카테고리 오버
  // $("1차 카테고리 태그를 참조하는 선택자").on();
  $("div#category_menu li a").on("mouseover", function (e) {
    e.preventDefault(); // a 태그의 링크 기능을 취소
    // console.log("1차 카테고리 오버");

    let sel_first_category = $(this);

    // let cg_code = "선택한 1차 카테고리 코드";
    let cg_code = $(this).data("cg_code"); // data-cg_code -> $(this).data("cg_code")

    // console.log("1차 카테고리 코드: ", cg_code);
    // return; // 하단 코드를 동작시키지 않게 하기 위함

    // let url = '2차 카테고리 정보를 가져오는 주소';
    let url = '/category/secondCategory/' + cg_code;
    $.getJSON(url, function (category) {

      // console.log(category);
      let str = '<ul class="nav justify-content-center" id="second_category">';
      for (let i = 0; i < category.length; i++) {
        str += '<li class="nav-item">';
        // 바로 아래 부분이 2차 카테고리를 보여주는 부분
        str += '<a class="nav-link active" href="#" data-cg_code="'+ category[i].cg_code +'">'+ category[i].cg_name + '</a>'; // str += '2차 카테고리'
        str += '</li>';
      }
      str += '</ul>';

      // console.log(str);
      sel_first_category.parent().parent().next().remove();
      sel_first_category.parent().parent().after(str);
    });
  });

  // 2차 카테고리 선택
  // $("정적 태그 참조 선택자").on("이벤트명", "동적 태그 참조 선택자", function() {});
  $("div#category_menu").on("click", "ul#second_category", function() {
    console.log("2차 카테고리 작업");
  });

});