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

@WebServlet("/verify-otp")
public class VerifyOtpController_24133009 extends HttpServlet {

    private final UserService_24133009 userService = new UserService_24133009();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("tempUser") == null) {
            response.sendRedirect(request.getContextPath() + "/register");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/verify-otp.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("tempUser") == null) {
            response.sendRedirect(request.getContextPath() + "/register");
            return;
        }

        String inputOtp = request.getParameter("otp");
        String correctOtp = (String) session.getAttribute("registeredOtp");
        User_24133009 tempUser = (User_24133009) session.getAttribute("tempUser");

        if (inputOtp != null && inputOtp.trim().equals(correctOtp)) {
            // Xác thực OTP thành công! Lưu tài khoản vào database
            userService.registerUser(tempUser);

            // Dọn dẹp session
            session.removeAttribute("tempUser");
            session.removeAttribute("registeredOtp");
            session.removeAttribute("verifyEmail");

            // Đặt thông báo thành công
            session.setAttribute("successMsg", "Đăng ký và kích hoạt tài khoản thành công! Vui lòng đăng nhập.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // Sai OTP
            request.setAttribute("error", "Mã OTP không chính xác hoặc đã hết hạn! Vui lòng kiểm tra lại.");
            request.getRequestDispatcher("/WEB-INF/views/verify-otp.jsp").forward(request, response);
        }
    }
}
