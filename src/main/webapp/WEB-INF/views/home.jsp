<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>Trang chủ - BookVerse International Bookstore</title>
<style>
:root {
    --ink: #111827;
    --ink-light: #1f2937;
    --gold: #f59e0b;
    --gold-dark: #d97706;
    --red-price: #c92127;
    --surface: #ffffff;
    --bg-page: #f8fafc;
    --border-color: #e2e8f0;
}

body {
    background-color: var(--bg-page);
}

/* ==================== HERO SECTION ==================== */
.hero {
    background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #0a0f1d 100%);
    position: relative;
    padding: 60px 0 70px;
    overflow: hidden;
    color: #fff;
}
.hero::before {
    content: '';
    position: absolute;
    width: 650px;
    height: 650px;
    background: radial-gradient(circle, rgba(245, 158, 11, 0.12) 0%, transparent 70%);
    top: -150px;
    right: -100px;
    pointer-events: none;
}
.hero-badge {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: rgba(245, 158, 11, 0.15);
    border: 1px solid rgba(245, 158, 11, 0.35);
    color: #fbbf24;
    font-size: 0.78rem;
    font-weight: 700;
    letter-spacing: 1.5px;
    text-transform: uppercase;
    padding: 6px 16px;
    border-radius: 50px;
    margin-bottom: 18px;
}
.hero-title {
    font-family: 'Playfair Display', Georgia, serif;
    font-size: clamp(2.2rem, 4vw, 3.4rem);
    font-weight: 700;
    line-height: 1.2;
    color: #ffffff;
    margin-bottom: 16px;
}
.hero-title em {
    color: #fbbf24;
    font-style: normal;
}
.hero-sub {
    color: rgba(255, 255, 255, 0.68);
    font-size: 1rem;
    line-height: 1.7;
    max-width: 480px;
    margin-bottom: 28px;
}
.btn-gold {
    background: #f59e0b;
    color: #111827;
    font-weight: 700;
    font-size: 0.92rem;
    padding: 12px 26px;
    border-radius: 10px;
    text-decoration: none;
    transition: all 0.25s ease;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    box-shadow: 0 4px 14px rgba(245, 158, 11, 0.35);
}
.btn-gold:hover {
    background: #d97706;
    color: #111827;
    transform: translateY(-2px);
    box-shadow: 0 8px 22px rgba(245, 158, 11, 0.45);
}
.btn-outline-light-custom {
    color: rgba(255,255,255,0.85);
    font-weight: 600;
    font-size: 0.92rem;
    padding: 12px 24px;
    border-radius: 10px;
    text-decoration: none;
    border: 1px solid rgba(255,255,255,0.25);
    transition: all 0.2s;
    display: inline-flex;
    align-items: center;
    gap: 8px;
}
.btn-outline-light-custom:hover {
    background: rgba(255,255,255,0.1);
    color: #fff;
    border-color: rgba(255,255,255,0.5);
}

.hero-stats {
    display: flex;
    gap: 28px;
    margin-top: 36px;
    padding-top: 24px;
    border-top: 1px solid rgba(255, 255, 255, 0.1);
}
.stat-num {
    font-family: 'Playfair Display', serif;
    font-size: 1.75rem;
    font-weight: 700;
    color: #fbbf24;
}
.stat-label {
    font-size: 0.75rem;
    color: rgba(255, 255, 255, 0.5);
    text-transform: uppercase;
    letter-spacing: 1px;
}

