<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Giỏ hàng của bạn - BookVerse</title>
    <style>
        .cart-wrapper {
            max-width: 1140px;
            margin: 30px auto 60px;
        }
        .cart-card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            border: 1px solid #eef2f6;
            padding: 24px;
        }
        .cart-table th {
            border-top: none;
            color: #64748b;
            font-size: 0.85rem;
            text-transform: uppercase;
            font-weight: 700;
            padding-bottom: 16px;
        }
        .cart-item-row td {
            vertical-align: middle;
            padding: 18px 8px;
            border-bottom: 1px solid #f1f5f9;
        }
        .cart-book-img {
            width: 70px;
            height: 95px;
            object-fit: cover;
            border-radius: 6px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.12);
        }
        .cart-qty-input {
            width: 60px;
            text-align: center;
            font-weight: 600;
        }
        .summary-card {
            background: #faf8f5;
            border-radius: 16px;
            border: 1px solid #fae8d2;
            padding: 26px;
        }
        .summary-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.35rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 20px;
        }
        .btn-checkout {
            background: #c92127;
            color: #ffffff;
            font-weight: 700;
            font-size: 1rem;
            padding: 14px;
            border-radius: 10px;
            border: none;
            width: 100%;
            transition: all 0.2s;
            display: inline-block;
            text-align: center;
            text-decoration: none;
        }
        .btn-checkout:hover {
            background: #a8171c;
            color: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 4px 14px rgba(201,33,39,0.3);
        }
    </style>
</head>
<body>

