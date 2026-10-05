# DEFENSE Q&A

80 câu hỏi/đáp án bám vào source hiện tại, ở mức sinh viên CNTT năm cuối có thể trình bày.

## 1. YangLingo giải quyết vấn đề gì?
Nó giảm việc người học tự quyết định học gì bằng Daily Plan, dùng SRS để ôn đúng hạn, lưu lỗi để tạo vòng học lại và gom TOEIC/Aptis vào cùng hồ sơ học tập.

## 2. Vì sao chọn PHP thay vì Node.js runtime?
Mục tiêu triển khai là HelioHost/shared hosting. PHP + MariaDB chạy trực tiếp trên môi trường này, nhẹ và không cần process manager hay build server.

## 3. Frontend dùng framework gì?
Vanilla JavaScript và CSS. Node chỉ được dùng để kiểm tra cú pháp trong quá trình test, không phải production dependency.

## 4. Repository có vai trò gì?
Repository gom truy vấn và nghiệp vụ dữ liệu của learner/admin, giữ api.php mỏng hơn và bắt buộc các thao tác người dùng đi qua user_id phù hợp.

## 5. Vì sao chưa rewrite Repository thành nhiều class?
Ở bước final, ổn định quan trọng hơn refactor lớn. Source đang chạy và có regression tests; thay cấu trúc quá mạnh có thể tạo lỗi mới.

## 6. PDO được cấu hình thế nào để chống SQL injection?
Dùng prepared statements, execute với params và tắt emulated prepares bằng PDO::ATTR_EMULATE_PREPARES=false.

## 7. Schema được khởi tạo thế nào?
database/schema.sql cung cấp base schema; Database::ensureSchema lưu schema_hash và chạy bổ sung migration/seed.

## 8. Migration được theo dõi ra sao?
schema_migrations lưu filename, SHA-1 checksum và thời điểm áp dụng. File đã áp dụng nhưng bị sửa sẽ gây lỗi checksum.

## 9. Vì sao content seed tách khỏi migration?
Schema và learning content có vòng đời khác nhau. content_seeds giúp thêm dữ liệu lớn, idempotent mà không gắn dữ liệu học với thay đổi schema.

## 10. Vì sao migration 004–008 vẫn có INSERT?
Đó là migration lịch sử đã phát hành. Giữ nguyên giúp không phá checksum ở deployment cũ; mọi nội dung Adaptive mới đã chuyển sang seeds.

## 11. SRS là gì?
Spaced Repetition System là cơ chế tăng/giảm khoảng ôn theo kết quả nhớ, để card khó xuất hiện sớm hơn và card ổn định xuất hiện thưa hơn.

## 12. Active Recall là gì?
Người học phải tự truy xuất đáp án trước khi xem lại, thay vì chỉ đọc lặp lại. Quiz, flashcard và listening dictation đều tạo recall event.

## 13. Các trạng thái SRS chính?
New, Learning, Review và Relearning.

## 14. Điều gì xảy ra khi chọn Again?
Card đi vào/re-enter relearning, tăng lapse và được lên lịch ôn lại sớm.

## 15. Mastery có phải chỉ dựa trên số lần nhìn thấy không?
Không. Test yêu cầu stability, successful repetitions và correct streak đạt điều kiện.

## 16. Daily Plan ưu tiên gì trước?
Overdue, due today, relearning, unresolved mistakes, weak skills, hard cards rồi mới đến kiến thức mới.

## 17. Vì sao backlog lớn thì giảm từ mới?
Nếu tiếp tục thêm mới khi nhiều card đang nợ ôn, tải nhận thức và số lượng due sẽ phình nhanh, làm retention giảm.

## 18. Adaptive Learning ở đây có phải Machine Learning không?
Không. Đây là rule-based adaptive engine dùng backlog, recent accuracy, mistakes và skill evidence. Project không tuyên bố có mô hình ML.

## 19. Learner Profile tính gì?
Nó tổng hợp tín hiệu học gần đây cho Vocabulary, Grammar, Listening, Reading, Speaking và Writing; đây là coaching metric, không phải điểm chứng chỉ.