/* Hero Book Showcase (3D Stack) */
.hero-stage {
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    height: 360px;
}
.hero-showcase-book {
    position: absolute;
    border-radius: 4px 10px 10px 4px;
    overflow: hidden;
    box-shadow: -6px 8px 24px rgba(0,0,0,0.5);
    transition: transform 0.4s ease;
}
.hero-showcase-book img {
    display: block;
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.hero-showcase-book:hover {
    transform: translateY(-8px) scale(1.05) !important;
    z-index: 10 !important;
}

/* ==================== TRUST STRIP ==================== */
.trust-strip {
    background: #ffffff;
    border-bottom: 1px solid var(--border-color);
    padding: 16px 0;
    box-shadow: 0 2px 10px rgba(0,0,0,0.03);
}
.trust-item {
    display: flex;
    align-items: center;
    gap: 14px;
    font-size: 0.86rem;
}
.trust-item i {
    font-size: 1.7rem;
    color: #d97706;
}
.trust-item strong {
    display: block;
    color: #111827;
    font-size: 0.92rem;
    margin-bottom: 2px;
}
.trust-item span {
    color: #64748b;
    font-size: 0.8rem;
}

/* ==================== SECTION TITLE ==================== */
.section-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    margin-bottom: 30px;
}
.section-tag {
    font-size: 0.75rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1.5px;
    color: #d97706;
    margin-bottom: 4px;
}
.section-heading {
    font-family: 'Playfair Display', Georgia, serif;
    font-size: 1.85rem;
    font-weight: 700;
    color: #0f172a;
    margin: 0;
}
.section-underline {
    width: 48px;
    height: 3px;
    background: #f59e0b;
    border-radius: 2px;
    margin-top: 8px;
}

/* ==================== BOOK CARDS (FAHASA STYLE) ==================== */
.book-card {
    background: #ffffff;
    border-radius: 14px;
    border: 1px solid #e2e8f0;
    box-shadow: 0 4px 16px rgba(0,0,0,0.05);
    overflow: hidden;
    display: flex;
    flex-direction: column;
    height: 100%;
    transition: transform 0.3s cubic-bezier(0.2, 0.8, 0.2, 1), box-shadow 0.3s ease;
}
.book-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 16px 36px rgba(0,0,0,0.11);
    border-color: #cbd5e1;
}

