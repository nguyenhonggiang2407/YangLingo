# Kiểm tra lịch học thích ứng

```bash
php tests/adaptive_test.php
php tests/daily_plan_test.php
php tests/daily_plan_toeic_test.php
php tests/mastery_test.php
php tests/aptis_adaptive_test.php
```

Các bài kiểm tra bao gồm ưu tiên thẻ đến hạn, học lại, mức độ nhớ,
lỗi lặp lại, giới hạn kiến thức mới và kết quả từng kỹ năng.

Khi thử trên giao diện, tạo các trạng thái khác nhau:
chưa có kết quả học, nhiều thẻ đến hạn, lỗi mới và lỗi tái diễn.
Kế hoạch cần hiển thị lý do ưu tiên; kỹ năng chưa có dữ liệu phải báo chưa đủ dữ liệu,
không tự coi là điểm 0.

Dùng database thử riêng nếu chạy các bài có dữ liệu lưu.
