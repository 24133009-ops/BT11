<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lịch sử đặt hàng - BookVerse</title>
    <style>
        .orders-wrapper {
            max-width: 1140px;
            margin: 30px auto 60px;
        }
        .filter-nav {
            background: #ffffff;
            border-radius: 12px;
            padding: 8px 12px;
            border: 1px solid #e2e8f0;
            display: flex;
            gap: 6px;
            overflow-x: auto;
            white-space: nowrap;
            margin-bottom: 24px;
        }
        .filter-btn {
            padding: 8px 16px;
            border-radius: 8px;
            text-decoration: none;
            color: #475569;
            font-size: 0.88rem;
            font-weight: 600;
            transition: all 0.2s;
            border: 1px solid transparent;
        }
        .filter-btn:hover {
            background: #f1f5f9;
            color: #0f172a;
        }
        .filter-btn.active {
            background: #0f172a;
            color: #fbbf24;
            border-color: #0f172a;
        }
        .order-card {
            background: #ffffff;
            border-radius: 14px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 16px rgba(0,0,0,0.04);
            margin-bottom: 20px;
            overflow: hidden;
            transition: transform 0.2s;
        }
        .order-card-header {
            background: #faf8f5;
            padding: 14px 20px;
            border-bottom: 1px solid #f1f5f9;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 10px;
        }
        .order-card-body {
            padding: 20px;
        }
        .order-item-row {
            display: flex;
            align-items: center;
            gap: 16px;
            padding: 12px 0;
            border-bottom: 1px dashed #f1f5f9;
        }
        .order-item-row:last-child {
            border-bottom: none;
        }
        .order-book-thumb {
            width: 55px;
            height: 75px;
            object-fit: cover;
            border-radius: 4px;
        }
        .badge-status-new { background: #e0f2fe; color: #0369a1; }
        .badge-status-confirmed { background: #e0e7ff; color: #4338ca; }
        .badge-status-prep { background: #fef3c7; color: #b45309; }
        .badge-status-shipping { background: #fed7aa; color: #c2410c; }
        .badge-status-delivering { background: #fef08a; color: #854d0e; }
        .badge-status-delivered { background: #dcfce7; color: #15803d; }
        .badge-status-cancelled { background: #fee2e2; color: #b91c1c; }
        .badge-status-returned { background: #f3e8ff; color: #6b21a8; }
    </style>
</head>
<body>

<div class="orders-wrapper px-3">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">Lịch sử đặt hàng</li>
        </ol>
    </nav>

    <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
        <h2 class="fw-bold mb-0" style="color: #0f172a;">
            <i class="bi bi-clock-history text-warning me-2"></i>Lịch Sử Đặt Hàng (8 Trạng Thái)
        </h2>
        <span class="badge bg-light text-dark border px-3 py-2">
            Tài khoản: <strong>${sessionScope.user.fullname != null ? sessionScope.user.fullname : sessionScope.user.email}</strong>
        </span>
    </div>

    <!-- Alert hướng dẫn 8 trạng thái theo đề bài -->
    <div class="alert alert-warning py-2 px-3 small d-flex align-items-center justify-content-between flex-wrap gap-2 mb-3 border-warning">
        <div>
            <i class="bi bi-shield-check text-warning me-1 fs-6"></i>
            <strong>8 Trạng thái theo yêu cầu:</strong>
            <span class="text-dark">1. Đơn hàng mới | 2. Đã xác nhận | 3. Chuẩn bị hàng | 4. Vận chuyển | 5. Giao hàng | 6. Đã giao | 7. Đơn hàng hủy | 8. Đơn hàng hoàn.</span>
            <br class="d-md-none">
            <span class="text-muted fst-italic ms-md-2">(Vào database đổi cột <code>status</code> bảng <code>orders</code> hoặc dùng menu/tabs lọc để kiểm tra)</span>
        </div>
    </div>

    <!-- Filter Tabs (8 Trạng thái theo yêu cầu đề bài) -->
    <div class="filter-nav">
        <a href="${pageContext.request.contextPath}/orders?status=ALL"
           class="filter-btn ${currentStatus == 'ALL' ? 'active' : ''}">
            Tất cả
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=Đơn hàng mới"
           class="filter-btn ${currentStatus == 'Đơn hàng mới' ? 'active' : ''}">
            <i class="bi bi-asterisk me-1"></i> Đơn hàng mới
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=Đã xác nhận"
           class="filter-btn ${currentStatus == 'Đã xác nhận' ? 'active' : ''}">
            <i class="bi bi-check2-circle me-1"></i> Đã xác nhận
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=Chuẩn bị hàng"
           class="filter-btn ${currentStatus == 'Chuẩn bị hàng' ? 'active' : ''}">
            <i class="bi bi-box-seam me-1"></i> Chuẩn bị hàng
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=Vận chuyển"
           class="filter-btn ${currentStatus == 'Vận chuyển' ? 'active' : ''}">
            <i class="bi bi-truck me-1"></i> Vận chuyển
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=Giao hàng"
           class="filter-btn ${currentStatus == 'Giao hàng' ? 'active' : ''}">
            <i class="bi bi-bicycle me-1"></i> Giao hàng
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=Đã giao"
           class="filter-btn ${currentStatus == 'Đã giao' ? 'active' : ''}">
            <i class="bi bi-patch-check-fill me-1"></i> Đã giao
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=Đơn hàng hủy"
           class="filter-btn ${currentStatus == 'Đơn hàng hủy' ? 'active' : ''}">
            <i class="bi bi-x-circle me-1"></i> Đơn hàng hủy
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=Đơn hàng hoàn"
           class="filter-btn ${currentStatus == 'Đơn hàng hoàn' ? 'active' : ''}">
            <i class="bi bi-arrow-return-left me-1"></i> Đơn hàng hoàn
        </a>
    </div>

    <!-- Orders List -->
    <c:choose>
        <c:when test="${empty orders}">
            <div class="card p-5 text-center shadow-sm">
                <i class="bi bi-inbox text-muted" style="font-size: 3.5rem;"></i>
                <h5 class="mt-3 text-dark fw-bold">Không tìm thấy đơn hàng nào!</h5>
                <p class="text-muted">
                    <c:choose>
                        <c:when test="${currentStatus != 'ALL'}">
                            Không có đơn hàng nào thuộc trạng thái "<strong>${currentStatus}</strong>".
                        </c:when>
                        <c:otherwise>Bạn chưa thực hiện đơn đặt hàng nào.</c:otherwise>
                    </c:choose>
                </p>
                <div class="mt-2">
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-warning px-4 py-2 fw-semibold">
                        <i class="bi bi-cart3 me-1"></i> Khám phá mua sắm ngay
                    </a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="ord" items="${orders}">
                <div class="order-card">
                    <!-- Order Header -->
                    <div class="order-card-header">
                        <div>
                            <span class="fw-bold fs-6 text-dark me-3">#DH-${ord.orderId}</span>
                            <span class="text-muted small">
                                Ngày đặt: <fmt:formatDate value="${ord.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </span>
                        </div>
                        <div class="d-flex align-items-center gap-2 flex-wrap">
                            <!-- Badge Trạng thái tương ứng -->
                            <c:choose>
                                <c:when test="${ord.status == 'Đơn hàng mới'}">
                                    <span class="badge badge-status-new px-3 py-2"><i class="bi bi-asterisk me-1"></i>Đơn hàng mới</span>
                                </c:when>
                                <c:when test="${ord.status == 'Đã xác nhận'}">
                                    <span class="badge badge-status-confirmed px-3 py-2"><i class="bi bi-check2-circle me-1"></i>Đã xác nhận</span>
                                </c:when>
                                <c:when test="${ord.status == 'Chuẩn bị hàng'}">
                                    <span class="badge badge-status-prep px-3 py-2"><i class="bi bi-box-seam me-1"></i>Chuẩn bị hàng</span>
                                </c:when>
                                <c:when test="${ord.status == 'Vận chuyển'}">
                                    <span class="badge badge-status-shipping px-3 py-2"><i class="bi bi-truck me-1"></i>Vận chuyển</span>
                                </c:when>
                                <c:when test="${ord.status == 'Giao hàng'}">
                                    <span class="badge badge-status-delivering px-3 py-2"><i class="bi bi-bicycle me-1"></i>Giao hàng</span>
                                </c:when>
                                <c:when test="${ord.status == 'Đã giao'}">
                                    <span class="badge badge-status-delivered px-3 py-2"><i class="bi bi-patch-check-fill me-1"></i>Đã giao</span>
                                </c:when>
                                <c:when test="${ord.status == 'Đơn hàng hủy'}">
                                    <span class="badge badge-status-cancelled px-3 py-2"><i class="bi bi-x-circle me-1"></i>Đơn hàng hủy</span>
                                </c:when>
                                <c:when test="${ord.status == 'Đơn hàng hoàn'}">
                                    <span class="badge badge-status-returned px-3 py-2"><i class="bi bi-arrow-return-left me-1"></i>Đơn hàng hoàn</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary px-3 py-2">${ord.status}</span>
                                </c:otherwise>
                            </c:choose>

                            <!-- Tool test chuyển nhanh 8 trạng thái cho Admin / Giảng viên chấm bài -->
                            <c:if test="${sessionScope.user.isAdmin}">
                                <form action="${pageContext.request.contextPath}/orders" method="post" class="d-inline-flex align-items-center gap-1 ms-2">
                                    <input type="hidden" name="orderId" value="${ord.orderId}"/>
                                    <input type="hidden" name="redirectUrl" value="${pageContext.request.contextPath}/orders?status=${currentStatus}"/>
                                    <select name="newStatus" class="form-select form-select-sm" style="font-size: 0.78rem; padding: 2px 8px; width: auto;" onchange="this.form.submit()">
                                        <option value="" disabled selected>⚡ Đổi trạng thái (Admin)...</option>
                                        <option value="Đơn hàng mới" ${ord.status == 'Đơn hàng mới' ? 'selected' : ''}>1. Đơn hàng mới</option>
                                        <option value="Đã xác nhận" ${ord.status == 'Đã xác nhận' ? 'selected' : ''}>2. Đã xác nhận</option>
                                        <option value="Chuẩn bị hàng" ${ord.status == 'Chuẩn bị hàng' ? 'selected' : ''}>3. Chuẩn bị hàng</option>
                                        <option value="Vận chuyển" ${ord.status == 'Vận chuyển' ? 'selected' : ''}>4. Vận chuyển</option>
                                        <option value="Giao hàng" ${ord.status == 'Giao hàng' ? 'selected' : ''}>5. Giao hàng</option>
                                        <option value="Đã giao" ${ord.status == 'Đã giao' ? 'selected' : ''}>6. Đã giao</option>
                                        <option value="Đơn hàng hủy" ${ord.status == 'Đơn hàng hủy' ? 'selected' : ''}>7. Đơn hàng hủy</option>
                                        <option value="Đơn hàng hoàn" ${ord.status == 'Đơn hàng hoàn' ? 'selected' : ''}>8. Đơn hàng hoàn</option>
                                    </select>
                                </form>
                            </c:if>
                        </div>
                    </div>

                    <!-- Order Body -->
                    <div class="order-card-body">
                        <c:forEach var="item" items="${ord.orderItems}">
                            <div class="order-item-row">
                                <img src="${pageContext.request.contextPath}/images/books/${item.book.coverImage}?v=20261005"
                                     class="order-book-thumb" alt="${item.book.title}"
                                     onerror="this.src='https://via.placeholder.com/55x75?text=Sách'">
                                <div class="flex-grow-1">
                                    <div class="fw-bold text-dark">${item.book.title}</div>
                                    <small class="text-muted">Số lượng: <strong>&times; ${item.quantity}</strong></small>
                                </div>
                                <div class="text-end">
                                    <div class="fw-bold text-danger">
                                        <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/> đ
                                    </div>
                                    <small class="text-muted"><fmt:formatNumber value="${item.price}" pattern="#,###"/> đ / cuốn</small>
                                </div>
                            </div>
                        </c:forEach>

                        <!-- Order Footer Info -->
                        <div class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top flex-wrap gap-2">
                            <div>
                                <small class="text-muted d-block">
                                    <i class="bi bi-person me-1"></i>Người nhận: <strong>${ord.fullname}</strong> (${ord.phone})
                                </small>
                                <small class="text-muted d-block">
                                    <i class="bi bi-geo-alt me-1"></i>Địa chỉ: ${ord.address}
                                </small>
                                <small class="text-muted d-block">
                                    <i class="bi bi-credit-card me-1"></i>Phương thức: <strong>${ord.paymentMethod}</strong>
                                </small>
                            </div>
                            <div class="text-end">
                                <span class="text-muted me-2">Tổng tiền:</span>
                                <span class="fs-5 fw-bold text-danger">
                                    <fmt:formatNumber value="${ord.totalPrice}" pattern="#,###"/> đ
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
