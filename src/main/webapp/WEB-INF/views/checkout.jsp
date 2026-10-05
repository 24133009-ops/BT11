<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh toán đơn hàng (COD) - BookVerse</title>
    <style>
        .checkout-wrapper {
            max-width: 1040px;
            margin: 30px auto 60px;
        }
        .checkout-card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            border: 1px solid #eef2f6;
            padding: 30px;
        }
        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.3rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f8fafc;
        }
        .cod-box {
            background: #f0fdf4;
            border: 2px solid #86efac;
            border-radius: 12px;
            padding: 16px;
            display: flex;
            align-items: center;
            gap: 14px;
        }
        .cod-radio {
            accent-color: #16a34a;
            width: 20px;
            height: 20px;
        }
        .order-summary-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 0;
            border-bottom: 1px dashed #e2e8f0;
        }
        .order-summary-img {
            width: 50px;
            height: 70px;
            object-fit: cover;
            border-radius: 4px;
        }
        .btn-order {
            background: #c92127;
            color: #ffffff;
            font-weight: 700;
            font-size: 1.05rem;
            padding: 14px;
            border-radius: 10px;
            border: none;
            width: 100%;
            transition: all 0.2s;
        }
        .btn-order:hover {
            background: #a8171c;
            color: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(201,33,39,0.3);
        }
    </style>
</head>
<body>

<div class="checkout-wrapper px-3">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cart" class="text-decoration-none">Giỏ hàng</a></li>
            <li class="breadcrumb-item active" aria-current="page">Thanh toán COD</li>
        </ol>
    </nav>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <h2 class="fw-bold mb-4" style="color: #0f172a;">
        <i class="bi bi-credit-card-2-front text-warning me-2"></i>Thanh Toán Đơn Hàng (COD)
    </h2>

    <form action="${pageContext.request.contextPath}/checkout" method="post">
        <div class="row g-4">
            <!-- Delivery Info Form -->
            <div class="col-lg-7">
                <div class="checkout-card mb-4">
                    <h3 class="section-title">
                        <i class="bi bi-geo-alt-fill text-danger me-2"></i>Thông Tin Giao Hàng
                    </h3>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Họ và tên người nhận <span class="text-danger">*</span></label>
                        <input type="text" name="fullname" class="form-control form-control-lg" required
                               placeholder="Ví dụ: Nguyễn Văn A"
                               value="${fullname != null ? fullname : (currentUser != null ? currentUser.fullname : '')}"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Số điện thoại liên hệ <span class="text-danger">*</span></label>
                        <input type="text" name="phone" class="form-control form-control-lg" required
                               placeholder="Ví dụ: 0912345678"
                               value="${phone != null ? phone : (currentUser != null && currentUser.phone != null ? '0' + currentUser.phone : '')}"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Địa chỉ nhận hàng chi tiết <span class="text-danger">*</span></label>
                        <textarea name="address" rows="3" class="form-control" required
                                  placeholder="Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố...">${address != null ? address : ''}</textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Ghi chú giao hàng (nếu có)</label>
                        <textarea name="note" rows="2" class="form-control"
                                  placeholder="Giao giờ hành chính, gọi trước khi giao...">${note != null ? note : ''}</textarea>
                    </div>
                </div>

                <!-- Payment Method (COD) -->
                <div class="checkout-card">
                    <h3 class="section-title">
                        <i class="bi bi-wallet2 text-success me-2"></i>Phương Thức Thanh Toán
                    </h3>

                    <div class="cod-box">
                        <input type="radio" name="paymentMethod" value="COD" checked class="cod-radio" id="pmCOD"/>
                        <label for="pmCOD" class="mb-0 flex-grow-1 cursor-pointer">
                            <div class="d-flex align-items-center justify-content-between">
                                <strong class="text-success fs-5">
                                    <i class="bi bi-cash-stack me-2"></i>Thanh toán khi nhận hàng (COD)
                                </strong>
                                <span class="badge bg-success">Khuyên dùng</span>
                            </div>
                            <small class="text-muted d-block mt-1">
                                Quý khách được kiểm tra hàng trước khi thanh toán tiền mặt cho nhân viên giao hàng.
                            </small>
                        </label>
                    </div>
                </div>
            </div>

            <!-- Order Review Sidebar -->
            <div class="col-lg-5">
                <div class="checkout-card">
                    <h3 class="section-title">
                        <i class="bi bi-bag-check text-warning me-2"></i>Đơn Hàng Của Bạn (${sessionScope.cart.totalQuantity} cuốn)
                    </h3>

                    <div class="order-items-scroll mb-3" style="max-height: 320px; overflow-y: auto;">
                        <c:forEach var="item" items="${sessionScope.cart.items}">
                            <div class="order-summary-item">
                                <img src="${pageContext.request.contextPath}/images/books/${item.book.coverImage}"
                                     class="order-summary-img" alt="${item.book.title}"
                                     onerror="this.src='https://via.placeholder.com/50x70?text=Sách'">
                                <div class="flex-grow-1">
                                    <div class="fw-semibold text-dark small text-truncate" style="max-width: 190px;">
                                        ${item.book.title}
                                    </div>
                                    <small class="text-muted">SL: <strong>${item.quantity}</strong> &times; <fmt:formatNumber value="${item.book.price}" pattern="#,###"/> đ</small>
                                </div>
                                <div class="fw-bold text-danger small">
                                    <fmt:formatNumber value="${item.subtotal}" pattern="#,###"/> đ
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Tạm tính:</span>
                        <span class="fw-bold"><fmt:formatNumber value="${sessionScope.cart.totalPrice}" pattern="#,###"/> đ</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Phí vận chuyển COD:</span>
                        <span class="text-success fw-bold">0 đ (Miễn phí)</span>
                    </div>

                    <hr class="my-3">

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <span class="fw-bold fs-5 text-dark">Tổng cộng:</span>
                        <span class="fw-bold fs-4 text-danger">
                            <fmt:formatNumber value="${sessionScope.cart.totalPrice}" pattern="#,###"/> đ
                        </span>
                    </div>

                    <button type="submit" class="btn-order">
                        <i class="bi bi-bag-check-fill me-2"></i> Xác Nhận Đặt Hàng COD
                    </button>

                    <div class="text-center mt-3">
                        <a href="${pageContext.request.contextPath}/cart" class="text-decoration-none text-muted small">
                            <i class="bi bi-pencil-square me-1"></i> Quay lại sửa giỏ hàng
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

</body>
</html>
