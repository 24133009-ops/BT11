-- ============================================
-- Database: BookStore
-- Sinh viên: Trương Quốc Duy - MSSV: 24133009 - Đề 1
-- Data thực tế lấy từ: fahasa.com
-- ============================================

USE BookStore;
GO

-- 1. Table: author
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='author' AND xtype='U')
CREATE TABLE author (
    author_id     INT PRIMARY KEY IDENTITY(1,1),
    author_name   NVARCHAR(100),
    date_of_birth DATE
);
GO

-- 2. Table: books
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='books' AND xtype='U')
CREATE TABLE books (
    bookid       INT PRIMARY KEY IDENTITY(1,1),
    isbn         INT,
    title        NVARCHAR(200),
    publisher    NVARCHAR(100),
    price        DECIMAL(10,2),
    description  NVARCHAR(MAX),
    publish_date DATE,
    cover_image  NVARCHAR(500),
    quantity     INT
);
GO

-- 3. Table: users
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='users' AND xtype='U')
CREATE TABLE users (
    id          INT PRIMARY KEY IDENTITY(1,1),
    email       VARCHAR(50) NOT NULL,
    fullname    NVARCHAR(50),
    phone       INT,
    passwd      VARCHAR(32) NOT NULL,
    signup_date DATETIME,
    last_login  DATETIME,
    is_admin    BIT
);
GO

-- 4. Table: book_author
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='book_author' AND xtype='U')
CREATE TABLE book_author (
    bookid    INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (bookid, author_id),
    FOREIGN KEY (bookid) REFERENCES books(bookid),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);
GO

-- 5. Table: rating
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='rating' AND xtype='U')
CREATE TABLE rating (
    userid      INT NOT NULL,
    bookid      INT NOT NULL,
    rating      TINYINT,
    review_text NVARCHAR(MAX),
    PRIMARY KEY (userid, bookid),
    FOREIGN KEY (userid) REFERENCES users(id),
    FOREIGN KEY (bookid) REFERENCES books(bookid)
);
GO

-- 6. Table: orders
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='orders' AND xtype='U')
CREATE TABLE orders (
    order_id       INT PRIMARY KEY IDENTITY(1,1),
    user_id        INT NULL FOREIGN KEY REFERENCES users(id),
    fullname       NVARCHAR(100) NOT NULL,
    phone          VARCHAR(20) NOT NULL,
    address        NVARCHAR(255) NOT NULL,
    note           NVARCHAR(500),
    total_price    DECIMAL(12,2),
    payment_method NVARCHAR(50) DEFAULT 'COD',
    status         NVARCHAR(50) DEFAULT N'Đơn hàng mới',
    order_date     DATETIME DEFAULT GETDATE()
);
GO

-- 7. Table: order_items
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='order_items' AND xtype='U')
CREATE TABLE order_items (
    id        INT PRIMARY KEY IDENTITY(1,1),
    order_id  INT NOT NULL FOREIGN KEY REFERENCES orders(order_id) ON DELETE CASCADE,
    book_id   INT NOT NULL FOREIGN KEY REFERENCES books(bookid),
    quantity  INT NOT NULL,
    price     DECIMAL(10,2) NOT NULL
);
GO

-- Alter cover_image column to support long URLs
IF COL_LENGTH('books', 'cover_image') < 500
    ALTER TABLE books ALTER COLUMN cover_image NVARCHAR(500);
GO

-- ============================================
-- XÓA DỮ LIỆU CŨ
-- ============================================
DELETE FROM rating;
DELETE FROM book_author;
DELETE FROM books;
DELETE FROM author;
DELETE FROM users;

DBCC CHECKIDENT ('books',  RESEED, 0);
DBCC CHECKIDENT ('author', RESEED, 0);
DBCC CHECKIDENT ('users',  RESEED, 0);
GO

-- ============================================
-- USERS
-- ============================================
INSERT INTO users (email, fullname, phone, passwd, signup_date, is_admin) VALUES
    ('admin@bookstore.com', N'Trương Quốc Duy (Admin)', 912345678, 'admin123', GETDATE(), 1),
    ('user@bookstore.com',  N'Nguyễn Văn A (User)',     987654321, '123456',   GETDATE(), 0),
    ('lan@bookstore.com',   N'Trần Thị Lan',            905123456, '123456',   GETDATE(), 0);
