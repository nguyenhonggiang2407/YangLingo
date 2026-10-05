-- Build deterministic relational knowledge links from the global library. No user data is touched.
INSERT IGNORE INTO knowledge_item_links(source_item_id,target_item_id,relation_type,weight)
SELECT v.id,c.id,'TOPIC_COLLOCATION',0.80
FROM global_learning_items v
JOIN global_learning_items c ON c.item_type='COLLOCATION' AND c.is_active=1 AND c.topic=v.topic
WHERE v.item_type='VOCABULARY' AND v.is_active=1
  AND c.id=(SELECT MIN(c2.id) FROM global_learning_items c2 WHERE c2.item_type='COLLOCATION' AND c2.is_active=1 AND c2.topic=v.topic);

INSERT IGNORE INTO knowledge_item_links(source_item_id,target_item_id,relation_type,weight)
SELECT v.id,l.id,'TOPIC_LISTENING',0.70
FROM global_learning_items v
JOIN global_learning_items l ON l.item_type='LISTENING_RECOGNITION' AND l.is_active=1 AND l.topic=v.topic
WHERE v.item_type='VOCABULARY' AND v.is_active=1
  AND l.id=(SELECT MIN(l2.id) FROM global_learning_items l2 WHERE l2.item_type='LISTENING_RECOGNITION' AND l2.is_active=1 AND l2.topic=v.topic);

INSERT IGNORE INTO knowledge_item_links(source_item_id,target_item_id,relation_type,weight)
SELECT a.id,b.id,'SAME_TOPIC',0.55
FROM global_learning_items a
JOIN global_learning_items b ON b.topic=a.topic AND b.is_active=1 AND b.id<>a.id
WHERE a.is_active=1 AND a.item_type IN ('SENTENCE_PATTERN','GRAMMAR_LESSON')
  AND b.id=(SELECT MIN(b2.id) FROM global_learning_items b2 WHERE b2.topic=a.topic AND b2.is_active=1 AND b2.id<>a.id);
