<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty author.authorId || author.authorId == 0 ? 'Thêm tác giả' : 'Sửa tác giả'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .form-label { font-weight: 500; }
        .required::after { content: " *"; color: red; }
    </style>
</head>
<body class="bg-light">

<div class="container py-4" style="max-width: 600px;">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="${pageContext.request.contextPath}/admin/authors">Quản lý Tác giả</a>
            </li>
            <li class="breadcrumb-item active">
                ${empty author.authorId || author.authorId == 0 ? 'Thêm mới' : 'Chỉnh sửa'}
            </li>
        </ol>
    </nav>

    <div class="card shadow-sm">
        <div class="card-header bg-success text-white">
            <h4 class="mb-0">
                <i class="bi bi-person-${empty author.authorId || author.authorId == 0 ? 'plus' : 'gear'} me-2"></i>
                ${empty author.authorId || author.authorId == 0 ? 'Thêm tác giả mới' : 'Chỉnh sửa tác giả'}
            </h4>
        </div>
        <div class="card-body">

            <!-- Error message -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-triangle me-1"></i> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/admin/authors" method="post">

                <!-- Hidden fields -->
                <input type="hidden" name="authorId" value="${author.authorId}">
                <input type="hidden" name="action"
                       value="${empty author.authorId || author.authorId == 0 ? 'create' : 'update'}">

                <!-- Author Name -->
                <div class="mb-3">
                    <label class="form-label required">Tên tác giả</label>
                    <input type="text" class="form-control" name="authorName"
                           value="${author.authorName}"
                           placeholder="Nhập tên tác giả" required>
                </div>

                <!-- Date of Birth -->
                <div class="mb-4">
                    <label class="form-label">Ngày sinh</label>
                    <input type="date" class="form-control" name="dateOfBirth"
                           value="<fmt:formatDate value='${author.dateOfBirth}' pattern='yyyy-MM-dd'/>">
                </div>

                <!-- Books info (read-only when editing) -->
                <c:if test="${not empty author.authorId && author.authorId != 0 && not empty author.books}">
                    <div class="mb-4">
                        <label class="form-label">Sách đã có</label>
                        <ul class="list-group">
                            <c:forEach var="book" items="${author.books}">
                                <li class="list-group-item py-2">
                                    <i class="bi bi-book me-2 text-primary"></i>
                                    ${book.title}
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>

                <!-- Buttons -->
                <hr>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-success">
                        <i class="bi bi-save me-1"></i>
                        ${empty author.authorId || author.authorId == 0 ? 'Thêm tác giả' : 'Lưu thay đổi'}
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/authors"
                       class="btn btn-outline-secondary">
                        <i class="bi bi-x-circle me-1"></i> Hủy
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
