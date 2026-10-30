# Kiểm tra cài đặt với MySQL/MariaDB

Chuẩn bị database thử riêng và một tài khoản có quyền tạo bảng, chỉ mục,
bảng tạm, đọc và ghi dữ liệu. Không dùng cấu hình của database đang vận hành.

## Cài mới

1. Trỏ cấu hình thử tới database trống.
2. Chạy setup.php và tạo tài khoản quản trị thử.
3. Kiểm tra schema_migrations và content_seeds đã ghi nhận các tệp áp dụng.
4. Mở ứng dụng lần nữa; số book, thẻ và nội dung dùng chung không được nhân đôi.
5. Đăng ký người học, tạo bộ từ, làm một lượt ôn và tải lại để kiểm tra tiến độ.

## Các bài tích hợp

```bash
php tests/db_integration_test.php
php tests/notebook_integration_test.php
php tests/daily_essentials_install_test.php
php tests/web_english_install_test.php
```

Mỗi bài có yêu cầu cấu hình riêng ở đầu tệp. Chọn biến cấu hình thử tương ứng
trong [testing.md](testing.md); các bài cài book kiểm tra tên database có hậu tố thử.

## Khi gặp lỗi checksum

Đối chiếu tệp SQL trong repository với lịch sử của database đang kiểm tra.
Không xóa dòng lịch sử hoặc sửa checksum chỉ để bỏ qua lỗi.
Giữ tệp đã áp dụng và tạo migration mới cho thay đổi cần thực hiện.

Ghi lại phiên bản PHP, MySQL/MariaDB, mã commit, lệnh chạy và kết quả để tái hiện.