## 20. Weakness Analysis khác accuracy chung thế nào?
Nó nhóm lỗi theo error_type/topic để chỉ ra điểm yếu cụ thể thay vì chỉ báo một phần trăm đúng tổng.

## 21. Mistake Book khác History thế nào?
History ghi sự kiện; Mistake Book lưu lỗi có cấu trúc, số lần lặp, đáp án đúng, giải thích, trạng thái resolve và dùng cho remediation.

## 22. Error-driven learning flow là gì?
Sai → Mistake Book → phân loại → Micro Lesson → drill → SRS → retest.

## 23. Micro Lesson lấy ở đâu?
Repository tìm grammar micro-lesson phù hợp trong global_learning_items; nếu chưa match chính xác thì dùng fallback lesson và vẫn hiển thị lỗi/đáp án.

## 24. Knowledge Hub là gì?
Thư viện learning content chung gồm vocabulary, collocation, pattern, grammar lesson, listening recognition và paraphrase.

## 25. Vì sao tách global learning khỏi user progress?
Một nội dung dùng chung cho nhiều learner. Tách giúp tránh duplicate content, còn user_global_learning/SRS giữ tiến độ riêng.

## 26. external_key dùng làm gì?
Nó là định danh ổn định cho content seed, hỗ trợ idempotency và duplicate detection.

## 27. content_hash dùng làm gì?
Nó phát hiện nội dung tương đương/trùng ở mức record dù external key khác.

## 28. TOEIC có tách biệt hoàn toàn khỏi hệ học không?
Không. Attempt và lỗi có thể đi vào Mistake Book/analytics; vocabulary và patterns dùng chung với hệ học.

## 29. Tại sao seed TOEIC tập trung Part 2/5/6/7?
Đây là các phần có thể tạo practice chất lượng cao mà không cần hàng trăm MB audio/hình. Part 1/3/4 vẫn có engine/starter và có thể mở rộng bằng media chuẩn.

## 30. TOEIC Part 6 khác Part 5 thế nào trong data?
Part 6 phải có passage/email/notice context; seed final không dùng câu rời Part 5 rồi gắn nhãn Part 6.

## 31. TOEIC Part 7 hỗ trợ loại câu gì?
Main idea, detail, inference, vocabulary/purpose và NOT/EXCEPT tùy document.

## 32. Data-quality test kiểm tra TOEIC gì?
Đếm đúng 300, phân phối part, không exact-duplicate question, correct_option hợp lệ và correct_answer khớp option.

## 33. Aptis Quick Check vì sao không gọi Full Mock?
Engine nhỏ đó chưa mô phỏng đầy đủ mọi điều kiện đề chính thức. Tên Quick Check tránh quảng cáo sai độ fidelity.

## 34. Aptis có những module nào?
Grammar, Vocabulary, Reading, Listening, Speaking và Writing.

## 35. Aptis có phải tất cả MCQ không?
Không. Adaptive pack có thêm task như sentence ordering và nhiều vocabulary task types; Speaking/Writing là prompt tự thực hiện.

## 36. Speaking được chấm chính thức không?
Không. App dùng recording/playback và self-assessment/rubric; nếu thêm AI thì chỉ gọi coaching feedback.

## 37. Writing có điểm chính thức Aptis không?
Không. Word count/rubric giúp luyện tập, không tuyên bố official score.

## 38. Tại sao không lưu recording Speaking lên server mặc định?
Để giảm storage/privacy burden trên shared hosting. Browser recording/playback phù hợp hơn cho luyện cá nhân.

## 39. Connected speech được biểu diễn thế nào?
Có formal phrase, spoken_form và giải thích rằng couldja/gonna/hafta… chỉ là cue nghe, không phải cách viết formal.

## 40. PWA cache những gì?
Static shell/assets và offline page. API authenticated data được loại khỏi static caching.

## 41. CSRF được xử lý thế nào?
Bootstrap tạo token random; request thay đổi dữ liệu phải gửi token và API kiểm tra trước khi xử lý.

## 42. Session fixation được giảm thế nào?
Sau register/login gọi session_regenerate_id(true), đồng thời dùng strict mode và cookies only.

