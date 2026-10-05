package repository;

import model.Book_24133009;
import model.OrderItem_24133009;
import model.Order_24133009;
import util.JPAUtil_24133009;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;

public class OrderRepository_24133009 {

    public Order_24133009 createOrder(Order_24133009 order) throws Exception {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();

            // Trừ số lượng tồn kho của từng cuốn sách
            for (OrderItem_24133009 item : order.getOrderItems()) {
                Book_24133009 managedBook = em.find(Book_24133009.class, item.getBook().getBookId());
                if (managedBook != null) {
                    int currentStock = managedBook.getQuantity() != null ? managedBook.getQuantity() : 0;
                    if (currentStock < item.getQuantity()) {
                        throw new Exception("Sách \"" + managedBook.getTitle() + "\" không đủ số lượng trong kho (còn: " + currentStock + ", yêu cầu: " + item.getQuantity() + ").");
                    }
                    managedBook.setQuantity(currentStock - item.getQuantity());
                    em.merge(managedBook);
                    item.setBook(managedBook);
                }
            }

            em.persist(order);
            tx.commit();
            return order;
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    public Order_24133009 findById(int orderId) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            TypedQuery<Order_24133009> query = em.createQuery(
                "SELECT DISTINCT o FROM Order_24133009 o LEFT JOIN FETCH o.orderItems i LEFT JOIN FETCH i.book WHERE o.orderId = :id",
                Order_24133009.class);
            query.setParameter("id", orderId);
            List<Order_24133009> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    public List<Order_24133009> findByUserId(int userId) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            TypedQuery<Order_24133009> query = em.createQuery(
                "SELECT DISTINCT o FROM Order_24133009 o LEFT JOIN FETCH o.orderItems i LEFT JOIN FETCH i.book " +
                "WHERE o.user.id = :userId ORDER BY o.orderDate DESC", Order_24133009.class);
            query.setParameter("userId", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Order_24133009> findByUserIdAndStatus(int userId, String status) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            TypedQuery<Order_24133009> query = em.createQuery(
                "SELECT DISTINCT o FROM Order_24133009 o LEFT JOIN FETCH o.orderItems i LEFT JOIN FETCH i.book " +
                "WHERE o.user.id = :userId AND LOWER(TRIM(o.status)) = LOWER(TRIM(:status)) ORDER BY o.orderDate DESC", Order_24133009.class);
            query.setParameter("userId", userId);
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Order_24133009> findAll() {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            TypedQuery<Order_24133009> query = em.createQuery(
                "SELECT DISTINCT o FROM Order_24133009 o LEFT JOIN FETCH o.orderItems i LEFT JOIN FETCH i.book " +
                "ORDER BY o.orderDate DESC", Order_24133009.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Order_24133009> findByStatus(String status) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            TypedQuery<Order_24133009> query = em.createQuery(
                "SELECT DISTINCT o FROM Order_24133009 o LEFT JOIN FETCH o.orderItems i LEFT JOIN FETCH i.book " +
                "WHERE LOWER(TRIM(o.status)) = LOWER(TRIM(:status)) ORDER BY o.orderDate DESC", Order_24133009.class);
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void updateStatus(int orderId, String newStatus) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Order_24133009 order = em.find(Order_24133009.class, orderId);
            if (order != null) {
                order.setStatus(newStatus);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