GO

-- ============================================
-- AUTHORS  (data thật từ Fahasa)
-- ============================================
INSERT INTO author (author_name, date_of_birth) VALUES
    (N'Nguyễn Nhật Ánh',   '1955-05-07'),  -- 1
    (N'Nam Cao',            '1917-10-29'),  -- 2
    (N'Tô Hoài',            '1920-09-27'),  -- 3
    (N'Ngô Tất Tố',         '1893-10-01'),  -- 4
    (N'Vũ Trọng Phụng',     '1912-10-01'),  -- 5
    (N'J.K. Rowling',       '1965-07-31'),  -- 6
    (N'Yuval Noah Harari',  '1976-02-24'),  -- 7
    (N'Dale Carnegie',      '1888-11-24'),  -- 8
    (N'Paulo Coelho',       '1947-08-24'),  -- 9
    (N'Nguyễn Ngọc',        '1932-09-05'),  -- 10
    (N'Trung Trung Đỉnh',   '1949-01-01'),  -- 11
    (N'Mark Manson',        '1984-03-09'),  -- 12
    (N'James Clear',        '1986-01-01'),  -- 13
    (N'Robin Sharma',       '1964-06-16'),  -- 14
    (N'Nguyễn Tuân',        '1910-07-10');  -- 15
GO

-- ============================================
-- BOOKS (data thật từ Fahasa - 20 cuốn)
-- Ảnh dùng URL CDN Fahasa thật
-- ============================================
INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) VALUES

(1001, N'Tôi thấy hoa vàng trên cỏ xanh',
 N'NXB Trẻ', 82000,
 N'Câu chuyện cảm động về tình anh em Thiều - Tường ở miền quê nghèo khó nhưng đầy ắp tình người. Tác phẩm được chuyển thể thành bộ phim điện ảnh ăn khách nhất lịch sử điện ảnh Việt Nam.',
 '2010-01-01', 'hoa_vang.jpg', 50),

(1002, N'Mắt biếc',
 N'NXB Trẻ', 90000,
 N'Câu chuyện tình yêu đơn phương xuyên suốt nhiều năm của Ngạn dành cho Hà Lan - người bạn gái tuổi thơ có đôi mắt biếc như bầu trời. Một tác phẩm đầy hoài niệm và nuối tiếc.',
 '2015-08-01', 'mat_biec.jpg', 60),

(1003, N'Chí Phèo',
 N'NXB Văn học', 45000,
 N'Tác phẩm văn học hiện thực xuất sắc của nhà văn Nam Cao về số phận bi thảm của người nông dân nghèo bị tha hóa trong xã hội cũ. Một kiệt tác văn học Việt Nam.',
 '2005-06-01', 'chi_pheo.jpg', 30),

(1004, N'Dế Mèn phiêu lưu ký',
 N'NXB Kim Đồng', 55000,
 N'Cuộc phiêu lưu kỳ thú của chú Dế Mèn qua nhiều vùng đất bí ẩn. Tác phẩm thiếu nhi kinh điển nhất Việt Nam, được dịch ra hơn 40 thứ tiếng trên thế giới.',
 '2000-01-01', 'de_men.jpg', 100),

(1005, N'Số đỏ',
 N'NXB Văn học', 60000,
 N'Tiểu thuyết trào phúng đỉnh cao của Vũ Trọng Phụng. Câu chuyện về Xuân Tóc Đỏ - kẻ lừa đảo vô học bỗng dưng trở nên danh giá trong xã hội thực dân phong kiến.',
 '2003-09-01', 'so_do.jpg', 40),

(1006, N'Kính vạn hoa (Trọn bộ 45 tập)',
 N'NXB Kim Đồng', 980000,
 N'Bộ truyện thiếu nhi nổi tiếng nhất của Nguyễn Nhật Ánh với 3 nhân vật chính Quý ròm, Tiểu Long và nhỏ Hạnh. Trọn bộ 45 tập hấp dẫn.',
 '2008-01-01', 'kinh_van_hoa.jpg', 80),

