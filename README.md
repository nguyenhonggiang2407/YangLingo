# YangLingo

**Học tiếng Anh theo bài ngắn, luyện nhớ chủ động và ôn đúng lúc.**

YangLingo is a PHP and MySQL English-learning web application. It brings vocabulary books, spaced review, contextual practice and an explainable daily study plan into one place.

[Trải nghiệm bản demo](https://yangcute.helioho.st/) · [Tổng quan dự án](docs/PROJECT_OVERVIEW.md) · [Kiến trúc](docs/ARCHITECTURE.md)

![Buổi luyện ngắn với book Student English và ba cách luyện](docs/images/practice.png)

Người xem demo có thể **tự đăng ký tài khoản riêng** để trải nghiệm. Thông tin tài khoản cá nhân và cấu hình hosting không nằm trong repository này.

## Bài toán

Người học thường lưu từ vựng ở một nơi, làm bài luyện ở nơi khác rồi bỏ quên những câu đã sai. YangLingo nối các bước đó: chọn một bài vừa sức, tự nhớ lại trước khi xem đáp án, luyện từ trong ngữ cảnh và quay lại ôn khi đến hạn.

## Những gì đã triển khai

- **Thư viện flashcard theo book và bài:** nghĩa Việt, ví dụ Anh–Việt, ghi chú cách dùng và lịch ôn SRS riêng. Book đóng gói được nhận diện theo nguồn để tránh tạo lại book và reset tiến độ khi đồng bộ.
- **Student English · Học tập & công việc:** book riêng gồm **120 thẻ / 12 bài / 10 thẻ mỗi bài**, từ giảng đường và bài nhóm đến email, thực tập, phỏng vấn, quản lý thời gian và đời sống số. Mỗi bài có mục tiêu và gợi ý luyện nói. A2–B1 là mức gợi ý biên soạn.
- **Ba cách luyện từ:** nhớ từ nghĩa Việt, điền từ vào câu, nghe rồi viết. Chọn 5 hoặc 10 thẻ, phối hợp cả ba cách, xem giải thích và thử lại từ chưa nhớ. Âm thanh dùng giọng đọc của trình duyệt; thiết bị chưa hỗ trợ chuyển sang luyện nhớ từ.
- **Thử dùng từ trong 30 giây:** gợi ý, câu mẫu, đồng hồ và tự kiểm tra giúp người học nói về tình huống của mình. Phần này không chấm phát âm. Kết quả buổi luyện từ lưu trong trình duyệt theo tài khoản; lịch SRS cập nhật qua luồng ôn bài.
- **Kế hoạch hôm nay, Mistake Book và phân tích điểm yếu:** ưu tiên thẻ đến hạn, học lại và lỗi tái diễn trước khi thêm kiến thức, kèm lý do cho người học.
- **Luyện TOEIC và Aptis:** các dạng câu hỏi, lịch sử làm bài và kiến thức liên quan; phần nói và viết Aptis có công cụ thực hành, tự đánh giá.
- **Tài khoản và quản trị:** đăng ký, đăng nhập, phân quyền, quản lý nội dung, import TXT/CSV/XLSX/DOCX. Giao diện dùng trên điện thoại; PWA lưu phần giao diện ngoại tuyến.

Daily Plan dùng **quy tắc có thể giải thích**, không phải mô hình học máy. Kết quả luyện và tự đánh giá không phải điểm thi chính thức. Chưa có nghiên cứu với nhóm người học để khẳng định mức tăng điểm hay hiệu quả ghi nhớ.

## Công nghệ và cấu trúc

Ứng dụng chạy bằng **PHP 8.0+**, **MySQL/MariaDB**, PDO, JavaScript và CSS thuần. Node.js chỉ phục vụ kiểm tra JavaScript khi phát triển. Tích hợp AI qua cấu hình là tùy chọn; thư viện và luyện tập hoạt động khi không có khóa AI.

| Thành phần | Vai trò |
| --- | --- |
| `index.php`, `assets/` | Giao diện, điều hướng, bài luyện và tài nguyên tĩnh |
| `api.php` | API JSON, đăng nhập, CSRF và phân quyền |
| `lib/` | Dữ liệu, xác thực, SRS, Daily Plan và bộ đọc import |
| `database/schema.sql` | Cấu trúc nền cho database mới |
| `database/migrations/` | Migration chạy theo thứ tự tên, có checksum |
| `database/seeds/` | Học liệu chung, được theo dõi riêng bằng checksum |
| `assets/flashbooks/` | Nguồn book đóng gói, gồm hai book English bổ sung |
| `templates/`, `tests/`, `docs/` | Mẫu import, kiểm tra và tài liệu |
| `storage/`, `uploads/` | Dữ liệu lúc chạy; Git chỉ giữ tệp bảo vệ thư mục |

## Chạy trên máy cục bộ

PHP cần bật `pdo_mysql` và `mbstring` để chạy thiết lập. Cần database MySQL/MariaDB mới và tài khoản có quyền tạo/thay đổi bảng, tạo bảng tạm, đọc/ghi dữ liệu. PHP cần quyền ghi cấu hình cục bộ và `storage/` khi thiết lập.

1. Tải hoặc clone repository; tạo một **database trống** cho YangLingo.
2. Sao chép `config.example.php` thành `config.local.php`. Điền `app_url` là `http://127.0.0.1:8080` và thông tin database cục bộ. Để `openrouter_api_key` trống nếu không dùng AI. Git bỏ qua `config.local.php`.
3. Trong thư mục dự án, khởi động máy chủ phát triển:

   ```bash
   php -S 127.0.0.1:8080
   ```

4. Mở `http://127.0.0.1:8080/setup.php`. Nhập cùng thông tin database, URL cục bộ và tài khoản quản trị **do bạn tự chọn**. Thiết lập ghi cấu hình, áp dụng schema, migration và content seed, tạo quản trị viên rồi ghi `storage/installed.lock` để khóa thiết lập.
5. Mở `http://127.0.0.1:8080/`, đăng nhập hoặc đăng ký người học riêng. Vào Thư viện, chọn book và thử luyện từ.

`lib/bootstrap.php` cũng gọi `Database::ensureSchema()` khi khởi động. Bộ chạy áp dụng các tệp `.sql` trong migration và seed theo thứ tự tên; tệp đã được ghi nhận sẽ không chạy lại. CSV/JSON là nguồn học liệu hoặc báo cáo, không tự được thực thi như SQL.

`database/seed.sql` là bộ từ mẫu tùy chọn, **không tự chạy**; nếu cần, chạy thủ công sau khi đã có quản trị viên. Chi tiết: [Database Migration Guide](DATABASE_MIGRATION_GUIDE.md).

Bản công khai đã thay định danh cá nhân trong migration 009 bằng dữ liệu mẫu và thêm điều kiện bỏ qua thao tác khi người học mẫu chưa tồn tại. Checksum tệp khác bản triển khai cũ, nên hướng dẫn này dành cho **cài đặt mới**. Với database đang dùng, giữ lịch sử migration của hệ thống đó và dùng migration mới cho thay đổi tiếp theo.

## Kiểm tra

Một số kiểm tra không cần database:

```bash
php tests/student_life_work_book_test.php
php tests/everyday_english_book_test.php
php tests/srs_test.php
php tests/adaptive_test.php
php tests/importer_test.php
php tests/migration_audit_test.php
php tests/static_audit.php
node --check assets/practice-lab.js
node tests/learning_ux_test.cjs
```

Cài đặt mới của bản công khai đã được kiểm tra với PHP 8.0.30/PDO và MariaDB 10.4.32: **14 migration, gồm migration 009, và 12 SQL content seed chạy thành công** trên database trống trước khi tạo tài khoản. Sau đó cài đủ 13 book trong catalog; book Everyday English có 60 thẻ và Student English có 120 thẻ. Chạy lại schema/đồng bộ không nhân đôi book hoặc làm đổi thẻ/SRS của dữ liệu kiểm tra đã có.

Kiểm tra tích hợp bằng `php tests/db_integration_test.php` cần cấu hình trỏ đến database thử nghiệm riêng; có thể áp dụng schema/migration/seed. Báo cáo lịch sử ở `TEST_REPORT.md` và `docs/` ghi phạm vi của từng phiên bản. Các kết quả này kiểm tra phần mềm, không đo mức tiến bộ tiếng Anh của người dùng.

## Bảo mật và dữ liệu

Mã nguồn có password hashing, giới hạn thử đăng nhập, phiên phía máy chủ, CSRF, phân quyền và truy vấn PDO có tham số. Dữ liệu học cá nhân gắn với chủ sở hữu. Import giới hạn kích thước/số phần tử và kiểm tra đường dẫn trong archive. Chi tiết: [SECURITY.md](SECURITY.md).

Repository không bao gồm cấu hình thật, database export, phiên đăng nhập, tệp người dùng tải lên hoặc bản sao lưu production. `.htaccess` bảo vệ các thư mục nội bộ trên Apache; triển khai bằng máy chủ khác cần các quy tắc tương ứng.

## Giấy phép và học liệu

Giữ nguyên [LICENSE](LICENSE) MIT đã có. PDF/Google Sheet được cung cấp trước đó có nguồn ghi trong tài liệu; không mặc nhiên coi mọi học liệu bên ngoài là MIT. Xem [nguồn và giấy phép học liệu](docs/CONTENT_LICENSES.md) và [manifest bản công khai](docs/PUBLIC_SOURCE_MANIFEST.json).

TOEIC và Aptis mô tả dạng luyện tập; YangLingo không phải dịch vụ thi hoặc chấm điểm chính thức.
