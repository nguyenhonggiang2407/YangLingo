# Daily Essentials · 64 từ & cụm dùng ngay

Một book bổ sung gồm **64 thẻ, 8 bài × 8 mục** cho hội thoại đời sống và sinh
viên. Có 39 từ đơn cùng 25 cụm/mẫu câu. Mỗi thẻ có nghĩa Việt, ví dụ Anh–Việt
tự biên soạn và ghi chú riêng; mỗi bài có mục tiêu, gợi ý nói và đoạn nói mẫu.

Đây là nội dung hướng A1–A2. Nhãn `cefr` là gợi ý biên tập theo cách dùng được
chọn, không phải xếp hạng CEFR đã chứng nhận. Các mục được chọn để phục vụ tình
huống của book, không khẳng định đây là danh sách từ bắt buộc cho mọi người.

## Các bài

| Bài | Tình huống | Bạn tập làm gì? |
| --- | --- | --- |
| 1 | Vào lớp & mượn đồ | Hỏi chỗ ngồi, mượn bút, nói chưa hiểu |
| 2 | Ở chung & việc nhà | Nói nơi để đồ, nhờ giảm nhạc, chia một việc nhà |
| 3 | Đi chợ cho bữa ăn | Nói món cần mua, số lượng và độ tươi |
| 4 | Đi tàu & xe buýt | Dùng vé, hỏi sân ga, nói lên/xuống và thời gian đi |
| 5 | Thời gian gần gũi | Phân biệt hôm qua, hôm nay, ngày mai và hẹn làm sau |
| 6 | Nhắn tin & kết nối | Xin đường dẫn, nói về tệp và kiểm tra âm thanh |
| 7 | Đủ, hết & còn lại | Nói đồ đủ/thiếu với danh từ đếm được và không đếm được |
| 8 | Chọn & trả lời lịch sự | Nói điều thích hơn, chấp nhận hoặc hoãn một gợi ý |

Book bổ sung cho Everyday60 và Student120: không có mục `term` trùng chính
xác với 180 mục của hai seed hiện có. Một số từ cũng xuất hiện trong học liệu
600 từ cũ; book này dùng ví dụ mới và tình huống nói ngắn để tập sử dụng chúng.

## Cách dùng một bài

Thời lượng 8 phút là gợi ý bố trí buổi học. Có thể chỉ chọn 4 mục nếu bài còn
khó: đọc ví dụ, che từ rồi tự nhớ lại, mở đáp án để sửa, sau đó nói hai câu về
tình huống của mình. Gợi ý nói và đoạn mẫu là điểm bắt đầu; người học có thể
thay đồ vật, thời gian và nơi chốn. Không có cam kết về tốc độ hay hiệu quả
học tập, và lịch ôn nên theo khả năng nhớ thực tế.

## Dữ liệu

- `assets/flashbooks/daily-essentials-a1-a2.json`: seed sạch, schema 1, code riêng
  `daily-essentials-a1-a2`; không có tài khoản, owner/card ID hay tiến độ cá nhân.
- `assets/flashbooks/daily-essentials-pronunciation-sources.json`: đối chiếu từng từ với nguồn phát âm.
- `assets/licenses/DAILY-ESSENTIALS-ORIGINAL-LICENSE.txt`: MIT cho phần nghĩa/ghi chú, ví dụ và cấu trúc tự biên soạn.
- `assets/licenses/`: nguyên văn ba giấy phép nguồn phát âm mở.

Mở **Khám phá book**, tìm **Daily Essentials** rồi chọn thêm vào thư viện.
Book được tạo riêng cho tài khoản hiện tại; bấm thêm lại vẫn dùng cùng book
và card ID. Mở **Luyện nhớ & dùng từ**, chọn book rồi chọn một trong tám bài.
Thông tin nguồn phát âm được giữ cùng seed khi phân phối ứng dụng.

## Phát âm và nguồn

39 từ đơn có phiên âm nhãn **US**. Các cụm/mẫu câu không được ghép IPA từ từng
từ. Giọng đọc trình duyệt, nếu được dùng khi tích hợp, phụ thuộc thiết bị và
giọng có sẵn; không có tệp âm thanh đi kèm seed.

20 mục sao chép nguyên IPA từ
[open-dict-data/ipa-dict](https://github.com/open-dict-data/ipa-dict/tree/43c3570eb3553bdd19fccd2bd0091534889af023)
(commit `43c3570eb3553bdd19fccd2bd0091534889af023`). Đây là dữ liệu US dẫn xuất
từ CMU qua [lingz/cmudict-ipa](https://github.com/lingz/cmudict-ipa/tree/629483e9a7fa5b9ff11bb83e3fda6dcc25c5c511).
Đối chiếu với [CMU Pronouncing Dictionary](https://github.com/cmusphinx/cmudict/tree/74790861f652b15e4ac49015a90074ad62a27690)
(commit `74790861f652b15e4ac49015a90074ad62a27690`): mỗi mục có một cách đọc
nguồn được chọn và chuỗi âm/trọng âm tương ứng. Hai nguồn có liên quan nên
việc đối chiếu không phải chứng nhận độc lập cho toàn bộ từ điển. Không tự đổi
AH1, ER0 hoặc các ký hiệu của nguồn.

19 mục có nguồn sự kiện phát âm được kiểm tra từ publisher: 18 từ tại
[Cambridge Dictionary](https://dictionary.cambridge.org/pronunciation/), và
`yesterday` theo phần American English của
[Collins / Webster’s New World College Dictionary](https://www.collinsdictionary.com/us/dictionary/english/yesterday).
Đường dẫn cụ thể và cách đọc được chọn nằm trong bảng nguồn JSON. Với
`entrance`, chọn đúng danh từ lối vào; `roommate` và `exit` có biến thể khác
được nguồn chấp nhận. Với `comfortable`, chỉ bỏ khoảng trắng do trình bày
quanh âm schwa cuối khi chuyển sang trường chữ; không đổi âm/trọng âm.

Các nguồn dùng quy ước khác nhau về độ dài âm, dấu chấm âm tiết, âm /r/,
/l/ và cách ghi /t/ Mỹ. Seed giữ cách ghi của nguồn thay vì tự chuẩn hóa.
Không sao chép câu định nghĩa, ví dụ, đoạn văn hoặc âm thanh từ publisher.
MIT của phần tự biên soạn không cấp phép lại nội dung publisher.

IPA-dict và dự án chuyển đổi có giấy phép MIT; dữ liệu CMU giữ giấy phép riêng
của Carnegie Mellon University. Phải giữ cả ba thông báo trong `assets/licenses/`
khi phân phối những mục phát âm nguồn mở này. Các nguồn không cấp phép cho
database cá nhân hoặc học liệu khác của ứng dụng.

## Tích hợp

Book dùng source_type riêng `daily_essentials_a1_a2_book` (27 ký tự). Catalog và
installer hiện có dùng owner + source_type dưới GET_LOCK; lượt thêm lặp lại
dùng cùng book/card ID. Seed JSON là nội dung mới cho một book riêng, không
phải SQL seed chạy lại trên các book đã cài. Migration 015 hiện có giữ nguyên.
