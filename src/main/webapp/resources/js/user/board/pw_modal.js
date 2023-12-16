// 모달을 드래그 가능하게 만드는 함수
function dragElement(elmnt) {
  let pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
  const modalHeader = document.getElementById(elmnt.id + "Header");

  if (modalHeader) {
      // 모달 헤더가 있으면 여기서부터 드래그 시작
      modalHeader.onmousedown = (e) => dragMouseDown(e);
  } else {
      // 모달 헤더가 없으면 모달의 어느 곳에서나 드래그 시작
      elmnt.onmousedown = (e) => dragMouseDown(e);
  }

  function dragMouseDown(e) {
      e.preventDefault(); // 기본 이벤트 방지
      // 초기 마우스 커서 위치 저장
      pos3 = e.clientX;
      pos4 = e.clientY;
      document.onmouseup = closeDragElement; // 마우스 버튼을 뗄 때 이벤트
      document.onmousemove = (e) => elementDrag(e); // 커서가 움직일 때 이벤트
  }

  function elementDrag(e) {
      e.preventDefault(); // 기본 이벤트 방지
      // 새 커서 위치 계산
      pos1 = pos3 - e.clientX;
      pos2 = pos4 - e.clientY;
      pos3 = e.clientX;
      pos4 = e.clientY;
      // 모달의 새 위치 설정
      elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
      elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
  }

  function closeDragElement() {
      // 마우스 버튼을 뗄 때 드래그 중단
      document.onmouseup = null;
      document.onmousemove = null;
  }
}

// 모달에 드래그 기능 적용
dragElement(document.getElementById("passwordModal"));
