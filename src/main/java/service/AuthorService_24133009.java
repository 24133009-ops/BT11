package service;

import model.Author_24133009;
import repository.AuthorRepository_24133009;

import java.util.List;

public class AuthorService_24133009 {

    private final AuthorRepository_24133009 authorRepo = new AuthorRepository_24133009();

    // Lấy tổng số trang
    public int getTotalPages(int pageSize) {
        long total = authorRepo.countAll();
        return (int) Math.ceil((double) total / pageSize);
    }

    // Lấy danh sách authors với phân trang
    public List<Author_24133009> getAuthors(int page, int pageSize) {
        return authorRepo.findAll(page, pageSize);
    }

    // Lấy tất cả authors
    public List<Author_24133009> getAllAuthors() {
        return authorRepo.findAll();
    }

    // Tìm author theo ID
    public Author_24133009 getAuthorById(int id) {
        return authorRepo.findById(id);
    }

    // Thêm author mới
    public void addAuthor(Author_24133009 author) {
        authorRepo.save(author);
    }

    // Cập nhật author
    public void updateAuthor(Author_24133009 author) {
        authorRepo.update(author);
    }

    // Xóa author
    public void deleteAuthor(int id) {
        authorRepo.delete(id);
    }

    // Lấy tổng số authors
    public long getTotalCount() {
        return authorRepo.countAll();
    }
}
