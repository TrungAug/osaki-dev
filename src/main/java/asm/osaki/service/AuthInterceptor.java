package asm.osaki.service;

import asm.osaki.entities.user.UserCustom;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    @Autowired
    private SessionService sessionService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // Kiểm tra trạng thái đăng nhập bằng session
        UserCustom user = (UserCustom) sessionService.get("userLogin");

        // Kiểm tra đường dẫn yêu cầu
        String requestURI = request.getRequestURI();
        System.out.println(requestURI);
        // Kiểm tra quyền truy cập
        if (user == null && requiresAuthentication(requestURI)) {
            response.sendRedirect("/login");
            return false;
        } else if (user != null && !hasAccess(user, requestURI)) {
            System.out.println(1);
            response.sendRedirect("/access-denied");
            return false;
        } else if (user != null && (requestURI.contains("login") || requestURI.contains("register"))) {
            System.out.println(3);
            response.sendRedirect("/");
            return false;
        }
        System.out.println(2);

        return true;
    }

    private boolean requiresAuthentication(String requestURI) {
        return !requestURI.equals("/account/login") && !requestURI.equals("/account/register") && !requestURI.equals("/account/forgot-password") && !requestURI.equals("/account/send-code") && !requestURI.contains("/account/verify-code");
    }

    private boolean hasAccess(UserCustom user, String requestURI) {
        if (user.getRoleName().getRoleName().equals("admin") && !requestURI.startsWith("/checkout") && !requestURI.contains("cart")) {
            return true;
        } else if (user.getRoleName().getRoleName().equals("user") && !requestURI.contains("/admin")) {
            return true;
        } else if (requestURI.contains("login") || requestURI.contains("register")) {
            return true;
        }
        return false;
    }
}
