-- ===================================================================
-- DATABASE: BookStore
-- DỮ LIỆU: 30 CUỐN SÁCH KINH ĐIỂN VĂN HỌC VIỆT NAM (DỮ LIỆU THỰC TẾ)
-- Sinh viên: Trương Quốc Duy - MSSV: 24133009 - Đề 1
-- Bảng mã: UTF-8 Unicode (chuẩn cú pháp N'...' của SQL Server)
-- ===================================================================

USE BookStore;
GO

-- 1. Đảm bảo cấu trúc cột chứa đủ độ dài cho link ảnh online và giá bán
IF COL_LENGTH('books', 'cover_image') < 500
    ALTER TABLE books ALTER COLUMN cover_image NVARCHAR(500);
IF COL_LENGTH('books', 'price') < 10
    ALTER TABLE books ALTER COLUMN price DECIMAL(10,2);
GO

-- 2. Dọn sạch dữ liệu cũ và reset IDENTITY về 0
DELETE FROM rating;
DELETE FROM book_author;
DELETE FROM books;
DELETE FROM author;
DBCC CHECKIDENT ('books',  RESEED, 0);
DBCC CHECKIDENT ('author', RESEED, 0);
GO

-- 3. Chèn danh sách tác giả (author)
SET IDENTITY_INSERT author ON;
INSERT INTO author (author_id, author_name, date_of_birth) VALUES
    (1, N'Nguyễn Nhật Ánh', '1955-05-07'),
    (2, N'Vũ Trọng Phụng', '1912-10-20'),
    (3, N'Nam Cao', '1917-10-29'),
    (4, N'Tô Hoài', '1920-09-27'),
    (5, N'Phùng Quán', '1932-01-01'),
    (6, N'Ngô Tất Tố', '1893-10-01'),
    (7, N'Kim Lân', '1920-08-01'),
    (8, N'Nguyên Hồng', '1918-11-05'),
    (9, N'Đoàn Giỏi', '1925-05-17'),
    (10, N'Nguyễn Quang Sáng', '1932-01-12'),
    (11, N'Nguyễn Ngọc Tư', '1976-01-01'),
    (12, N'Bảo Ninh', '1952-10-18'),
    (13, N'Dương Hướng', '1949-01-01'),
    (14, N'Nguyễn Huy Thiệp', '1950-04-29'),
    (15, N'Thạch Lam', '1910-07-07'),
    (16, N'Nguyễn Tuân', '1910-07-10'),
    (17, N'Nguyễn Khải', '1930-12-03');
SET IDENTITY_INSERT author OFF;
GO

-- 4. Chèn 30 cuốn sách thực tế của Việt Nam (books)
SET IDENTITY_INSERT books ON;
INSERT INTO books (bookid, isbn, title, publisher, price, description, publish_date, cover_image, quantity) VALUES

(1, 1001, N'Mắt Biếc', N'NXB Trẻ', 95000.00,
 N'Mắt Biếc là một trong những truyện dài lãng mạn và xúc động nhất của nhà văn Nguyễn Nhật Ánh. Câu chuyện xoay quanh mối tình đơn phương sâu sắc, day dứt cả một đời của chàng thư sinh tên Ngạn dành cho cô bạn gái từ thuở thiếu thời có đôi mắt biếc biếc như bầu trời.',
 '2015-08-15', N'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80', 50),

(2, 1002, N'Tôi Thấy Hoa Vàng Trên Cỏ Xanh', N'NXB Trẻ', 88000.00,
 N'Tác phẩm đưa người đọc trở về với tuổi thơ miền quê êm ả qua những câu chuyện nhỏ xoay quanh hai anh em Thiều và Tường, về tình anh em, tình bạn, và những rung động đầu đời trong sáng ngây ngô.',
 '2010-12-09', N'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80', 50),

(3, 1003, N'Cho Tôi Xin Một Vé Đi Tuổi Thơ', N'NXB Trẻ', 79000.00,
 N'Cuốn sách không chỉ viết cho trẻ em mà còn viết cho những ai từng là trẻ em, kể về thế giới mộng mơ, tinh nghịch của cu Mùi, Hải cò, con Tủn và Tí sún cùng những triết lý giản dị mà sâu sắc.',
 '2008-01-01', N'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=600&q=80', 50),

