# Schema, migration và seed

## Trình tự khởi động

setup.php ghi config.local.php, gọi Database::ensureSchema(), tạo quản trị viên,
sau đó ghi storage/installed.lock.
lib/bootstrap.php cũng gọi ensureSchema() khi có cấu hình database hợp lệ.

1. database/schema.sql tạo lược đồ nền.
2. Các tệp SQL trong database/migrations được chạy theo thứ tự tên.
3. Các tệp SQL trong database/seeds được chạy theo thứ tự tên.

schema_migrations và content_seeds lưu checksum của tệp đã chạy.
Một tệp đã được ghi nhận sẽ không chạy lại; nếu nội dung khác checksum, bộ chạy dừng
để tránh âm thầm thay lịch sử. MySQL/MariaDB có thể tự commit DDL,
còn các content seed được thực hiện trong transaction.

CSV và JSON là dữ liệu nguồn, không được thực thi như SQL.
database/seed.sql nằm ngoài thư mục seed được theo dõi và chỉ dùng tùy chọn sau khi có quản trị viên.

## Migration hiện có

Các migration có số 001–009 và 011–016. Không có migration 010.
Chúng bao gồm xác thực, loại thẻ, TOEIC, SRS, học liệu và sổ tay.
Danh sách đầy đủ nằm trong database/migrations.

Migration 009 có dữ liệu theo người học mẫu learner@example.test.
Các lệnh thêm nội dung cần chủ sở hữu và bộ từ đã tồn tại;
nếu chưa có người học mẫu thì phần đó được bỏ qua, không tạo tài khoản cố định.

Không chép một phiên bản khác của migration 009 lên hệ thống đã lưu checksum cũ.
Giữ lịch sử đó và thêm migration mới nếu cần thay đổi dữ liệu.

## Học liệu và book

SQL seed dùng chung nằm từ 011_global_learning_library.sql đến
022_helen_toeic_part1_vocabulary.sql.
Book JSON/CSV trong assets/flashbooks được tạo cho người học qua thao tác trong thư viện,
tách khỏi lịch sử SRS cá nhân.

## Kiểm tra

```bash
php tests/migration_integrity_test.php
php tests/seed_audit_test.php
php tests/db_integration_test.php
```

Bài kiểm tra tích hợp cần database thử riêng có pdo_mysql.
Không đổi tên, sửa nội dung hoặc sắp xếp lại các SQL migration và seed đã chạy.
