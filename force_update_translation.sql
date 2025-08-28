-- 번역 데이터 강제 업데이트 스크립트
-- 오라클에서 실행하세요

-- 1. 기존 번역 데이터 삭제 (선택사항)
-- DELETE FROM C##HEALNGO.ITEM_LIST_I18N WHERE LOCALE IN ('en', 'zh', 'ja');

-- 2. 영어 번역 데이터 강제 업데이트
MERGE INTO C##HEALNGO.ITEM_LIST_I18N t
USING (
  SELECT 1 AS item_id, 'en' AS locale,
         '2010 Plastic Surgery Clinic' AS name_tr,
         'Incheon Metropolitan City, Yeonsu-gu, Incheontower-daero 180beon-gil 11, B-211 (Songdo-dong, The Sharp Songdo Central Park III)' AS address_tr
  FROM dual
  UNION ALL
  SELECT 2, 'en', 'ABC Dermatology Clinic', 'Seoul, Gangnam-gu, Teheran-ro 123' FROM dual
  UNION ALL
  SELECT 3, 'en', 'XYZ Dental Hospital', 'Busan, Haeundae-gu, Marine City 1-ro 45' FROM dual
  UNION ALL
  SELECT 4, 'en', 'Premium Skin Care Center', 'Daegu, Suseong-gu, Beomeo-ro 456' FROM dual
  UNION ALL
  SELECT 5, 'en', 'Modern Dental Clinic', 'Daejeon, Yuseong-gu, Daehak-ro 789' FROM dual
) s
ON (t.ITEM_ID = s.ITEM_ID AND t.LOCALE = s.LOCALE)
WHEN MATCHED THEN
  UPDATE SET
    t.NAME_TR       = s.NAME_TR,
    t.ADDRESS_TR    = s.ADDRESS_TR,
    t.NAME_LABEL    = s.NAME_TR,
    t.ADDRESS_LABEL = s.ADDRESS_TR
WHEN NOT MATCHED THEN
  INSERT (ITEM_ID, LOCALE, NAME_TR, ADDRESS_TR, NAME_LABEL, ADDRESS_LABEL)
  VALUES (s.ITEM_ID, s.LOCALE, s.NAME_TR, s.ADDRESS_TR, s.NAME_TR, s.ADDRESS_TR);

-- 3. 중국어 번역 데이터 강제 업데이트
MERGE INTO C##HEALNGO.ITEM_LIST_I18N t
USING (
  SELECT 1 AS item_id, 'zh' AS locale,
         '2010整形外科诊所' AS name_tr,
         '仁川广域市延寿区仁川塔大道180号路11号B-211室（松岛洞，The Sharp松岛中央公园III）' AS address_tr
  FROM dual
  UNION ALL
  SELECT 2, 'zh', 'ABC皮肤科诊所', '首尔江南区德黑兰路123号' FROM dual
  UNION ALL
  SELECT 3, 'zh', 'XYZ牙科医院', '釜山海云台区海洋城市1路45号' FROM dual
  UNION ALL
  SELECT 4, 'zh', '高级皮肤护理中心', '大邱寿城区梵鱼路456号' FROM dual
  UNION ALL
  SELECT 5, 'zh', '现代牙科诊所', '大田儒城区大学路789号' FROM dual
) s
ON (t.ITEM_ID = s.ITEM_ID AND t.LOCALE = s.LOCALE)
WHEN MATCHED THEN
  UPDATE SET
    t.NAME_TR       = s.NAME_TR,
    t.ADDRESS_TR    = s.ADDRESS_TR,
    t.NAME_LABEL    = s.NAME_TR,
    t.ADDRESS_LABEL = s.ADDRESS_TR
WHEN NOT MATCHED THEN
  INSERT (ITEM_ID, LOCALE, NAME_TR, ADDRESS_TR, NAME_LABEL, ADDRESS_LABEL)
  VALUES (s.ITEM_ID, s.LOCALE, s.NAME_TR, s.ADDRESS_TR, s.NAME_TR, s.ADDRESS_TR);

-- 4. 일본어 번역 데이터 강제 업데이트
MERGE INTO C##HEALNGO.ITEM_LIST_I18N t
USING (
  SELECT 1 AS item_id, 'ja' AS locale,
         '2010形成外科クリニック' AS name_tr,
         '仁川広域市延寿区仁川タワー大路180番路11、B-211（ソンド洞、The SharpソンドセントラルパークIII）' AS address_tr
  FROM dual
  UNION ALL
  SELECT 2, 'ja', 'ABC皮膚科クリニック', 'ソウル江南区テヘラン路123' FROM dual
  UNION ALL
  SELECT 3, 'ja', 'XYZ歯科医院', '釜山海雲台区マリンシティ1路45' FROM dual
  UNION ALL
  SELECT 4, 'ja', 'プレミアムスキンケアセンター', '大邱寿城区梵魚路456' FROM dual
  UNION ALL
  SELECT 5, 'ja', 'モダンデンタルクリニック', '大田儒城区大学路789' FROM dual
) s
ON (t.ITEM_ID = s.ITEM_ID AND t.LOCALE = s.LOCALE)
WHEN MATCHED THEN
  UPDATE SET
    t.NAME_TR       = s.NAME_TR,
    t.ADDRESS_TR    = s.ADDRESS_TR,
    t.NAME_LABEL    = s.NAME_TR,
    t.ADDRESS_LABEL = s.ADDRESS_TR
WHEN NOT MATCHED THEN
  INSERT (ITEM_ID, LOCALE, NAME_TR, ADDRESS_TR, NAME_LABEL, ADDRESS_LABEL)
  VALUES (s.ITEM_ID, s.LOCALE, s.NAME_TR, s.ADDRESS_TR, s.NAME_TR, s.ADDRESS_TR);

COMMIT;

-- 5. 업데이트된 번역 데이터 확인
SELECT 'English' as Language, ITEM_ID, NAME_LABEL, ADDRESS_LABEL 
FROM C##HEALNGO.ITEM_LIST_I18N WHERE LOCALE = 'en' AND ROWNUM <= 3
UNION ALL
SELECT 'Chinese' as Language, ITEM_ID, NAME_LABEL, ADDRESS_LABEL 
FROM C##HEALNGO.ITEM_LIST_I18N WHERE LOCALE = 'zh' AND ROWNUM <= 3
UNION ALL
SELECT 'Japanese' as Language, ITEM_ID, NAME_LABEL, ADDRESS_LABEL 
FROM C##HEALNGO.ITEM_LIST_I18N WHERE LOCALE = 'ja' AND ROWNUM <= 3;
