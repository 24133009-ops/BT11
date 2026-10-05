package model;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "order_items")
public class OrderItem_24133009 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", nullable = false)
    private Order_24133009 order;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "book_id", nullable = false)
    private Book_24133009 book;

    @Column(name = "quantity", nullable = false)
    private int quantity;

    @Column(name = "price", precision = 10, scale = 2, nullable = false)
    private Double price;

    public OrderItem_24133009() {
    }

    public OrderItem_24133009(Order_24133009 order, Book_24133009 book, int quantity, Double price) {
        this.order = order;
        this.book = book;
        this.quantity = quantity;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Order_24133009 getOrder() {
        return order;
    }

    public void setOrder(Order_24133009 order) {
        this.order = order;
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

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public double getSubtotal() {
        if (price != null) {
            return price * quantity;
        }
        return 0.0;
    }
}
