// 모달 컨텐츠만 드래그 가능하게 만드는 함수
function dragElement(elmnt) {
    let pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0; // 드래그에 필요한 위치 변수 초기화

    elmnt.onmousedown = dragMouseDown; // 마우스 버튼을 누를 때 이벤트 핸들러 지정

    function dragMouseDown(e) {
        if (e.target.tagName === 'INPUT') {
            return; // 입력 필드에서 드래그 시작을 방지
        }
        e.preventDefault(); // 다른 요소에서 기본 이벤트 방지
        pos3 = e.clientX; // 드래그 시작 X 위치
        pos4 = e.clientY; // 드래그 시작 Y 위치
        document.onmouseup = closeDragElement; // 마우스 버튼을 뗄 때 이벤트 지정
        document.onmousemove = elementDrag; // 마우스 움직임에 따른 이벤트 지정
    }

    function elementDrag(e) {
        e.preventDefault(); // 기본 이벤트 방지
        // 마우스 움직임에 따른 새 위치 계산
        pos1 = pos3 - e.clientX;
        pos2 = pos4 - e.clientY;
        pos3 = e.clientX;
        pos4 = e.clientY;
        // 계산된 새 위치로 모달 위치 업데이트
        elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
        elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
    }

    function closeDragElement() {
        // 드래그 이벤트 제거
        document.onmouseup = null;
        document.onmousemove = null;
    }
}

dragElement(document.querySelector(".pw-modal-content")); // 모달 컨텐츠에 드래그 기능 적용
