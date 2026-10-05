package controller;

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
import java.util.List;

@WebServlet({"/orders", "/order-detail"})
public class OrderHistoryController_24133009 extends HttpServlet {

    private final OrderService_24133009 orderService = new OrderService_24133009();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User_24133009 user = (User_24133009) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        if ("/order-detail".equals(path)) {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    int orderId = Integer.parseInt(idParam);
                    Order_24133009 order = orderService.getOrderById(orderId);
                    request.setAttribute("order", order);
                } catch (NumberFormatException ignored) {}
            }
            request.getRequestDispatcher("/WEB-INF/views/order-detail.jsp").forward(request, response);
            return;
        }

        // List orders with status filter
        String currentStatus = request.getParameter("status");
        if (currentStatus == null || currentStatus.trim().isEmpty()) {
            currentStatus = "ALL";
        } else {
            currentStatus = currentStatus.trim();
        }

        List<Order_24133009> orders = orderService.getOrders(user, currentStatus);

        request.setAttribute("orders", orders);
        request.setAttribute("currentStatus", currentStatus);
        request.getRequestDispatcher("/WEB-INF/views/order-history.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User_24133009 user = (User_24133009) session.getAttribute("user");

        if (user != null && Boolean.TRUE.equals(user.getIsAdmin())) {
            String orderIdStr = request.getParameter("orderId");
            String newStatus = request.getParameter("newStatus");
            if (orderIdStr != null && newStatus != null) {
                try {
                    int orderId = Integer.parseInt(orderIdStr.trim());
                    orderService.updateOrderStatus(orderId, newStatus.trim());
                } catch (Exception ignored) {}
            }
        }

        String redirectUrl = request.getParameter("redirectUrl");
        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            response.sendRedirect(redirectUrl);
        } else {
            response.sendRedirect(request.getContextPath() + "/orders");
        }
    }
}
