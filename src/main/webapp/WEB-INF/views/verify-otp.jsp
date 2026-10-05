<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Xác thực mã OTP - BookStore</title>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header bg-warning text-dark text-center py-3 rounded-top-3">
                    <h4 class="mb-0 fw-bold"><i class="bi bi-shield-check me-2"></i>XÁC THỰC OTP</h4>
                    <small>Kích hoạt tài khoản người dùng</small>
                </div>
                <div class="card-body p-4">

                    <p class="text-muted small text-center mb-3">
                        Mã OTP xác thực đã được gửi đến email:
                        <br><strong class="text-dark">${sessionScope.verifyEmail}</strong>
                    </p>

                    <!-- Lỗi hiển thị -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
                        <!-- Input OTP -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold text-secondary">
                                <i class="bi bi-key me-1"></i>Nhập mã OTP (6 số)
                            </label>
                            <input type="text" class="form-control text-center fs-4 fw-bold letter-spacing"
                                   name="otp" maxlength="6" placeholder="------" required autofocus>
                        </div>

                        <!-- Submit Button -->
                        <button type="submit" class="btn btn-warning w-100 py-2 fw-semibold mb-3">
                            <i class="bi bi-check2-circle me-1"></i> Kích hoạt tài khoản
                        </button>

                        <div class="text-center small text-muted">
                            Chưa nhận được mã?
                            <a href="${pageContext.request.contextPath}/register" class="text-decoration-none">
                                Thử lại
                            </a>
                        </div>
                    </form>

                    <div class="mt-4 p-2 text-center text-muted small">
                        <i class="bi bi-shield-lock text-success me-1"></i>
                        Vui lòng kiểm tra hộp thư đến (hoặc mục Spam/Rác) để lấy mã OTP bảo mật.
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
