package repository;

import model.Rating_24133009;
import model.RatingId_24133009;
import util.JPAUtil_24133009;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;

public class RatingRepository_24133009 {

    public List<Rating_24133009> findByBookId(int bookId) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            TypedQuery<Rating_24133009> query = em.createQuery(
                "SELECT r FROM Rating_24133009 r WHERE r.bookId = :bookId", Rating_24133009.class);
            query.setParameter("bookId", bookId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public long countByBookId(int bookId) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(r) FROM Rating_24133009 r WHERE r.bookId = :bookId", Long.class);
            query.setParameter("bookId", bookId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public void saveOrUpdate(Rating_24133009 rating) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            em.getTransaction().begin();
            RatingId_24133009 id = new RatingId_24133009(rating.getUserId(), rating.getBookId());
            Rating_24133009 existing = em.find(Rating_24133009.class, id);
            if (existing != null) {
                existing.setRating(rating.getRating());
                existing.setReviewText(rating.getReviewText());
                em.merge(existing);
            } else {
                em.persist(rating);
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
