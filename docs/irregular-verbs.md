# Bộ động từ bất quy tắc

Học liệu gồm Core 120, Extended 40 và một book riêng cho các cặp dễ nhầm.
Core và Extended có tổng cộng 160 khóa V1 không trùng nhau.

## Quy tắc dữ liệu

- Giữ be → was/were → been và oversee → oversaw → overseen.
- Overlook là động từ có quy tắc; chỉ đặt trong bài phân biệt với oversee.
- Giữ các biến thể được chấp nhận, ví dụ burned/burnt và got/gotten.
- Không tự thêm IPA khi chưa có nguồn phiên âm.
- Các cặp rise/raise, lie/lay, find/found được học riêng trong book Verb Traps.

## Đồng bộ với book đã có

Nguồn Core dùng source type verb_irregular_800_book để nhận diện book cũ.
Thẻ trùng khóa V1 được chuẩn hóa tại chỗ; thẻ còn thiếu được thêm mới.
Book Extended chỉ được tạo nếu chưa có.

Đồng bộ giữ ID thẻ và lịch sử SRS. Các thẻ cũ không còn trong nguồn chuẩn
không tự động bị xóa.

## Kiểm tra

```bash
php tests/irregular_verbs_test.php
php tests/verb_section_books_test.php
```

Dữ liệu CSV nguồn nằm trong assets/flashbooks. Các tên nguồn đã được dùng bởi
book và kiểm thử cần được giữ thống nhất khi cập nhật học liệu.