(4, 1004, N'Cô Gái Đến Từ Hôm Qua', N'NXB Trẻ', 82000.00,
 N'Câu chuyện đan xen giữa hiện tại và quá khứ của chàng trai Thư si tình, với những kỷ niệm tuổi thơ cùng cô bé Tiểu Li và mối tình học trò đầy lãng mạn với cô bạn cùng lớp Việt An.',
 '2012-03-20', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 50),

(5, 1005, N'Kính Vạn Hoa', N'NXB Kim Đồng', 125000.00,
 N'Bộ truyện học trò huyền thoại với bộ ba Quý Ròm, Tiểu Long và nhỏ Hạnh, đưa bạn đọc phiêu lưu qua những trò nghịch ngợm thú vị, những kỳ nghỉ hè ý nghĩa và bài học tình bạn sâu sắc.',
 '2005-06-10', N'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=600&q=80', 50),

(6, 1006, N'Số Đỏ', N'NXB Văn học', 65000.00,
 N'Kiệt tác trào phúng đỉnh cao của văn học Việt Nam thế kỷ 20, khắc họa sự lên đời kỳ dị của Xuân Tóc Đỏ trong xã hội thực dân phong kiến đồi bại lố lăng Âu hóa nửa mùa.',
 '2003-09-01', N'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80', 50),

(7, 1007, N'Giông Tố', N'NXB Văn học', 72000.00,
 N'Bức tranh hiện thực khốc liệt về mâu thuẫn giai cấp, sức mạnh đồng tiền và danh vọng qua cuộc đời trắc trở của Thị Mịch và tên tư sản Nghị Hách tàn bạo, nham hiểm.',
 '2005-04-12', N'https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80', 50),

(8, 1008, N'Chí Phèo', N'NXB Văn học', 45000.00,
 N'Tác phẩm hiện thực phê phán xuất sắc nhất của Nam Cao, phản ánh bi kịch bị tha hóa và bị cự tuyệt quyền làm người lương thiện của người nông dân nghèo trước Cách mạng Tháng Tám.',
 '2005-06-01', N'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80', 50),

(9, 1009, N'Lão Hạc', N'NXB Văn học', 42000.00,
 N'Truyện ngắn đẫm nước mắt về lòng tự trọng cao cả và tình thương con bao la của người cha già nghèo khổ trong cảnh ngộ bế tắc cùng cực của xã hội cũ.',
 '2004-10-15', N'https://images.unsplash.com/photo-1532012164546-f432f2e3edd3?auto=format&fit=crop&w=600&q=80', 50),

(10, 1010, N'Sống Mòn', N'NXB Hội nhà văn', 68000.00,
 N'Tiểu thuyết phân tích tâm lý sâu sắc về tấn bi kịch tinh thần của tầng lớp trí thức tiểu tư sản nghèo bị gánh nặng cơm áo gạo tiền bóp nghẹt lý tưởng và hoài bão cao đẹp.',
 '2008-07-22', N'https://images.unsplash.com/photo-1519682337058-a94d519337bc?auto=format&fit=crop&w=600&q=80', 50),

(11, 1011, N'Dế Mèn Phiêu Lưu Ký', N'NXB Kim Đồng', 55000.00,
 N'Tác phẩm thiếu nhi kinh điển nhất Việt Nam, kể về chuyến du hành qua thế giới loài vật muôn màu của chú Dế Mèn dũng cảm, biết hối lỗi, hướng thiện và luôn khao khát lý tưởng đại đồng.',
 '2000-01-01', N'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&w=600&q=80', 50),

(12, 1012, N'Vợ Chồng A Phủ', N'NXB Kim Đồng', 48000.00,
 N'Bản anh hùng ca về sức sống tiềm tàng và khát vọng tự do mãnh liệt của đồng bào các dân tộc thiểu số miền núi Tây Bắc dưới ách áp bức tàn bạo của bọn chúa đất thực dân.',
 '2006-05-18', N'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80', 50),