(1007, N'Harry Potter và Hòn đá phù thủy',
 N'NXB Trẻ', 149000,
 N'Phần đầu tiên trong bộ truyện phù thủy huyền thoại. Cậu bé Harry Potter khám phá ra mình là phù thủy và được nhận vào trường Hogwarts - nơi học phép thuật kỳ diệu.',
 '2001-01-01', 'harry_potter1.jpg', 25),

(1008, N'Harry Potter và Phòng chứa bí mật',
 N'NXB Trẻ', 152000,
 N'Năm học thứ hai đầy nguy hiểm của Harry Potter tại Hogwarts. Một căn phòng bí ẩn được mở ra, phép thuật kỳ lạ tấn công học sinh trong trường.',
 '2002-01-01', 'harry_potter2.jpg', 20),

(1009, N'Sapiens: Lược sử loài người',
 N'NXB Thế giới', 185000,
 N'Cuốn sách phi hư cấu ăn khách nhất thế giới. Yuval Noah Harari kể lại toàn bộ lịch sử nhân loại từ thời tiền sử đến hiện đại với góc nhìn hoàn toàn mới mẻ và đột phá.',
 '2018-05-01', 'sapiens.jpg', 45),

(1010, N'Đắc nhân tâm',
 N'NXB Tổng hợp TP.HCM', 89000,
 N'Cuốn sách kỹ năng sống bán chạy nhất mọi thời đại với hơn 15 triệu bản in. Dale Carnegie chia sẻ bí quyết thành công trong giao tiếp và xây dựng mối quan hệ.',
 '2016-03-01', 'dac_nhan_tam.jpg', 120),

(1011, N'Nhà giả kim',
 N'NXB Văn học', 79000,
 N'Hành trình tìm kiếm "kho báu" của chàng chăn cừu Santiago - một câu chuyện ngụ ngôn sâu sắc về giấc mơ, định mệnh và ý nghĩa cuộc sống. Bán hơn 65 triệu bản toàn cầu.',
 '2013-07-01', 'nha_giam_kim.jpg', 95),

(1012, N'Atomic Habits - Thói quen nguyên tử',
 N'NXB Lao Động', 139000,
 N'Cuốn sách giúp bạn xây dựng thói quen tốt và loại bỏ thói quen xấu. James Clear chia sẻ phương pháp thay đổi 1% mỗi ngày để tạo ra kết quả phi thường.',
 '2020-08-01', 'atomic_habits.jpg', 75),

(1013, N'Tư duy nhanh và chậm',
 N'NXB Thế giới', 149000,
 N'Daniel Kahneman - Nobel kinh tế 2002 - phân tích hai hệ thống tư duy của con người: Hệ thống 1 nhanh, trực giác và Hệ thống 2 chậm, lý trí. Một cuốn sách thay đổi nhận thức.',
 '2019-04-01', 'tu_duy.jpg', 35),

(1014, N'Nghệ thuật tinh tế của việc không quan tâm',
 N'NXB Lao Động', 115000,
 N'Mark Manson mang đến góc nhìn thực tế và hài hước về việc chấp nhận bản thân, sống có giới hạn và tập trung vào những gì thật sự quan trọng.',
 '2018-11-01', 'mark_manson.jpg', 55),

(1015, N'Nhà sư và chiếc Ferrari',
 N'NXB Lao Động', 99000,
 N'Robin Sharma kể câu chuyện về một luật sư thành đạt từ bỏ tất cả để tìm kiếm hạnh phúc thật sự. Cuốn sách được coi là kinh thánh về phát triển bản thân.',
 '2017-06-01', 'nha_su.jpg', 40),

(1016, N'Tắt đèn',
 N'NXB Văn học', 50000,
 N'Bức tranh hiện thực xã hội nông thôn Việt Nam trước cách mạng. Chị Dậu - hình tượng người phụ nữ bất khuất trong hoàn cảnh cùng cực - là biểu tượng của văn học hiện thực.',
 '2004-05-01', 'tat_den.jpg', 35),

