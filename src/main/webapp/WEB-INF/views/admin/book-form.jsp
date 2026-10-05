<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty book.bookId || book.bookId == 0 ? 'Thêm sách mới' : 'Sửa sách'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .form-label { font-weight: 500; }
        .required::after { content: " *"; color: red; }
        .preview-img { max-width: 150px; max-height: 200px; object-fit: cover; border-radius: 8px; }
    </style>
</head>
<body class="bg-light">

<div class="container py-4" style="max-width: 800px;">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="${pageContext.request.contextPath}/admin/books">Quản lý Sách</a>
            </li>
            <li class="breadcrumb-item active">
                ${empty book.bookId || book.bookId == 0 ? 'Thêm mới' : 'Chỉnh sửa'}
            </li>
        </ol>
    </nav>

    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">
                <i class="bi bi-${empty book.bookId || book.bookId == 0 ? 'plus-circle' : 'pencil-square'} me-2"></i>
                ${empty book.bookId || book.bookId == 0 ? 'Thêm sách mới' : 'Chỉnh sửa sách'}
            </h4>
        </div>
        <div class="card-body">

            <!-- Error message -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-triangle me-1"></i> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/admin/books"
                  method="post" enctype="multipart/form-data">

                <!-- Hidden fields -->
                <input type="hidden" name="bookId" value="${book.bookId}">
                <input type="hidden" name="action"
                       value="${empty book.bookId || book.bookId == 0 ? 'create' : 'update'}">

                <div class="row">
                    <!-- Left column -->
                    <div class="col-md-8">
                        <!-- Title -->
                        <div class="mb-3">
                            <label class="form-label required">Tiêu đề sách</label>
                            <input type="text" class="form-control" name="title"
                                   value="${book.title}" placeholder="Nhập tiêu đề sách" required>
                        </div>

                        <!-- ISBN & Price -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">ISBN</label>
                                <input type="number" class="form-control" name="isbn"
                                       value="${book.isbn}" placeholder="Nhập mã ISBN">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Giá (VNĐ)</label>
                                <input type="number" class="form-control" name="price"
                                       value="${book.price}" placeholder="0" step="0.01" min="0">
                            </div>
                        </div>

                        <!-- Publisher & Publish Date -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Nhà xuất bản</label>
                                <input type="text" class="form-control" name="publisher"
                                       value="${book.publisher}" placeholder="Tên NXB">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Ngày xuất bản</label>
                                <input type="date" class="form-control" name="publishDate"
                                       value="<fmt:formatDate value='${book.publishDate}' pattern='yyyy-MM-dd'/>">
                            </div>
                        </div>

                        <!-- Quantity -->
                        <div class="mb-3">
                            <label class="form-label">Số lượng</label>
                            <input type="number" class="form-control" name="quantity"
                                   value="${book.quantity}" placeholder="0" min="0">
                        </div>

                        <!-- Description -->
                        <div class="mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea class="form-control" name="description" rows="4"
                                      placeholder="Nhập mô tả về cuốn sách...">${book.description}</textarea>
                        </div>

                        <!-- Authors -->
                        <div class="mb-3">
                            <label class="form-label">Tác giả</label>
                            <c:choose>
                                <c:when test="${not empty authors}">
                                    <select class="form-select" name="authorIds" multiple size="5">
                                        <c:forEach var="author" items="${authors}">
                                            <c:set var="isSelected" value="false"/>
                                            <c:if test="${not empty book.authors}">
                                                <c:forEach var="ba" items="${book.authors}">
                                                    <c:if test="${ba.authorId == author.authorId}">
                                                        <c:set var="isSelected" value="true"/>
                                                    </c:if>
                                                </c:forEach>
                                            </c:if>
                                            <option value="${author.authorId}"
                                                    ${isSelected ? 'selected' : ''}>
                                                ${author.authorName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <small class="text-muted">
                                        <i class="bi bi-info-circle me-1"></i>
                                        Giữ Ctrl (hoặc Cmd) để chọn nhiều tác giả
                                    </small>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-warning py-2">
                                        <i class="bi bi-exclamation-triangle me-1"></i>
                                        Chưa có tác giả nào.
                                        <a href="${pageContext.request.contextPath}/admin/authors?action=new">
                                            Thêm tác giả
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Right column: Cover Image -->
                    <div class="col-md-4">
                        <div class="mb-3">
                            <label class="form-label">Ảnh bìa</label>
                            <div class="text-center mb-2">
                                <c:choose>
                                    <c:when test="${not empty book.coverImage}">
                                        <img id="previewImg"
                                             src="${pageContext.request.contextPath}/images/books/${book.coverImage}"
                                             class="preview-img img-thumbnail"
                                             alt="Cover"
                                             onerror="this.src='https://via.placeholder.com/150x200?text=No+Image'">
                                    </c:when>
                                    <c:otherwise>
                                        <img id="previewImg"
                                             src="https://via.placeholder.com/150x200?text=No+Image"
                                             class="preview-img img-thumbnail" alt="Cover">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <label class="form-label">Tên file ảnh</label>
                            <input type="text" class="form-control" name="coverImage"
                                   value="${book.coverImage}"
                                   placeholder="vd: book1.jpg">
                            <small class="text-muted">
                                Đặt ảnh vào thư mục <code>/images/books/</code>
                            </small>
                        </div>
                    </div>
                </div>

                <!-- Buttons -->
                <hr>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-save me-1"></i>
                        ${empty book.bookId || book.bookId == 0 ? 'Thêm sách' : 'Lưu thay đổi'}
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/books"
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
