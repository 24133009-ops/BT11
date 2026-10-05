package service;

import model.*;
import repository.OrderRepository_24133009;

import java.util.Date;
import java.util.List;

public class OrderService_24133009 {

    private final OrderRepository_24133009 orderRepository = new OrderRepository_24133009();

    public Order_24133009 checkoutCOD(User_24133009 user, Cart_24133009 cart,
                                      String fullname, String phone, String address, String note) throws Exception {
        if (cart == null || cart.isEmpty()) {
            throw new Exception("Giỏ hàng của bạn đang trống!");
        }
        if (fullname == null || fullname.trim().isEmpty()) {
            throw new Exception("Vui lòng nhập họ và tên người nhận!");
        }
        if (phone == null || phone.trim().isEmpty()) {
            throw new Exception("Vui lòng nhập số điện thoại người nhận!");
        }
        if (address == null || address.trim().isEmpty()) {
            throw new Exception("Vui lòng nhập địa chỉ nhận hàng!");
        }

        Order_24133009 order = new Order_24133009();
        order.setUser(user);
        order.setFullname(fullname.trim());
        order.setPhone(phone.trim());
        order.setAddress(address.trim());
        order.setNote(note != null ? note.trim() : "");
        order.setTotalPrice(cart.getTotalPrice());
        order.setPaymentMethod("COD");
        order.setStatus("Đơn hàng mới");
        order.setOrderDate(new Date());

        for (CartItem_24133009 item : cart.getItems()) {
            OrderItem_24133009 orderItem = new OrderItem_24133009();
            orderItem.setOrder(order);
            orderItem.setBook(item.getBook());
            orderItem.setQuantity(item.getQuantity());
            orderItem.setPrice(item.getBook().getPrice());
            order.addOrderItem(orderItem);
        }

        Order_24133009 saved = orderRepository.createOrder(order);
        // Làm rỗng giỏ sau khi đặt hàng thành công
        cart.clear();
        return saved;
    }

    public Order_24133009 getOrderById(int orderId) {
        return orderRepository.findById(orderId);
    }

    public List<Order_24133009> getOrders(User_24133009 user, String status) {
        boolean hasStatus = status != null && !status.trim().isEmpty() && !status.equalsIgnoreCase("ALL");
        if (user != null && !Boolean.TRUE.equals(user.getIsAdmin())) {
            // User thường: chỉ xem đơn hàng của mình
            if (hasStatus) {
                return orderRepository.findByUserIdAndStatus(user.getId(), status.trim());
            } else {
                return orderRepository.findByUserId(user.getId());
            }
        } else if (user != null && Boolean.TRUE.equals(user.getIsAdmin())) {
            // Admin: xem được tất cả đơn hàng
            if (hasStatus) {
                return orderRepository.findByStatus(status.trim());
            } else {
                return orderRepository.findAll();
            }
        } else {
            // Khách chưa đăng nhập: trả về rỗng hoặc theo id
            return orderRepository.findAll();
        }
    }

    public void updateOrderStatus(int orderId, String newStatus) {
        orderRepository.updateStatus(orderId, newStatus);
    }
}
