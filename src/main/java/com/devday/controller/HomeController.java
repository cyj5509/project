package com.devday.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) {

		// 쿠키에서 session_id 값을 확인하는 로직(게시판에서의 추천 및 비추천 작업)
		Cookie[] cookies = request.getCookies();
		String session_id = null;
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("session_id".equals(cookie.getName())) {
					session_id = cookie.getValue();
					break;
				}
			}
		}
		// 파라미터로 HttpSession 대신 HttpServletRequest로 세션 가져오기
		HttpSession session = request.getSession();
		
		if (session.getAttribute("userStatus") == null) {
			// 로그인하지 않은 사용자(비회원)만 새로운 session_id 쿠키 생성
			if (session_id == null) {
				session_id = UUID.randomUUID().toString();
				Cookie cookie = new Cookie("session_id", session_id);
				cookie.setMaxAge(60 * 60 * 24); // 쿠키 유효기간 24시간(1일) 설정
				cookie.setPath("/"); // 웹사이트의 모든 경로에서 쿠키 사용
				cookie.setHttpOnly(true); // 보안 설정(JavaScript 접근 방지)
				// cookie.setSecure(true); // HTTPS를 통해서만 전송
				response.addCookie(cookie); // 쿠키를 응답에 추가하여 클라이언트에 전송
			}
		}
		// 기존 로직 유지
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		return "main"; // main.jsp
	}
	
}
