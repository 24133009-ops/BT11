package repository;

import model.Author_24133009;
import util.JPAUtil_24133009;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;

public class AuthorRepository_24133009 {

    // Lấy tổng số authors
    public long countAll() {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(a) FROM Author_24133009 a", Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    // Lấy danh sách authors với phân trang
    public List<Author_24133009> findAll(int page, int pageSize) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            TypedQuery<Author_24133009> query = em.createQuery(
                "SELECT a FROM Author_24133009 a ORDER BY a.authorId", Author_24133009.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // Lấy tất cả authors (không phân trang - dùng cho dropdown)
    public List<Author_24133009> findAll() {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            return em.createQuery("SELECT a FROM Author_24133009 a ORDER BY a.authorName",
                Author_24133009.class).getResultList();
        } finally {
            em.close();
        }
    }

    // Tìm author theo ID
    public Author_24133009 findById(int id) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            return em.find(Author_24133009.class, id);
        } finally {
            em.close();
        }
    }

    // Thêm author mới
    public void save(Author_24133009 author) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(author);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // Cập nhật author
    public void update(Author_24133009 author) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(author);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // Xóa author theo ID
    public void delete(int id) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            em.getTransaction().begin();
            Author_24133009 author = em.find(Author_24133009.class, id);
            if (author != null) {
                em.remove(author);
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