/* Cover Wrapper */
.book-cover-wrap {
    height: 270px;
    background: linear-gradient(180deg, #f8fafc 0%, #edf2f7 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    padding: 16px;
    overflow: hidden;
}
.book-cover-img {
    max-height: 235px;
    max-width: 165px;
    width: auto;
    height: auto;
    object-fit: cover;
    border-radius: 4px 8px 8px 4px;
    box-shadow:
        -4px 2px 8px rgba(0,0,0,0.12),
        4px 6px 18px rgba(0,0,0,0.18);
    transition: transform 0.35s ease, box-shadow 0.35s ease;
}
.book-card:hover .book-cover-img {
    transform: scale(1.05) rotateY(-4deg);
    box-shadow:
        -6px 4px 12px rgba(0,0,0,0.16),
        6px 12px 24px rgba(0,0,0,0.24);
}

/* Floating Badges */
.card-badge {
    position: absolute;
    top: 12px;
    left: 12px;
    font-size: 0.68rem;
    font-weight: 800;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    padding: 4px 10px;
    border-radius: 6px;
    z-index: 2;
}
.badge-new { background: #10b981; color: #fff; }
.badge-hot { background: #ef4444; color: #fff; }
.badge-sale { background: #f59e0b; color: #111827; }

/* Quick View Overlay on Cover */
.cover-overlay {
    position: absolute;
    inset: 0;
    background: rgba(15, 23, 42, 0.45);
    backdrop-filter: blur(2px);
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    transition: opacity 0.25s ease;
}
.book-card:hover .cover-overlay {
    opacity: 1;
}
.btn-quickview {
    background: #ffffff;
    color: #0f172a;
    font-size: 0.82rem;
    font-weight: 700;
    padding: 9px 18px;
    border-radius: 8px;
    text-decoration: none;
    box-shadow: 0 4px 14px rgba(0,0,0,0.25);
    transition: all 0.2s;
    display: inline-flex;
    align-items: center;
    gap: 6px;
}
.btn-quickview:hover {
    background: #f59e0b;
    color: #111827;
}

/* Card Body */
.book-card-body {
    padding: 18px 20px 20px;
    display: flex;
    flex-direction: column;
    flex: 1;
}
.book-author {
    font-size: 0.72rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: #d97706;
    margin-bottom: 6px;
}
.book-title {
    font-family: 'Playfair Display', Georgia, serif;
    font-size: 1.08rem;
    font-weight: 700;
    color: #0f172a;
    line-height: 1.35;
    margin-bottom: 10px;
    text-decoration: none;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    transition: color 0.15s;
}
.book-title:hover {
    color: #d97706;
}

/* Price Box */
.book-price-box {
    display: flex;
    align-items: baseline;
    gap: 10px;
    margin-bottom: 12px;
    padding-bottom: 12px;
    border-bottom: 1px dashed #e2e8f0;
}
.price-current {
    font-size: 1.35rem;
    font-weight: 800;
    color: #c92127;
}
.price-original {
    font-size: 0.82rem;
    color: #94a3b8;
    text-decoration: line-through;
}
.price-discount {
    font-size: 0.7rem;
    font-weight: 800;
    color: #ef4444;
    background: #fee2e2;
    border-radius: 4px;
    padding: 2px 6px;
}

/* Specs Block (Câu 3 Requirement) */
.book-specs {
    font-size: 0.78rem;
    color: #64748b;
    line-height: 1.7;
    margin-bottom: 14px;
    flex: 1;
}
.book-specs strong {
    color: #334155;
    font-weight: 600;
}
.badge-stock {
    font-size: 0.72rem;
    font-weight: 600;
    padding: 2px 8px;
    border-radius: 4px;
}
.badge-in-stock { background: #dcfce7; color: #15803d; }
.badge-out-stock { background: #fee2e2; color: #b91c1c; }

.review-stars-box {
    display: flex;
    align-items: center;
    gap: 6px;
    margin-bottom: 14px;
    font-size: 0.8rem;
}
.star-icons { color: #f59e0b; }
.review-count-label { color: #94a3b8; font-size: 0.74rem; }

/* Bottom Action Button */
.btn-card-action {
    background: #0f172a;
    color: #fbbf24;
    font-weight: 700;
    font-size: 0.85rem;
    text-align: center;
    padding: 10px 16px;
    border-radius: 8px;
    text-decoration: none;
    transition: all 0.2s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}
.btn-card-action:hover {
    background: #f59e0b;
    color: #111827;
}

/* ==================== PAGINATION ==================== */
.pagination-container {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
    margin: 50px 0 20px;
}
.p-btn {
    min-width: 42px;
    height: 42px;
    padding: 0 14px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    border-radius: 10px;
    text-decoration: none;
    font-size: 0.9rem;
    font-weight: 600;
    color: #334155;
    background: #ffffff;
    border: 1.5px solid #cbd5e1;
    transition: all 0.2s;
}
.p-btn:hover {
    background: #0f172a;
    color: #fbbf24;
    border-color: #0f172a;
}
.p-btn.active {
    background: #f59e0b;
    color: #111827;
    border-color: #f59e0b;
    font-weight: 700;
}
.p-btn.disabled {
    opacity: 0.35;
    pointer-events: none;
}
.pagination-info {
    text-align: center;
    font-size: 0.84rem;
    color: #64748b;
    margin-top: 10px;
}

/* ==================== BOTTOM FEATURE SECTION ==================== */
.feature-section {
    background: #0f172a;
    padding: 50px 0;
    margin-top: 50px;
    color: #ffffff;
}
.feature-box {
    background: rgba(255, 255, 255, 0.04);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 14px;
    padding: 26px 22px;
    display: flex;
    gap: 16px;
    align-items: flex-start;
    transition: all 0.25s;
}
.feature-box:hover {
    background: rgba(255, 255, 255, 0.08);
    border-color: rgba(245, 158, 11, 0.3);
}
.feature-icon-wrap {
    font-size: 2rem;
    color: #fbbf24;
    background: rgba(245, 158, 11, 0.12);
    border-radius: 12px;
    padding: 12px;
    flex-shrink: 0;
}
.feature-title {
    font-weight: 700;
    font-size: 1rem;
    color: #ffffff;
    margin-bottom: 6px;
}
.feature-desc {
    color: rgba(255, 255, 255, 0.55);
    font-size: 0.82rem;
    line-height: 1.6;
    margin: 0;
}
</style>
</head>
<body>

<!-- ==================== HERO SECTION ==================== -->
<div class="hero">
    <div class="container" style="position:relative; z-index:2;">
        <div class="row align-items-center g-5">
            <div class="col-lg-7">
                <div class="hero-badge">
                    <i class="bi bi-stars"></i> World-Class Bookstore
                </div>
                <h1 class="hero-title">
                    Thế Giới Tri Thức<br>
                    <em>Đẳng Cấp Quốc Tế</em>
                </h1>
                <p class="hero-sub">
                    Tuyển tập hàng nghìn đầu sách văn học, kinh tế, tâm lý, kỹ năng sống chọn lọc từ các nhà xuất bản hàng đầu Việt Nam và thế giới.
                </p>
                <div class="d-flex gap-3 flex-wrap">
                    <a href="#books-grid-section" class="btn-gold">
                        <i class="bi bi-book-half"></i> Khám phá ngay
                    </a>
                    <a href="#books-grid-section" class="btn-outline-light-custom">
                        <i class="bi bi-fire"></i> Bán chạy nhất
                    </a>
                </div>
                <div class="hero-stats">
                    <div>
                        <div class="stat-num">${totalCount}+</div>
                        <div class="stat-label">Đầu sách</div>
                    </div>
                    <div style="width:1px; background:rgba(255,255,255,0.12);"></div>
                    <div>
                        <div class="stat-num">50+</div>
                        <div class="stat-label">Tác giả</div>
                    </div>
                    <div style="width:1px; background:rgba(255,255,255,0.12);"></div>
                    <div>
                        <div class="stat-num">4.9 ★</div>
                        <div class="stat-label">Đánh giá</div>
                    </div>
                    <div style="width:1px; background:rgba(255,255,255,0.12);"></div>
                    <div>
                        <div class="stat-num">24h</div>
                        <div class="stat-label">Giao hàng</div>
                    </div>
                </div>
            </div>

            <!-- Hero Book Showcase (3 books in staggered 3D stack) -->
            <div class="col-lg-5 d-none d-lg-block">
                <div class="hero-stage">
                    <c:if test="${not empty books}">
                        <!-- Book 1 (Left Behind) -->
                        <c:if test="${not empty books[1]}">
                            <div class="hero-showcase-book"
                                 style="width: 140px; height: 205px; left: 30px; top: 75px; transform: rotate(-8deg); z-index: 1;">
                                <img src="${pageContext.request.contextPath}/images/books/${books[1].coverImage}"
                                     alt="${books[1].title}">
                            </div>
                        </c:if>

                        <!-- Book 2 (Right Behind) -->
                        <c:if test="${not empty books[2]}">
                            <div class="hero-showcase-book"
                                 style="width: 145px; height: 215px; right: 35px; top: 60px; transform: rotate(10deg); z-index: 2;">
                                <img src="${pageContext.request.contextPath}/images/books/${books[2].coverImage}"
                                     alt="${books[2].title}">
                            </div>
                        </c:if>

                        <!-- Book 0 (Center Front) -->
                        <div class="hero-showcase-book"
                             style="width: 180px; height: 260px; left: 130px; top: 40px; transform: rotate(0deg); z-index: 5;">
                            <img src="${pageContext.request.contextPath}/images/books/${books[0].coverImage}"
                                 alt="${books[0].title}">
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ==================== TRUST STRIP ==================== -->
<div class="trust-strip">
    <div class="container">
        <div class="row g-4">
            <div class="col-6 col-md-3">
                <div class="trust-item">
                    <i class="bi bi-truck"></i>
                    <div>
                        <strong>Giao Hàng Siêu Tốc</strong>
                        <span>Miễn phí đơn từ 300k</span>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="trust-item">
                    <i class="bi bi-patch-check-fill"></i>
                    <div>
                        <strong>100% Sách Chính Hãng</strong>
                        <span>Từ nhà xuất bản uy tín</span>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="trust-item">
                    <i class="bi bi-arrow-repeat"></i>
                    <div>
                        <strong>Đổi Trả Dễ Dàng</strong>
                        <span>Miễn phí trong 30 ngày</span>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="trust-item">
                    <i class="bi bi-headset"></i>
                    <div>
                        <strong>Hỗ Trợ 24/7</strong>
                        <span>Tư vấn tận tâm, chu đáo</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ==================== MAIN BOOKS SECTION ==================== -->
<div class="container py-5" id="books-grid-section">

    <!-- Header -->
    <div class="section-header">
        <div>
            <div class="section-tag">Bộ Sưu Tập Nổi Bật</div>
            <h2 class="section-heading">Tất Cả Sách</h2>
            <div class="section-underline"></div>
        </div>
        <div class="text-end text-muted small">
            Hiển thị <strong>${pageSize}</strong> sản phẩm / trang &nbsp;|&nbsp;
            Tổng: <strong>${totalCount}</strong> cuốn
        </div>
    </div>

    <!-- Grid: 3 columns on desktop, 2 on tablet, 1 on small mobile -->
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
        <c:choose>
            <c:when test="${empty books}">
                <div class="col-12 text-center py-5 text-muted">
                    <i class="bi bi-journal-x fs-1 d-block mb-3"></i>
                    Không có cuốn sách nào trong danh mục.
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="book" items="${books}" varStatus="st">
                    <div class="col">
                        <div class="book-card">

                            <!-- Cover Wrapper -->
                            <div class="book-cover-wrap">
                                <!-- Badge -->
                                <c:choose>
                                    <c:when test="${st.index == 0}">
                                        <span class="card-badge badge-new"><i class="bi bi-sparkles me-1"></i>Mới</span>
                                    </c:when>
                                    <c:when test="${st.index == 1}">
                                        <span class="card-badge badge-hot"><i class="bi bi-fire me-1"></i>Hot</span>
                                    </c:when>
                                    <c:when test="${st.index == 2}">
                                        <span class="card-badge badge-sale">-20%</span>
                                    </c:when>
                                </c:choose>

                                <!-- Cover Image -->
                                <img src="${pageContext.request.contextPath}/images/books/${book.coverImage}"
                                     class="book-cover-img"
                                     alt="${book.title}"
                                     loading="lazy"
                                     onerror="this.src='https://via.placeholder.com/200x290/1e293b/fbbf24?text=BOOK'">

                                <!-- Hover Quick View -->
                                <div class="cover-overlay">
                                    <a href="${pageContext.request.contextPath}/book-detail?id=${book.bookId}" class="btn-quickview">
                                        <i class="bi bi-eye"></i> Xem chi tiết
                                    </a>
                                </div>
                            </div>

                            <!-- Card Body -->
                            <div class="book-card-body">
                                <!-- Author Name -->
                                <div class="book-author">
                                    <c:choose>
                                        <c:when test="${not empty book.authors}">
                                            ${book.authors[0].authorName}
                                        </c:when>
                                        <c:otherwise>Tác giả chưa cập nhật</c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Book Title (Câu 3 Requirement: Tiêu đề: ...) -->
                                <a href="${pageContext.request.contextPath}/book-detail?id=${book.bookId}" class="book-title">
                                    Tiêu đề: ${book.title}
                                </a>

                                <!-- Price Block -->
                                <div class="book-price-box">
                                    <span class="price-current">
                                        <fmt:formatNumber value="${book.price}" pattern="#,###"/> đ
                                    </span>
                                    <c:if test="${not empty book.price && book.price > 0}">
                                        <span class="price-original">
                                            <fmt:formatNumber value="${book.price * 1.25}" pattern="#,###"/> đ
                                        </span>
                                        <span class="price-discount">-20%</span>
                                    </c:if>
                                </div>

                                <!-- Specs (Câu 3 Requirements) -->
                                <div class="book-specs">
                                    <div><strong>Mã isbn:</strong> ${book.isbn != null ? book.isbn : 'N/A'}</div>
                                    <div><strong>Tác giả:</strong>
                                        <c:choose>
                                            <c:when test="${not empty book.authors}">
                                                <c:forEach var="au" items="${book.authors}" varStatus="as">
                                                    ${au.authorName}<c:if test="${!as.last}">, </c:if>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>—</c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div><strong>Publisher:</strong> ${not empty book.publisher ? book.publisher : '—'}</div>
                                    <div><strong>Publisher_date:</strong>
                                        <c:choose>
                                            <c:when test="${book.publishDate != null}">
                                                <fmt:formatDate value="${book.publishDate}" pattern="dd/MM/yyyy"/>
                                            </c:when>
                                            <c:otherwise>—</c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="mt-1">
                                        <strong>Quantity:</strong>
                                        <c:choose>
                                            <c:when test="${book.quantity != null && book.quantity > 0}">
                                                <span class="badge-stock badge-in-stock">
                                                    <i class="bi bi-check-circle-fill me-1"></i>${book.quantity} còn hàng
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-stock badge-out-stock">Hết hàng</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <!-- Star Review (Câu 3 Requirement) -->
                                <div class="review-stars-box">
                                    <span class="star-icons">★★★★★</span>
                                    <span class="review-count-label">Review (10)</span>
                                </div>

                                <!-- Action Buttons -->
                                <div class="d-flex gap-2">
                                    <a href="${pageContext.request.contextPath}/book-detail?id=${book.bookId}" class="btn-card-action flex-grow-1">
                                        <i class="bi bi-eye"></i> Xem Chi Tiết
                                    </a>
                                    <c:if test="${book.quantity != null && book.quantity > 0}">
                                        <form action="${pageContext.request.contextPath}/cart" method="post" class="d-inline">
                                            <input type="hidden" name="action" value="add"/>
                                            <input type="hidden" name="bookId" value="${book.bookId}"/>
                                            <input type="hidden" name="quantity" value="1"/>
                                            <button type="submit" class="btn btn-warning" title="Thêm vào giỏ" style="padding: 10px 14px; border-radius: 8px;">
                                                <i class="bi bi-cart-plus-fill"></i>
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>

                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- ==================== PAGINATION ==================== -->
    <c:if test="${totalPages > 1}">
        <div class="pagination-container">
            <a href="${pageContext.request.contextPath}/home?page=1"
               class="p-btn ${currentPage == 1 ? 'disabled' : ''}" title="Trang đầu">
                <i class="bi bi-chevron-double-left"></i>
            </a>
            <a href="${pageContext.request.contextPath}/home?page=${currentPage - 1}"
               class="p-btn ${currentPage == 1 ? 'disabled' : ''}" title="Trang trước">
                <i class="bi bi-chevron-left"></i>
            </a>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:if test="${i >= currentPage - 2 && i <= currentPage + 2}">
                    <a href="${pageContext.request.contextPath}/home?page=${i}"
                       class="p-btn ${i == currentPage ? 'active' : ''}">${i}</a>
                </c:if>
            </c:forEach>

            <a href="${pageContext.request.contextPath}/home?page=${currentPage + 1}"
               class="p-btn ${currentPage == totalPages ? 'disabled' : ''}" title="Trang sau">
                <i class="bi bi-chevron-right"></i>
            </a>
            <a href="${pageContext.request.contextPath}/home?page=${totalPages}"
               class="p-btn ${currentPage == totalPages ? 'disabled' : ''}" title="Trang cuối">
                <i class="bi bi-chevron-double-right"></i>
            </a>
        </div>
        <div class="pagination-info">
            Trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong> (${pageSize} cuốn / trang)
        </div>
    </c:if>

</div>

<!-- ==================== FEATURE SECTION ==================== -->
<div class="feature-section">
    <div class="container">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="feature-box">
                    <div class="feature-icon-wrap"><i class="bi bi-globe-americas"></i></div>
                    <div>
                        <div class="feature-title">Sách Quốc Tế Chọn Lọc</div>
                        <p class="feature-desc">Tuyển chọn các tựa sách bestseller từ các nhà xuất bản hàng đầu thế giới.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-box">
                    <div class="feature-icon-wrap"><i class="bi bi-trophy"></i></div>
                    <div>
                        <div class="feature-title">Bestsellers Mỗi Tuần</div>
                        <p class="feature-desc">Cập nhật liên tục những tựa sách bán chạy và được yêu thích nhất.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-box">
                    <div class="feature-icon-wrap"><i class="bi bi-shield-check"></i></div>
                    <div>
                        <div class="feature-title">Đảm Bảo Chất Lượng</div>
                        <p class="feature-desc">100% sách chính hãng, đóng gói cẩn thận, bảo hành đổi trả miễn phí.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
