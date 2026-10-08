# English for Web · Đọc tài liệu & làm việc nhóm

Book riêng gồm 48 từ và cụm trong 6 bài, mỗi bài 8 thẻ. Nội dung dành cho người muốn đọc tài liệu web, hiểu thông báo và trao đổi khi làm dự án. Đây là học liệu bổ sung; các book đã cài, card ID và lịch học của người dùng được giữ nguyên.

| Bài | Tình huống |
| --- | --- |
| 1 | Đọc tài liệu, yêu cầu và mô tả hàm |
| 2 | Yêu cầu HTTP, phản hồi và lỗi |
| 3 | Tài khoản, đăng nhập và quyền thao tác |
| 4 | Tệp, định dạng và dữ liệu mẫu |
| 5 | Báo lỗi, tái hiện lỗi và kết quả mong đợi/thực tế |
| 6 | Xem xét thay đổi, gộp nhánh và triển khai |

Mở **Khám phá book**, tìm **English for Web** rồi thêm vào thư viện. Mỗi tài khoản có book riêng; thêm lại trả về cùng book, giữ cả những thẻ người học đã sửa hoặc xoá. Ứng dụng không dùng thao tác thêm lại để phục hồi hoặc reset học liệu cá nhân.

Trong **Luyện nhớ & dùng từ**, chọn book và một bài. Thử nhớ trước khi xem đáp án. Sau **Kiểm tra** hoặc **Xem đáp án / chưa nhớ**, đọc ví dụ Anh–Việt và gợi ý **Thử dùng từ** để tự đặt câu. Gợi ý này không phải ô gõ câu riêng của bài luyện.

Muốn lưu câu, mở **Thư viện của tôi → book → bấm vào từ → Ghi câu của tôi**. Nháp sổ tay có phần tham khảo; ô câu tự viết luôn để trống. Chỉ **Lưu ghi chú** mới lưu. Ghi chú giúp tra lại câu bạn viết; nó không tự chấm đúng ngữ pháp và không tự thay lịch SRS. Với từ chưa nhớ, đánh giá theo khả năng nhớ thực tế và ôn khi đến hạn.

Mỗi bài có nhiệm vụ nói và một mẫu ngắn để đối chiếu sau khi tự thử. Khoảng 10 phút là gợi ý bắt đầu, không phải lời hứa về thời gian hoặc hiệu quả. A2/B1 là định hướng biên soạn câu ví dụ; các thuật ngữ kỹ thuật không được chứng nhận CEFR riêng, và đây không phải danh sách từ bắt buộc cho mọi người.

## Dữ liệu và nguồn

Các tệp chung nằm trong `assets/flashbooks/english-for-web-a2-b1/`. Seed và 48 nhiệm vụ riêng được kiểm tra theo bài và đúng từ/cụm. Khi tạo book, nhiệm vụ được thêm vào đoạn **Thử dùng từ** trong ghi chú cách dùng của thẻ; seed gốc vẫn giữ nguyên. Không có owner/card ID hoặc lịch học cá nhân trong các tệp chung.

34 từ đơn trong bộ học liệu chuẩn có IPA **US**, gồm 12 mục giữ đúng ký hiệu từ dữ liệu mở và 22 sự kiện phát âm từ Cambridge. Required chọn một cách đọc nguyên mục từ en_US; giữ ký hiệu của nguồn và không tự ghép hậu tố. 14 mục là cụm hoặc từ có gạch nối vẫn chưa có IPA, không ghép phiên âm từ các từ rời. Nút đọc dùng giọng trình duyệt và phụ thuộc thiết bị. Book không kèm tệp âm thanh.

- [Bảng nguồn phát âm](../assets/flashbooks/english-for-web-a2-b1/pronunciation-sources.json) ghi từng cách đọc, URL và bản dữ liệu ghim. Giữ nguyên các ký hiệu của nguồn; các nguồn có thể dùng quy ước trình bày IPA khác nhau.
- [Các điểm từ vựng và kỹ thuật đã đối chiếu](../assets/flashbooks/english-for-web-a2-b1/content-references.json) gồm nguồn MDN, GitHub và từ điển cho những điểm cụ thể như parameter/argument, HTTP request/response và xác thực định dạng email.
- Văn bản dạy học, ví dụ, bản dịch và nhiệm vụ được tự biên soạn trong tình huống hư cấu, theo `LICENSE.original.txt`. Ba thông báo giấy phép dữ liệu phát âm mở được giữ trong `licenses/`. Các sự kiện phát âm Cambridge không cấp lại giấy phép cho định nghĩa, ví dụ hoặc bản ghi âm của nhà xuất bản.

## Tích hợp

Book dùng code `english-for-web-a2-b1` và source type `english_for_web_a2_b1_book` riêng. Nó dùng cơ chế thêm book hiện có với khoá theo người học, xác thực/phân quyền và CSRF hiện có. Không có migration, API mới hoặc bảng dữ liệu mới cho book này. Các bài của book này dùng 8 thẻ và gợi ý 10 phút; nhóm bài và thời lượng của book cũ giữ nguyên.

Đọc [hướng dẫn sổ tay](LEARNING_NOTEBOOK.md) và [chi tiết thẻ](CARD_DETAILS.md) để hiểu lưu nháp, lưu thật và giới hạn giọng đọc.
