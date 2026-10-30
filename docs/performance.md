# Hiệu năng

## Các phần đang dùng

- Phân trang và giới hạn số dòng khi tải dữ liệu.
- Lưu học liệu dùng chung một lần, tách tiến độ theo tài khoản.
- Chỉ cache giao diện và tài nguyên tĩnh bằng service worker.
- Không cache API có dữ liệu đăng nhập.
- Dùng SVG cục bộ cho một số hình minh họa bài Aptis.
- Xử lý bản thu nói trong trình duyệt khi không có thao tác tải lên.

Các tệp seed chỉ được đọc khi thiết lập hoặc cập nhật dữ liệu,
không tải toàn bộ xuống trình duyệt trong mỗi lượt học.

## Cần đo trên môi trường triển khai

Đo thời gian mở trang chính, tạo Daily Plan, lấy bài luyện và tải lần đầu các tài nguyên.
Ghi cả số bản ghi trong database, cấu hình host và bộ cache đang dùng để so sánh được các lần đo.

Chưa có bộ benchmark lặp lại cho host trong repository này.
Không suy ra tốc độ thực tế chỉ từ kích thước tệp hoặc kết quả kiểm tra cú pháp.

## Hướng cải thiện

Tách assets/app.js và Repository.php theo chức năng trước khi số lượng màn hình tiếp tục tăng.
Đối chiếu chỉ mục với truy vấn chậm thực tế; tránh thêm chỉ mục cho mọi cột.
