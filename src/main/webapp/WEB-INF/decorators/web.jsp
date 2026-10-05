<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:title default="BookVerse - International Bookstore"/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #1a1a2e;
            --secondary: #16213e;
            --accent: #e8b86d;
            --accent-dark: #c99a50;
            --cream: #faf8f5;
            --text-dark: #1c1c1e;
            --text-muted: #6b7280;
            --border: #e5e7eb;
            --white: #ffffff;
            --success: #10b981;
            --danger: #ef4444;
        }

        * { box-sizing: border-box; }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background-color: var(--cream);
            color: var(--text-dark);
            line-height: 1.6;
        }

        /* ===== NAVBAR ===== */
        .main-navbar {
            background: var(--primary);
            border-bottom: 1px solid rgba(255,255,255,0.06);
            padding: 0;
            position: sticky;
            top: 0;
            z-index: 1030;
            box-shadow: 0 4px 20px rgba(0,0,0,0.25);
        }

        .navbar-inner {
            display: flex;
            align-items: center;
            height: 70px;
            gap: 20px;
        }

        .navbar-brand-custom {
            font-family: 'Playfair Display', serif;
            font-size: 1.6rem;
            font-weight: 700;
            color: var(--accent) !important;
            text-decoration: none;
            letter-spacing: -0.5px;
            flex-shrink: 0;
        }
        .navbar-brand-custom span { color: #fff; font-weight: 300; }

        /* Search Bar */
        .nav-search {
            flex: 1;
            max-width: 480px;
        }
        .nav-search-form {
            display: flex;
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.12);
            border-radius: 8px;
            overflow: hidden;
            transition: all 0.2s;
        }
        .nav-search-form:focus-within {
            background: rgba(255,255,255,0.13);
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(232,184,109,0.15);
        }
        .nav-search-form input {
            flex: 1;
            background: transparent;
            border: none;
            outline: none;
            color: #fff;
            padding: 8px 14px;
            font-size: 0.88rem;
        }
        .nav-search-form input::placeholder { color: rgba(255,255,255,0.4); }
        .nav-search-form button {
            background: var(--accent);
            border: none;
            color: var(--primary);
            padding: 8px 14px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background 0.2s;
        }
        .nav-search-form button:hover { background: var(--accent-dark); }

        /* Nav links */
        .nav-links {
            display: flex;
            align-items: center;
            gap: 4px;
            list-style: none;
            margin: 0;
            padding: 0;
        }
        .nav-links a {
            color: rgba(255,255,255,0.75);
            text-decoration: none;
            font-size: 0.85rem;
            font-weight: 500;
            padding: 6px 12px;
            border-radius: 6px;
            transition: all 0.15s;
            white-space: nowrap;
        }
        .nav-links a:hover { color: #fff; background: rgba(255,255,255,0.08); }
        .nav-links a.active { color: var(--accent); }

        .nav-btn-login {
            background: transparent;
            border: 1px solid rgba(255,255,255,0.25);
            color: rgba(255,255,255,0.85) !important;
            border-radius: 7px !important;
        }
        .nav-btn-login:hover {
            background: rgba(255,255,255,0.08) !important;
            border-color: rgba(255,255,255,0.4) !important;
            color: #fff !important;
        }
        .nav-btn-register {
            background: var(--accent) !important;
            color: var(--primary) !important;
            font-weight: 600 !important;
            border-radius: 7px !important;
            border: none !important;
        }
        .nav-btn-register:hover { background: var(--accent-dark) !important; }

        .nav-admin-badge {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            color: #1a1a2e !important;
            font-weight: 700 !important;
            font-size: 0.78rem !important;
            border-radius: 6px !important;
            padding: 5px 11px !important;
        }
        .nav-admin-badge:hover { background: linear-gradient(135deg, #d97706, #b45309) !important; }

        /* Sub-navbar category bar */
        .category-bar {
            background: var(--secondary);
            border-bottom: 1px solid rgba(255,255,255,0.05);
            padding: 0;
        }
        .category-bar ul {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
            gap: 0;
            overflow-x: auto;
        }
        .category-bar ul a {
            display: block;
            color: rgba(255,255,255,0.65);
            text-decoration: none;
            font-size: 0.82rem;
            font-weight: 500;
            padding: 9px 16px;
            transition: all 0.15s;
            white-space: nowrap;
            border-bottom: 2px solid transparent;
        }
        .category-bar ul a:hover {
            color: var(--accent);
            background: rgba(255,255,255,0.04);
            border-bottom-color: var(--accent);
        }

        /* ===== FOOTER ===== */
        .main-footer {
            background: var(--primary);
            color: rgba(255,255,255,0.7);
            padding: 48px 0 0;
            margin-top: 80px;
        }
        .footer-brand {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--accent);
        }
        .footer-desc {
            font-size: 0.85rem;
            line-height: 1.7;
            color: rgba(255,255,255,0.5);
            margin-top: 12px;
        }
        .footer-heading {
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            color: var(--accent);
            margin-bottom: 16px;
        }
        .footer-links {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .footer-links li { margin-bottom: 9px; }
        .footer-links a {
            color: rgba(255,255,255,0.5);
            text-decoration: none;
            font-size: 0.85rem;
            transition: color 0.15s;
        }
        .footer-links a:hover { color: var(--accent); }
        .footer-bottom {
            background: rgba(0,0,0,0.2);
            padding: 16px 0;
            margin-top: 40px;
            font-size: 0.82rem;
            color: rgba(255,255,255,0.35);
        }
        .footer-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            color: var(--accent);
            font-size: 0.8rem;
        }

        /* ===== GENERAL COMPONENTS ===== */
        .btn-accent {
            background: var(--accent);
            color: var(--primary);
            font-weight: 600;
            border: none;
            border-radius: 8px;
            padding: 10px 22px;
            transition: all 0.2s;
        }
        .btn-accent:hover {
            background: var(--accent-dark);
            color: var(--primary);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(232,184,109,0.3);
        }

        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.7rem;
            font-weight: 700;
            color: var(--primary);
        }
        .section-subtitle {
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        /* Dropdown */
        .user-dropdown .dropdown-menu {
            border: 1px solid var(--border);
            border-radius: 10px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.12);
            padding: 6px;
            min-width: 200px;
        }
        .user-dropdown .dropdown-item {
            border-radius: 6px;
            font-size: 0.87rem;
            padding: 8px 14px;
        }

        <sitemesh:head/>
    </style>
</head>
<body>

<!-- ===== MAIN NAVBAR ===== -->
<nav class="main-navbar">
    <div class="container">
        <div class="navbar-inner">
            <!-- Brand -->
            <a class="navbar-brand-custom" href="${pageContext.request.contextPath}/home">
                BookVerse
            </a>

            <!-- Search Bar -->
            <div class="nav-search d-none d-md-block">
                <form class="nav-search-form" action="${pageContext.request.contextPath}/home" method="get">
                    <input type="text" name="q" placeholder="Tìm kiếm sách, tác giả, thể loại...">
                    <button type="submit"><i class="bi bi-search"></i></button>
                </form>
            </div>

            <!-- Nav Actions -->
            <ul class="nav-links ms-auto">
                <li><a href="${pageContext.request.contextPath}/home">
                    <i class="bi bi-house me-1"></i>Trang Chủ
                </a></li>
                <li><a href="${pageContext.request.contextPath}/home">
                    <i class="bi bi-grid me-1"></i>Sản phẩm
                </a></li>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <c:if test="${sessionScope.user.isAdmin}">
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/books" class="nav-admin-badge">
                                    <i class="bi bi-shield-shaded me-1"></i>Quản trị
                                </a>
                            </li>
                        </c:if>
                        <li class="user-dropdown dropdown">
                            <a href="#" class="dropdown-toggle" data-bs-toggle="dropdown"
                               style="color:rgba(255,255,255,0.85);text-decoration:none;font-size:0.85rem;padding:6px 12px;">
                                <i class="bi bi-person-circle me-1" style="color:var(--accent)"></i>
                                ${not empty sessionScope.user.fullname ? sessionScope.user.fullname : sessionScope.user.email}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <c:if test="${sessionScope.user.isAdmin}">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/books">
                                        <i class="bi bi-speedometer2 me-2 text-warning"></i>Quản lý Sách
                                    </a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/authors">
                                        <i class="bi bi-people me-2 text-info"></i>Quản lý Tác giả
                                    </a></li>
                                    <li><hr class="dropdown-divider"></li>
                                </c:if>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                                    <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                </a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${pageContext.request.contextPath}/login" class="nav-btn-login">
                            <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
                        </a></li>
                        <li><a href="${pageContext.request.contextPath}/register" class="nav-btn-register">
                            <i class="bi bi-person-plus me-1"></i>Đăng ký
                        </a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- Category Bar -->
<div class="category-bar">
    <div class="container">
        <ul>
            <li><a href="${pageContext.request.contextPath}/home"><i class="bi bi-fire me-1"></i>Bestsellers</a></li>
            <li><a href="${pageContext.request.contextPath}/home">Văn học Việt Nam</a></li>
            <li><a href="${pageContext.request.contextPath}/home">Tiểu thuyết</a></li>
            <li><a href="${pageContext.request.contextPath}/home">Thiếu nhi</a></li>
            <li><a href="${pageContext.request.contextPath}/home">Kinh dị & Phiêu lưu</a></li>
            <li><a href="${pageContext.request.contextPath}/home">Khoa học</a></li>
            <li><a href="${pageContext.request.contextPath}/home">Kỹ năng sống</a></li>
            <li><a href="${pageContext.request.contextPath}/home"><i class="bi bi-tag me-1"></i>Ưu đãi</a></li>
        </ul>
    </div>
</div>

<!-- Main Content -->
<main>
    <sitemesh:body/>
</main>

<!-- ===== FOOTER ===== -->
<footer class="main-footer">
    <div class="container">
        <div class="row g-5">
            <div class="col-lg-4">
                <div class="footer-brand">BookVerse</div>
                <p class="footer-desc">
                    Hệ thống sách quốc tế hàng đầu, mang đến hàng nghìn đầu sách chất lượng
                    từ khắp nơi trên thế giới. Khám phá tri thức, mở rộng tầm nhìn.
                </p>
                <div class="d-flex gap-3 mt-3">
                    <a href="#" class="text-decoration-none" style="color:rgba(255,255,255,0.4);font-size:1.2rem;"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="text-decoration-none" style="color:rgba(255,255,255,0.4);font-size:1.2rem;"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="text-decoration-none" style="color:rgba(255,255,255,0.4);font-size:1.2rem;"><i class="bi bi-twitter-x"></i></a>
                    <a href="#" class="text-decoration-none" style="color:rgba(255,255,255,0.4);font-size:1.2rem;"><i class="bi bi-youtube"></i></a>
                </div>
            </div>
            <div class="col-sm-4 col-lg-2">
                <div class="footer-heading">Khám phá</div>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/home">Sản phẩm</a></li>
                    <li><a href="${pageContext.request.contextPath}/home">Bestsellers</a></li>
                    <li><a href="${pageContext.request.contextPath}/home">Sách mới</a></li>
                </ul>
            </div>
            <div class="col-sm-4 col-lg-2">
                <div class="footer-heading">Hỗ trợ</div>
                <ul class="footer-links">
                    <li><a href="#">Chính sách vận chuyển</a></li>
                    <li><a href="#">Đổi trả sản phẩm</a></li>
                    <li><a href="#">Bảo mật thông tin</a></li>
                    <li><a href="#">Liên hệ</a></li>
                </ul>
            </div>
            <div class="col-sm-4 col-lg-4">
                <div class="footer-heading">Đăng ký nhận ưu đãi</div>
                <p style="font-size:0.83rem;color:rgba(255,255,255,0.4);">
                    Nhận thông tin ưu đãi và sách mới hàng tuần.
                </p>
                <div class="d-flex gap-2">
                    <input type="email" class="form-control form-control-sm"
                           placeholder="Email của bạn..."
                           style="background:rgba(255,255,255,0.07);border:1px solid rgba(255,255,255,0.12);color:#fff;border-radius:7px;">
                    <button class="btn btn-sm btn-accent px-3 flex-shrink-0">Đăng ký</button>
                </div>
                <div class="mt-4 d-flex gap-3 flex-wrap">
                    <div style="font-size:0.78rem;color:rgba(255,255,255,0.35);">
                        <i class="bi bi-shield-check text-success me-1"></i>Thanh toán an toàn
                    </div>
                    <div style="font-size:0.78rem;color:rgba(255,255,255,0.35);">
                        <i class="bi bi-truck text-info me-1"></i>Giao hàng toàn quốc
                    </div>
                    <div style="font-size:0.78rem;color:rgba(255,255,255,0.35);">
                        <i class="bi bi-arrow-return-left text-warning me-1"></i>Đổi trả 30 ngày
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <div class="container d-flex justify-content-between align-items-center flex-wrap gap-2">
            <div>© 2026 BookVerse International. All rights reserved.</div>
            <div class="footer-badge">
                <i class="bi bi-person-badge"></i>
                Trương Quốc Duy &nbsp;|&nbsp; MSSV: 24133009 &nbsp;|&nbsp; Đề 1
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