(13, 1013, N'Tuổi Thơ Dữ Dội', N'NXB Kim Đồng', 135000.00,
 N'Bộ tiểu thuyết hoành tráng và xúc động sâu sắc về đội thiếu niên trinh sát cảm tử của trung đoàn Trần Cao Vân trong những ngày khói lửa kháng chiến hào hùng tại mặt trận Thừa Thiên Huế.',
 '2012-09-01', N'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&w=600&q=80', 50),

(14, 1014, N'Tắt Đèn', N'NXB Văn học', 50000.00,
 N'Tác phẩm tái hiện chân thực thảm cảnh sưu cao thuế nặng đè nặng lên nông thôn Việt Nam trước 1945 và ngợi ca vẻ đẹp tâm hồn kiên cường, bất khuất của người phụ nữ nông dân - chị Dậu.',
 '2004-05-01', N'https://images.unsplash.com/photo-1491841550275-ad7854e35ca6?auto=format&fit=crop&w=600&q=80', 50),

(15, 1015, N'Việc Làng', N'NXB Văn học', 49000.00,
 N'Tập phóng sự vạch trần những hủ tục phong kiến đè nặng lên người dân quê nghèo như ăn uống xôi thịt, tế tự, khao vọng và kiện cáo lũng đoạn làng xã thôn quê.',
 '2007-02-14', N'https://images.unsplash.com/photo-1463320726281-696a485928c7?auto=format&fit=crop&w=600&q=80', 50),

(16, 1016, N'Vợ Nhặt', N'NXB Văn học', 45000.00,
 N'Bức tranh hiện thực về nạn đói khủng khiếp năm Ất Dậu 1945, qua đó tỏa sáng tình người ấm áp, niềm tin mãnh liệt vào tương lai và sự đùm bọc yêu thương của những con người bần cùng.',
 '2005-08-20', N'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=600&q=80', 50),

(17, 1017, N'Làng', N'NXB Văn học', 42000.00,
 N'Truyện ngắn thể hiện sâu sắc tình yêu làng Chợ Dầu gắn bó mật thiết, hòa quyện thống nhất với lòng yêu nước nồng nàn và tinh thần kháng chiến kiên trung của nhân vật ông Hai.',
 '2006-11-10', N'https://images.unsplash.com/photo-1474932430478-367dbb6832c1?auto=format&fit=crop&w=600&q=80', 50),

(18, 1018, N'Bỉ Vỏ', N'NXB Văn học', 62000.00,
 N'Bức tranh chân thực về thế giới ngầm lưu manh trộm cắp nơi thành thị Hải Phòng thời Pháp thuộc và số phận oan trái, bi kịch bước vào đường lầm lỡ của người đàn bà lương thiện Tám Bính.',
 '2005-03-15', N'https://images.unsplash.com/photo-1495640388908-05fa85288e61?auto=format&fit=crop&w=600&q=80', 50),

(19, 1019, N'Những Ngày Thơ Ấu', N'NXB Văn học', 48000.00,
 N'Tập hồi ký cảm động về những năm tháng ấu thơ đầy cay đắng, nhọc nhằn, thiếu thốn tình thương của chú bé Hồng trong một gia đình phong kiến suy tàn, lạnh lẽo.',
 '2007-06-25', N'https://images.unsplash.com/photo-1505664194779-8beaceb93744?auto=format&fit=crop&w=600&q=80', 50),

(20, 1020, N'Đất Rừng Phương Nam', N'NXB Kim Đồng', 89000.00,
 N'Hành trình phiêu lưu đầy thú vị của cậu bé An qua vùng thiên nhiên Nam Bộ hoang sơ, trù phú cùng những con người chất phác, hào hiệp và kiên cường trong những năm đầu kháng chiến chống Pháp.',
 '2015-04-30', N'https://images.unsplash.com/photo-1470549638415-0a0755be0619?auto=format&fit=crop&w=600&q=80', 50),

