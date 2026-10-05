package controller;

import model.Author_24133009;
import service.AuthorService_24133009;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/admin/authors")
public class AuthorController_24133009 extends HttpServlet {

    private static final int PAGE_SIZE = 5;
    private final AuthorService_24133009 authorService = new AuthorService_24133009();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                listAuthors(request, response);
                break;
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteAuthor(request, response);
                break;
            default:
                listAuthors(request, response);
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
                createAuthor(request, response);
                break;
            case "update":
                updateAuthor(request, response);
                break;
            default:
                listAuthors(request, response);
        }
    }

    // Hiển thị danh sách authors có phân trang
    private void listAuthors(HttpServletRequest request, HttpServletResponse response)
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

        List<Author_24133009> authors = authorService.getAuthors(page, PAGE_SIZE);
        int totalPages = authorService.getTotalPages(PAGE_SIZE);
        long totalCount = authorService.getTotalCount();

        request.setAttribute("authors", authors);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("pageSize", PAGE_SIZE);

        request.getRequestDispatcher("/WEB-INF/views/admin/author-list.jsp")
               .forward(request, response);
    }

    // Hiển thị form thêm mới
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("author", new Author_24133009());
        request.getRequestDispatcher("/WEB-INF/views/admin/author-form.jsp")
               .forward(request, response);
    }

    // Hiển thị form chỉnh sửa
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Author_24133009 author = authorService.getAuthorById(id);
        request.setAttribute("author", author);
        request.getRequestDispatcher("/WEB-INF/views/admin/author-form.jsp")
               .forward(request, response);
    }

    // Tạo author mới
    private void createAuthor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Author_24133009 author = extractAuthorFromRequest(request);
            authorService.addAuthor(author);
            response.sendRedirect(request.getContextPath() + "/admin/authors?action=list&success=create");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi thêm tác giả: " + e.getMessage());
            showNewForm(request, response);
        }
    }

    // Cập nhật author
    private void updateAuthor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("authorId"));
            Author_24133009 author = extractAuthorFromRequest(request);
            author.setAuthorId(id);
            authorService.updateAuthor(author);
            response.sendRedirect(request.getContextPath() + "/admin/authors?action=list&success=update");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi cập nhật tác giả: " + e.getMessage());
            showEditForm(request, response);
        }
    }

    // Xóa author
    private void deleteAuthor(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        authorService.deleteAuthor(id);
        response.sendRedirect(request.getContextPath() + "/admin/authors?action=list&success=delete");
    }

    // Trích xuất thông tin author từ request
    private Author_24133009 extractAuthorFromRequest(HttpServletRequest request) throws Exception {
        Author_24133009 author = new Author_24133009();
        author.setAuthorName(request.getParameter("authorName"));

        String dobStr = request.getParameter("dateOfBirth");
        if (dobStr != null && !dobStr.isEmpty()) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            author.setDateOfBirth(sdf.parse(dobStr));
        }

        return author;
    }
}
