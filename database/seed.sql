-- YangLingo optional starter data (non-destructive).
-- Run AFTER setup.php has created/updated an ADMIN account.
-- Existing English learning materials are preserved; this seed only adds one starter set if absent.

SET @yl_admin_id := (SELECT id FROM users WHERE role='admin' AND is_active=1 ORDER BY id LIMIT 1);

INSERT INTO flashcard_sets (user_id, folder_id, title, description, source_type)
SELECT @yl_admin_id, NULL, 'YangLingo Starter English',
       'Bộ từ mẫu nhỏ để kiểm tra Flashcard, SRS và Quiz. Có thể xóa sau khi xác nhận hệ thống hoạt động.',
       'seed'
WHERE @yl_admin_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM flashcard_sets
      WHERE user_id=@yl_admin_id AND title='YangLingo Starter English'
  );

SET @yl_set_id := (
    SELECT id FROM flashcard_sets
    WHERE user_id=@yl_admin_id AND title='YangLingo Starter English'
    ORDER BY id LIMIT 1
);

INSERT INTO flashcards (set_id,term,definition,ipa,part_of_speech,cefr,example_en,example_vi,notes)
SELECT @yl_set_id, x.term, x.definition, x.ipa, x.part_of_speech, x.cefr, x.example_en, x.example_vi, 'Starter seed'
FROM (
    SELECT 'appointment' term,'cuộc hẹn' definition,'/əˈpɔɪntmənt/' ipa,'noun' part_of_speech,'A2' cefr,'I have an appointment at three o''clock.' example_en,'Tôi có một cuộc hẹn lúc ba giờ.' example_vi
    UNION ALL SELECT 'available','có sẵn; rảnh','/əˈveɪləbl/','adjective','A2','Is this meeting room available?','Phòng họp này có trống không?'
    UNION ALL SELECT 'confirm','xác nhận','/kənˈfɜːrm/','verb','B1','Please confirm your reservation by email.','Vui lòng xác nhận đặt chỗ qua email.'
    UNION ALL SELECT 'deadline','hạn chót','/ˈdedlaɪn/','noun','B1','The project deadline is Friday.','Hạn chót của dự án là thứ Sáu.'
    UNION ALL SELECT 'delivery','sự giao hàng','/dɪˈlɪvəri/','noun','B1','The delivery will arrive tomorrow.','Đơn hàng sẽ được giao vào ngày mai.'
    UNION ALL SELECT 'department','phòng ban','/dɪˈpɑːrtmənt/','noun','A2','She works in the sales department.','Cô ấy làm việc ở phòng kinh doanh.'
    UNION ALL SELECT 'equipment','thiết bị','/ɪˈkwɪpmənt/','noun','B1','The office needs new equipment.','Văn phòng cần thiết bị mới.'
    UNION ALL SELECT 'invoice','hóa đơn','/ˈɪnvɔɪs/','noun','B1','The supplier sent the invoice yesterday.','Nhà cung cấp đã gửi hóa đơn hôm qua.'
    UNION ALL SELECT 'maintenance','bảo trì','/ˈmeɪntənəns/','noun','B1','The elevator is closed for maintenance.','Thang máy đang đóng để bảo trì.'
    UNION ALL SELECT 'negotiate','đàm phán','/nɪˈɡoʊʃieɪt/','verb','B2','They will negotiate the contract terms.','Họ sẽ đàm phán các điều khoản hợp đồng.'
    UNION ALL SELECT 'postpone','hoãn lại','/poʊstˈpoʊn/','verb','B1','We had to postpone the meeting.','Chúng tôi phải hoãn cuộc họp.'
    UNION ALL SELECT 'purchase','mua; việc mua hàng','/ˈpɜːrtʃəs/','verb/noun','B1','You can purchase tickets online.','Bạn có thể mua vé trực tuyến.'
    UNION ALL SELECT 'receipt','biên lai','/rɪˈsiːt/','noun','A2','Keep the receipt for your records.','Hãy giữ biên lai để lưu hồ sơ.'
    UNION ALL SELECT 'schedule','lịch trình; lên lịch','/ˈskedʒuːl/','noun/verb','A2','The interview is scheduled for Monday.','Buổi phỏng vấn được lên lịch vào thứ Hai.'
    UNION ALL SELECT 'shipment','lô hàng','/ˈʃɪpmənt/','noun','B1','The shipment has left the warehouse.','Lô hàng đã rời kho.'
    UNION ALL SELECT 'supervisor','người giám sát','/ˈsuːpərvaɪzər/','noun','B1','Ask your supervisor for approval.','Hãy xin người giám sát phê duyệt.'
    UNION ALL SELECT 'temporary','tạm thời','/ˈtempəreri/','adjective','B1','This is a temporary solution.','Đây là một giải pháp tạm thời.'
    UNION ALL SELECT 'vacancy','vị trí tuyển dụng còn trống','/ˈveɪkənsi/','noun','B2','The company posted a new vacancy.','Công ty đã đăng một vị trí tuyển dụng mới.'
) x
WHERE @yl_set_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM flashcards c
      WHERE c.set_id=@yl_set_id AND c.term=x.term
  );
