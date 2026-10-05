package controller;

import model.User_24133009;
import service.UserService_24133009;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginController_24133009 extends HttpServlet {

    private final UserService_24133009 userService = new UserService_24133009();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User_24133009 user = userService.login(email, password);

        if (user != null) {
            // Đăng nhập thành công: lưu session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Theo đề bài: Đăng nhập với vai trò user thành công thì vào trang chủ của User (/home)
            // Nếu là admin thì có thể vào trang quản trị hoặc trang chủ
            if (user.getIsAdmin() != null && user.getIsAdmin()) {
                response.sendRedirect(request.getContextPath() + "/admin/books");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            // Ngược lại thì quay lại trang đăng nhập kèm thông báo lỗi
            request.setAttribute("error", "Email hoặc mật khẩu không chính xác! Vui lòng thử lại.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}
