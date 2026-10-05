package model;

import java.io.Serializable;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public class Cart_24133009 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Map<Integer, CartItem_24133009> items;

    public Cart_24133009() {
        this.items = new LinkedHashMap<>();
    }

    public Collection<CartItem_24133009> getItems() {
        return items.values();
    }

    public Map<Integer, CartItem_24133009> getItemMap() {
        return items;
    }

    /**
     * Thêm sản phẩm vào giỏ hàng
     * Giới hạn: Không vượt quá số lượng tồn kho (book.getQuantity())
     * @return Thông báo kết quả (null nếu thành công)
     */
    public String addItem(Book_24133009 book, int addQty) {
        if (book == null || addQty <= 0) {
            return "Sản phẩm không hợp lệ.";
        }

        int maxStock = book.getQuantity() != null ? book.getQuantity() : 0;
        if (maxStock <= 0) {
            return "Sách \"" + book.getTitle() + "\" hiện đã hết hàng.";
        }

        CartItem_24133009 existing = items.get(book.getBookId());
        int currentQty = existing != null ? existing.getQuantity() : 0;
        int newQty = currentQty + addQty;

        if (newQty > maxStock) {
            if (existing != null) {
                existing.setQuantity(maxStock);
            } else {
                items.put(book.getBookId(), new CartItem_24133009(book, maxStock));
            }
            return "Số lượng yêu cầu vượt quá tồn kho. Giỏ hàng đã được điều chỉnh về mức tối đa: " + maxStock + " cuốn.";
        }

        if (existing != null) {
            existing.setQuantity(newQty);
        } else {
            items.put(book.getBookId(), new CartItem_24133009(book, newQty));
        }
        return null;
    }

    /**
     * Cập nhật số lượng sản phẩm trong giới hạn
     * @return Thông báo lỗi nếu có
     */
    public String updateQuantity(int bookId, int newQty) {
        CartItem_24133009 item = items.get(bookId);
        if (item == null) {
            return "Sản phẩm không tồn tại trong giỏ hàng.";
        }

        int maxStock = item.getBook().getQuantity() != null ? item.getBook().getQuantity() : 0;

        if (newQty <= 0) {
            items.remove(bookId);
            return "Đã xóa sản phẩm khỏi giỏ hàng.";
        }

        if (newQty > maxStock) {
            item.setQuantity(maxStock);
            return "Số lượng chỉ còn " + maxStock + " cuốn trong kho. Đã tự động điều chỉnh về mức tối đa.";
        }

        item.setQuantity(newQty);
        return null;
    }

    public void removeItem(int bookId) {
        items.remove(bookId);
    }

    public void clear() {
        items.clear();
    }

    public double getTotalPrice() {
        double total = 0.0;
        for (CartItem_24133009 item : items.values()) {
            total += item.getSubtotal();
        }
        return total;
    }

    public int getTotalQuantity() {
        int total = 0;
        for (CartItem_24133009 item : items.values()) {
            total += item.getQuantity();
        }
        return total;
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }
}
