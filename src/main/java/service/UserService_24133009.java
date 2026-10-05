package service;

import model.User_24133009;
import repository.UserRepository_24133009;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;

public class UserService_24133009 {

    private final UserRepository_24133009 userRepo = new UserRepository_24133009();

    public static String toMD5(String input) {
        if (input == null) return "";
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(input.getBytes());
            BigInteger no = new BigInteger(1, messageDigest);
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        } catch (NoSuchAlgorithmException e) {
            return input;
        }
    }

    public User_24133009 login(String email, String password) {
        if (email == null || password == null) return null;
        User_24133009 user = userRepo.findByEmail(email.trim());
        if (user != null && user.getPasswd() != null) {
            String dbPass = user.getPasswd().trim();
            String inputPass = password.trim();
            String inputMd5 = toMD5(inputPass);

            // Cho phép khớp cả mật khẩu gốc (admin123, 123456) lẫn chuỗi mã hoá MD5
            if (dbPass.equalsIgnoreCase(inputPass) || dbPass.equalsIgnoreCase(inputMd5)) {
                user.setLastLogin(new Date());
                try {
                    userRepo.update(user);
                } catch (Exception ignored) {}
                return user;
            }
        }
        return null;
    }

    public boolean isEmailExists(String email) {
        if (email == null) return false;
        return userRepo.findByEmail(email.trim()) != null;
    }

    public User_24133009 getUserById(int id) {
        return userRepo.findById(id);
    }

    public void registerUser(User_24133009 user) {
        user.setSignupDate(new Date());
        if (user.getIsAdmin() == null) {
            user.setIsAdmin(false);
        }
        userRepo.save(user);
    }
}