## 43. Login brute force được giảm thế nào?
auth_login_throttle lưu failures theo hash email+IP, khóa tạm thời khi vượt ngưỡng.

## 44. IDOR được giảm thế nào?
Repository query learner-owned resources với cả object id và current user_id; admin actions cần requireAdmin.

## 45. Importer hỗ trợ gì?
TXT/CSV và các cấu trúc DOCX/XLSX được parse về dữ liệu học; các template import được bundle.

## 46. ZIP bomb là gì?
Archive rất nhỏ nhưng giải nén cực lớn/hoặc có quá nhiều entry gây cạn tài nguyên. ZipReader giới hạn size, entries, ratio và output.

## 47. XLSX bị giới hạn gì?
XML 10 MB, tối đa 5.000 dòng và 100 cột trong reader hiện tại.

## 48. DOCX bị giới hạn gì?
Archive dùng giới hạn ZipReader, document.xml tối đa 10 MB và output text bị cap.

## 49. Có upload bất kỳ file extension nào không?
Không nên coi filename là an toàn. Import flow chỉ xử lý format hỗ trợ và parser có giới hạn; storage directories còn có .htaccess.

## 50. AI có bắt buộc không?
Không. OpenRouter key là optional, core SRS/TOEIC/Aptis/analytics chạy deterministic.

## 51. Tại sao không gọi weakness rule là AI?
Vì không có learned model. Gọi đúng là rule-based analytics/adaptive rules giúp project trung thực về kỹ thuật.

## 52. Database integration test cuối có chạy không?
Không trong build container final vì không có pdo_mysql/MySQL/MariaDB và apt package update bị timeout. Trạng thái là NOT EXECUTED.

## 53. Vì sao không dùng SQLite thay để báo PASS?
SQL dialect, enum/index/foreign-key/DDL semantics khác MariaDB; dùng SQLite rồi gọi tương đương sẽ tạo kết luận sai.

## 54. Làm sao test DB trên HelioHost?
Sau cấu hình DB, chạy `php tests/db_integration_test.php` nếu có CLI hoặc kiểm tra setup + các bảng/seed qua phpMyAdmin và smoke-test route.

## 55. Seed có idempotent không?
Content seed files được checksum-track; global items có unique external_key/content_hash; connected speech dùng ON DUPLICATE KEY UPDATE.

## 56. Nếu sửa seed đã chạy trên production thì sao?
Checksum sẽ đổi và app báo lỗi. Đúng quy trình là tạo seed số mới.

## 57. Tại sao có numeric gap 009/010?
Hai file cũ user-scoped/data-mixed được loại khỏi active release. Gap được giữ thay vì renumber các migration đã phát hành.

## 58. Có hard-code email cá nhân trong migration final không?
Không. Security audit tìm legacy personal identifier trên source/content/doc và yêu cầu không còn.

## 59. Setup lưu DB password ở đâu?
Trong config.local.php trên server. File này không nằm trong release ZIP.

## 60. Password admin có nằm trong source không?
Không. Setup nhận password và lưu password_hash trong database.

## 61. Điểm mạnh portfolio lớn nhất của project?
Nó không chỉ là CRUD: có auth/RBAC, SRS, adaptive rules, error remediation, exam engines, content pipeline, import security, PWA, tests và shared-host deployment.

## 62. Điểm hạn chế kỹ thuật lớn nhất hiện tại?
Backend Repository/app.js còn khá monolithic và build-container chưa có real MariaDB integration. Stability được ưu tiên hơn refactor ở final.

## 63. Nếu phát triển tiếp nên ưu tiên gì?
Thêm DB integration CI với MariaDB, tách Repository/service modules có test, audio source chuẩn cho listening và rubric feedback sâu hơn cho Speaking/Writing.

## 64. Adaptive Engine khác random practice ở đâu?
Random practice chọn câu không dựa trên trạng thái học. Adaptive Engine dùng backlog SRS, lỗi, recurrence, weakness, exam relevance và mastery để xếp ưu tiên có thể giải thích.

