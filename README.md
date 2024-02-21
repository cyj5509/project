 # [개인] 쇼핑몰 프로젝트

![0-0  프로젝트개요01](https://github.com/cyj5509/project/assets/139317478/54ce9033-1cef-43fc-a872-c25755fc148f)

(바로 아래 부분은 구현한 기능들을 파악하기 쉽게 정리 중인 부분입니다. 자세한 내용은 그 다음부터 이어집니다.)
![0-1  프로젝트개요02](https://github.com/cyj5509/project/assets/139317478/017f34ef-a1b5-468e-b845-45e709cc1c86)

[1] 사용자 페이지

⒈ 메인 페이지

 (1) 섹션별 ‘더 알아보기’를 통한 해당 페이지로의 링크 제공
 ![0-2  메인페이지(사용자)](https://github.com/cyj5509/project/assets/139317478/b86eba8d-19d8-4541-b9ca-d4ed2f9731be)

 (2) 로그인한 계정에 따른 관리자 페이지로의 링크 표시/숨김
 ![0-3  메인페이지(관리자페이지)](https://github.com/cyj5509/project/assets/139317478/48f75d1d-bcec-4280-b652-1f992b428456)

⒉ 회원 관리

 (1) 회원가입 양식 및 유효성 검사

  ① 회원가입 양식: 로그인 정보와 회원 정보로 구분
  ![1-1  회원관리01](https://github.com/cyj5509/project/assets/139317478/9ed84f80-9bc7-43eb-9199-194e8e9788ae)

  ② 양식이 미작성된 상태에서 '가입' 버튼 클릭 시의 알림들
  ![1-1  회원관리02](https://github.com/cyj5509/project/assets/139317478/a8c9e52c-367a-40b9-89c7-242a8c08ca01)
  
  ③ 로그인 정보에서의 유효성 검사
  
  ⅰ) 아이디의 유효성 검사: 아이디 입력 후 중복검사 버튼 클릭 시
  ![1-1  회원관리03](https://github.com/cyj5509/project/assets/139317478/a14146d4-f687-48ab-b536-afeec361f4a7)

  ⅱ) 비밀번호의 유효성 검사
  ![1-1  회원관리04](https://github.com/cyj5509/project/assets/139317478/2215cc0f-f7be-4b74-9750-db63e22c1a01)

  ④ 회원 정보에서의 유효성 검사
  
  ⅰ) 이름/전화번호의 유효성 검사: 이름/전화번호 입력 후 '가입' 버튼 클릭 시
  ![1-1  회원관리05](https://github.com/cyj5509/project/assets/139317478/19681c5f-67ab-4a72-9891-571a513daf44)

  ⅱ) 이메일의 유효성 검사: 이메일 입력 후 ‘발송’ 버튼 클릭 시
  ![1-1  회원관리06](https://github.com/cyj5509/project/assets/139317478/e6d0b531-2761-4bd2-a6dc-59c55561f976)

  ⅲ) 인증번호의 유효성 검사: 인증번호(6자리) 입력 후 ‘확인’ 버튼 클릭 시
  ![1-1  회원관리07](https://github.com/cyj5509/project/assets/139317478/cd7f48bc-63c9-4d52-8471-a5b687d911c7)
  
  ⅳ) 주소의 유효성 검사: 주소를 직접 입력하거나 우편번호 서비스 API 활용
  ![1-1  회원관리08](https://github.com/cyj5509/project/assets/139317478/2cd49120-6cd8-42cc-928d-478b2f365767)
  
 (2) 로그인 및 아이디/비밀번호 찾기 등
 
  ① 가입 양식 작성 후 가입 버튼을 클릭한 경우
  ![1-1  회원관리09](https://github.com/cyj5509/project/assets/139317478/185bfbcb-5893-469d-9657-566fb4a1a8a0)

  ② 로그인 정보를 바탕으로 로그인하는 경우
  ![1-1  회원관리10](https://github.com/cyj5509/project/assets/139317478/a7f9f8b6-904f-46e8-8bfb-95ce7b92000d)

  ③ 단계별 아이디 찾기 및 비밀번호 찾기
  ![1-1  회원관리11](https://github.com/cyj5509/project/assets/139317478/c2ecbd46-f3ed-4ca5-b194-444573f8fd68)
  ![1-1  회원관리12](https://github.com/cyj5509/project/assets/139317478/bfc088a1-8f6a-45fb-8ffe-655a751aeb16)

  ④ 비밀번호 찾기: 임시 비밀번호 생성 vs. 비밀번호 재설정
  ![1-1  회원관리13](https://github.com/cyj5509/project/assets/139317478/50e84024-e9d3-4776-9d26-ad9e5ffec819)

  ⑤ 아이디 저장과 로그인 유지 옵션
  
⒊ 상품 관리

![1-2  상품관리01](https://github.com/cyj5509/project/assets/139317478/45a78c29-d909-48e1-9826-bfe220a8e3bc)
![1-2  상품관리02](https://github.com/cyj5509/project/assets/139317478/9a49f381-caaa-4774-83b3-18a756979ac4)
![1-2  상품관리03](https://github.com/cyj5509/project/assets/139317478/8f7bc000-50b6-4824-841a-10b1369b9d1f)
![1-2  상품관리04](https://github.com/cyj5509/project/assets/139317478/119ed63a-7160-4613-a3f8-6c7ded90e702)
![1-2  상품관리05](https://github.com/cyj5509/project/assets/139317478/c495cd2b-8dcc-4ac0-9fef-1943f7c7d71d)


⒋ 주문 관리(로직은 있음. md에 해당 내용 추가할 예정)
⒌ 게시판 관리(로직은 있음. md에 해당 내용 수정할 예정)
![최종01](https://github.com/cyj5509/project/assets/139317478/04561e4b-8e05-4c05-9dd7-a0780849d173)
![최종02](https://github.com/cyj5509/project/assets/139317478/d08defbf-7957-4a13-adf4-727f84b9b045)
![최종03](https://github.com/cyj5509/project/assets/139317478/bc58722d-8157-4e47-8cd1-8d82352d166c)
![최종04](https://github.com/cyj5509/project/assets/139317478/0abbabc9-4763-46b9-ab8a-3c1ebc4658bf)
![최종05](https://github.com/cyj5509/project/assets/139317478/69709faa-ae31-42a6-8e55-2dcbc6e07b80)
![최종06](https://github.com/cyj5509/project/assets/139317478/fdaade7d-9bc8-437d-9bf4-54a080db2d2a)
![최종07](https://github.com/cyj5509/project/assets/139317478/67b34690-ae7d-47ee-bf8c-ab44315af019)
![최종08](https://github.com/cyj5509/project/assets/139317478/46c5325d-d278-4c59-89dc-96e96e33d709)

[2] 관리자 페이지
1. 회원 관리(로직 미비)
2. 상품 관리(로직은 있음. md에 해당 내용 추가할 예정)
3. 주문 관리(로직은 있음. md에 해당 내용 추가할 예정)
4. 게시판 관리(로직 미비)
