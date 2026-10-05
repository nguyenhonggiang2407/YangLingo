-- Connected speech learner cues. These are listening approximations, not formal spelling.
INSERT INTO connected_speech_examples(pattern_key,title,explanation,phrase,spoken_form,category,sort_order,is_active) VALUES
('could-you-reduction','could you → couldja','Trong hội thoại nhanh, /d/ + /j/ có thể hòa âm. Chỉ dùng spoken_form để nhận diện âm; viết chuẩn là could you.','Could you send me the report?','Couldja send me the report?','reduction',110,1),
('would-you-reduction','would you → wouldja','/d/ + /j/ thường hòa âm trong lời nói nhanh; không viết wouldja trong văn phong chuẩn.','Would you open the window?','Wouldja open the window?','reduction',120,1),
('did-you-reduction','did you → didja','Cụm did you có thể nghe gần như didja trong hội thoại tự nhiên.','Did you receive my email?','Didja receive my email?','reduction',130,1),
('dont-you-reduction','don''t you → doncha','don''t you có thể nghe gần như doncha; đây là cue nghe, không phải chính tả chuẩn.','Don''t you need the receipt?','Doncha need the receipt?','reduction',140,1),
('want-to-reduction','want to → wanna','want to thường giảm âm trong lời nói thân mật; văn viết vẫn dùng want to.','I want to confirm the booking.','I wanna confirm the booking.','reduction',150,1),
('going-to-reduction','going to → gonna','going to có thể giảm thành gonna khi nói nhanh về dự định/tương lai.','We are going to start at nine.','We''re gonna start at nine.','reduction',160,1),
('got-to-reduction','got to → gotta','have got to / got to thường giảm âm thành gotta trong lời nói thân mật.','I have got to leave now.','I gotta leave now.','reduction',170,1),
('have-to-reduction','have to → hafta','have to thường bị vô thanh và giảm âm, gần với hafta.','We have to finish today.','We hafta finish today.','reduction',180,1),
('kind-of-reduction','kind of → kinda','kind of có thể giảm thành kinda trong hội thoại; không dùng như chính tả formal.','It is kind of expensive.','It''s kinda expensive.','reduction',190,1),
('a-lot-of-reduction','a lot of → alotta','Chuỗi a lot of có thể nối và giảm mạnh trong lời nói nhanh.','A lot of people attended the event.','Alotta people attended the event.','reduction',200,1),
('let-me-reduction','let me → lemme','let me thường nối và giảm âm thành lemme trong hội thoại nhanh.','Let me check the schedule.','Lemme check the schedule.','reduction',210,1),
('give-me-reduction','give me → gimme','give me thường nối thành gimme trong lời nói thân mật.','Give me a minute, please.','Gimme a minute, please.','reduction',220,1)
ON DUPLICATE KEY UPDATE title=VALUES(title),explanation=VALUES(explanation),phrase=VALUES(phrase),spoken_form=VALUES(spoken_form),category=VALUES(category),sort_order=VALUES(sort_order),is_active=VALUES(is_active);
