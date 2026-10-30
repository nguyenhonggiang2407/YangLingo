# Kiểm thử YangLingo

Chạy các lệnh từ thư mục gốc của dự án.

## Kiểm tra logic và dữ liệu

```bash
php tests/srs_test.php
php tests/adaptive_test.php
php tests/importer_test.php
php tests/migration_integrity_test.php
php tests/seed_audit_test.php
php tests/security_test.php
php tests/data_quality_test.php
```

Các bài này kiểm tra lịch ôn, tính ưu tiên, importer, cấu trúc dữ liệu,
lịch sử migration và các điều kiện bảo vệ trong mã nguồn.

## Kiểm tra JavaScript

```bash
node --check assets/app.js
node --check assets/aptis.js
node --check service-worker.js
node tests/learning_ux_test.cjs
node tests/pronunciation_ux_test.cjs
node tests/notebook_navigation_test.cjs
node tests/practice_state_test.cjs
node tests/card_details_test.cjs
node tests/card_notebook_test.cjs
node tests/notebook_api_retry_test.cjs
```

Những bài kiểm tra giao diện dùng dữ liệu thử và các module thật của ứng dụng.
Chúng kiểm tra điều hướng, đáp án chưa được mở, bản nháp, lưu ghi chú và xử lý phản hồi đến muộn.

## Kiểm tra có database

Dùng một database riêng cho kiểm thử. Các bài dưới đây có thể tạo tài khoản,
bảng hoặc dữ liệu rồi dọn sau khi chạy.

- db_integration_test.php: kết nối và luồng dữ liệu chung.
- notebook_integration_test.php: quyền sở hữu, tìm kiếm, giới hạn, lưu và khôi phục ghi chú.
- card_type_preservation_test.php: giữ loại thẻ khi tạo và sửa.
- daily_essentials_install_test.php và web_english_install_test.php:
  cài book lần đầu, lặp lại và đồng thời.

Đọc phần cấu hình ở đầu từng tệp trước khi chạy.
Các bài cài book dùng YL_TEST_CONFIG_PATH; bài sổ tay dùng YANG_NOTEBOOK_TEST_CONFIG.
Database được bảo vệ theo yêu cầu trong từng bài, thường có hậu tố _qa hoặc _test.

## Kiểm tra thủ công

Sau một thay đổi giao diện, thử một lượt học trên máy tính và điện thoại:
chọn bài, nhập câu trả lời, xem đáp án, tạm dừng, tải lại và tiếp tục.
Kiểm tra thêm việc đổi tài khoản khi còn yêu cầu đang tải.
Ghi riêng kết quả kiểm tra mã nguồn, database và trình duyệt để biết phần nào đã được thử.
