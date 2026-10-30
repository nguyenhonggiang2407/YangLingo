# Kiểm tra học liệu

Các bài kiểm tra tập trung vào dữ liệu trùng, đáp án, JSON, định dạng thẻ
và nguồn của học liệu đóng gói.

```bash
php tests/data_quality_test.php
php tests/seed_audit_test.php
php tests/toeic_seed_test.php
php tests/aptis_productive_test.php
php tests/aptis_adaptive_test.php
php tests/irregular_verbs_test.php
```

Seed 018 có các bản sửa theo external_key, giữ liên kết với tiến độ đã có.
Khi thay nội dung Aptis, bản cũ được đánh dấu không hoạt động để lịch sử làm bài
vẫn tham chiếu được, thay vì xóa hẳn.

Kiểm tra tự động không thay thế việc đọc lại ví dụ, nghĩa và mức độ phù hợp của bài.
Nguồn học liệu và giấy phép nằm trong [content-licenses.md](content-licenses.md).
