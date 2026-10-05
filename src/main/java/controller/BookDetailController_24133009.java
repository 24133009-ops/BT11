package controller;

import model.Book_24133009;
import model.Rating_24133009;
import model.User_24133009;
import service.BookService_24133009;
import service.RatingService_24133009;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/book-detail")
public class BookDetailController_24133009 extends HttpServlet {

    private final BookService_24133009 bookService = new BookService_24133009();
    private final RatingService_24133009 ratingService = new RatingService_24133009();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try {
            int bookId = Integer.parseInt(idParam.trim());
            Book_24133009 book = bookService.getBookById(bookId);

            if (book == null) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }

            List<Rating_24133009> reviews = ratingService.getReviewsByBookId(bookId);
            long reviewCount = ratingService.getReviewCount(bookId);

            request.setAttribute("book", book);
            request.setAttribute("reviews", reviews);
            request.setAttribute("reviewCount", reviewCount);

            request.getRequestDispatcher("/WEB-INF/views/book-detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);

        User_24133009 currentUser = (session != null) ? (User_24133009) session.getAttribute("user") : null;

        String idParam = request.getParameter("bookId");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        int bookId = Integer.parseInt(idParam.trim());

        // Nếu chưa đăng nhập -> chuyển sang trang login
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=need_login");
            return;
        }

        String reviewText = request.getParameter("reviewText");
        String ratingStr = request.getParameter("rating");
        byte ratingVal = 5;
        if (ratingStr != null && !ratingStr.trim().isEmpty()) {
            try {
                ratingVal = Byte.parseByte(ratingStr.trim());
            } catch (NumberFormatException ignored) {}
        }

        if (reviewText != null && !reviewText.trim().isEmpty()) {
            ratingService.addReview(currentUser.getId(), bookId, ratingVal, reviewText.trim());
        }

        response.sendRedirect(request.getContextPath() + "/book-detail?id=" + bookId + "&success=reviewed");
    }
}
