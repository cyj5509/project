package com.devday.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.lang.Nullable;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.log4j.Log4j;

// 인터셉터 기능을 적용하기 위한 준비
// 1. 인터셉터 클래스를 생성 후 HandlerInterceptorAdapter 추상 클래스를 상속한다.
//2. HandlerInterceptorAdapter 추상 클래스의 주요 3가지 메서드를 재정의한다.
// 3. 인터셉터 클래스를 사용하기 위해 servlet-context.xml에서 설정을 해야 한다.

//[참고] https://velog.io/@dnflekf2748/%EC%8A%A4%ED%94%84%EB%A7%81-%EC%9D%B8%ED%84%B0%EC%85%89%ED%84%B0Interceptor

@Log4j // 제대로 작동하지 않을 경우 System.out.println(); 활용 
public class TestInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		// 컨트롤러에서 공통적으로 필요한 작업(인증, 권한, 로깅)
		
		// log.info("인터셉터: preHandle() 호출" );
		System.out.println("인터셉터 1: preHandle() 메서드 호출");
		
		return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			@Nullable ModelAndView modelAndView) throws Exception {

		System.out.println("인터셉터 2: postHandle() 메서드 호출");

		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
			@Nullable Exception ex) throws Exception {

		System.out.println("인터셉터 3: afterCompletion 메서드 호출");
		
		super.afterCompletion(request, response, handler, ex);
	}

	
}
