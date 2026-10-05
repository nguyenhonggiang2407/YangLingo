# Kiểm tra bản nâng cấp giao diện và học tập v40

Kiểm tra ngày 05/10/2026 với PHP 8.0.30 và MariaDB 10.4.32. Các kiểm tra chức năng ban đầu dùng database thử nghiệm riêng và tài khoản giả. Sau khi triển khai, bản sao lưu database thực tế trước và sau nâng cấp được nhập vào hai database cục bộ riêng để đối chiếu; bước đối chiếu không kết nối hoặc sửa database trên hosting.

- **53 tệp PHP** và **6 tệp JavaScript** kiểm tra cú pháp thành công.
- **26/29 bài kiểm tra không cần database** thành công. Ba bài audit cũ vẫn báo thông tin email cá nhân nằm trong migration 009 và báo cáo seed 009 của nguồn gốc. Những tệp này giữ nguyên để tránh thay đổi checksum của hệ thống cũ. Đây là lỗi đã tồn tại trong bản đầu vào; không phải lỗi mới của bản nâng cấp.
- Script cài đặt cũ `setup_1111.php` chứa tài khoản cố định không nằm trong gói nâng cấp.
- **56 tệp dữ liệu cũ** (CSV, PDF, SQL và mẫu DOCX/XLSX) giữ nguyên SHA-256 so với nguồn đầu vào.

## Kiểm tra database và giữ dữ liệu

MariaDB kiểm tra chạy riêng trên máy cục bộ. Migration 009 vốn chỉ dành cho tài khoản cũ được đánh dấu đã áp dụng trong database thử nghiệm, vì database này không chứa tài khoản cá nhân gốc. Các migration còn lại và toàn bộ content seed được thực thi.

- Database integration thành công: 1.946 global learning items, 100 connected speech, 300 TOEIC adaptive, 608 Aptis đang hoạt động và 110 Aptis đã nghỉ nhưng còn lịch sử.
- Tạo book Everyday English riêng: **60 thẻ**, **6 bài**, **10 thẻ mỗi bài**.
- Cài lại book giữ nguyên set ID và card ID, không tạo bản sao.
- Toàn bộ 6 bài phủ đủ 60 thẻ, không chồng lặp.
- Thẻ cá nhân cũ, ghi chú và lịch SRS cũ giữ nguyên sau khi cài book và đồng bộ thư viện.
- Đồng bộ toàn bộ danh mục book hoàn tất sau migration 015.
- HTTP thực tế: đăng nhập, dashboard 10 nhiệm vụ và danh mục 12 book thành công.

## Sửa lỗi tương thích đã được kiểm chứng

- Tra cứu cột bằng `INFORMATION_SCHEMA.COLUMNS` thay cho placeholder trong `SHOW COLUMNS`, tương thích với PDO native prepare trên MariaDB.
- Thêm `array_is_list` polyfill cho PHP 8.0.
- Migration 015 chỉ nới `flashcard_sets.source_type` khi độ dài hiện tại nhỏ hơn 64, để book Irregular Extended giữ nguyên định danh cũ mà không bị cắt chuỗi. Không sửa schema hoặc migration cũ.

## Xác nhận dữ liệu sau triển khai thực tế

Đã đối chiếu bản sao lưu database ngay trước và sau khi triển khai trên hosting. Mỗi hàng được so sánh bằng SHA-256 của toàn bộ giá trị cột và định danh khóa chính. Định danh được băm để báo cáo không chứa khóa phiên đăng nhập hoặc dữ liệu cá nhân.

- **10.329 hàng gốc trong 46 bảng học tập** được đối chiếu: **0 hàng bị xóa, 0 hàng bị sửa**.
- Toàn bộ **5.667 flashcard cũ**, **25 book cũ**, **3 hàng SRS** và lịch sử học giữ nguyên định danh và nội dung.
- Thêm đúng **1 book**, **1 thư mục**, **60 flashcard** mới. Tổng sau nâng cấp: **26 book**, **2 thư mục**, **5.727 flashcard**.
- Có thêm **1 migration** để nới độ dài định danh nguồn; không sửa hàng dữ liệu học cũ.
- Đối chiếu từng cột tài khoản cho thấy chỉ `last_login_at` và `updated_at` thay đổi do đăng nhập. Dữ liệu tài khoản còn lại giữ nguyên; các thay đổi phiên đăng nhập phù hợp với quá trình kiểm tra.

Báo cáo đã lọc dữ liệu cá nhân: `YangLingo-data-preservation.json`. Bản sao lưu SQL và snapshot chi tiết chỉ lưu trong khu vực làm việc, không nằm trong gói source hoặc gói cập nhật.
