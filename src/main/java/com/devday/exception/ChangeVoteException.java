package com.devday.exception;

public class ChangeVoteException extends AlreadyVoteException {

	public ChangeVoteException(String message) {
		// super(): 직접적인 상위 클래스의 생성자 호출(소괄호 제외 시 메서드 호출)
		super(message); // RuntimeException <- Exception <- Throwable
	}
	
	/*
	[1] RuntimeException -> AlreadyVoteException 
	public RuntimeException(String message) {
        super(message);
    }
    
    [2] Exception -> RuntimeException
	public Exception(String message) {
        super(message);
    }
    
    [3] Throwable -> Exception
	public Throwable(String message) {
        fillInStackTrace();
        detailMessage = message;
    }
	*/
}
