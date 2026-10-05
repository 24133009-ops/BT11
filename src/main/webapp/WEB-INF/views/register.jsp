<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký tài khoản - BookStore</title>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header bg-success text-white text-center py-3 rounded-top-3">
                    <h4 class="mb-0 fw-bold"><i class="bi bi-person-plus-fill me-2"></i>ĐĂNG KÝ TÀI KHOẢN</h4>
                    <small>Kích hoạt tài khoản bằng mã OTP qua email</small>
                </div>
                <div class="card-body p-4">

                    <!-- Lỗi hiển thị -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register" method="post">
                        <!-- Fullname -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary">
                                <i class="bi bi-person me-1"></i>Họ và tên
                            </label>
                            <input type="text" class="form-control" name="fullname"
                                   value="${fullname}" placeholder="Nguyễn Văn A" required>
                        </div>

                        <!-- Email -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary">
                                <i class="bi bi-envelope me-1"></i>Email (nhận mã OTP)
                            </label>
                            <input type="email" class="form-control" name="email"
                                   value="${email}" placeholder="example@gmail.com" required>
                        </div>

                        <!-- Phone -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary">
                                <i class="bi bi-telephone me-1"></i>Số điện thoại
                            </label>
                            <input type="number" class="form-control" name="phone"
                                   value="${phone}" placeholder="0912345678">
                        </div>

                        <!-- Password -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary">
                                <i class="bi bi-lock me-1"></i>Mật khẩu
                            </label>
                            <input type="password" class="form-control" name="password"
                                   placeholder="Tối đa 32 ký tự" maxlength="32" required>
                        </div>

                        <!-- Confirm Password -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold text-secondary">
                                <i class="bi bi-lock-fill me-1"></i>Xác nhận mật khẩu
                            </label>
                            <input type="password" class="form-control" name="confirmPassword"
                                   placeholder="Nhập lại mật khẩu" maxlength="32" required>
                        </div>

                        <!-- Submit Button -->
                        <button type="submit" class="btn btn-success w-100 py-2 fw-semibold mb-3">
                            <i class="bi bi-send-check me-1"></i> Nhận mã OTP & Tiếp tục
                        </button>

                        <div class="text-center small text-muted">
                            Đã có tài khoản?
                            <a href="${pageContext.request.contextPath}/login" class="fw-semibold text-success text-decoration-none">
                                Đăng nhập
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
