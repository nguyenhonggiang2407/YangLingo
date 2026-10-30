# Triển khai YangLingo

## Cài mới

1. Chuẩn bị PHP 8.0 trở lên, bật pdo_mysql và mbstring, tạo database MySQL/MariaDB.
2. Đặt mã nguồn vào document root của domain, ví dụ httpdocs trên Plesk.
3. Tạo config.local.php từ config.example.php, điền URL ứng dụng và database.
4. Mở setup.php để tạo schema, học liệu và tài khoản quản trị.
5. Kiểm tra storage/installed.lock đã được tạo rồi đăng nhập trang chính.

Apache dùng các tệp .htaccess đi kèm để chặn truy cập thư mục nội bộ.
Nếu dùng Nginx hoặc máy chủ khác, cần cấu hình các quy tắc tương ứng.
Không đưa config.local.php, database, log hoặc tệp của người học vào Git.

## Cập nhật hệ thống đã có dữ liệu

Sao lưu database và mã nguồn trước khi cập nhật.
Giữ config.local.php và storage/installed.lock của hệ thống đang dùng.

Bộ chạy schema trong lib/Database.php áp dụng migration và seed chưa được ghi nhận.
Tệp đã chạy được kiểm tra checksum. Không thay hoặc đổi tên tệp SQL đã áp dụng;
thêm migration mới cho thay đổi tiếp theo.

Migration 009 ở repository dùng learner@example.test cho dữ liệu mẫu.
Nếu hệ thống cũ lưu checksum của một bản migration khác, giữ lịch sử của hệ thống đó.
Chi tiết ở [migrations.md](migrations.md).

## Tài nguyên và cache

Sau khi cập nhật JavaScript hoặc CSS, kiểm tra service worker và tải lại trang.
Các đường dẫn tài nguyên được khai báo trong index.php và service-worker.js.
API có dữ liệu đăng nhập không được lưu trong cache tĩnh.

Gia sư và tạo flashcard dùng khóa OpenRouter trong cấu hình phía máy chủ.
Để trống khóa nếu không dùng hai chức năng này.
Phần thư viện, SRS, nhập file và bài luyện không cần khóa đó.

## Kiểm tra sau triển khai

- Đăng ký, đăng nhập và phân biệt quyền quản trị/người học.
- Tạo một bộ từ, nhập file mẫu và sửa một thẻ.
- Làm một lượt ôn, tải lại và kiểm tra lịch ôn đã lưu.
- Mở một book, bài TOEIC/Aptis và sổ tay.
- Kiểm tra giao diện điện thoại, giọng đọc trình duyệt và trạng thái khi mất mạng.

Xem [deployment-checks.md](deployment-checks.md) và [testing.md](testing.md).
