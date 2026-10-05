<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập - BookStore</title>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header bg-primary text-white text-center py-3 rounded-top-3">
                    <h4 class="mb-0 fw-bold"><i class="bi bi-box-arrow-in-right me-2"></i>ĐĂNG NHẬP</h4>
                    <small>Hệ thống Quản lý BookStore</small>
                </div>
                <div class="card-body p-4">

                    <!-- Thông báo thành công từ đăng ký -->
                    <c:if test="${not empty sessionScope.successMsg}">
                        <div class="alert alert-success alert-dismissible fade show small" role="alert">
                            <i class="bi bi-check-circle-fill me-1"></i> ${sessionScope.successMsg}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="successMsg" scope="session"/>
                    </c:if>

                    <!-- Thông báo lỗi đăng nhập -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/login" method="post">
                        <!-- Email -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary">
                                <i class="bi bi-envelope me-1"></i>Địa chỉ Email
                            </label>
                            <input type="email" class="form-control" name="email"
                                   value="${email}" placeholder="example@gmail.com" required autofocus>
                        </div>

                        <!-- Password -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary">
                                <i class="bi bi-lock me-1"></i>Mật khẩu
                            </label>
                            <input type="password" class="form-control" name="password"
                                   placeholder="Nhập mật khẩu" required>
                        </div>

                        <!-- Submit Button -->
                        <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mb-3">
                            <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
                        </button>

                        <div class="text-center small text-muted">
                            Chưa có tài khoản?
                            <a href="${pageContext.request.contextPath}/register" class="fw-semibold text-primary text-decoration-none">
                                Đăng ký ngay
                            </a>
                        </div>
                    </form>

                    <!-- Hint tài khoản test -->
                    <div class="mt-4 p-3 bg-light rounded text-center small text-muted border">
                        <i class="bi bi-info-circle text-primary me-1"></i>
                        <strong>Tài khoản đăng nhập có sẵn:</strong><br>
                        • <strong>Admin:</strong> <code>admin@bookstore.com</code> / Mật khẩu: <code>admin123</code><br>
                        • <strong>User:</strong> <code>user@bookstore.com</code> / Mật khẩu: <code>123456</code><br>
                        <em>Hoặc bấm "Đăng ký ngay" để kiểm tra OTP qua mail!</em>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
