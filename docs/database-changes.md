# Các thay đổi database

Migration được lưu trong database/migrations và theo dõi bằng checksum.
Bảng dưới đây giúp tra cứu theo phần chức năng; tên tệp SQL được giữ nguyên.

| Nhóm migration | Nội dung |
| --- | --- |
| 001 | Giới hạn thử đăng nhập |
| 002 và 004 | Mistake Book và trạng thái lỗi |
| 003 | Loại thẻ và metadata học liệu |
| 005–007 | Cá nhân hóa, taxonomy, TOEIC và connected speech |
| 008 | Thư viện cấu trúc câu |
| 009 | Bổ sung từ vựng theo bộ/người học đã có |
| 011 | Học liệu dùng chung, Aptis và tiến độ |
| 012 | Liên kết kiến thức và luyện lại theo lỗi |
| 013 | Học liệu TOEIC dạng handbook |
| 014–015 | Tên bài và mã nguồn book |
| 016 | Sổ tay riêng theo tài khoản |

Không có migration 010. Content seed được theo dõi riêng trong content_seeds.
Book đóng gói dạng JSON/CSV được xử lý qua các thao tác thư viện.

Khi bổ sung tính năng, thêm migration mới. Không đổi tên hoặc sửa lại một tệp đã áp dụng,
kể cả chỉ sửa chú thích, vì checksum của database cũ sẽ không còn khớp.

Xem [migrations.md](migrations.md) cho trình tự cài đặt và kiểm tra.
