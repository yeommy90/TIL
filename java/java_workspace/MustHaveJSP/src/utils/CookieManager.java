package utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieManager {
	// 명시한 이름, 값, 유지 기간으로 새로운 쿠키 생성
	public static void makeCookie(HttpServletResponse res, String cName, String cValue, int cTime) {
		Cookie cookie = new Cookie(cName, cValue);
		cookie.setPath("/");
		cookie.setMaxAge(cTime);
		res.addCookie(cookie);
	}
	
	// 명시한 이름의 쿠키를 찾아 값을 반환
	public static String readCookie(HttpServletRequest req, String cName) {
		String cookieValue = "";
		
		Cookie[] cookies = req.getCookies();
		if (cookies != null) {
			for (Cookie c : cookies) {
				String cookieName = c.getName();
				if (cookieName.equals(cName)) {
					cookieValue = c.getValue();
				}
			}
		}
		return cookieValue;
	}
	
	// 명시한 이름의 쿠키를 삭제
	public static void deleteCookie(HttpServletResponse res, String cName) {
		makeCookie(res, cName, "", 0);
	}
}
