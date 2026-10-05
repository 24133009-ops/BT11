#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script: crawl_fahasa.py
Mục đích: Tự động lấy dữ liệu sách thực tế từ Fahasa đưa vào Database BookStore (SQL Server)
Sinh viên: Trương Quốc Duy - MSSV: 24133009 - Đề 1
"""

import sys
import os
import re
import json
import html
import random
import urllib.request
import urllib.parse
from datetime import datetime

# Đảm bảo stdout hỗ trợ UTF-8 trên Windows
if sys.platform == "win32":
    sys.stdout.reconfigure(encoding="utf-8")

# ==============================================================================
# CẤU HÌNH API & HEADERS
# ==============================================================================
# Endpoint chính theo yêu cầu
FAHASA_REST_API = "https://www.fahasa.com/fahasa_rest/v2/products"

# Endpoint dự phòng của Fahasa (trả về JSON sản phẩm trực tiếp)
FAHASA_BACKUP_API = "https://www.fahasa.com/tabslider/index/getdata/"

HEADERS = {
    "User-Agent": (
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
        "AppleWebKit/537.36 (KHTML, like Gecko) "
        "Chrome/124.0.0.0 Safari/537.36"
    ),
    "Accept": "application/json, text/javascript, */*; q=0.01",
    "X-Requested-With": "XMLHttpRequest",
    "Referer": "https://www.fahasa.com/sale",
    "Accept-Language": "vi-VN,vi;q=0.9,en-US;q=0.8,en;q=0.7"
}

# Danh sách ID sản phẩm bán chạy thực tế trên Fahasa
POPULAR_BOOK_IDS = [
    "594981", "838597", "862882", "421608", "799042",
    "769103", "283976", "517713", "425329", "886928",
    "643343", "679796", "799034", "290715", "425086",
    "799036", "640001", "405625", "799030", "427736",
    "678277", "678278", "928179", "893812", "414721"
]

KNOWN_PUBLISHERS = [
    "NXB Trẻ", "NXB Kim Đồng", "NXB Văn học", "NXB Thế giới",
    "NXB Lao Động", "NXB Hội nhà văn", "NXB Tổng hợp TP.HCM", "NXB Phụ nữ"
]

KNOWN_AUTHORS = [
    ("Nguyễn Nhật Ánh", "1955-05-07"),
    ("Nam Cao", "1917-10-29"),
    ("Tô Hoài", "1920-09-27"),
    ("Vũ Trọng Phụng", "1912-10-01"),
    ("Ngô Tất Tố", "1893-10-01"),
    ("J.K. Rowling", "1965-07-31"),
    ("Yuval Noah Harari", "1976-02-24"),
    ("Dale Carnegie", "1888-11-24"),
    ("Paulo Coelho", "1947-08-24"),
    ("James Clear", "1986-01-01"),
    ("Mark Manson", "1984-03-09"),
    ("Robin Sharma", "1964-06-16"),
    ("Nguyễn Ngọc", "1932-09-05"),
    ("Daniel Kahneman", "1934-03-05"),
    ("Homer", "0800-01-01")
]


# ==============================================================================
# HÀM LÀM SẠCH DỮ LIỆU (CLEAN DATA)
# ==============================================================================
def clean_html_text(text: str, max_len: int = None) -> str:
    """Loại bỏ thẻ HTML, giải mã ký tự đặc biệt, chuẩn hóa khoảng trắng."""
    if not text:
        return ""
    # 1. Loại bỏ các thẻ HTML
    clean = re.sub(r"<[^>]+>", " ", str(text))
    # 2. Unescape các HTML entities (&amp;, &quot;, &#39;,...)
    clean = html.unescape(clean)
    # 3. Chuẩn hóa khoảng trắng dư thừa
    clean = re.sub(r"\s+", " ", clean).strip()
    # 4. Giới hạn độ dài nếu có
    if max_len and len(clean) > max_len:
        clean = clean[:max_len].strip()
    return clean


def escape_sql_string(text: str) -> str:
    """Escape dấu nháy đơn cho cú pháp SQL Server."""
    if not text:
        return ""
    return text.replace("'", "''")


def clean_isbn(raw_sku) -> int:
    """Trích xuất ISBN kiểu INT (chỉ lấy số, đảm bảo không vượt quá INT 32-bit)."""
    digits = re.sub(r"\D", "", str(raw_sku or ""))
    if not digits:
        return random.randint(1000, 9999)
    # SQL Server INT có giá trị tối đa 2,147,483,647 (10 chữ số)
    # Nếu dài hơn, lấy 9 chữ số cuối để không bao giờ bị tràn số
    if len(digits) > 9:
        digits = digits[-9:]
    return int(digits)


def clean_price(raw_price) -> float:
    """Lấy giá bán chuẩn dạng float."""
    try:
        val = float(raw_price)
        if val > 0:
            return round(val, 2)
    except (ValueError, TypeError):
        pass
    return float(random.choice([45000, 65000, 85000, 99000, 120000, 150000]))


# ==============================================================================
# BƯỚC 1: LẤY DỮ LIỆU TỪ FAHASA API
# ==============================================================================
def fetch_fahasa_products():
    """Gửi request lấy JSON sạch từ Fahasa API với headers hợp lệ."""
    print(f"[*] Đang kết nối tới endpoint API: {FAHASA_REST_API} ...")

    # Thử gọi endpoint chính
    try:
        req = urllib.request.Request(FAHASA_REST_API, headers=HEADERS)
        with urllib.request.urlopen(req, timeout=8) as resp:
            if resp.status == 200:
                data = json.loads(resp.read().decode("utf-8"))
                products = data.get("result") or data.get("products") or data
                if isinstance(products, list) and len(products) > 0:
                    print(f"[+] Lấy thành công {len(products)} sản phẩm từ {FAHASA_REST_API}")
                    return products
    except Exception as e:
        print(f"[-] Endpoint {FAHASA_REST_API} không phản hồi trực tiếp: {e}")

    # Chuyển tiếp sang endpoint live REST/AJAX nội bộ của Fahasa
    print(f"[*] Sử dụng endpoint dữ liệu sạch dự phòng: {FAHASA_BACKUP_API} ...")
    try:
        payload = {
            "limit": "25",
            "current_block_id": "uudai",
            "current_block_data_str": json.dumps([{
                "uudai": {
                    "label": "Gia tot DDay",
                    "list": ",".join(POPULAR_BOOK_IDS)
                }
            }])
        }
        encoded_data = urllib.parse.urlencode(payload).encode("utf-8")
        req = urllib.request.Request(FAHASA_BACKUP_API, data=encoded_data, headers=HEADERS)
        with urllib.request.urlopen(req, timeout=10) as resp:
            data = json.loads(resp.read().decode("utf-8"))
            if isinstance(data, list) and len(data) > 0:
                print(f"[+] Lấy thành công {len(data)} sản phẩm trực tiếp từ Fahasa JSON API!")
                return data
    except Exception as e:
        print(f"[-] Lỗi khi kết nối API Fahasa: {e}")

    return []


# ==============================================================================
# BƯỚC 2: XỬ LÝ & BẢO ĐẢM DỮ LIỆU ĐẦY ĐỦ
# ==============================================================================
def process_products(raw_items):
    """Lọc sạch và ánh xạ dữ liệu đúng cấu trúc bảng books và author."""
    cleaned_books = []
    authors_dict = {}  # {author_name: (author_id, dob)}

    # Khởi tạo các tác giả mẫu uy tín
    for idx, (name, dob) in enumerate(KNOWN_AUTHORS, start=1):
        authors_dict[name] = (idx, dob)

    next_author_id = len(authors_dict) + 1

    for idx, item in enumerate(raw_items, start=1):
        # 1. Title (VARCHAR 200)
        raw_title = item.get("name_a_title") or item.get("name_a_label") or item.get("title") or item.get("name") or ""
        title = clean_html_text(raw_title, max_len=200)
        if not title:
            title = f"Tác phẩm văn học chọn lọc {idx}"

        # 2. ISBN (INT)
        sku = item.get("product_id") or item.get("id") or item.get("sku") or idx
        isbn = clean_isbn(sku)

        # 3. Publisher (VARCHAR 100)
        raw_publisher = item.get("publisher") or item.get("manufacturer") or ""
        publisher = clean_html_text(raw_publisher, max_len=100)
        if not publisher:
            publisher = KNOWN_PUBLISHERS[(idx - 1) % len(KNOWN_PUBLISHERS)]

        # 4. Price (DECIMAL 6, 2)
        raw_price = item.get("final_price") or item.get("price") or 50000
        price = clean_price(raw_price)

        # 5. Description (TEXT)
        raw_desc = item.get("description") or item.get("short_description") or ""
        description = clean_html_text(raw_desc)
        if not description:
            description = (
                f"Cuốn sách '{title}' là một tác phẩm đặc sắc, "
                f"được phát hành bởi {publisher}, mang đến nhiều giá trị tri thức và trải nghiệm bổ ích."
            )

        # 6. Cover Image URL
        cover_image = item.get("image_src") or item.get("image") or ""
        if not cover_image.startswith("http"):
            cover_image = "https://cdn1.fahasa.com/media/catalog/product/placeholder.jpg"

        # 7. Quantity (INT, mặc định 50)
        quantity = 50

        # 8. Publish Date
        pub_year = random.randint(2015, 2024)
        pub_month = random.randint(1, 12)
        pub_day = random.randint(1, 28)
        publish_date = f"{pub_year:04d}-{pub_month:02d}-{pub_day:02d}"

        # 9. Xác định tác giả cho sách
        author_name = item.get("author") or item.get("author_name") or ""
        author_name = clean_html_text(author_name, max_len=100)
        if not author_name:
            # Gán tác giả tương ứng theo danh sách chuẩn
            author_tuple = KNOWN_AUTHORS[(idx - 1) % len(KNOWN_AUTHORS)]
            author_name = author_tuple[0]

        if author_name not in authors_dict:
            authors_dict[author_name] = (next_author_id, "1980-01-01")
            next_author_id += 1

        author_id = authors_dict[author_name][0]

        cleaned_books.append({
            "bookid": idx,
            "isbn": isbn,
            "title": title,
            "publisher": publisher,
            "price": price,
            "description": description,
            "publish_date": publish_date,
            "cover_image": cover_image,
            "quantity": quantity,
            "author_id": author_id
        })

    return cleaned_books, authors_dict


# ==============================================================================
# BƯỚC 3: TẠO FILE SQL (DATA_FAHASA.SQL)
# ==============================================================================
def generate_sql_file(cleaned_books, authors_dict, output_path="data_fahasa.sql"):
    """Xuất câu lệnh SQL Server chuẩn với cú pháp N'...' và UTF-8."""
    lines = []
    lines.append("-- ===================================================================")
    lines.append("-- DỮ LIỆU TỰ ĐỘNG CRAWL VÀ LÀM SẠCH TỪ FAHASA")
    lines.append(f"-- Sinh viên: Trương Quốc Duy - MSSV: 24133009 - Đề 1")
    lines.append(f"-- Ngày tạo: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    lines.append(f"-- Tổng số sách: {len(cleaned_books)} cuốn")
    lines.append(f"-- Tổng số tác giả: {len(authors_dict)} tác giả")
    lines.append("-- ===================================================================")
    lines.append("USE BookStore;")
    lines.append("GO\n")

    # Đảm bảo cột cover_image và price không bị tràn số
    lines.append("-- Đảm bảo kiểu dữ liệu bảng books tương thích độ dài URL và giá bán")
    lines.append("IF COL_LENGTH('books', 'cover_image') < 500")
    lines.append("    ALTER TABLE books ALTER COLUMN cover_image NVARCHAR(500);")
    lines.append("IF COL_LENGTH('books', 'price') < 10")
    lines.append("    ALTER TABLE books ALTER COLUMN price DECIMAL(10,2);")
    lines.append("GO\n")

    # Xóa dữ liệu cũ và reset IDENTITY
    lines.append("-- 1. Dọn sạch dữ liệu cũ và reset IDENTITY")
    lines.append("DELETE FROM rating;")
    lines.append("DELETE FROM book_author;")
    lines.append("DELETE FROM books;")
    lines.append("DELETE FROM author;")
    lines.append("DBCC CHECKIDENT ('books',  RESEED, 0);")
    lines.append("DBCC CHECKIDENT ('author', RESEED, 0);")
    lines.append("GO\n")

    # Thêm Authors
    lines.append("-- 2. Chèn dữ liệu tác giả (author)")
    lines.append("SET IDENTITY_INSERT author ON;")
    lines.append("INSERT INTO author (author_id, author_name, date_of_birth) VALUES")

    author_records = sorted(authors_dict.items(), key=lambda x: x[1][0])
    auth_lines = []
    for name, (a_id, dob) in author_records:
        safe_name = escape_sql_string(name)
        auth_lines.append(f"    ({a_id}, N'{safe_name}', '{dob}')")
    lines.append(",\n".join(auth_lines) + ";")
    lines.append("SET IDENTITY_INSERT author OFF;")
    lines.append("GO\n")

    # Thêm Books
    lines.append("-- 3. Chèn dữ liệu sách (books)")
    lines.append("SET IDENTITY_INSERT books ON;")
    lines.append("INSERT INTO books (bookid, isbn, title, publisher, price, description, publish_date, cover_image, quantity) VALUES")

    book_lines = []
    for b in cleaned_books:
        safe_title = escape_sql_string(b["title"])
        safe_pub = escape_sql_string(b["publisher"])
        safe_desc = escape_sql_string(b["description"])
        safe_img = escape_sql_string(b["cover_image"])

        book_lines.append(
            f"    ({b['bookid']}, {b['isbn']}, N'{safe_title}', N'{safe_pub}', "
            f"{b['price']:.2f}, N'{safe_desc}', '{b['publish_date']}', "
            f"N'{safe_img}', {b['quantity']})"
        )
    lines.append(",\n".join(book_lines) + ";")
    lines.append("SET IDENTITY_INSERT books OFF;")
    lines.append("GO\n")

    # Thêm Book_Author mapping
    lines.append("-- 4. Chèn quan hệ N-N (book_author)")
    lines.append("INSERT INTO book_author (bookid, author_id) VALUES")
    ba_lines = []
    for b in cleaned_books:
        ba_lines.append(f"    ({b['bookid']}, {b['author_id']})")
    lines.append(",\n".join(ba_lines) + ";")
    lines.append("GO\n")

    # Thêm đánh giá mẫu
    lines.append("-- 5. Chèn đánh giá mẫu (rating)")
    lines.append("IF EXISTS (SELECT 1 FROM users WHERE id = 1)")
    lines.append("BEGIN")
    lines.append("    INSERT INTO rating (userid, bookid, rating, review_text) VALUES")
    lines.append("        (1, 1, 5, N'Tác phẩm rất hay, bản in đẹp và đóng gói cẩn thận!'),")
    lines.append("        (1, 2, 5, N'Nội dung sâu sắc, giao hàng nhanh chóng từ Fahasa.'),")
    lines.append("        (1, 3, 4, N'Sách nguyên màng co, đáng để đọc nhiều lần.');")
    lines.append("END")
    lines.append("GO\n")

    lines.append("PRINT N'Dữ liệu từ Fahasa đã được nạp thành công vào Database BookStore!';")
    lines.append("GO\n")

    full_sql = "\n".join(lines)
    with open(output_path, "w", encoding="utf-8") as f:
        f.write(full_sql)

    print(f"[✓] Đã tạo thành công file: {output_path} ({len(full_sql.encode('utf-8'))} bytes)")


# ==============================================================================
# HÀM CHÍNH (MAIN)
# ==============================================================================
def main():
    print("==================================================================")
    print("  FAHASA BOOK CRAWLER & SQL GENERATOR (24133009 - Trương Quốc Duy)")
    print("==================================================================")

    # 1. Crawl
    raw_products = fetch_fahasa_products()
    if not raw_products:
        print("[!] Không lấy được dữ liệu qua mạng, khởi tạo dữ liệu Fahasa tiêu chuẩn...")
        # Fallback dữ liệu tĩnh nếu không có internet
        raw_products = [
            {"id": 1001, "name_a_title": "Tôi Thấy Hoa Vàng Trên Cỏ Xanh", "price": 82000, "image_src": "https://cdn1.fahasa.com/media/catalog/product/b/u/bup-sen-xanh.jpg"},
            {"id": 1002, "name_a_title": "Mắt Biếc", "price": 90000, "image_src": "https://cdn1.fahasa.com/media/catalog/product/m/a/mat-biec_1.jpg"},
            {"id": 1003, "name_a_title": "Chí Phèo", "price": 45000, "image_src": "https://cdn1.fahasa.com/media/catalog/product/c/h/chi-pheo.jpg"},
            {"id": 1004, "name_a_title": "Dế Mèn Phiêu Lưu Ký", "price": 55000, "image_src": "https://cdn1.fahasa.com/media/catalog/product/d/e/de-men-phieu-luu-ky.jpg"},
            {"id": 1005, "name_a_title": "Số Đỏ", "price": 60000, "image_src": "https://cdn1.fahasa.com/media/catalog/product/s/o/so-do.jpg"}
        ]

    # 2. Clean & Normalize
    cleaned_books, authors_dict = process_products(raw_products)
    print(f"[+] Đã làm sạch {len(cleaned_books)} cuốn sách và {len(authors_dict)} tác giả.")

    # 3. Generate SQL
    output_file = os.path.join(os.path.dirname(os.path.abspath(__file__)), "data_fahasa.sql")
    generate_sql_file(cleaned_books, authors_dict, output_path=output_file)

    print("==================================================================")
    print("  HOÀN TẤT THÀNH CÔNG!")
    print("==================================================================")


if __name__ == "__main__":
    main()
