package repository;

import model.User_24133009;
import util.JPAUtil_24133009;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import java.util.List;

public class UserRepository_24133009 {

    public User_24133009 findById(int id) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            return em.find(User_24133009.class, id);
        } finally {
            em.close();
        }
    }

    public User_24133009 findByEmail(String email) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            TypedQuery<User_24133009> query = em.createQuery(
                "SELECT u FROM User_24133009 u WHERE u.email = :email", User_24133009.class);
            query.setParameter("email", email);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public User_24133009 findByEmailAndPassword(String email, String passwd) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            TypedQuery<User_24133009> query = em.createQuery(
                "SELECT u FROM User_24133009 u WHERE u.email = :email AND u.passwd = :passwd",
                User_24133009.class);
            query.setParameter("email", email);
            query.setParameter("passwd", passwd);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public void save(User_24133009 user) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void update(User_24133009 user) {
        EntityManager em = JPAUtil_24133009.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(user);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
