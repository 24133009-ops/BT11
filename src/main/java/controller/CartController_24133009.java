package controller;

import model.Book_24133009;
import model.Cart_24133009;
import service.BookService_24133009;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/cart")
public class CartController_24133009 extends HttpServlet {

    private final BookService_24133009 bookService = new BookService_24133009();

    private Cart_24133009 getCart(HttpSession session) {
        Cart_24133009 cart = (Cart_24133009) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart_24133009();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Cart_24133009 cart = getCart(session);

        if ("remove".equals(action)) {
            try {
                int bookId = Integer.parseInt(request.getParameter("id"));
                cart.removeItem(bookId);
                session.setAttribute("cartSuccess", "Đã xóa sách khỏi giỏ hàng!");
            } catch (Exception ignored) {}
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        } else if ("clear".equals(action)) {
            cart.clear();
            session.setAttribute("cartSuccess", "Đã xóa toàn bộ giỏ hàng!");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        } else if ("add".equals(action)) {
            // GET-based add to cart (e.g. quick buy from home)
            doPost(request, response);
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Cart_24133009 cart = getCart(session);

        String action = request.getParameter("action");
        if (action == null) action = "view";

        try {
            if ("add".equals(action)) {
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                int quantity = 1;
                try {
                    String qParam = request.getParameter("quantity");
                    if (qParam != null && !qParam.isEmpty()) {
                        quantity = Integer.parseInt(qParam);
                    }
                } catch (NumberFormatException ignored) {}

                Book_24133009 book = bookService.getBookById(bookId);
                if (book != null) {
                    String msg = cart.addItem(book, quantity);
                    if (msg != null) {
                        session.setAttribute("cartWarning", msg);
                    } else {
                        session.setAttribute("cartSuccess", "Đã thêm \"" + book.getTitle() + "\" vào giỏ hàng thành công!");
                    }
                }

                String buyNow = request.getParameter("buyNow");
                if ("true".equalsIgnoreCase(buyNow)) {
                    response.sendRedirect(request.getContextPath() + "/checkout");
                    return;
                }
            } else if ("update".equals(action)) {
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                String msg = cart.updateQuantity(bookId, quantity);
                if (msg != null) {
                    session.setAttribute("cartWarning", msg);
                } else {
                    session.setAttribute("cartSuccess", "Đã cập nhật số lượng thành công!");
                }
            } else if ("remove".equals(action)) {
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                cart.removeItem(bookId);
                session.setAttribute("cartSuccess", "Đã xóa sách khỏi giỏ hàng!");
            }
        } catch (Exception e) {
            session.setAttribute("cartError", "Thao tác không hợp lệ: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
