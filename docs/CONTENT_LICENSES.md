# Nguồn và giấy phép học liệu

`LICENSE` là giấy phép MIT đã có của dự án. Giữ nguyên giấy phép cho phạm vi phần mềm và tài liệu thuộc dự án; không suy diễn rằng nó tự cấp quyền đối với học liệu được cung cấp từ bên ngoài.

| Nhóm | Tệp và tài liệu nguồn |
| --- | --- |
| English bổ sung | `assets/flashbooks/everyday-english-a1-a2.json`, `student-life-work-a2-b1.json`; các bài ngắn Anh–Việt đóng gói cùng ứng dụng |
| Ba handbook TOEIC 800+ được cung cấp | `assets/handbooks/toeic-verb-master-800-plus.pdf`, `toeic-listening-100-cau-800-plus.pdf`, `toeic-grammar-800-plus.pdf` |
| HELEN TOEIC Part 1 Vocabulary | Snapshot `assets/handbooks/helen-toeic-part1-vocabulary.csv`; nguồn ghi ở `HELEN_PART1_VOCAB_INTEGRATION.md` |
| Học liệu dẫn xuất | Một số CSV trong `assets/flashbooks/`, seed `021_toeic_800_handbooks.sql`, `022_helen_toeic_part1_vocabulary.sql`; provenance trong dữ liệu và tài liệu tích hợp |

[HANDBOOKS_800_INTEGRATION.md](HANDBOOKS_800_INTEGRATION.md) mô tả PDF/Sheet được cung cấp và nguyên tắc giữ nội dung nguồn. Trường `source` hoặc tên nguồn trong tài liệu là thông tin xuất xứ, không tự tạo giấy phép phân phối lại.

Trong tài liệu và metadata kiểm tra để chuẩn bị bản public, chưa thấy thông báo giấy phép phân phối lại riêng cho các PDF/Sheet nói trên và phần dẫn xuất. Source giữ tài nguyên để tính năng tham chiếu hiện có hoạt động; không thêm tuyên bố cấp phép mới cho tài nguyên đó. Khi tái sử dụng hoặc phân phối học liệu, cần kiểm tra quyền đối với nguồn tương ứng.

TOEIC, Aptis và HELEN xác định ngữ cảnh hoặc nguồn. Repository không khẳng định là sản phẩm chính thức hoặc được đơn vị tổ chức kỳ thi chứng nhận. Mức CEFR của book English mới là gợi ý biên soạn.

## Phiên âm IPA bổ sung

IPA-dict `en_US.txt` (General American) có nguồn chuyển đổi cmudict-ipa; đối chiếu âm và trọng âm với CMUdict. Các phiên bản được ghim và thông báo giấy phép đầy đủ nằm trong [trang ghi nguồn IPA](../pronunciation-sources.html) và `assets/licenses/`. Dữ liệu cũ có thể có nguồn khác; giao diện không tự gắn US cho IPA chưa ghi giọng. Kế hoạch đối chiếu theo card ID và database cá nhân được giữ ngoài repository.

Một số cách đọc được kiểm tra riêng trên trang phát âm chính thức của Cambridge; danh sách liên kết nằm trong trang ghi nguồn. Chỉ lưu ký hiệu phát âm ngắn của mục đã kiểm tra. Không phân phối lại từ điển, định nghĩa, câu ví dụ hoặc tệp âm thanh của Cambridge; những liên kết này không có nghĩa toàn bộ nội dung Cambridge mang giấy phép MIT.

## Hướng dẫn học trong sổ tay

`assets/learning-notebook.js` chứa phần hướng dẫn và ví dụ Anh–Việt do dự án biên soạn. Quy tắc được đối chiếu với ABC Education, British Council và Oxford Learner’s Dictionaries; tự kiểm tra và học giãn cách tham khảo tổng quan Dunlosky và cộng sự (2013), liên kết ở từng mục. Chỉ diễn giải ngắn và dẫn nguồn; không phân phối lại nội dung đầy đủ của các nhà xuất bản. Giấy phép phần mềm dự án không cấp quyền đối với các trang tham khảo.

## Daily Essentials

Book JSON `daily-essentials-a1-a2` có 64 thẻ với nghĩa, ví dụ, ghi chú và gợi ý nói tự biên soạn, được cấp phép MIT trong `assets/licenses/DAILY-ESSENTIALS-ORIGINAL-LICENSE.txt`. Hai mươi mục IPA được chọn từ dữ liệu mở giữ cả ba thông báo giấy phép gốc. Mười chín cách đọc ngắn được ghi nguồn riêng từ Cambridge và Collins theo đúng nghĩa/từ loại; không sao chép ví dụ, định nghĩa hoặc âm thanh của các nhà xuất bản. Nguồn từng từ nằm trong `assets/flashbooks/daily-essentials-pronunciation-sources.json`. Không tạo IPA cho 25 cụm/mẫu câu bằng cách ghép phiên âm từ đơn.


Thirteen further single-word US pronunciation facts in the -ed learning material are linked individually on the pronunciation-source page. Selection distinguishes verb live from adjective live, learned meaning knowledgeable, aged meaning very old, and a before-noun pronunciation of beloved. Short pronunciation facts and authored explanations do not redistribute publisher examples or audio; publisher content is not covered by the software license.

## English for Web

Book `english-for-web-a2-b1` gồm 48 thẻ và 48 nhiệm vụ viết câu tự biên soạn trong tình huống hư cấu, theo giấy phép MIT ở `assets/flashbooks/english-for-web-a2-b1/LICENSE.original.txt`. 12 mục IPA giữ đúng dữ liệu mở được ghim, cùng đủ ba thông báo giấy phép IPA-dict/CMUdict-IPA/CMUdict trong thư mục `licenses/` của book. Required chọn một cách đọc nguyên mục từ en_US, giữ nguyên ký hiệu và không khẳng định tần suất của các biến thể. 22 cách đọc US khác là các sự kiện phát âm ngắn từ Cambridge, ghi riêng theo từ và từ loại; chúng không cấp lại giấy phép cho định nghĩa, ví dụ hoặc âm thanh của nhà xuất bản. Nguồn từng mục, hash/bản nguồn và giới hạn nằm trong `pronunciation-sources.json`; các điểm cách dùng đối chiếu MDN/GitHub/từ điển nằm trong `content-references.json`. 14 mục là cụm hoặc từ có gạch nối chưa có IPA được để trống; không ghép IPA từ đơn để khẳng định cách đọc cả cụm hoặc câu. Xem [cách học và giới hạn](WEB_ENGLISH48.md).
