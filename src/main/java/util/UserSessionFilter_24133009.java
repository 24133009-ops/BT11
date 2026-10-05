package util;

import model.User_24133009;
import service.UserService_24133009;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class UserSessionFilter_24133009 implements Filter {

    private final UserService_24133009 userService = new UserService_24133009();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        req.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session != null) {
            User_24133009 u = (User_24133009) session.getAttribute("user");
            if (u != null) {
                // Tự động làm mới thông tin user từ database nếu phát hiện chuỗi mojibake
                if (u.getFullname() == null || u.getFullname().contains("Æ") || u.getFullname().contains("Ã") || u.getFullname().contains("á»")) {
                    try {
                        User_24133009 fresh = userService.getUserById(u.getId());
                        if (fresh != null) {
                            session.setAttribute("user", fresh);
                        }
                    } catch (Exception ignored) {}
                }
            }
        }
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) {}

    @Override
    public void destroy() {}
}