<div class="cart-wrapper px-3">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">Giỏ hàng</li>
        </ol>
    </nav>

    <!-- Flash alerts -->
    <c:if test="${not empty sessionScope.cartSuccess}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>${sessionScope.cartSuccess}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="cartSuccess" scope="session"/>
    </c:if>
    <c:if test="${not empty sessionScope.cartWarning}">
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>${sessionScope.cartWarning}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="cartWarning" scope="session"/>
    </c:if>
    <c:if test="${not empty sessionScope.cartError}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-x-circle-fill me-2"></i>${sessionScope.cartError}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="cartError" scope="session"/>
    </c:if>

    <h2 class="fw-bold mb-4" style="color: #0f172a;">
        <i class="bi bi-cart3 text-warning me-2"></i>Giỏ Hàng Của Bạn
    </h2>

    <c:choose>
        <c:when test="${empty sessionScope.cart || sessionScope.cart.empty}">
            <div class="cart-card text-center py-5">
                <i class="bi bi-cart-x text-muted" style="font-size: 4rem;"></i>
                <h4 class="mt-3 fw-bold text-dark">Giỏ hàng của bạn đang trống!</h4>
                <p class="text-muted mb-4">Hãy khám phá các đầu sách hấp dẫn và thêm vào giỏ hàng ngay nhé.</p>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-warning px-4 py-2 fw-semibold">
                    <i class="bi bi-arrow-left me-1"></i> Mua sắm ngay
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">
                <!-- Cart Items Table -->
                <div class="col-lg-8">
                    <div class="cart-card">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="text-muted">Tổng cộng: <strong>${sessionScope.cart.totalQuantity}</strong> sản phẩm</span>
                            <a href="${pageContext.request.contextPath}/cart?action=clear"
                               class="btn btn-outline-danger btn-sm"
                               onclick="return confirm('Bạn có chắc chắn muốn xóa toàn bộ giỏ hàng?');">
                                <i class="bi bi-trash me-1"></i> Xóa tất cả
                            </a>
                        </div>

                        <div class="table-responsive">
                            <table class="table cart-table align-middle">
                                <thead>
                                    <tr>
                                        <th>Sách</th>
                                        <th>Đơn giá</th>
                                        <th style="min-width: 140px;">Số lượng</th>
                                        <th>Thành tiền</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${sessionScope.cart.items}">
                                        <tr class="cart-item-row">
                                            <td>
                                                <div class="d-flex align-items-center gap-3">
                                                    <img src="${pageContext.request.contextPath}/images/books/${item.book.coverImage}?v=20261005"
                                                         alt="${item.book.title}"
                                                         class="cart-book-img"
                                                         onerror="this.src='https://via.placeholder.com/70x95?text=Sách'">
                                                    <div>
                                                        <a href="${pageContext.request.contextPath}/book-detail?id=${item.book.bookId}"
                                                           class="text-decoration-none fw-bold text-dark d-block">
                                                            ${item.book.title}
                                                        </a>
                                                        <small class="text-muted">Tồn kho: <strong>${item.book.quantity}</strong> cuốn</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="fw-semibold text-danger">
                                                <fmt:formatNumber value="${item.book.price}" pattern="#,###"/> đ
                                            </td>
                                            <td>
                                                <!-- Form thay đổi số lượng trong giới hạn -->
                                                <form action="${pageContext.request.contextPath}/cart" method="post" class="d-inline-flex align-items-center gap-1">
                                                    <input type="hidden" name="action" value="update"/>
                                                    <input type="hidden" name="bookId" value="${item.book.bookId}"/>
                                                    
                                                    <!-- Nút giảm -->
                                                    <button type="button" class="btn btn-outline-secondary btn-sm"
                                                            onclick="var inp=this.form.quantity; if(parseInt(inp.value)>1){inp.value=parseInt(inp.value)-1; this.form.submit();}">
                                                        -
                                                    </button>
                                                    
                                                    <!-- Input số lượng trong giới hạn 1 đến maxStock -->
                                                    <input type="number" name="quantity" value="${item.quantity}"
                                                           min="1" max="${item.book.quantity}"
                                                           class="form-control form-control-sm cart-qty-input"
                                                           onchange="this.form.submit();"/>
                                                    
                                                    <!-- Nút tăng -->
                                                    <button type="button" class="btn btn-outline-secondary btn-sm"
                                                            onclick="var inp=this.form.quantity; var mx=parseInt(inp.max); if(parseInt(inp.value)<mx){inp.value=parseInt(inp.value)+1; this.form.submit();}else{alert('Kho chỉ còn tối đa '+mx+' cuốn!');}">
                                                        +
                                                    </button>
                                                </form>
                                            </td>
                                            <td class="fw-bold text-danger">
                                                <fmt:formatNumber value="${item.subtotal}" pattern="#,###"/> đ
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/cart?action=remove&id=${item.book.bookId}"
                                                   class="btn btn-light text-danger btn-sm"
                                                   title="Xóa sản phẩm"
                                                   onclick="return confirm('Xóa sách này khỏi giỏ hàng?');">
                                                    <i class="bi bi-x-lg"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="mt-3">
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary btn-sm">
                                <i class="bi bi-arrow-left me-1"></i> Tiếp tục chọn sách
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Order Summary & Checkout -->
                <div class="col-lg-4">
                    <div class="summary-card">
                        <h4 class="summary-title"><i class="bi bi-receipt me-2 text-warning"></i>Tóm Tắt Đơn Hàng</h4>
                        
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Tổng số lượng:</span>
                            <span class="fw-bold">${sessionScope.cart.totalQuantity} cuốn</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Tạm tính:</span>
                            <span class="fw-bold"><fmt:formatNumber value="${sessionScope.cart.totalPrice}" pattern="#,###"/> đ</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Phí giao hàng:</span>
                            <span class="text-success fw-bold">MIỄN PHÍ</span>
                        </div>

                        <hr class="my-3" style="border-color: #f0d5b0;">

                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <span class="fw-bold fs-5 text-dark">Tổng thanh toán:</span>
                            <span class="fw-bold fs-4 text-danger">
                                <fmt:formatNumber value="${sessionScope.cart.totalPrice}" pattern="#,###"/> đ
                            </span>
                        </div>

                        <a href="${pageContext.request.contextPath}/checkout" class="btn-checkout">
                            <i class="bi bi-shield-check me-1"></i> Thanh Toán (COD)
                        </a>

                        <div class="mt-3 text-center text-muted small">
                            <i class="bi bi-truck me-1"></i> Hỗ trợ nhận hàng kiểm tra rồi mới thanh toán (COD).
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
