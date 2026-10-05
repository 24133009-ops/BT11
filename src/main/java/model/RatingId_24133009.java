package model;

import java.io.Serializable;
import java.util.Objects;

public class RatingId_24133009 implements Serializable {
    private int userId;
    private int bookId;

    public RatingId_24133009() {}

    public RatingId_24133009(int userId, int bookId) {
        this.userId = userId;
        this.bookId = bookId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof RatingId_24133009)) return false;
        RatingId_24133009 that = (RatingId_24133009) o;
        return userId == that.userId && bookId == that.bookId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, bookId);
    }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
}
