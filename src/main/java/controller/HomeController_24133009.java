package controller;

import model.Book_24133009;
import service.BookService_24133009;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeController_24133009 extends HttpServlet {

    private static final int PAGE_SIZE = 6;
    private final BookService_24133009 bookService = new BookService_24133009();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try { page = Integer.parseInt(pageParam); }
            catch (NumberFormatException e) { page = 1; }
        }

        List<Book_24133009> books = bookService.getBooks(page, PAGE_SIZE);
        int totalPages = bookService.getTotalPages(PAGE_SIZE);
        long totalCount = bookService.getTotalCount();

        request.setAttribute("books", books);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("pageSize", PAGE_SIZE);

        request.getRequestDispatcher("/WEB-INF/views/home.jsp")
               .forward(request, response);
    }
}