(21, 1021, N'Chiếc Lược Ngà', N'NXB Trẻ', 52000.00,
 N'Câu chuyện cảm động rơi nước mắt về tình phụ tử thiêng liêng, bất diệt giữa anh Sáu và bé Thu trong hoàn cảnh éo le của chiến tranh bom đạn chia cắt đất nước.',
 '2010-09-02', N'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?auto=format&fit=crop&w=600&q=80', 50),

(22, 1022, N'Cánh Đồng Bất Tận', N'NXB Trẻ', 85000.00,
 N'Tác phẩm làm rung động lòng người với giọng văn mang đậm hơi thở đồng bằng sông Cửu Long, lột tả nỗi đau phận người trôi dạt, sự cô đơn và tình yêu thương bao dung sâu lắng.',
 '2005-11-20', N'https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80', 50),

(23, 1023, N'Khói Trời Lộng Lẫy', N'NXB Trẻ', 78000.00,
 N'Những tản văn và truyện ngắn mộc mạc mà lắng đọng về cuộc đời, con người và những hoài niệm bâng khuâng nơi miệt vườn sông nước Cà Mau.',
 '2010-04-15', N'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80', 50),

(24, 1024, N'Nỗi Buồn Chiến Tranh', N'NXB Trẻ', 115000.00,
 N'Một trong những tiểu thuyết về chiến tranh Việt Nam xuất sắc nhất được dịch ra nhiều thứ tiếng trên thế giới, tái hiện dòng hồi ức đau đớn, mất mát và vết thương lòng của người lính thời hậu chiến.',
 '2011-04-30', N'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80', 50),

(25, 1025, N'Bến Không Chồng', N'NXB Hội nhà văn', 92000.00,
 N'Bức tranh làng quê Bắc Bộ thời hậu chiến với những người phụ nữ thủy chung son sắt chờ chồng mỏi mòn, chứa chan lòng bao dung nhân hậu và đức hy sinh thầm lặng.',
 '2006-12-05', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 50),

(26, 1026, N'Tướng Về Hưu', N'NXB Trẻ', 75000.00,
 N'Tác phẩm gây tiếng vang lớn trên văn đàn Việt Nam với cái nhìn trực diện, sắc sảo về sự rạn nứt nhân cách và đạo đức trước sức ép ghê gớm của đồng tiền trong thời kỳ đổi mới.',
 '2009-08-10', N'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=600&q=80', 50),

(27, 1027, N'Hà Nội Ba Mươi Sáu Phố Phường', N'NXB Văn học', 45000.00,
 N'Tập bút ký nhẹ nhàng, tinh tế và đầy chất thơ về nét đẹp thanh lịch của đất kinh kỳ Hà Nội xưa, với những thức quà truyền thống nồng nàn dư vị cổ phong.',
 '2002-10-10', N'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=600&q=80', 50),

(28, 1028, N'Gió Đầu Mùa', N'NXB Văn học', 42000.00,
 N'Tập truyện ngắn thấm đượm tình người ấm áp, len lỏi vào tâm hồn độc giả như làn gió lạnh đầu mùa với lòng trắc ẩn sâu sắc dành cho những số phận trẻ thơ nghèo khổ.',
 '2003-01-15', N'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80', 50),

(29, 1029, N'Vang Bóng Một Thời', N'NXB Văn học', 60000.00,
 N'Tác phẩm tài hoa tuyệt mỹ của Nguyễn Tuân, khắc họa và lưu giữ những thú vui tao nhã cổ truyền của cha ông như uống trà, thả thơ, chơi hoa lan và viết chữ thư pháp.',
 '2004-09-02', N'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80', 50),

(30, 1030, N'Mùa Lạc', N'NXB Văn học', 46000.00,
 N'Tác phẩm ngợi ca sự hồi sinh và đổi đời kỳ diệu của người lao động trên vùng đất Điện Biên hoang tàn sau chiến tranh, mở ra chân lý sống lạc quan: Ở đời này không có con đường cùng, chỉ có những ranh giới.',
 '2005-05-01', N'https://images.unsplash.com/photo-1532012164546-f432f2e3edd3?auto=format&fit=crop&w=600&q=80', 50);

