<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đặt hàng thành công - BookVerse</title>
    <style>
        .success-box {
            max-width: 680px;
            margin: 50px auto;
            background: #ffffff;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.06);
            border: 1px solid #e2e8f0;
            text-align: center;
        }
        .success-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: #dcfce7;
            color: #16a34a;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2.8rem;
            margin-bottom: 20px;
        }
        .order-info-card {
            background: #faf8f5;
            border: 1px solid #fae8d2;
            border-radius: 12px;
            padding: 20px;
            text-align: left;
            margin: 24px 0;
        }
    </style>
</head>
<body>

<div class="container px-3">
    <div class="success-box">
        <div class="success-icon">
            <i class="bi bi-check-lg"></i>
        </div>
        <h2 class="fw-bold text-dark">Đặt Hàng Thành Công!</h2>
        <p class="text-muted">Cảm ơn bạn đã tin tưởng mua sắm tại BookVerse. Đơn hàng của bạn đã được ghi nhận vào hệ thống.</p>

        <c:if test="${not empty order}">
            <div class="order-info-card">
                <div class="row g-2 mb-2">
                    <div class="col-sm-5 text-muted">Mã đơn hàng:</div>
                    <div class="col-sm-7 fw-bold text-danger">#DH-${order.orderId}</div>
                </div>
                <div class="row g-2 mb-2">
                    <div class="col-sm-5 text-muted">Người nhận:</div>
                    <div class="col-sm-7 fw-semibold text-dark">${order.fullname} (${order.phone})</div>
                </div>
                <div class="row g-2 mb-2">
                    <div class="col-sm-5 text-muted">Địa chỉ nhận hàng:</div>
                    <div class="col-sm-7 text-dark">${order.address}</div>
                </div>
                <div class="row g-2 mb-2">
                    <div class="col-sm-5 text-muted">Phương thức thanh toán:</div>
                    <div class="col-sm-7"><span class="badge bg-success">Thanh toán khi nhận hàng (COD)</span></div>
                </div>
                <div class="row g-2 mb-2">
                    <div class="col-sm-5 text-muted">Trạng thái:</div>
                    <div class="col-sm-7"><span class="badge bg-primary">${order.status}</span></div>
                </div>
                <div class="row g-2">
                    <div class="col-sm-5 text-muted">Tổng tiền:</div>
                    <div class="col-sm-7 fw-bold text-danger fs-5">
                        <fmt:formatNumber value="${order.totalPrice}" pattern="#,###"/> đ
                    </div>
                </div>
            </div>
        </c:if>

        <div class="d-flex justify-content-center gap-3 flex-wrap">
            <a href="${pageContext.request.contextPath}/orders" class="btn btn-warning px-4 py-2 fw-semibold">
                <i class="bi bi-clock-history me-1"></i> Xem lịch sử đơn hàng
            </a>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-dark px-4 py-2 fw-semibold">
                <i class="bi bi-house me-1"></i> Về trang chủ
            </a>
        </div>
    </div>
</div>

</body>
</html>
