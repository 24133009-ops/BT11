#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script: generate_books_sql.py
Mục đích: Tự động sinh file data_books.sql gồm 30 cuốn sách thực tế của văn học Việt Nam
          kèm tác giả, nhà xuất bản, mô tả chi tiết, giá tiền và link ảnh online thật.
Sinh viên: Trương Quốc Duy - MSSV: 24133009 - Đề 1
"""

import sys
import os

if sys.platform == "win32":
    sys.stdout.reconfigure(encoding="utf-8")

# Danh sách 30 cuốn sách kinh điển của văn học Việt Nam
BOOKS_DATA = [
    {
        "bookid": 1,
        "isbn": 1001,
        "title": "Mắt Biếc",
        "author": "Nguyễn Nhật Ánh",
        "dob": "1955-05-07",
        "publisher": "NXB Trẻ",
        "price": 95000.00,
        "description": "Mắt Biếc là một trong những truyện dài lãng mạn và xúc động nhất của nhà văn Nguyễn Nhật Ánh. Câu chuyện xoay quanh mối tình đơn phương sâu sắc, day dứt cả một đời của chàng thư sinh tên Ngạn dành cho cô bạn gái từ thuở thiếu thời có đôi mắt biếc biếc như bầu trời.",
        "publish_date": "2015-08-15",
        "cover_image": "https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 2,
        "isbn": 1002,
        "title": "Tôi Thấy Hoa Vàng Trên Cỏ Xanh",
        "author": "Nguyễn Nhật Ánh",
        "dob": "1955-05-07",
        "publisher": "NXB Trẻ",
        "price": 88000.00,
        "description": "Tác phẩm đưa người đọc trở về với tuổi thơ miền quê êm ả qua những câu chuyện nhỏ xoay quanh hai anh em Thiều và Tường, về tình anh em, tình bạn, và những rung động đầu đời trong sáng ngây ngô.",
        "publish_date": "2010-12-09",
        "cover_image": "https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 3,
        "isbn": 1003,
        "title": "Cho Tôi Xin Một Vé Đi Tuổi Thơ",
        "author": "Nguyễn Nhật Ánh",
        "dob": "1955-05-07",
        "publisher": "NXB Trẻ",
        "price": 79000.00,
        "description": "Cuốn sách không chỉ viết cho trẻ em mà còn viết cho những ai từng là trẻ em, kể về thế giới mộng mơ, tinh nghịch của cu Mùi, Hải cò, con Tủn và Tí sún.",
        "publish_date": "2008-01-01",
        "cover_image": "https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 4,
        "isbn": 1004,
        "title": "Cô Gái Đến Từ Hôm Qua",
        "author": "Nguyễn Nhật Ánh",
        "dob": "1955-05-07",
        "publisher": "NXB Trẻ",
        "price": 82000.00,
        "description": "Câu chuyện đan xen giữa hiện tại và quá khứ của chàng trai Thư si tình, với những kỷ niệm tuổi thơ cùng cô bé Tiểu Li và mối tình học trò đầy lãng mạn.",
        "publish_date": "2012-03-20",
        "cover_image": "https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 5,
        "isbn": 1005,
        "title": "Kính Vạn Hoa",
        "author": "Nguyễn Nhật Ánh",
        "dob": "1955-05-07",
        "publisher": "NXB Kim Đồng",
        "price": 125000.00,
        "description": "Bộ truyện học trò huyền thoại với bộ ba Quý Ròm, Tiểu Long và nhỏ Hạnh, đưa bạn đọc phiêu lưu qua những trò nghịch ngợm thú vị và bài học tình bạn sâu sắc.",
        "publish_date": "2005-06-10",
        "cover_image": "https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 6,
        "isbn": 1006,
        "title": "Số Đỏ",
        "author": "Vũ Trọng Phụng",
        "dob": "1912-10-20",
        "publisher": "NXB Văn học",
        "price": 65000.00,
        "description": "Kiệt tác trào phúng đỉnh cao của văn học Việt Nam thế kỷ 20, khắc họa sự lên đời kỳ dị của Xuân Tóc Đỏ trong xã hội thực dân phong kiến đồi bại lố lăng.",
        "publish_date": "2003-09-01",
        "cover_image": "https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 7,
        "isbn": 1007,
        "title": "Giông Tố",
        "author": "Vũ Trọng Phụng",
        "dob": "1912-10-20",
        "publisher": "NXB Văn học",
        "price": 72000.00,
        "description": "Bức tranh hiện thực khốc liệt về mâu thuẫn giai cấp, đồng tiền và danh vọng qua cuộc đời trắc trở của Thị Mịch và tên tư sản Nghị Hách tàn bạo.",
        "publish_date": "2005-04-12",
        "cover_image": "https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 8,
        "isbn": 1008,
        "title": "Chí Phèo",
        "author": "Nam Cao",
        "dob": "1917-10-29",
        "publisher": "NXB Văn học",
        "price": 45000.00,
        "description": "Tác phẩm hiện thực phê phán xuất sắc nhất của Nam Cao, phản ánh bi kịch bị cự tuyệt quyền làm người của người nông dân nghèo lương thiện trước Cách mạng.",
        "publish_date": "2005-06-01",
        "cover_image": "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 9,
        "isbn": 1009,
        "title": "Lão Hạc",
        "author": "Nam Cao",
        "dob": "1917-10-29",
        "publisher": "NXB Văn học",
        "price": 42000.00,
        "description": "Truyện ngắn đẫm nước mắt về lòng tự trọng cao cả và tình thương con bao la của người cha già nghèo khổ trong cảnh ngộ bế tắc cùng cực.",
        "publish_date": "2004-10-15",
        "cover_image": "https://images.unsplash.com/photo-1532012164546-f432f2e3edd3?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 10,
        "isbn": 1010,
        "title": "Sống Mòn",
        "author": "Nam Cao",
        "dob": "1917-10-29",
        "publisher": "NXB Hội nhà văn",
        "price": 68000.00,
        "description": "Tiểu thuyết phân tích tâm lý sâu sắc về tấn bi kịch tinh thần của tầng lớp trí thức tiểu tư sản nghèo bị cơm áo gạo tiền bóp nghẹt hoài bão.",
        "publish_date": "2008-07-22",
        "cover_image": "https://images.unsplash.com/photo-1519682337058-a94d519337bc?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 11,
        "isbn": 1011,
        "title": "Dế Mèn Phiêu Lưu Ký",
        "author": "Tô Hoài",
        "dob": "1920-09-27",
        "publisher": "NXB Kim Đồng",
        "price": 55000.00,
        "description": "Tác phẩm thiếu nhi kinh điển nhất Việt Nam, kể về chuyến du hành qua thế giới muôn loài của chú Dế Mèn dũng cảm, biết hướng thiện và khao khát lý tưởng đại đồng.",
        "publish_date": "2000-01-01",
        "cover_image": "https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 12,
        "isbn": 1012,
        "title": "Vợ Chồng A Phủ",
        "author": "Tô Hoài",
        "dob": "1920-09-27",
        "publisher": "NXB Kim Đồng",
        "price": 48000.00,
        "description": "Bản anh hùng ca về sức sống tiềm tàng và khát vọng tự do mãnh liệt của đồng bào các dân tộc thiểu số miền núi Tây Bắc dưới ách áp bức của bọn chúa đất.",
        "publish_date": "2006-05-18",
        "cover_image": "https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 13,
        "isbn": 1013,
        "title": "Tuổi Thơ Dữ Dội",
        "author": "Phùng Quán",
        "dob": "1932-01-01",
        "publisher": "NXB Kim Đồng",
        "price": 135000.00,
        "description": "Bộ tiểu thuyết hoành tráng và xúc động về đội thiếu niên trinh sát cảm tử của trung đoàn Trần Cao Vân trong những ngày khói lửa kháng chiến tại Huế.",
        "publish_date": "2012-09-01",
        "cover_image": "https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 14,
        "isbn": 1014,
        "title": "Tắt Đèn",
        "author": "Ngô Tất Tố",
        "dob": "1893-10-01",
        "publisher": "NXB Văn học",
        "price": 50000.00,
        "description": "Tác phẩm tái hiện chân thực thảm cảnh sưu cao thuế nặng ở nông thôn Việt Nam trước 1945 và ngợi ca phẩm chất kiên cường, bất khuất của chị Dậu.",
        "publish_date": "2004-05-01",
        "cover_image": "https://images.unsplash.com/photo-1491841550275-ad7854e35ca6?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 15,
        "isbn": 1015,
        "title": "Việc Làng",
        "author": "Ngô Tất Tố",
        "dob": "1893-10-01",
        "publisher": "NXB Văn học",
        "price": 49000.00,
        "description": "Tập phóng sự vạch trần những hủ tục phong kiến đè nặng lên người dân quê như xôi thịt, tế tự, khao vọng và kiện cáo lũng đoạn làng xã.",
        "publish_date": "2007-02-14",
        "cover_image": "https://images.unsplash.com/photo-1463320726281-696a485928c7?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 16,
        "isbn": 1016,
        "title": "Vợ Nhặt",
        "author": "Kim Lân",
        "dob": "1920-08-01",
        "publisher": "NXB Văn học",
        "price": 45000.00,
        "description": "Bức tranh về nạn đói khủng khiếp năm 1945, qua đó tỏa sáng tình người ấm áp, niềm tin vào tương lai và sự đùm bọc yêu thương của những con người bần cùng.",
        "publish_date": "2005-08-20",
        "cover_image": "https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 17,
        "isbn": 1017,
        "title": "Làng",
        "author": "Kim Lân",
        "dob": "1920-08-01",
        "publisher": "NXB Văn học",
        "price": 42000.00,
        "description": "Truyện ngắn thể hiện sâu sắc tình yêu làng quê gắn bó mật thiết và thống nhất với lòng yêu nước nồng nàn của ông Hai khi phải đi tản cư kháng chiến.",
        "publish_date": "2006-11-10",
        "cover_image": "https://images.unsplash.com/photo-1474932430478-367dbb6832c1?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 18,
        "isbn": 1018,
        "title": "Bỉ Vỏ",
        "author": "Nguyên Hồng",
        "dob": "1918-11-05",
        "publisher": "NXB Văn học",
        "price": 62000.00,
        "description": "Bức tranh chân thực về thế giới ngầm trộm cắp nơi thành thị Hải Phòng thời Pháp thuộc và số phận oan trái, bi kịch của người đàn bà lương thiện Tám Bính.",
        "publish_date": "2005-03-15",
        "cover_image": "https://images.unsplash.com/photo-1495640388908-05fa85288e61?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 19,
        "isbn": 1019,
        "title": "Những Ngày Thơ Ấu",
        "author": "Nguyên Hồng",
        "dob": "1918-11-05",
        "publisher": "NXB Văn học",
        "price": 48000.00,
        "description": "Tập hồi ký cảm động về những năm tháng ấu thơ đầy cay đắng, thiếu thốn tình thương của chú bé Hồng trong một gia đình phong kiến suy tàn.",
        "publish_date": "2007-06-25",
        "cover_image": "https://images.unsplash.com/photo-1505664194779-8beaceb93744?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 20,
        "isbn": 1020,
        "title": "Đất Rừng Phương Nam",
        "author": "Đoàn Giỏi",
        "dob": "1925-05-17",
        "publisher": "NXB Kim Đồng",
        "price": 89000.00,
        "description": "Hành trình phiêu lưu của cậu bé An qua vùng thiên nhiên Nam Bộ trù phú, hoang sơ và hào hiệp cùng những con người chất phác can trường trong kháng chiến.",
        "publish_date": "2015-04-30",
        "cover_image": "https://images.unsplash.com/photo-1470549638415-0a0755be0619?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 21,
        "isbn": 1021,
        "title": "Chiếc Lược Ngà",
        "author": "Nguyễn Quang Sáng",
        "dob": "1932-01-12",
        "publisher": "NXB Trẻ",
        "price": 52000.00,
        "description": "Câu chuyện cảm động rơi nước mắt về tình phụ tử thiêng liêng giữa ông Sáu và bé Thu trong bối cảnh chiến tranh khốc liệt chia cắt đất nước.",
        "publish_date": "2010-09-02",
        "cover_image": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 22,
        "isbn": 1022,
        "title": "Cánh Đồng Bất Tận",
        "author": "Nguyễn Ngọc Tư",
        "dob": "1976-01-01",
        "publisher": "NXB Trẻ",
        "price": 85000.00,
        "description": "Tập truyện ngắn làm say đắm lòng người với ngòi bút đậm chất miền Tây Nam Bộ, phản ánh những số phận trôi dạt, nỗi cô đơn và lòng vị tha sâu lắng.",
        "publish_date": "2005-11-20",
        "cover_image": "https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 23,
        "isbn": 1023,
        "title": "Khói Trời Lộng Lẫy",
        "author": "Nguyễn Ngọc Tư",
        "dob": "1976-01-01",
        "publisher": "NXB Trẻ",
        "price": 78000.00,
        "description": "Những tản văn và truyện ngắn mộc mạc mà lắng đọng về cuộc sống, con người và những hoài niệm bâng khuâng nơi miệt vườn sông nước.",
        "publish_date": "2010-04-15",
        "cover_image": "https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 24,
        "isbn": 1024,
        "title": "Nỗi Buồn Chiến Tranh",
        "author": "Bảo Ninh",
        "dob": "1952-10-18",
        "publisher": "NXB Trẻ",
        "price": 115000.00,
        "description": "Một trong những tiểu thuyết về chiến tranh Việt Nam xuất sắc nhất được dịch ra nhiều thứ tiếng, kể về ký ức đau thương, mất mát và vết thương lòng của người lính sau trận mạc.",
        "publish_date": "2011-04-30",
        "cover_image": "https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 25,
        "isbn": 1025,
        "title": "Bến Không Chồng",
        "author": "Dương Hướng",
        "dob": "1949-01-01",
        "publisher": "NXB Hội nhà văn",
        "price": 92000.00,
        "description": "Bức tranh làng quê Bắc Bộ thời hậu chiến với những người phụ nữ chung thủy chờ đợi chồng mỏi mòn, chứa chan lòng bao dung và sự hy sinh thầm lặng.",
        "publish_date": "2006-12-05",
        "cover_image": "https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 26,
        "isbn": 1026,
        "title": "Tướng Về Hưu",
        "author": "Nguyễn Huy Thiệp",
        "dob": "1950-04-29",
        "publisher": "NXB Trẻ",
        "price": 75000.00,
        "description": "Tác phẩm gây chấn động văn đàn Việt Nam thập niên 1980 với cái nhìn trực diện, sắc lạnh về sự tha hóa nhân cách trước cơn lốc kinh tế thị trường.",
        "publish_date": "2009-08-10",
        "cover_image": "https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 27,
        "isbn": 1027,
        "title": "Hà Nội Ba Mươi Sáu Phố Phường",
        "author": "Thạch Lam",
        "dob": "1910-07-07",
        "publisher": "NXB Văn học",
        "price": 45000.00,
        "description": "Tập bút ký nhẹ nhàng, tinh tế và đầy chất thơ về nét đẹp thanh lịch của đất kinh kỳ, với những thức quà Hà Nội nồng nàn dư vị cổ kính.",
        "publish_date": "2002-10-10",
        "cover_image": "https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 28,
        "isbn": 1028,
        "title": "Gió Đầu Mùa",
        "author": "Thạch Lam",
        "dob": "1910-07-07",
        "publisher": "NXB Văn học",
        "price": 42000.00,
        "description": "Tập truyện ngắn thấm đượm tình người ấm áp, len lỏi vào tâm hồn độc giả như ngọn gió sớm đầu mùa với tấm lòng trắc ẩn dành cho người nghèo.",
        "publish_date": "2003-01-15",
        "cover_image": "https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 29,
        "isbn": 1029,
        "title": "Vang Bóng Một Thời",
        "author": "Nguyễn Tuân",
        "dob": "1910-07-10",
        "publisher": "NXB Văn học",
        "price": 60000.00,
        "description": "Tác phẩm tài hoa tuyệt mỹ của Nguyễn Tuân, lưu giữ những thú vui tao nhã cổ truyền của cha ông như uống trà, thả thơ, chơi hoa lan và viết chữ thư pháp.",
        "publish_date": "2004-09-02",
        "cover_image": "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    },
    {
        "bookid": 30,
        "isbn": 1030,
        "title": "Mùa Lạc",
        "author": "Nguyễn Khải",
        "dob": "1930-12-03",
        "publisher": "NXB Văn học",
        "price": 46000.00,
        "description": "Tác phẩm ngợi ca sự đổi đời kỳ diệu của người lao động trên nông trường Điện Biên, mở ra chân lý: Ở đời này không có con đường cùng, chỉ có những ranh giới.",
        "publish_date": "2005-05-01",
        "cover_image": "https://images.unsplash.com/photo-1532012164546-f432f2e3edd3?auto=format&fit=crop&w=600&q=80",
        "quantity": 50
    }
]


def escape_sql(text):
    if not text:
        return ""
    return str(text).replace("'", "''").strip()


def build_sql_script(output_file="data_books.sql"):
    # 1. Trích xuất danh sách tác giả duy nhất
    author_map = {}  # name -> (id, dob)
    next_author_id = 1
    for b in BOOKS_DATA:
        name = b["author"]
        if name not in author_map:
            author_map[name] = (next_author_id, b["dob"])
            next_author_id += 1

    lines = []
    lines.append("-- ===================================================================")
    lines.append("-- DATABASE: BookStore")
    lines.append("-- DỮ LIỆU: 30 CUỐN SÁCH KINH ĐIỂN VĂN HỌC VIỆT NAM")
    lines.append("-- Sinh viên: Trương Quốc Duy - MSSV: 24133009 - Đề 1")
    lines.append(f"-- Tổng số sách: {len(BOOKS_DATA)} cuốn")
    lines.append(f"-- Tổng số tác giả: {len(author_map)} tác giả")
    lines.append("-- ===================================================================")
    lines.append("USE BookStore;")
    lines.append("GO\n")

    lines.append("-- Đảm bảo cột cover_image và price tương thích link online và giá bán")
    lines.append("IF COL_LENGTH('books', 'cover_image') < 500")
    lines.append("    ALTER TABLE books ALTER COLUMN cover_image NVARCHAR(500);")
    lines.append("IF COL_LENGTH('books', 'price') < 10")
    lines.append("    ALTER TABLE books ALTER COLUMN price DECIMAL(10,2);")
    lines.append("GO\n")

    lines.append("-- 1. Dọn sạch dữ liệu cũ và reset IDENTITY")
    lines.append("DELETE FROM rating;")
    lines.append("DELETE FROM book_author;")
    lines.append("DELETE FROM books;")
    lines.append("DELETE FROM author;")
    lines.append("DBCC CHECKIDENT ('books',  RESEED, 0);")
    lines.append("DBCC CHECKIDENT ('author', RESEED, 0);")
    lines.append("GO\n")

    # 2. Authors
    lines.append("-- 2. Chèn danh sách tác giả (author)")
    lines.append("SET IDENTITY_INSERT author ON;")
    lines.append("INSERT INTO author (author_id, author_name, date_of_birth) VALUES")
    sorted_authors = sorted(author_map.items(), key=lambda x: x[1][0])
    auth_rows = []
    for name, (a_id, dob) in sorted_authors:
        safe_name = escape_sql(name)
        auth_rows.append(f"    ({a_id}, N'{safe_name}', '{dob}')")
    lines.append(",\n".join(auth_rows) + ";")
    lines.append("SET IDENTITY_INSERT author OFF;")
    lines.append("GO\n")

    # 3. Books
    lines.append("-- 3. Chèn 30 cuốn sách kinh điển (books)")
    lines.append("SET IDENTITY_INSERT books ON;")
    lines.append("INSERT INTO books (bookid, isbn, title, publisher, price, description, publish_date, cover_image, quantity) VALUES")
    book_rows = []
    for b in BOOKS_DATA:
        safe_title = escape_sql(b["title"])
        safe_pub = escape_sql(b["publisher"])
        safe_desc = escape_sql(b["description"])
        safe_img = escape_sql(b["cover_image"])
        book_rows.append(
            f"    ({b['bookid']}, {b['isbn']}, N'{safe_title}', N'{safe_pub}', "
            f"{b['price']:.2f}, N'{safe_desc}', '{b['publish_date']}', "
            f"N'{safe_img}', {b['quantity']})"
        )
    lines.append(",\n".join(book_rows) + ";")
    lines.append("SET IDENTITY_INSERT books OFF;")
    lines.append("GO\n")

    # 4. Book_Author mapping
    lines.append("-- 4. Chèn quan hệ N-N (book_author)")
    lines.append("INSERT INTO book_author (bookid, author_id) VALUES")
    ba_rows = []
    for b in BOOKS_DATA:
        a_id = author_map[b["author"]][0]
        ba_rows.append(f"    ({b['bookid']}, {a_id})")
    lines.append(",\n".join(ba_rows) + ";")
    lines.append("GO\n")

    # 5. Reviews mẫu (Câu 4)
    lines.append("-- 5. Chèn đánh giá mẫu (rating)")
    lines.append("IF EXISTS (SELECT 1 FROM users WHERE id = 1)")
    lines.append("BEGIN")
    lines.append("    INSERT INTO rating (userid, bookid, rating, review_text) VALUES")
    lines.append("        (1, 1, 5, N'Một tác phẩm quá đỗi tuyệt vời của Nguyễn Nhật Ánh, đọc mà nghẹn ngào.'),")
    lines.append("        (1, 6, 5, N'Số Đỏ đúng là tuyệt tác trào phúng, đọc thời nào cũng thấy thấm thía.'),")
    lines.append("        (1, 8, 5, N'Tiếng kêu đòi quyền làm người của Chí Phèo thật ám ảnh và xúc động.'),")
    lines.append("        (1, 11, 5, N'Dế Mèn Phiêu Lưu Ký là tuổi thơ của biết bao thế hệ Việt Nam!'),")
    lines.append("        (1, 13, 5, N'Tuổi Thơ Dữ Dội bi tráng, hào hùng và ngập tràn tình yêu quê hương đất nước.');")
    lines.append("END")
    lines.append("GO\n")

    lines.append("PRINT N'30 cuốn sách Việt Nam kinh điển đã được nạp thành công vào Database BookStore!';")
    lines.append("PRINT N'Sinh viên: Trương Quốc Duy - MSSV: 24133009';")
    lines.append("GO\n")

    content = "\n".join(lines)
    with open(output_file, "w", encoding="utf-8") as f:
        f.write(content)

    print(f"[✓] Đã tạo thành công file: {output_file} ({len(content.encode('utf-8'))} bytes)")
    print(f"[✓] Tổng số sách: {len(BOOKS_DATA)} cuốn.")
    print(f"[✓] Tổng số tác giả: {len(author_map)} tác giả.")


if __name__ == "__main__":
    out = os.path.join(os.path.dirname(os.path.abspath(__file__)), "data_books.sql")
    build_sql_script(out)
