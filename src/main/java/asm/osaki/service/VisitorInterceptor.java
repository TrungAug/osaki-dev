package asm.osaki.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class VisitorInterceptor implements HandlerInterceptor {
	@Autowired
	private VisitorCounter counter;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// Tăng số lượng truy cập mỗi khi có yêu cầu mới
		if (!request.getRequestURI().startsWith("/admin")) {
            counter.increment();
        }
		return true;
	}
}
