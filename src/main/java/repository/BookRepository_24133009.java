package repository;

import model.Book_24133009;
import util.JPAUtil_24133009;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;

public class BookRepository_24133009 {

    // Lấy tổng số books
    public long countAll() {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(b) FROM Book_24133009 b", Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    // Lấy danh sách books với phân trang
    public List<Book_24133009> findAll(int page, int pageSize) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            TypedQuery<Book_24133009> query = em.createQuery(
                "SELECT b FROM Book_24133009 b ORDER BY b.bookId", Book_24133009.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // Lấy tất cả books (không phân trang - dùng cho dropdown)
    public List<Book_24133009> findAll() {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            return em.createQuery("SELECT b FROM Book_24133009 b ORDER BY b.title",
                Book_24133009.class).getResultList();
        } finally {
            em.close();
        }
    }

    // Tìm book theo ID
    public Book_24133009 findById(int id) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            return em.find(Book_24133009.class, id);
        } finally {
            em.close();
        }
    }

    // Thêm book mới
    public void save(Book_24133009 book) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(book);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // Cập nhật book
    public void update(Book_24133009 book) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(book);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // Xóa book theo ID
    public void delete(int id) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            em.getTransaction().begin();
            Book_24133009 book = em.find(Book_24133009.class, id);
            if (book != null) {
                em.remove(book);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
