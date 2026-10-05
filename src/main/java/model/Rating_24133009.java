package model;

import javax.persistence.*;

@Entity
@Table(name = "rating")
@IdClass(RatingId_24133009.class)
public class Rating_24133009 {

    @Id
    @Column(name = "userid")
    private int userId;

    @Id
    @Column(name = "bookid")
    private int bookId;

    @Column(name = "rating", columnDefinition = "tinyint")
    private Byte rating;

    @Column(name = "review_text", columnDefinition = "TEXT")
    private String reviewText;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "userid", insertable = false, updatable = false)
    private User_24133009 user;

    // Constructors
    public Rating_24133009() {}

    public Rating_24133009(int userId, int bookId, Byte rating, String reviewText) {
        this.userId = userId;
        this.bookId = bookId;
        this.rating = rating;
        this.reviewText = reviewText;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }

    public Byte getRating() { return rating; }
    public void setRating(Byte rating) { this.rating = rating; }

    public String getReviewText() { return reviewText; }
    public void setReviewText(String reviewText) { this.reviewText = reviewText; }

    public User_24133009 getUser() { return user; }
    public void setUser(User_24133009 user) { this.user = user; }
}