(1017, N'Lược sử nước Việt bằng tranh (Tái bản 2024)',
 N'NXB Trẻ', 240000,
 N'Bộ sách tranh kể toàn bộ lịch sử 4000 năm dựng nước và giữ nước của dân tộc Việt Nam qua hình ảnh minh họa sống động, phù hợp mọi lứa tuổi.',
 '2024-01-01', 'luoc_su.jpg', 65),

(1018, N'Bồ câu không đưa thư',
 N'NXB Trẻ', 95000,
 N'Tập truyện ngắn đặc sắc của Nguyễn Nhật Ánh, với những câu chuyện nhỏ nhẹ nhàng nhưng sâu lắng về tình bạn, tình yêu và những ký ức tuổi thơ.',
 '2021-06-01', 'bo_cau.jpg', 70),

(1019, N'Iliad (Tái bản 2026)',
 N'NXB Hội nhà văn', 189000,
 N'Sử thi vĩ đại nhất của Homer về cuộc chiến thành Troy. Tác phẩm kinh điển của nền văn học thế giới được tái bản với bản dịch mới hoàn toàn, chú thích đầy đủ.',
 '2026-01-01', 'iliad.jpg', 28),

(1020, N'Tuổi thơ dữ dội',
 N'NXB Kim Đồng', 125000,
 N'Tiểu thuyết về những đứa trẻ thiếu niên trinh sát dũng cảm trong cuộc kháng chiến chống Pháp. Một trong những tác phẩm văn học hay nhất viết cho thiếu nhi Việt Nam.',
 '2012-09-01', 'tuoi_tho.jpg', 55);
GO

-- ============================================
-- BOOK-AUTHOR mapping
-- ============================================
INSERT INTO book_author (bookid, author_id) VALUES
    (1,  1),  -- Hoa vàng -> Nguyễn Nhật Ánh
    (2,  1),  -- Mắt biếc -> Nguyễn Nhật Ánh
    (3,  2),  -- Chí Phèo -> Nam Cao
    (4,  3),  -- Dế Mèn -> Tô Hoài
    (5,  5),  -- Số đỏ -> Vũ Trọng Phụng
    (6,  1),  -- Kính vạn hoa -> Nguyễn Nhật Ánh
    (7,  6),  -- Harry Potter 1 -> J.K. Rowling
    (8,  6),  -- Harry Potter 2 -> J.K. Rowling
    (9,  7),  -- Sapiens -> Yuval Noah Harari
    (10, 8),  -- Đắc nhân tâm -> Dale Carnegie
    (11, 9),  -- Nhà giả kim -> Paulo Coelho
    (12, 13), -- Atomic Habits -> James Clear
    (13, 7),  -- Tư duy nhanh và chậm -> Yuval Noah Harari
    (14, 12), -- Nghệ thuật tinh tế -> Mark Manson
    (15, 14), -- Nhà sư Ferrari -> Robin Sharma
    (16, 4),  -- Tắt đèn -> Ngô Tất Tố
    (17, 1),  -- Lược sử nước Việt -> Nguyễn Nhật Ánh
    (18, 1),  -- Bồ câu -> Nguyễn Nhật Ánh
    (19, 6),  -- Iliad -> Homer (dùng J.K. Rowling ID tạm)
    (20, 2);  -- Tuổi thơ dữ dội -> Nam Cao
GO

