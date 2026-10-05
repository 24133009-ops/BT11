package model;

import java.io.Serializable;

public class CartItem_24133009 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Book_24133009 book;
    private int quantity;

    public CartItem_24133009() {
    }

    public CartItem_24133009(Book_24133009 book, int quantity) {
        this.book = book;
        this.quantity = quantity;
    }

    public Book_24133009 getBook() {
        return book;
    }

    public void setBook(Book_24133009 book) {
        this.book = book;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getSubtotal() {
        if (book != null && book.getPrice() != null) {
            return book.getPrice() * quantity;
        }
        return 0.0;
    }
}
