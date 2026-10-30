# Một số quyết định thiết kế

## PHP và JavaScript thuần

Ứng dụng hướng tới hosting PHP/MySQL. Giao diện không cần bước build khi triển khai;
Node chỉ được dùng cho các bài kiểm tra JavaScript.

## Tách học liệu và tiến độ

Học liệu dùng chung có định danh riêng. Tiến độ, lịch ôn, ghi chú và câu tự viết
được gắn với tài khoản. Đồng bộ book không nên tạo lại thẻ hoặc làm mất lịch sử học.

## Lịch học theo tiến độ

Daily Plan ưu tiên thẻ đến hạn, thẻ cần học lại và lỗi lặp lại trước khi thêm nội dung mới.
Lý do ưu tiên được trả cùng kế hoạch để người học biết vì sao một bài xuất hiện.

## Kiểm tra quyền ở API

Ẩn nút ở giao diện chỉ giúp sử dụng thuận tiện.
Truy vấn dữ liệu cá nhân phải kiểm tra chủ sở hữu; thao tác quản trị cần đúng vai trò.
Các yêu cầu ghi dữ liệu cần CSRF token.

## Giữ lịch sử database

Migration và seed có checksum. Không sửa tệp đã chạy vì một cơ sở dữ liệu cũ
có thể đã lưu checksum khác. Thay đổi tiếp theo được đưa vào migration mới.

## Giới hạn và phần cần cải thiện

Repository.php và assets/app.js còn lớn, có thể tiếp tục tách theo chức năng.
Giọng đọc và nhận dạng giọng nói phụ thuộc trình duyệt.
Speaking/Writing có công cụ luyện và tự đánh giá, không thay cho chấm thi chính thức.
