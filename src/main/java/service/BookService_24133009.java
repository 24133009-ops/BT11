package service;

import model.Book_24133009;
import repository.BookRepository_24133009;

import java.util.List;

public class BookService_24133009 {

    private final BookRepository_24133009 bookRepo = new BookRepository_24133009();

    // Lấy tổng số trang
    public int getTotalPages(int pageSize) {
        long total = bookRepo.countAll();
        return (int) Math.ceil((double) total / pageSize);
    }

    // Lấy danh sách books với phân trang
    public List<Book_24133009> getBooks(int page, int pageSize) {
        return bookRepo.findAll(page, pageSize);
    }

    // Lấy tất cả books
    public List<Book_24133009> getAllBooks() {
        return bookRepo.findAll();
    }

    // Tìm book theo ID
    public Book_24133009 getBookById(int id) {
        return bookRepo.findById(id);
    }

    // Thêm book mới
    public void addBook(Book_24133009 book) {
        bookRepo.save(book);
    }

    // Cập nhật book
    public void updateBook(Book_24133009 book) {
        bookRepo.update(book);
    }

    // Xóa book
    public void deleteBook(int id) {
        bookRepo.delete(id);
    }

    // Lấy tổng số books
    public long getTotalCount() {
        return bookRepo.countAll();
    }
}
