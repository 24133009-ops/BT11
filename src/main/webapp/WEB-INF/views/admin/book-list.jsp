<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Sách</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .pagination-info { font-size: 0.9rem; color: #6c757d; }
        .table-hover tbody tr:hover { background-color: #f8f9fa; }
        .badge-isbn { font-size: 0.8rem; }
        .action-btns .btn { padding: 3px 8px; font-size: 0.8rem; }
    </style>
</head>
<body class="bg-light">

<div class="container-fluid py-4">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="mb-0"><i class="bi bi-book me-2"></i>Quản lý Sách</h2>
            <small class="text-muted">Tổng: <strong>${totalCount}</strong> cuốn sách</small>
        </div>
        <a href="${pageContext.request.contextPath}/admin/books?action=new"
           class="btn btn-primary">
            <i class="bi bi-plus-circle me-1"></i> Thêm sách mới
        </a>
    </div>

    <!-- Alert messages -->
    <c:if test="${param.success == 'create'}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle me-1"></i> Thêm sách thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.success == 'update'}">
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle me-1"></i> Cập nhật sách thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.success == 'delete'}">
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <i class="bi bi-trash me-1"></i> Đã xóa sách thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Table -->
    <div class="card shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th style="width:50px">#</th>
                            <th>Ảnh bìa</th>
                            <th>Tiêu đề</th>
                            <th>ISBN</th>
                            <th>Tác giả</th>
                            <th>NXB</th>
                            <th>Giá</th>
                            <th>Ngày XB</th>
                            <th>Số lượng</th>
                            <th style="width:130px">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty books}">
                                <tr>
                                    <td colspan="10" class="text-center py-4 text-muted">
                                        <i class="bi bi-inbox fs-3 d-block mb-2"></i>
                                        Chưa có sách nào
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="book" items="${books}" varStatus="status">
                                    <tr>
                                        <td>${(currentPage - 1) * pageSize + status.index + 1}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty book.coverImage}">
                                                    <img src="${pageContext.request.contextPath}/images/books/${book.coverImage}"
                                                         alt="${book.title}"
                                                         style="width:50px; height:65px; object-fit:cover;"
                                                         class="rounded"
                                                         onerror="this.src='https://via.placeholder.com/50x65?text=No+Image'">
                                                </c:when>
                                                <c:otherwise>
                                                    <div style="width:50px; height:65px; background:#e9ecef;"
                                                         class="rounded d-flex align-items-center justify-content-center">
                                                        <i class="bi bi-image text-muted"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <strong>${book.title}</strong>
                                            <c:if test="${not empty book.description}">
                                                <br><small class="text-muted">
                                                    ${book.description.length() > 60 ?
                                                      book.description.substring(0, 60).concat('...') :
                                                      book.description}
                                                </small>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${book.isbn != null}">
                                                <span class="badge bg-secondary badge-isbn">${book.isbn}</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty book.authors}">
                                                    <c:forEach var="author" items="${book.authors}" varStatus="aStatus">
                                                        ${author.authorName}<c:if test="${!aStatus.last}">, </c:if>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">—</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${book.publisher}</td>
                                        <td>
                                            <c:if test="${book.price != null}">
                                                <fmt:formatNumber value="${book.price}" type="number" groupingUsed="true"/> đ
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${book.publishDate != null}">
                                                <fmt:formatDate value="${book.publishDate}" pattern="dd/MM/yyyy"/>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${book.quantity != null && book.quantity > 0}">
                                                    <span class="badge bg-success">${book.quantity}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">0</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="action-btns">
                                            <a href="${pageContext.request.contextPath}/admin/books?action=edit&id=${book.bookId}"
                                               class="btn btn-outline-warning me-1" title="Sửa">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <button type="button" class="btn btn-outline-danger"
                                                    title="Xóa"
                                                    onclick="confirmDelete(${book.bookId}, '${book.title}')">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <div class="card-footer d-flex justify-content-between align-items-center">
                <span class="pagination-info">
                    Trang ${currentPage} / ${totalPages}
                    (${pageSize} sách/trang)
                </span>
                <nav>
                    <ul class="pagination mb-0 pagination-sm">
                        <!-- First page -->
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/books?action=list&page=1">
                               <i class="bi bi-chevron-double-left"></i>
                            </a>
                        </li>
                        <!-- Previous -->
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/books?action=list&page=${currentPage - 1}">
                               <i class="bi bi-chevron-left"></i>
                            </a>
                        </li>
                        <!-- Page numbers -->
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:if test="${i >= currentPage - 2 && i <= currentPage + 2}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link"
                                       href="${pageContext.request.contextPath}/admin/books?action=list&page=${i}">
                                        ${i}
                                    </a>
                                </li>
                            </c:if>
                        </c:forEach>
                        <!-- Next -->
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/books?action=list&page=${currentPage + 1}">
                               <i class="bi bi-chevron-right"></i>
                            </a>
                        </li>
                        <!-- Last page -->
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/books?action=list&page=${totalPages}">
                               <i class="bi bi-chevron-double-right"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </c:if>
    </div>

    <!-- Navigation links -->
    <div class="mt-3">
        <a href="${pageContext.request.contextPath}/admin/authors"
           class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-people me-1"></i> Quản lý Tác giả
        </a>
        <a href="${pageContext.request.contextPath}/admin/books"
           class="btn btn-outline-secondary btn-sm ms-2">
            <i class="bi bi-house me-1"></i> Trang chủ
        </a>
    </div>
</div>

<!-- Delete confirmation modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title"><i class="bi bi-exclamation-triangle me-2"></i>Xác nhận xóa</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc chắn muốn xóa sách <strong id="bookTitle"></strong>?
                <br><small class="text-danger">Hành động này không thể hoàn tác!</small>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <a id="confirmDeleteBtn" href="#" class="btn btn-danger">
                    <i class="bi bi-trash me-1"></i> Xóa
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function confirmDelete(bookId, bookTitle) {
        document.getElementById('bookTitle').textContent = bookTitle;
        document.getElementById('confirmDeleteBtn').href =
            '${pageContext.request.contextPath}/admin/books?action=delete&id=' + bookId;
        new bootstrap.Modal(document.getElementById('deleteModal')).show();
    }
</script>
</body>
</html>
