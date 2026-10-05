package service;

import model.Rating_24133009;
import repository.RatingRepository_24133009;

import java.util.List;

public class RatingService_24133009 {

    private final RatingRepository_24133009 ratingRepo = new RatingRepository_24133009();

    public List<Rating_24133009> getReviewsByBookId(int bookId) {
        return ratingRepo.findByBookId(bookId);
    }

    public long getReviewCount(int bookId) {
        return ratingRepo.countByBookId(bookId);
    }

    public void addReview(int userId, int bookId, byte ratingVal, String reviewText) {
        Rating_24133009 rating = new Rating_24133009(userId, bookId, ratingVal, reviewText);
        ratingRepo.saveOrUpdate(rating);
    }
}