## 65. Vì sao không dùng Machine Learning?
Dữ liệu người dùng hiện chưa đủ để huấn luyện/đánh giá một model đáng tin cậy. Rule engine deterministic phù hợp hơn với đồ án, dễ test, giải thích và chạy trên HelioHost.

## 66. Trọng số Priority Score dựa trên đâu?
Đó là trọng số thiết kế sản phẩm: lỗi lặp/recurred được ưu tiên mạnh, weakness và overdue tăng điểm, mastery giảm điểm. Chúng không phải tham số được “học” từ dữ liệu.

## 67. Nếu user mới chưa có dữ liệu thì Daily Plan làm gì?
Không tạo phần trăm giả. Hệ thống dùng SRS hiện có, workload bảo thủ và kiến thức nền; Knowledge Map hiển thị “Chưa đủ dữ liệu” cho skill chưa có evidence.

## 68. Nếu mistake đã RESOLVED nhưng lại sai thì sao?
Mistake chuyển sang `RECURRED`, `resolved_at` bị xóa và recurrence tăng priority để concept quay lại remediation/Daily Plan sớm hơn.

## 69. Vì sao không clone 1.449 learning item cho từng user?
Nội dung học là tài nguyên chung. Clone theo user gây duplicate lớn, khó sửa content và tốn database. YangLingo chỉ tách progress/SRS/mistake theo user.

## 70. Knowledge Linking có cần graph database không?
Không. Quan hệ nhiều-nhiều giữa global items được lưu trong `knowledge_item_links`; MariaDB relational mapping đủ cho quy mô và deployment hiện tại.

## 71. Knowledge Map lấy phần trăm ở đâu?
Từ attempts/study events/progress thật. Nếu số attempt chưa đủ, frontend hiển thị “Chưa đủ dữ liệu” thay vì biến thiếu dữ liệu thành 0%.

## 72. Làm sao đảm bảo hơn 2.000 record không bị trùng/sai?
Có unique key/hash, checksum seed, data-quality tests cho duplicate/answer alignment/JSON/placeholder, correction seed và strategy retire thay vì sửa/xóa history tùy tiện.

## 73. Vì sao Aptis task được retire thay vì delete?
`aptis_attempts` tham chiếu question_id. Retire bằng `is_active=0` loại task khỏi bank mới nhưng giữ foreign key/history để analytics cũ vẫn đúng.

## 74. Word Matching khác MCQ thế nào ở engine?
Options là hai tập left/right và correct answer là mapping JSON. UI render mỗi left item với lựa chọn match, rồi backend so canonical mapping; không ép thành A/B/C/D.

## 75. Speaking audio được lưu ở server không?
Mặc định không. MediaRecorder ghi trong browser, playback/retry dùng object URL cục bộ; server chỉ lưu duration/self-assessment/notes khi user bấm lưu.

## 76. Writing autosave tránh xung đột thế nào?
Draft key chứa module + user ID + question ID. Vì vậy hai user/task khác nhau không dùng cùng một localStorage key; submit thành công mới xóa draft tương ứng.

## 77. `NOT EXECUTED` khác `FAIL` thế nào?
FAIL nghĩa là test đã chạy và kết quả sai. NOT EXECUTED nghĩa là môi trường không đủ điều kiện để chạy, ví dụ thiếu `pdo_mysql`/MariaDB; không được đổi thành PASS hay FAIL giả.

## 78. Nếu build environment không có MariaDB thì bảo đảm deploy thế nào?
Static-audit SQL/migration/seed, PHP lint, regression và content checks vẫn chạy; release có `db_integration_test.php` và HelioHost smoke-test để xác nhận trên MariaDB thật sau deploy.

## 79. Hạn chế của evaluation simulation là gì?
Nó chỉ chứng minh rule engine phản ứng đúng với fixture thiết kế. Nó không chứng minh người thật học nhanh hơn, nhớ lâu hơn hay tăng điểm thi bao nhiêu phần trăm.

## 80. Đóng góp kỹ thuật/học tập cốt lõi của YangLingo là gì?
Cùng một learning core nối Study Event → SRS/Mistake → Weakness → Priority/Daily Plan → Remediation → Retest/Mastery, rồi tái sử dụng cho cả học nền, TOEIC và Aptis.
