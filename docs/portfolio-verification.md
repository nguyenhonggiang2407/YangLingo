# Kiểm chứng portfolio — 03/11/2026

Đợt này giữ nguyên chức năng, dữ liệu, giấy phép MIT và các thông báo nguồn học liệu.
Ảnh `docs/images/practice.png` và `notebook.jpg` là tài nguyên đã có trong repository;
không phải ảnh vừa chụp lại từ hosting.

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

Kiểm tra cú pháp và toàn bộ 12 tệp kiểm thử JavaScript `.cjs` vượt qua.
Chúng kiểm tra các module thật bằng môi trường dữ liệu/DOM thử, gồm bảo vệ câu trả lời,
bản nháp, định tuyến, lưu sổ tay, quyền sở hữu và phản hồi bất đồng bộ đến muộn.
Đây không phải kiểm thử trình duyệt tương tác hoặc đo coverage.

`https://yangcute.helioho.st/` trả HTTP 200, tiêu đề
`YangLingo | Một chút mỗi ngày, tiếng Anh tiến xa` vào ngày kiểm tra.
Không tạo tài khoản hoặc thay đổi dữ liệu trên hosting trong đợt này.

## Chưa kiểm chứng

Môi trường không có PHP, MySQL/MariaDB hoặc Docker. Chưa chạy các bài PHP,
cài database, migration/seed và các luồng học đã đăng nhập. Chưa chụp ảnh desktop/mobile
mới. Cần thực hiện các bước trong [testing.md](testing.md) trên database thử riêng;
không dùng database thật để chạy integration tests.
