# Kiểm chứng portfolio — 03/11/2026

Đợt này giữ nguyên chức năng, dữ liệu, giấy phép MIT và các thông báo nguồn học liệu.
Ảnh `docs/images/practice.png` và `notebook.jpg` là tài nguyên đã có trong repository;
không phải ảnh vừa chụp lại từ hosting. Hai ảnh mới trong `docs/screenshots/`
được chụp trực tiếp từ trang đăng nhập hosting bằng Chromium ở 1440×1000 và 390×844.

## Điểm kỹ thuật có thể đọc từ source

- `api.php` nhận yêu cầu JSON; `lib/Repository.php` truy vấn qua PDO, giới hạn book,
  set và card theo tài khoản trước khi thay đổi tiến độ.
- `srs_progress` gắn người học với card và lịch đến hạn; `study_events` lưu hoạt động.
  Tiến độ cá nhân tách khỏi học liệu dùng chung và seed nội dung.
- `lib/AdaptiveLearningService.php` tách tính ưu tiên/lượng bài khỏi database.
  Đây là quy tắc xác định từ dữ liệu học tập, không phải mô hình AI dự đoán điểm thi.
- Browser lưu bản nháp và trạng thái luyện; API vẫn là nơi xác thực và lưu dữ liệu.
  Service worker chỉ giữ shell, không đồng bộ toàn bộ dữ liệu tài khoản để học offline.

Xem [kiến trúc](architecture.md), [kiểm thử](testing.md) và
[giới hạn giấy phép học liệu](content-licenses.md) trước khi tái sử dụng.

## Kiểm tra đã chạy

Trong Windows với Node.js 24.19.0:

```powershell
node --check assets/app.js
Get-ChildItem tests -Filter '*.cjs' | ForEach-Object {
    node $_.FullName
    if ($LASTEXITCODE -ne 0) { throw "Test failed: $($_.Name)" }
}
```

Kiểm tra cú pháp và toàn bộ 10 tệp kiểm thử JavaScript `.cjs` vượt qua.
Chúng kiểm tra các module thật bằng môi trường dữ liệu/DOM thử, gồm bảo vệ câu trả lời,
bản nháp, định tuyến, lưu sổ tay, quyền sở hữu và phản hồi bất đồng bộ đến muộn.
Đây không phải kiểm thử trình duyệt tương tác hoặc đo coverage.

`https://yangcute.helioho.st/` trả HTTP 200, tiêu đề
`YangLingo | Một chút mỗi ngày, tiếng Anh tiến xa` vào ngày kiểm tra.
Không tạo tài khoản hoặc thay đổi dữ liệu trên hosting trong đợt này.
Hai viewport không tràn ngang, không ghi nhận JavaScript page error hoặc request thất bại
trong lượt tải trang. Đã xem lại ảnh; chúng chỉ thể hiện trang vào chưa đăng nhập.

## Chưa kiểm chứng

Chưa thiết lập database thử riêng, chạy migration/seed hoặc các luồng học đã đăng nhập.
Cần thực hiện các bước trong [testing.md](testing.md) trên database thử riêng;
không dùng database thật để chạy integration tests.

## Bổ sung kiểm tra PHP — 04/11/2026

Đã tìm thấy PHP CLI 8.0.30 trong XAMPP ngoài PATH; nhận định trước đó rằng môi
trường không có PHP đã được đính chính. Bản này đáp ứng yêu cầu PHP 8.0 trở lên
trong README; có các extension `pdo_mysql`, `mbstring`, `zip` và `dom`.

`php -l` vượt qua với toàn bộ **63 tệp PHP tracked**. Lint chỉ kiểm tra cú pháp,
không thực thi source hoặc kết nối database. Bảy tệp kiểm thử dưới đây được đọc
trước để xác nhận chỉ dùng logic thuần/tài nguyên local hoặc static audit, rồi
chạy riêng bằng PHP CLI; cả bảy trả exit code 0:

```powershell
php tests/srs_test.php
php tests/adaptive_test.php
php tests/importer_test.php
php tests/migration_integrity_test.php
php tests/seed_audit_test.php
php tests/security_test.php
php tests/data_quality_test.php
```

Các bài migration/seed ở đây đọc và kiểm tra file, không chạy SQL. Các bài security
chỉ đối chiếu điều kiện trong source, không thay thế kiểm thử bảo mật runtime.
Không khởi tạo cấu hình/database, gọi installer hoặc chạy integration tests trong
phần bổ sung này. Chưa build/chạy Docker.
