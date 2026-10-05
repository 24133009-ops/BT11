<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-book-half text-warning me-2"></i>BookStore
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#userNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="userNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/home">
                        <i class="bi bi-house me-1"></i>Trang Chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">
                        <i class="bi bi-grid me-1"></i>Sản phẩm
                    </a>
                </li>
                <!-- Mục chính: Đơn hàng (8 trạng thái yêu cầu) -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-warning fw-semibold" href="#" role="button" data-bs-toggle="dropdown">
                        <i class="bi bi-box-seam-fill me-1"></i>Đơn hàng (8 trạng thái)
                    </a>
                    <ul class="dropdown-menu shadow">
                        <li class="dropdown-header text-uppercase fw-bold text-muted small">
                            <i class="bi bi-funnel-fill me-1 text-warning"></i>Lọc 8 Trạng Thái
                        </li>
                        <li><a class="dropdown-item fw-bold" href="${pageContext.request.contextPath}/orders?status=ALL">
                            <i class="bi bi-collection-fill me-2 text-primary"></i>Tất cả đơn hàng
                        </a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders?status=Đơn hàng mới">1. Đơn hàng mới</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders?status=Đã xác nhận">2. Đã xác nhận</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders?status=Chuẩn bị hàng">3. Chuẩn bị hàng</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders?status=Vận chuyển">4. Vận chuyển</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders?status=Giao hàng">5. Giao hàng</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders?status=Đã giao">6. Đã giao</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders?status=Đơn hàng hủy">7. Đơn hàng hủy</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders?status=Đơn hàng hoàn">8. Đơn hàng hoàn</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-center fw-bold text-warning bg-dark rounded mx-2 py-2" href="${pageContext.request.contextPath}/orders">
                            <i class="bi bi-clock-history me-1"></i>Xem trang Đơn Hàng
                        </a></li>
                    </ul>
                </li>
                <!-- Trang quản trị: chỉ Admin mới thấy chức năng này -->
                <c:if test="${not empty sessionScope.user && sessionScope.user.isAdmin}">
                    <li class="nav-item">
                        <a class="nav-link text-warning fw-semibold" href="${pageContext.request.contextPath}/admin/books">
                            <i class="bi bi-shield-lock me-1"></i>Trang quản trị
                        </a>
                    </li>
                </c:if>
            </ul>

            <ul class="navbar-nav ms-auto align-items-center">
                <!-- Giỏ hàng -->
                <li class="nav-item me-3">
                    <a class="btn btn-outline-warning btn-sm position-relative" href="${pageContext.request.contextPath}/cart">
                        <i class="bi bi-cart3 me-1"></i>Giỏ hàng
                        <c:if test="${not empty sessionScope.cart && sessionScope.cart.totalQuantity > 0}">
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                ${sessionScope.cart.totalQuantity}
                            </span>
                        </c:if>
                    </a>
                </li>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-light" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle me-1"></i>
                                <c:choose>
                                    <c:when test="${sessionScope.user.isAdmin}">
                                        <strong>Trương Quốc Duy (Admin)</strong>
                                    </c:when>
                                    <c:otherwise>
                                        <strong>${sessionScope.user.fullname != null ? sessionScope.user.fullname : sessionScope.user.email}</strong>
                                    </c:otherwise>
                                </c:choose>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders"><i class="bi bi-clock-history me-2"></i>Lịch sử đặt hàng</a></li>
                                <c:if test="${sessionScope.user.isAdmin}">
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/books"><i class="bi bi-speedometer2 me-2"></i>Quản trị sách</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/authors"><i class="bi bi-people me-2"></i>Quản trị tác giả</a></li>
                                </c:if>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/orders">
                                <i class="bi bi-clock-history me-1"></i>Đơn hàng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-outline-warning btn-sm ms-2" href="${pageContext.request.contextPath}/register">
                                <i class="bi bi-person-plus me-1"></i>Đăng ký
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
