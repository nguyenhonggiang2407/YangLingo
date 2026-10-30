# Tổng quan YangLingo

YangLingo kết hợp thư viện từ vựng, ôn tập SRS, luyện ngữ cảnh và sổ tay theo tài khoản.
Một buổi học thường bắt đầu từ thẻ đến hạn, chuyển sang bài ngắn,
sau đó ghi lại từ hoặc cấu trúc cần dùng lại.

## Các phần chính

- Thư viện book và bài: quản lý thẻ, metadata, IPA và ví dụ.
- Daily Plan: ưu tiên bài theo lịch ôn và kết quả gần đây.
- Practice: nhớ từ nghĩa Việt, điền câu, nghe và viết lại.
- TOEIC/Aptis: ngân hàng câu hỏi, bài luyện và lịch sử.
- Sổ tay: ghi chú, câu tự viết, ghim, tìm kiếm và lưu trữ.
- Quản trị: nhập nội dung, quản lý câu hỏi, người dùng và bài giao.

## Luồng dữ liệu

Giao diện gọi api.php. Các route kiểm tra tài khoản và CSRF trước khi gọi lớp dữ liệu.
Repository.php xử lý truy vấn và các luồng học;
SRS.php và AdaptiveLearningService.php xử lý lịch ôn và mức ưu tiên.

Học liệu dùng chung nằm trong SQL seed và assets/flashbooks.
Tiến độ, ghi chú và lịch sử làm bài nằm trong database theo tài khoản.
Dữ liệu cá nhân và cấu hình đang chạy không được đưa vào repository.

## Tích hợp

Giọng đọc và nhận dạng giọng nói dùng hỗ trợ của trình duyệt.
Gia sư và tạo flashcard có thể gọi OpenRouter khi cấu hình khóa ở máy chủ.
Các book và phần ôn tập vẫn dùng được khi không bật tích hợp này.

Xem [kiến trúc](architecture.md), [lịch ôn](adaptive-scheduling.md),
[hướng dẫn kiểm thử](testing.md) và [nguồn học liệu](content-licenses.md).
