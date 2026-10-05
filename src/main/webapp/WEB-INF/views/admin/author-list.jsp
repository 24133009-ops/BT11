<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Tác giả</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .pagination-info { font-size: 0.9rem; color: #6c757d; }
        .action-btns .btn { padding: 3px 8px; font-size: 0.8rem; }
    </style>
</head>
<body class="bg-light">

<div class="container-fluid py-4">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="mb-0"><i class="bi bi-people me-2"></i>Quản lý Tác giả</h2>
            <small class="text-muted">Tổng: <strong>${totalCount}</strong> tác giả</small>
        </div>
        <a href="${pageContext.request.contextPath}/admin/authors?action=new"
           class="btn btn-success">
            <i class="bi bi-plus-circle me-1"></i> Thêm tác giả mới
        </a>
    </div>

    <!-- Alert messages -->
    <c:if test="${param.success == 'create'}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle me-1"></i> Thêm tác giả thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.success == 'update'}">
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle me-1"></i> Cập nhật tác giả thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.success == 'delete'}">
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <i class="bi bi-trash me-1"></i> Đã xóa tác giả thành công!
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
                            <th>Tên tác giả</th>
                            <th>Ngày sinh</th>
                            <th>Số sách</th>
                            <th style="width:130px">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty authors}">
                                <tr>
                                    <td colspan="5" class="text-center py-4 text-muted">
                                        <i class="bi bi-inbox fs-3 d-block mb-2"></i>
                                        Chưa có tác giả nào
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="author" items="${authors}" varStatus="status">
                                    <tr>
                                        <td>${(currentPage - 1) * pageSize + status.index + 1}</td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-3"
                                                     style="width:38px; height:38px; font-size:14px; flex-shrink:0;">
                                                    ${not empty author.authorName ?
                                                      author.authorName.substring(0,1).toUpperCase() : '?'}
                                                </div>
                                                <strong>${author.authorName}</strong>
                                            </div>
                                        </td>
                                        <td>
                                            <c:if test="${author.dateOfBirth != null}">
                                                <fmt:formatDate value="${author.dateOfBirth}" pattern="dd/MM/yyyy"/>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty author.books}">
                                                    <span class="badge bg-primary">${author.books.size()}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">0</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="action-btns">
                                            <a href="${pageContext.request.contextPath}/admin/authors?action=edit&id=${author.authorId}"
                                               class="btn btn-outline-warning me-1" title="Sửa">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <button type="button" class="btn btn-outline-danger"
                                                    title="Xóa"
                                                    onclick="confirmDelete(${author.authorId}, '${author.authorName}')">
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
                    (${pageSize} tác giả/trang)
                </span>
                <nav>
                    <ul class="pagination mb-0 pagination-sm">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/authors?action=list&page=1">
                               <i class="bi bi-chevron-double-left"></i>
                            </a>
                        </li>
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/authors?action=list&page=${currentPage - 1}">
                               <i class="bi bi-chevron-left"></i>
                            </a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:if test="${i >= currentPage - 2 && i <= currentPage + 2}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link"
                                       href="${pageContext.request.contextPath}/admin/authors?action=list&page=${i}">
                                        ${i}
                                    </a>
                                </li>
                            </c:if>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/authors?action=list&page=${currentPage + 1}">
                               <i class="bi bi-chevron-right"></i>
                            </a>
                        </li>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/authors?action=list&page=${totalPages}">
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
        <a href="${pageContext.request.contextPath}/admin/books"
           class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-book me-1"></i> Quản lý Sách
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
                Bạn có chắc chắn muốn xóa tác giả <strong id="authorName"></strong>?
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
    function confirmDelete(authorId, authorName) {
        document.getElementById('authorName').textContent = authorName;
        document.getElementById('confirmDeleteBtn').href =
            '${pageContext.request.contextPath}/admin/authors?action=delete&id=' + authorId;
        new bootstrap.Modal(document.getElementById('deleteModal')).show();
    }
</script>
</body>
</html>
