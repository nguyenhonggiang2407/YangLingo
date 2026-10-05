# YangLingo — bản nâng cấp cá nhân v40

Ngày cập nhật: 05/10/2026.

## Cách học dễ bắt đầu

1. Mở **Hôm nay** và chọn **Bắt đầu 15 phút**. Bộ đếm giúp giữ một khoảng học vừa sức; bạn có thể dừng bất cứ lúc nào.
2. Với flashcard, thử nhớ hoặc gõ từ tiếng Anh trước khi bấm **Kiểm tra đáp án**.
3. Chọn **Chưa nhớ / Nhớ khó / Đã nhớ / Rất dễ** đúng với cảm giác nhớ của bạn. Lịch ôn được lưu cho từng thẻ.
4. Mỗi lượt ôn tự do tối đa 10 thẻ. Bài của book cũ giữ nguyên cách chia; book mới dùng 10 thẻ một bài.

## Book bổ sung riêng

**Everyday English · Giao tiếp hằng ngày** gồm 60 từ/cụm/cấu trúc A1–A2, chia thành sáu bài:

- Làm quen & giới thiệu.
- Một ngày của bạn.
- Gọi món & quán cà phê.
- Hỏi đường & di chuyển.
- Mua sắm & thanh toán.
- Hẹn gặp & nhờ giúp đỡ.

Mỗi thẻ có nghĩa tiếng Việt, ví dụ Anh–Việt và gợi ý thực hành. Book dùng một bộ riêng trong thư mục **English hằng ngày**. Cài lại trả về book đã có, không tạo bản trùng.

## Dữ liệu và tương thích

- Giữ nguyên toàn bộ CSV, PDF, SQL và học liệu gốc. Không thay tệp cấu hình database hay tài khoản trên host.
- Mở thư viện/kho book chỉ đọc dữ liệu; bỏ thao tác tự cập nhật thẻ cũ.
- Nhận diện được mã book Extended từng bị cắt ngắn, ngăn tạo thêm bản trùng. Các bản cũ vẫn được giữ.
- Migration 015 chỉ mở rộng độ dài cột mã nguồn book nếu đang quá ngắn; giữ nguyên giá trị cũ.
- Sửa câu kiểm tra cột database để tương thích MariaDB và bổ sung hỗ trợ `array_is_list` cho PHP 8.0.

## Tệp và khôi phục

Gói `YangLingo-v40-upgrade.zip` chứa 11 tệp cần thêm/thay cùng tài liệu này. Giải nén đè đúng thư mục website; giữ nguyên `config.local.php`, `storage`, `uploads` và mọi học liệu cũ.

Trước khi triển khai, đã lưu một bản sao các tệp mã sẽ thay và xuất database vào thư mục riêng của host. Nếu cần hoàn tác giao diện, khôi phục những tệp mã cũ từ bản sao. Không chạy trình cài đặt lại hoặc nhập lại các seed SQL vào database đang sử dụng.

Xem `VALIDATION_V40.md` để đọc kết quả kiểm tra. Ba lỗi audit metadata có sẵn trong học liệu gốc được ghi nhận riêng; các tệp gốc được giữ nguyên.
