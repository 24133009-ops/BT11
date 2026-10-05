<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết đơn hàng #DH-${order.orderId} - BookVerse</title>
    <style>
        .order-detail-wrapper {
            max-width: 900px;
            margin: 30px auto 60px;
        }
        .detail-card {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            padding: 30px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }
    </style>
</head>
<body>

<div class="order-detail-wrapper px-3">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/orders" class="text-decoration-none">Lịch sử đơn hàng</a></li>
            <li class="breadcrumb-item active" aria-current="page">Chi tiết #DH-${order.orderId}</li>
        </ol>
    </nav>

    <c:choose>
        <c:when test="${empty order}">
            <div class="alert alert-danger">Không tìm thấy đơn hàng yêu cầu!</div>
        </c:when>
        <c:otherwise>
            <div class="detail-card">
                <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom flex-wrap gap-2">
                    <div>
                        <h3 class="fw-bold text-dark mb-1">Đơn Hàng #DH-${order.orderId}</h3>
                        <small class="text-muted">Ngày đặt: <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></small>
                    </div>
                    <div>
                        <span class="badge bg-primary fs-6 px-3 py-2">${order.status}</span>
                    </div>
                </div>

                <div class="row g-4 mb-4">
                    <div class="col-md-6">
                        <div class="p-3 bg-light rounded-3">
                            <h6 class="fw-bold text-dark mb-2"><i class="bi bi-geo-alt me-1 text-danger"></i>Thông tin nhận hàng</h6>
                            <div><strong>Người nhận:</strong> ${order.fullname}</div>
                            <div><strong>Điện thoại:</strong> ${order.phone}</div>
                            <div><strong>Địa chỉ:</strong> ${order.address}</div>
                            <c:if test="${not empty order.note}">
                                <div><strong>Ghi chú:</strong> ${order.note}</div>
                            </c:if>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="p-3 bg-light rounded-3">
                            <h6 class="fw-bold text-dark mb-2"><i class="bi bi-wallet2 me-1 text-success"></i>Thanh toán</h6>
                            <div><strong>Phương thức:</strong> ${order.paymentMethod}</div>
                            <div><strong>Trạng thái thanh toán:</strong> Khi nhận hàng (COD)</div>
                            <div><strong>Phí vận chuyển:</strong> 0 đ (Miễn phí)</div>
                        </div>
                    </div>
                </div>

                <h5 class="fw-bold text-dark mb-3"><i class="bi bi-bag me-1 text-warning"></i>Danh sách sản phẩm</h5>
                <div class="table-responsive mb-4">
                    <table class="table align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Sách</th>
                                <th>Đơn giá</th>
                                <th>Số lượng</th>
                                <th class="text-end">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${order.orderItems}">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center gap-3">
                                            <img src="${pageContext.request.contextPath}/images/books/${item.book.coverImage}?v=20261005"
                                                 style="width: 50px; height: 70px; object-fit: cover; border-radius: 4px;"
                                                 alt="${item.book.title}"
                                                 onerror="this.src='https://via.placeholder.com/50x70?text=Sách'">
                                            <div class="fw-semibold text-dark">${item.book.title}</div>
                                        </div>
                                    </td>
                                    <td><fmt:formatNumber value="${item.price}" pattern="#,###"/> đ</td>
                                    <td>${item.quantity}</td>
                                    <td class="text-end fw-bold text-danger">
                                        <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/> đ
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="3" class="text-end fw-bold fs-6">Tổng tiền:</td>
                                <td class="text-end fw-bold fs-5 text-danger">
                                    <fmt:formatNumber value="${order.totalPrice}" pattern="#,###"/> đ
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>

                <div class="text-end">
                    <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-dark">
                        <i class="bi bi-arrow-left me-1"></i> Quay lại danh sách đơn hàng
                    </a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
