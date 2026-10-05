package controller;

import model.User_24133009;
import service.EmailService_24133009;
import service.UserService_24133009;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/register")
public class RegisterController_24133009 extends HttpServlet {

    private final UserService_24133009 userService = new UserService_24133009();
    private final EmailService_24133009 emailService = new EmailService_24133009();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String fullname = request.getParameter("fullname");
        String phoneStr = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.setAttribute("email", email);
            request.setAttribute("fullname", fullname);
            request.setAttribute("phone", phoneStr);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        if (userService.isEmailExists(email)) {
            request.setAttribute("error", "Email này đã được sử dụng! Vui lòng dùng email khác.");
            request.setAttribute("fullname", fullname);
            request.setAttribute("phone", phoneStr);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        User_24133009 tempUser = new User_24133009();
        tempUser.setEmail(email.trim());
        tempUser.setFullname(fullname);
        if (phoneStr != null && !phoneStr.trim().isEmpty()) {
            try {
                tempUser.setPhone(Integer.parseInt(phoneStr.trim()));
            } catch (NumberFormatException ignored) {}
        }
        tempUser.setPasswd(password);
        tempUser.setIsAdmin(false);

        // Sinh mã OTP và gửi qua mail
        String otp = emailService.generateOtp();
        emailService.sendOtpEmail(email, otp);

        // Lưu thông tin tạm và mã OTP vào Session
        HttpSession session = request.getSession();
        session.setAttribute("tempUser", tempUser);
        session.setAttribute("registeredOtp", otp);
        session.setAttribute("verifyEmail", email);

        response.sendRedirect(request.getContextPath() + "/verify-otp");
    }
}