SET IDENTITY_INSERT books OFF;
GO

-- 5. Chèn quan hệ N-N giữa sách và tác giả (book_author)
INSERT INTO book_author (bookid, author_id) VALUES
    (1, 1),   -- Mắt Biếc -> Nguyễn Nhật Ánh
    (2, 1),   -- Tôi Thấy Hoa Vàng -> Nguyễn Nhật Ánh
    (3, 1),   -- Cho Tôi Xin Một Vé -> Nguyễn Nhật Ánh
    (4, 1),   -- Cô Gái Đến Từ Hôm Qua -> Nguyễn Nhật Ánh
    (5, 1),   -- Kính Vạn Hoa -> Nguyễn Nhật Ánh
    (6, 2),   -- Số Đỏ -> Vũ Trọng Phụng
    (7, 2),   -- Giông Tố -> Vũ Trọng Phụng
    (8, 3),   -- Chí Phèo -> Nam Cao
    (9, 3),   -- Lão Hạc -> Nam Cao
    (10, 3),  -- Sống Mòn -> Nam Cao
    (11, 4),  -- Dế Mèn Phiêu Lưu Ký -> Tô Hoài
    (12, 4),  -- Vợ Chồng A Phủ -> Tô Hoài
    (13, 5),  -- Tuổi Thơ Dữ Dội -> Phùng Quán
    (14, 6),  -- Tắt Đèn -> Ngô Tất Tố
    (15, 6),  -- Việc Làng -> Ngô Tất Tố
    (16, 7),  -- Vợ Nhặt -> Kim Lân
    (17, 7),  -- Làng -> Kim Lân
    (18, 8),  -- Bỉ Vỏ -> Nguyên Hồng
    (19, 8),  -- Những Ngày Thơ Ấu -> Nguyên Hồng
    (20, 9),  -- Đất Rừng Phương Nam -> Đoàn Giỏi
    (21, 10), -- Chiếc Lược Ngà -> Nguyễn Quang Sáng
    (22, 11), -- Cánh Đồng Bất Tận -> Nguyễn Ngọc Tư
    (23, 11), -- Khói Trời Lộng Lẫy -> Nguyễn Ngọc Tư
    (24, 12), -- Nỗi Buồn Chiến Tranh -> Bảo Ninh
    (25, 13), -- Bến Không Chồng -> Dương Hướng
    (26, 14), -- Tướng Về Hưu -> Nguyễn Huy Thiệp
    (27, 15), -- Hà Nội 36 Phố Phường -> Thạch Lam
    (28, 15), -- Gió Đầu Mùa -> Thạch Lam
    (29, 16), -- Vang Bóng Một Thời -> Nguyễn Tuân
    (30, 17); -- Mùa Lạc -> Nguyễn Khải
GO

-- 6. Chèn đánh giá mẫu (rating - Câu 4)
IF EXISTS (SELECT 1 FROM users WHERE id = 1)
BEGIN
    INSERT INTO rating (userid, bookid, rating, review_text) VALUES
        (1, 1, 5, N'Một tác phẩm quá đỗi tuyệt vời của Nguyễn Nhật Ánh, đọc mà nghẹn ngào.'),
        (1, 6, 5, N'Số Đỏ đúng là tuyệt tác trào phúng, đọc thời nào cũng thấy thấm thía.'),
        (1, 8, 5, N'Tiếng kêu đòi quyền làm người của Chí Phèo thật ám ảnh và xúc động.'),
        (1, 11, 5, N'Dế Mèn Phiêu Lưu Ký là tuổi thơ của biết bao thế hệ Việt Nam!'),
        (1, 13, 5, N'Tuổi Thơ Dữ Dội bi tráng, hào hùng và ngập tràn tình yêu quê hương đất nước.');
END
GO

PRINT N'30 cuốn sách Việt Nam kinh điển đã được nạp thành công vào Database BookStore!';
PRINT N'Sinh viên: Trương Quốc Duy - MSSV: 24133009';
GO