-- ============================================
-- REVIEWS / RATINGS
-- ============================================
INSERT INTO rating (userid, bookid, rating, review_text) VALUES
    (2,  1,  5, N'Sách rất hay và cảm động, gợi nhớ tuổi thơ êm đềm! Văn phong Nguyễn Nhật Ánh quá đẹp.'),
    (3,  1,  5, N'Một trong những cuốn sách Việt Nam hay nhất tôi từng đọc. 5 sao không đủ!'),
    (2,  7,  5, N'Thế giới phù thủy Hogwarts vô cùng kỳ diệu! Cả nhà tôi đều mê bộ sách này.'),
    (3,  3,  4, N'Tác phẩm giàu giá trị nhân đạo sâu sắc. Số phận Chí Phèo thật bi thảm.'),
    (2,  9,  5, N'Sapiens thay đổi hoàn toàn cách tôi nhìn nhận lịch sử nhân loại. Xuất sắc!'),
    (3,  10, 5, N'Đắc nhân tâm là cuốn sách mọi người cần đọc ít nhất một lần trong đời.'),
    (2,  12, 5, N'Atomic Habits đã giúp tôi xây dựng thói quen đọc sách mỗi ngày. Hiệu quả!'),
    (3,  11, 4, N'Nhà giả kim - câu chuyện đơn giản nhưng ý nghĩa thật sâu xa về giấc mơ cuộc đời.');
GO

-- ============================================
-- ORDERS & ORDER_ITEMS (Mẫu đủ 8 trạng thái để test)
-- 1. Đơn hàng mới
-- 2. Đã xác nhận
-- 3. Chuẩn bị hàng
-- 4. Vận chuyển
-- 5. Giao hàng
-- 6. Đã giao
-- 7. Đơn hàng hủy
-- 8. Đơn hàng hoàn
-- ============================================
INSERT INTO orders (user_id, fullname, phone, address, note, total_price, payment_method, status, orderDate) VALUES
    (2, N'Nguyễn Văn A', '0987654321', N'1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Giao giờ hành chính', 82000,  'COD', N'Đơn hàng mới',   GETDATE()),
    (2, N'Nguyễn Văn A', '0987654321', N'1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Gọi trước khi giao',  180000, 'COD', N'Đã xác nhận',    DATEADD(day, -1, GETDATE())),
    (2, N'Nguyễn Văn A', '0987654321', N'1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'',                    45000,  'COD', N'Chuẩn bị hàng',  DATEADD(day, -2, GETDATE())),
    (2, N'Nguyễn Văn A', '0987654321', N'1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'',                    55000,  'COD', N'Vận chuyển',     DATEADD(day, -3, GETDATE())),
    (2, N'Nguyễn Văn A', '0987654321', N'1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Giao tận tay',        60000,  'COD', N'Giao hàng',       DATEADD(day, -4, GETDATE())),
    (2, N'Nguyễn Văn A', '0987654321', N'1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Đã nhận sách tốt',   149000, 'COD', N'Đã giao',        DATEADD(day, -5, GETDATE())),
    (2, N'Nguyễn Văn A', '0987654321', N'1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Khách đổi ý',         90000,  'COD', N'Đơn hàng hủy',   DATEADD(day, -6, GETDATE())),
    (2, N'Nguyễn Văn A', '0987654321', N'1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Bị rách bìa',         79000,  'COD', N'Đơn hàng hoàn',  DATEADD(day, -7, GETDATE()));
GO

INSERT INTO order_items (order_id, book_id, quantity, price) VALUES
    (1, 1,  1, 82000),
    (2, 2,  2, 90000),
    (3, 3,  1, 45000),
    (4, 4,  1, 55000),
    (5, 5,  1, 60000),
    (6, 7,  1, 149000),
    (7, 2,  1, 90000),
    (8, 11, 1, 79000);
GO

-- HƯỚNG DẪN CẬP NHẬT TRẠNG THÁI TRONG DATABASE ĐỂ TEST:
-- UPDATE orders SET status = N'Đã xác nhận'    WHERE order_id = 1;
-- UPDATE orders SET status = N'Chuẩn bị hàng'  WHERE order_id = 1;
-- UPDATE orders SET status = N'Vận chuyển'     WHERE order_id = 1;
-- UPDATE orders SET status = N'Giao hàng'       WHERE order_id = 1;
-- UPDATE orders SET status = N'Đã giao'        WHERE order_id = 1;
-- UPDATE orders SET status = N'Đơn hàng hủy'   WHERE order_id = 1;
-- UPDATE orders SET status = N'Đơn hàng hoàn'  WHERE order_id = 1;

PRINT N'BookStore Database - Fahasa Data - Đã thiết lập thành công!';
PRINT N'Sinh viên: Trương Quốc Duy - MSSV: 24133009';
