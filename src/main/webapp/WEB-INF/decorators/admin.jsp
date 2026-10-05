<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi" class="h-100">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - <sitemesh:title default="Quản trị BookStore"/></title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background-color: #f4f6f9;
        }
        .admin-sidebar-nav .nav-link {
            color: rgba(255,255,255,0.8);
            border-radius: 6px;
            margin-bottom: 4px;
            padding: 8px 12px;
        }
        .admin-sidebar-nav .nav-link:hover, .admin-sidebar-nav .nav-link.active {
            color: #fff;
            background-color: rgba(255,255,255,0.15);
        }
    </style>
    <sitemesh:head/>
</head>
<body class="d-flex flex-column h-100">

    <!-- Admin Topbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark border-bottom border-warning border-3">
        <div class="container-fluid px-4">
            <a class="navbar-brand fw-bold text-warning" href="${pageContext.request.contextPath}/admin/books">
                <i class="bi bi-shield-shaded me-2"></i>BookStore Admin
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="adminNavbar">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="bi bi-box-arrow-up-right me-1"></i>Xem trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/books">
                            <i class="bi bi-journal-album me-1"></i>Quản lý Sách
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/authors">
                            <i class="bi bi-people me-1"></i>Quản lý Tác giả
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-warning fw-bold" href="${pageContext.request.contextPath}/orders">
                            <i class="bi bi-box-seam me-1"></i>Quản lý Đơn hàng (8 trạng thái)
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item me-3 text-light">
                        <i class="bi bi-person-fill text-warning me-1"></i>
                        Xin chào, <strong>Trương Quốc Duy (Admin)</strong>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-outline-danger btn-sm" href="${pageContext.request.contextPath}/logout">
                            <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content Area -->
    <main class="flex-shrink-0">
        <sitemesh:body/>
    </main>

    <!-- Footer component -->
    <jsp:include page="/WEB-INF/decorators/footer.jsp"/>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
