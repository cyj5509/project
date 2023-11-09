package com.devday.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnailator;

// 파일 업로드 관련 필요한 메서드 구성
// 폴더명을 업로드 날짜로 생성
public class FileUtils {

	// 날짜 폴더 생성을 위한 날짜 정보
	public static String getDateFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();

		String str = sdf.format(date); // 예) "2023-11-02"

		// File.separator: 각 OS별로 경로 구분자를 반환
		// 유닉스, 맥, 리눅스 구분자: '/' 예) "2023-11-02" -> "2023/11/02"
		// 윈도우즈 구분자: '\' 예) "2023-11-02" -> "2023\11\02"
		return str.replace("-", File.separator);
	}

	// 서버에 파일 업로드 기능 구현 및 실제 업로드한 파일명 반환
	/*
	< 매개 변수의 의미 >
	1. String uploadFolder: 서버 측의 업로드될 폴더 -> C:\\Dev\\upload\\product(servlet-context.xml 참고)
	2. String dateFolder: 이미지 파일을 저장할 날짜 폴더명 -> 2023\11\03 
	3. MultipartFile uploadFile: 업로드될 파일을 참조하는 객체
	*/
	public static String uploadFile(String uploadFolder, String dateFolder, MultipartFile uploadFile) {

		String realUploadFileName = ""; // 실제 업로드한 파일 이름(파일 이름 중복 방지)

		// File 클래스: 파일과 폴더 관련 작업하는 기능
		// 예) "C:/Dev/devtools/upload/" -> "C:/Dev/devtools/upload/2023/11/02"
		File file = new File(uploadFolder, dateFolder); 

		// 폴더 경로가 없으면 폴더명을 생성함
		if (file.exists() == false) {
			file.mkdirs();
		}

		String clientFileName = uploadFile.getOriginalFilename();

		// 파일명 중복 방지를 위해 고유한 이름에 사용하는 UUID 사용
		UUID uuid = UUID.randomUUID();
		realUploadFileName = uuid.toString() + "_" + clientFileName;

		try {
			// file ─ "C:/Dev/devtools/upload/2023/11/02" + realUploadFileName: 실제 업로드할 파일명
			File saveFile = new File(file, realUploadFileName);
			// 파일 업로드(파일 복사)
			uploadFile.transferTo(saveFile); // 파일 업로드의 핵심 메서드(이전 작업들은 해당 코드를 도출하기 위한 작업)

			// Thumbnail 작업
			// 원본 이미지가 파일 크기가 커서 브라우저에 리스트로 사용 시 로딩는 시간이 길어진다.
			// 원본 이미지를 파일 크기와 해상도를 낮춰 작은 형태로 이미지로 만드는 것
			if (checkImageType(saveFile)) { // 첨부된 파일이 이미지일 경우라면,

				// 파일 출력 스트림 클래스
				// 밑에 코드가 실행이 되면 두 개의 파일이 생성('s_'로 시작하는 0KB 용량의 썸네일 파일 포함)
				FileOutputStream thumbnail = new FileOutputStream(new File(file, "s_" + realUploadFileName));

				// 썸네일 작업기능 라이브러리에서 제공하는 클래스(pom.xml 참고)
				// 원본 이미지 파일의 내용을 스트림 방식으로 읽어서 썸네일 이미지 파일에 쓰는 작업
				// Thumbnailator.createThumbnail(원본 파일의 입력 스트림, 사본(썸네일 파일 객체), 100, 100);
				Thumbnailator.createThumbnail(uploadFile.getInputStream(), thumbnail, 100, 100);

				thumbnail.close();
			}

		} catch (Exception e) {
			e.printStackTrace(); // 파일 업로드 시 예외가 발생되면 예외 관련 정보를 출력
		}

		return realUploadFileName; // 상품 테이블에 파일명이 상품 이미지명으로 저장
	}

	// 업로드 되는 파일 구문(이미지 파일 또는 일반 파일 구분)
	private static boolean checkImageType(File savefile) {
		boolean isImageType = false;// true면 이미지파일이고, false면 일반파일
		try {
			// MIME 정보: text/html, text/plain, image/image...
			String contentType = Files.probeContentType(savefile.toPath());

			// contentType 변수의 값이 image 문자열로 시작하는지 여부를 True, False값으로 반환
			isImageType = contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();

		}

		return isImageType;
	}

	// 프로젝트 외부폴더에서 관리되고 있는 상품이미지를 브라우저의 <img src="매핑주소">
	// 이미지 태그로부터 요청이 들어왔을 때 바이트 배열로 보내주는 작업.
	// String uploadPath : 업로드 폴더경로
	// String fileName : 날짜폴더경로를 포함한 파일명.(db)
	// ResponseEntity 클래스: 1) 헤더(header) / 2)바디(body) ─ 데이터 / 3) 상태코드
	public static ResponseEntity<byte[]> getFile(String uploadPath, String fileName) throws Exception {

		ResponseEntity<byte[]> entity = null;

		File file = new File(uploadPath, fileName); // 상품이미지파일을 참조한는 파일객체

		// 파일이 해당경로에 존재하지 않으면
		if (!file.exists()) {
			return entity; // null 로 리턴.
		}

		// 1) Header
		// Files.probeContentType(file.toPath()) : image/jpeg
		// file : 716a5e3e-9e52-45ba-a512-6509595437fa_pineapple.jpg
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", Files.probeContentType(file.toPath()));

		entity = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);

		return entity;
	}
	
	// 파일 삭제
	// String uploadPath: 업로드 폴더명 -> servlet-context.xml의 uploadPath bean 정보 사용
	// String folderName: 날짜 폴더명
	// String fileName: 파일명
	public static void deleteFile(String uploadPath, String folderName, String fileName) {
		
		// 1) 원본 이미지 삭제
		// File.separatorChar: 배포된 서버의 운영체제에서 사용하는 파일의 경로 구분자를 반환 -> 예) 윈도우즈: \, 리눅스: /
		new File((uploadPath + folderName + "\\" + fileName).replace('\\', File.separatorChar)).delete(); // 작은 따옴표('')는 char를 표현(Escape Sequence)
		
		// 2) 썸네일 이미지 삭제
		new File((uploadPath + folderName + "\\" + "s_" + fileName).replace('\\', File.separatorChar)).delete(); // 작은 따옴표('')는 char를 표현(Escape Sequence)
	}
}
