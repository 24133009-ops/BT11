<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>${book.title} - BookVerse</title>
    <style>
        .detail-wrapper {
            max-width: 1140px;
            margin: 0 auto;
        }

        /* Breadcrumb */
        .custom-breadcrumb {
            background: transparent;
            padding: 12px 0;
            font-size: 0.86rem;
        }
        .custom-breadcrumb a {
            color: #6b7280;
            text-decoration: none;
            transition: color 0.15s;
        }
        .custom-breadcrumb a:hover {
            color: var(--accent, #e8b86d);
        }

        /* Main detail card */
        .book-main-card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.06);
            border: 1px solid #edf0f5;
            padding: 32px;
            margin-bottom: 30px;
        }

        /* 3D Book Display */
        .book-stage-detail {
            perspective: 900px;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px 0;
        }
        .book-3d-detail {
            position: relative;
            transform-style: preserve-3d;
            transform: rotateY(-14deg) rotateX(2deg);
            transition: transform 0.5s ease;
        }
        .book-3d-detail:hover {
            transform: rotateY(-2deg) rotateX(0deg);
        }
        .book-detail-cover {
            width: 260px;
            height: 380px;
            border-radius: 3px 10px 10px 3px;
            overflow: hidden;
            box-shadow:
                6px 6px 0px rgba(0,0,0,0.18),
                12px 12px 0px rgba(0,0,0,0.10),
                20px 20px 28px rgba(0,0,0,0.22);
            background: #1a1a2e;
        }
        .book-detail-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }
        .book-detail-spine {
            position: absolute;
            top: 0;
            left: -16px;
            width: 16px;
            height: 100%;
            background: linear-gradient(to right, rgba(0,0,0,0.45), rgba(0,0,0,0.15));
            transform: rotateY(-90deg);
            transform-origin: right center;
            border-radius: 3px 0 0 3px;
        }
        .book-detail-pages {
            position: absolute;
            top: 3px;
            right: -10px;
            width: 10px;
            height: calc(100% - 6px);
            background: repeating-linear-gradient(to bottom, #e8ddd0, #e8ddd0 2px, #f5ede0 2px, #f5ede0 4px);
            transform-origin: left center;
            transform: rotateY(90deg);
            border-radius: 0 3px 3px 0;
        }

        /* Book Info Column */
        .book-title-heading {
            font-family: 'Playfair Display', serif;
            font-size: 1.85rem;
            font-weight: 700;
            color: #1a1a2e;
            line-height: 1.3;
            margin-bottom: 12px;
        }
        .book-author-lead {
            font-size: 0.95rem;
            color: #6b7280;
            margin-bottom: 16px;
        }
        .book-author-lead strong {
            color: #1a1a2e;
        }

        /* Price Box */
        .price-highlight-box {
            background: #faf8f5;
            border: 1px solid #fae8d2;
            border-radius: 12px;
            padding: 16px 20px;
            margin-bottom: 22px;
            display: flex;
            align-items: center;
            gap: 14px;
            flex-wrap: wrap;
        }
        .price-current {
            font-size: 1.85rem;
            font-weight: 700;
            color: #c92127;
        }
        .price-old {
            font-size: 1rem;
            color: #9ca3af;
            text-decoration: line-through;
        }
        .badge-discount {
            background: #c92127;
            color: #ffffff;
            font-weight: 700;
            font-size: 0.78rem;
            padding: 4px 8px;
            border-radius: 6px;
        }
        .badge-freeship {
            background: #e8f5e9;
            color: #2e7d32;
            font-size: 0.75rem;
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 50px;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        /* Info Table */
        .info-table {
            width: 100%;
            margin-bottom: 20px;
        }
        .info-table tr {
            border-bottom: 1px solid #f3f4f6;
        }
        .info-table tr:last-child {
            border-bottom: none;
        }
        .info-table th {
            width: 150px;
            padding: 10px 0;
            font-size: 0.88rem;
            font-weight: 600;
            color: #6b7280;
            vertical-align: top;
        }
        .info-table td {
            padding: 10px 0;
            font-size: 0.9rem;
            color: #1a1a2e;
        }

        /* Actions */
        .action-btns {
            display: flex;
            gap: 12px;
            margin-top: 24px;
            flex-wrap: wrap;
        }
        .btn-buy-now {
            background: #c92127;
            color: #ffffff;
            font-weight: 700;
            font-size: 0.95rem;
            padding: 12px 28px;
            border-radius: 10px;
            border: none;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-buy-now:hover {
            background: #a8171c;
            color: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(201,33,39,0.3);
        }
        .btn-add-cart {
            background: #ffffff;
            color: #c92127;
            font-weight: 700;
            font-size: 0.95rem;
            padding: 12px 24px;
            border-radius: 10px;
            border: 2px solid #c92127;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-add-cart:hover {
            background: #fff5f5;
            color: #a8171c;
        }

        /* Reviews Section */
        .section-card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.05);
            border: 1px solid #edf0f5;
            padding: 28px;
            margin-bottom: 26px;
        }
        .section-header-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.35rem;
            font-weight: 700;
            color: #1a1a2e;
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 2px solid #faf8f5;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Review Item */
        .review-bubble {
            background: #fafbfc;
            border: 1px solid #eef2f6;
            border-radius: 12px;
            padding: 16px 20px;
            margin-bottom: 14px;
            transition: all 0.2s;
        }
        .review-bubble:hover {
            background: #ffffff;
            box-shadow: 0 4px 14px rgba(0,0,0,0.06);
        }
        .review-user-name {
            font-weight: 700;
            font-size: 0.92rem;
            color: #1a1a2e;
        }
        .review-stars {
            color: #f59e0b;
            font-size: 0.85rem;
        }
        .review-text-content {
            font-size: 0.9rem;
            color: #4b5563;
            line-height: 1.6;
            margin-top: 8px;
            padding-left: 10px;
            border-left: 3px solid var(--accent, #e8b86d);
        }

        /* Form review */
        .form-review-box {
            background: #faf8f5;
            border: 1px solid #fae8d2;
            border-radius: 14px;
            padding: 24px;
        }
    </style>
</head>
<body>

<div class="container py-4 detail-wrapper">

    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="custom-breadcrumb mb-3">
        <ol class="breadcrumb mb-0">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home"><i class="bi bi-house me-1"></i>Trang chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">${book.title}</li>
        </ol>
    </nav>

    <!-- Success notification -->
    <c:if test="${param.success == 'reviewed'}">
        <div class="alert alert-success alert-dismissible fade show rounded-3 mb-4 shadow-sm" role="alert">
            <i class="bi bi-check-circle-fill me-2 fs-5 text-success"></i>
            <strong>Thành công!</strong> Cảm ơn bạn đã gửi đánh giá cho cuốn sách này!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Main Book Detail Card -->
    <div class="book-main-card">
        <div class="row g-5 align-items-center">

            <!-- 3D Book Cover -->
            <div class="col-md-5 text-center">
                <div class="book-stage-detail">
                    <div class="book-3d-detail">
                        <div class="book-detail-spine"></div>
                        <div class="book-detail-cover">
                            <c:set var="cImg" value="${fn:startsWith(book.coverImage,'http') ? book.coverImage : pageContext.request.contextPath.concat('/images/books/').concat(book.coverImage)}"/>
                            <img src="${cImg}" alt="${book.title}"
                                 onerror="this.src='https://via.placeholder.com/260x380/1a1a2e/e8b86d?text=No+Cover'">
                        </div>
                        <div class="book-detail-pages"></div>
                    </div>
                </div>
            </div>

            <!-- Book Info (Câu 4) -->
            <div class="col-md-7">
                <div class="d-flex align-items-center gap-2 mb-2">
                    <span class="badge bg-danger rounded-pill px-3 py-1">Chính hãng</span>
                    <span class="badge-freeship"><i class="bi bi-truck"></i> Giao nhanh 24h</span>
                </div>

                <h1 class="book-title-heading">Tiêu đề: ${book.title}</h1>

                <div class="book-author-lead">
                    Tác giả: <strong>
                        <c:choose>
                            <c:when test="${not empty book.authors}">
                                <c:forEach var="au" items="${book.authors}" varStatus="as">
                                    ${au.authorName}<c:if test="${!as.last}">, </c:if>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>Đang cập nhật</c:otherwise>
                        </c:choose>
                    </strong>
                    &nbsp;|&nbsp; Nhà xuất bản: <strong>${not empty book.publisher ? book.publisher : 'N/A'}</strong>
                </div>

                <!-- Price Box -->
                <div class="price-highlight-box">
                    <div>
                        <div class="price-current">
                            <fmt:formatNumber value="${book.price}" pattern="#,###"/> đ
                        </div>
                        <c:if test="${not empty book.price && book.price > 0}">
                            <div class="d-flex align-items-center gap-2 mt-1">
                                <span class="price-old"><fmt:formatNumber value="${book.price * 1.25}" pattern="#,###"/> đ</span>
                                <span class="badge-discount">-20%</span>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Specs Table (Câu 4) -->
                <table class="info-table">
                    <tbody>
                        <tr>
                            <th>Mã isbn:</th>
                            <td class="fw-bold">${book.isbn != null ? book.isbn : 'N/A'}</td>
                        </tr>
                        <tr>
                            <th>Tác giả:</th>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty book.authors}">
                                        <c:forEach var="author" items="${book.authors}" varStatus="loop">
                                            <span class="badge bg-light text-dark border me-1">${author.authorName}</span>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise><span class="text-muted">Chưa cập nhật</span></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>Publisher:</th>
                            <td>${not empty book.publisher ? book.publisher : 'N/A'}</td>
                        </tr>
                        <tr>
                            <th>Publisher_date:</th>
                            <td>
                                <c:choose>
                                    <c:when test="${book.publishDate != null}">
                                        <fmt:formatDate value="${book.publishDate}" pattern="dd/MM/yyyy"/>
                                    </c:when>
                                    <c:otherwise>N/A</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>Quantity:</th>
                            <td>
                                <span class="badge ${book.quantity != null && book.quantity > 0 ? 'bg-success' : 'bg-danger'} px-3 py-2">
                                    <i class="bi bi-box-seam me-1"></i>${book.quantity != null ? book.quantity : 0} cuốn còn trong kho
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <th>Reviews:</th>
                            <td>
                                <span class="text-warning fw-bold">
                                    ★★★★★ <span class="text-dark ms-1">(${reviewCount} đánh giá từ độc giả)</span>
                                </span>
                            </td>
                        </tr>
                        <c:if test="${not empty book.description}">
                            <tr>
                                <th>Mô tả sách:</th>
                                <td style="line-height: 1.7; color: #4b5563;">${book.description}</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>

                <!-- Quantity & Action buttons -->
                <c:choose>
                    <c:when test="${book.quantity != null && book.quantity > 0}">
                        <form action="${pageContext.request.contextPath}/cart" method="post" class="mt-3">
                            <input type="hidden" name="action" value="add"/>
                            <input type="hidden" name="bookId" value="${book.bookId}"/>

                            <div class="d-flex align-items-center gap-3 mb-3">
                                <label class="fw-semibold text-dark">Số lượng mua:</label>
                                <div class="input-group" style="width: 140px;">
                                    <button class="btn btn-outline-secondary" type="button"
                                            onclick="var q=document.getElementById('buyQty'); if(parseInt(q.value)>1) q.value=parseInt(q.value)-1;">-</button>
                                    <input type="number" id="buyQty" name="quantity" value="1" min="1" max="${book.quantity}"
                                           class="form-control text-center fw-bold"/>
                                    <button class="btn btn-outline-secondary" type="button"
                                            onclick="var q=document.getElementById('buyQty'); if(parseInt(q.value)<${book.quantity}) q.value=parseInt(q.value)+1; else alert('Kho chỉ còn tối đa ${book.quantity} cuốn!');">+</button>
                                </div>
                                <small class="text-muted">(Tối đa ${book.quantity} cuốn)</small>
                            </div>

                            <div class="action-btns">
                                <button type="submit" name="buyNow" value="true" class="btn-buy-now">
                                    <i class="bi bi-lightning-fill"></i> Mua Ngay
                                </button>
                                <button type="submit" class="btn-add-cart">
                                    <i class="bi bi-cart-plus-fill"></i> Thêm Vào Giỏ Hàng
                                </button>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-danger mt-3">
                            <i class="bi bi-exclamation-octagon-fill me-2"></i>Sách này hiện tại đã hết hàng!
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Reviews List Section (Câu 4) -->
    <div class="section-card">
        <h3 class="section-header-title">
            <i class="bi bi-chat-quote-fill text-warning"></i>
            Đánh Giá & Nhận Xét (${reviewCount})
        </h3>

        <c:choose>
            <c:when test="${empty reviews}">
                <div class="text-center py-4 text-muted">
                    <i class="bi bi-chat-square-dots fs-1 d-block mb-2 text-secondary"></i>
                    Chưa có nhận xét nào cho cuốn sách này. Hãy là người đầu tiên chia sẻ cảm nhận!
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="rev" items="${reviews}">
                    <div class="review-bubble">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <div class="d-flex align-items-center gap-2">
                                <i class="bi bi-person-circle fs-5 text-secondary"></i>
                                <span class="review-user-name">
                                    [${not empty rev.user ? (not empty rev.user.fullname ? rev.user.fullname : rev.user.email) : 'Người dùng'}]
                                </span>
                            </div>
                            <div class="review-stars">
                                <c:forEach begin="1" end="${rev.rating != null ? rev.rating : 5}">
                                    <i class="bi bi-star-fill"></i>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="review-text-content">
                            [${rev.reviewText}]
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Form Thêm Review (Câu 4) -->
    <div class="section-card">
        <h3 class="section-header-title">
            <i class="bi bi-pencil-square text-success"></i>
            Form Thêm Reviews
        </h3>

        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <form action="${pageContext.request.contextPath}/book-detail" method="post" class="form-review-box">
                    <input type="hidden" name="bookId" value="${book.bookId}">

                    <!-- Rating Select -->
                    <div class="mb-3 row align-items-center">
                        <label class="col-sm-2 col-form-label fw-bold text-dark">Đánh giá sao:</label>
                        <div class="col-sm-4">
                            <select class="form-select" name="rating">
                                <option value="5" selected>⭐⭐⭐⭐⭐ (5 sao - Tuyệt vời)</option>
                                <option value="4">⭐⭐⭐⭐ (4 sao - Rất hay)</option>
                                <option value="3">⭐⭐⭐ (3 sao - Khá)</option>
                                <option value="2">⭐⭐ (2 sao - Trung bình)</option>
                                <option value="1">⭐ (1 sao - Kém)</option>
                            </select>
                        </div>
                    </div>

                    <!-- Review Text -->
                    <div class="mb-3">
                        <label class="form-label fw-bold text-dark">Nội dung review:</label>
                        <textarea class="form-control" name="reviewText" rows="3"
                                  placeholder="Nhập cảm nhận của bạn về cuốn sách này..." required></textarea>
                    </div>

                    <!-- Submit -->
                    <button type="submit" class="btn btn-success px-4 py-2 fw-bold rounded-3">
                        <i class="bi bi-send-fill me-1"></i> [Submit]
                    </button>
                </form>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning mb-0 rounded-3" role="alert">
                    <i class="bi bi-shield-lock-fill me-2 fs-5"></i>
                    Vui lòng <a href="${pageContext.request.contextPath}/login" class="fw-bold text-dark alert-link">Đăng nhập</a> để gửi nhận xét và đánh giá sách!
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</div>

</body>
</html>
