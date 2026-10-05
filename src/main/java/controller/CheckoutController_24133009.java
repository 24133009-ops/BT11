package controller;

import model.Cart_24133009;
import model.Order_24133009;
import model.User_24133009;
import service.OrderService_24133009;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet({"/checkout", "/order-success"})
public class CheckoutController_24133009 extends HttpServlet {

    private final OrderService_24133009 orderService = new OrderService_24133009();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String servletPath = request.getServletPath();

        if ("/order-success".equals(servletPath)) {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    int orderId = Integer.parseInt(idParam);
                    Order_24133009 order = orderService.getOrderById(orderId);
                    request.setAttribute("order", order);
                } catch (NumberFormatException ignored) {}
            }
            request.getRequestDispatcher("/WEB-INF/views/order-success.jsp").forward(request, response);
            return;
        }

        // Checkout view
        HttpSession session = request.getSession();
        Cart_24133009 cart = (Cart_24133009) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            session.setAttribute("cartWarning", "Giỏ hàng của bạn đang trống. Hãy chọn sản phẩm trước khi thanh toán!");
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        User_24133009 user = (User_24133009) session.getAttribute("user");
        request.setAttribute("currentUser", user);
        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Cart_24133009 cart = (Cart_24133009) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        User_24133009 user = (User_24133009) session.getAttribute("user");
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String note = request.getParameter("note");

        try {
            Order_24133009 order = orderService.checkoutCOD(user, cart, fullname, phone, address, note);
            response.sendRedirect(request.getContextPath() + "/order-success?id=" + order.getOrderId());
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("fullname", fullname);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.setAttribute("note", note);
            request.setAttribute("currentUser", user);
            request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
        }
    }
}
