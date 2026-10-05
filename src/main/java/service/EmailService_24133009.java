package service;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Random;

public class EmailService_24133009 {

    // Sinh mã OTP 6 số ngẫu nhiên
    public String generateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    // Gửi email chứa OTP
    public boolean sendOtpEmail(String recipientEmail, String otp) {
        System.out.println("==================================================");
        System.out.println(" [OTP SERVICE] Gửi mã OTP tới email: " + recipientEmail);
        System.out.println(" [MÃ OTP XÁC THỰC LÀ]: >>> " + otp + " <<<");
        System.out.println("==================================================");

        // Cấu hình SMTP Gmail (có thể cấu hình nếu có app password)
        final String senderEmail = "duytq4906@gmail.com";
        final String senderPassword = "nrtadeguoschbrby";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        try {
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(senderEmail, senderPassword);
                }
            });

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail, "BookStore 24133009", "UTF-8"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Mã OTP xác thực tài khoản BookStore: " + otp, "UTF-8");
            message.setContent(
                "<div style='font-family: Arial, sans-serif; padding: 20px; border: 1px solid #e0e0e0; border-radius: 8px; max-width: 500px;'>" +
                "<h2 style='color: #0d6efd;'>BookStore - Trương Quốc Duy (24133009)</h2>" +
                "<p>Xin chào,</p>" +
                "<p>Bạn đang đăng ký tài khoản tại hệ thống BookStore. Mã xác thực OTP của bạn là:</p>" +
                "<div style='background-color: #f8f9fa; padding: 15px; text-align: center; border-radius: 6px; margin: 20px 0;'>" +
                "<span style='font-size: 28px; font-weight: bold; letter-spacing: 5px; color: #dc3545;'>" + otp + "</span>" +
                "</div>" +
                "<p style='color: #6c757d; font-size: 13px;'>Mã OTP này có hiệu lực trong vòng 5 phút. Vui lòng không chia sẻ mã này cho bất kỳ ai.</p>" +
                "</div>",
                "text/html; charset=UTF-8"
            );

            Transport.send(message);
            return true;
        } catch (Exception e) {
            // Trong môi trường phòng thi không có mạng hoặc chưa cấu hình mail,
            // mã OTP vẫn được in ra console và hiển thị ở session để test thuận tiện!
            System.err.println("Lưu ý: Không kết nối được SMTP server (" + e.getMessage() + "). OTP đã được in ra console!");
            return false;
        }
    }
}
