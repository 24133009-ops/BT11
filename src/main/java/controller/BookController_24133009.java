package controller;

import model.Book_24133009;
import model.Author_24133009;
import service.BookService_24133009;
import service.AuthorService_24133009;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/admin/books")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB
public class BookController_24133009 extends HttpServlet {

    private static final int PAGE_SIZE = 5;
    private final BookService_24133009 bookService = new BookService_24133009();
    private final AuthorService_24133009 authorService = new AuthorService_24133009();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                listBooks(request, response);
                break;
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteBook(request, response);
                break;
            default:
                listBooks(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "create":
                createBook(request, response);
                break;
            case "update":
                updateBook(request, response);
                break;
            default:
                listBooks(request, response);
        }
    }

    // Hiển thị danh sách books có phân trang
    private void listBooks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        List<Book_24133009> books = bookService.getBooks(page, PAGE_SIZE);
        int totalPages = bookService.getTotalPages(PAGE_SIZE);
        long totalCount = bookService.getTotalCount();

        request.setAttribute("books", books);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("pageSize", PAGE_SIZE);

        request.getRequestDispatcher("/WEB-INF/views/admin/book-list.jsp")
               .forward(request, response);
    }

    // Hiển thị form thêm mới
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Author_24133009> authors = authorService.getAllAuthors();
        request.setAttribute("authors", authors);
        request.setAttribute("book", new Book_24133009());
        request.getRequestDispatcher("/WEB-INF/views/admin/book-form.jsp")
               .forward(request, response);
    }

    // Hiển thị form chỉnh sửa
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Book_24133009 book = bookService.getBookById(id);
        List<Author_24133009> authors = authorService.getAllAuthors();

        request.setAttribute("book", book);
        request.setAttribute("authors", authors);
        request.getRequestDispatcher("/WEB-INF/views/admin/book-form.jsp")
               .forward(request, response);
    }

    // Tạo book mới
    private void createBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Book_24133009 book = extractBookFromRequest(request);
            bookService.addBook(book);
            response.sendRedirect(request.getContextPath() + "/admin/books?action=list&success=create");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi thêm sách: " + e.getMessage());
            showNewForm(request, response);
        }
    }

    // Cập nhật book
    private void updateBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("bookId"));
            Book_24133009 book = extractBookFromRequest(request);
            book.setBookId(id);
            bookService.updateBook(book);
            response.sendRedirect(request.getContextPath() + "/admin/books?action=list&success=update");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi cập nhật sách: " + e.getMessage());
            showEditForm(request, response);
        }
    }

    // Xóa book
    private void deleteBook(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        bookService.deleteBook(id);
        response.sendRedirect(request.getContextPath() + "/admin/books?action=list&success=delete");
    }

    // Trích xuất thông tin book từ request
    private Book_24133009 extractBookFromRequest(HttpServletRequest request) throws Exception {
        Book_24133009 book = new Book_24133009();

        String isbnStr = request.getParameter("isbn");
        if (isbnStr != null && !isbnStr.isEmpty()) {
            book.setIsbn(Integer.parseInt(isbnStr));
        }

        book.setTitle(request.getParameter("title"));
        book.setPublisher(request.getParameter("publisher"));

        String priceStr = request.getParameter("price");
        if (priceStr != null && !priceStr.isEmpty()) {
            book.setPrice(Double.parseDouble(priceStr));
        }

        book.setDescription(request.getParameter("description"));

        String publishDateStr = request.getParameter("publishDate");
        if (publishDateStr != null && !publishDateStr.isEmpty()) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            book.setPublishDate(sdf.parse(publishDateStr));
        }

        book.setCoverImage(request.getParameter("coverImage"));

        String quantityStr = request.getParameter("quantity");
        if (quantityStr != null && !quantityStr.isEmpty()) {
            book.setQuantity(Integer.parseInt(quantityStr));
        }

        // Xử lý danh sách authors
        String[] authorIds = request.getParameterValues("authorIds");
        if (authorIds != null) {
            List<Author_24133009> selectedAuthors = new ArrayList<>();
            for (String authorIdStr : authorIds) {
                Author_24133009 author = authorService.getAuthorById(Integer.parseInt(authorIdStr));
                if (author != null) {
                    selectedAuthors.add(author);
                }
            }
            book.setAuthors(selectedAuthors);
        }

        return book;
    }
}
