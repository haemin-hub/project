-- ITEM_LIST_I18N 테이블 구조 확인 및 수정
-- 1. 기존 테이블 구조 확인
DESC ITEM_LIST_I18N;

-- 2. NAME_LABEL 컬럼이 없다면 추가
ALTER TABLE ITEM_LIST_I18N ADD NAME_LABEL VARCHAR2(500);

-- 3. ADDRESS_LABEL 컬럼이 없다면 추가
ALTER TABLE ITEM_LIST_I18N ADD ADDRESS_LABEL VARCHAR2(500);

-- 4. 테이블 구조 재확인
DESC ITEM_LIST_I18N;

-- 5. 기존 데이터 확인
SELECT * FROM ITEM_LIST_I18N WHERE ROWNUM <= 5;

-- 6. 샘플 번역 데이터 추가 (기존 데이터가 있다면 UPDATE, 없다면 INSERT)
-- 영어 번역
MERGE INTO ITEM_LIST_I18N i18n
USING (SELECT 1 as ITEM_ID, 'en' as LOCALE FROM DUAL) src
ON (i18n.ITEM_ID = src.ITEM_ID AND i18n.LOCALE = src.LOCALE)
WHEN MATCHED THEN
    UPDATE SET 
        i18n.NAME_LABEL = '2010 Plastic Surgery Clinic',
        i18n.ADDRESS_LABEL = 'Incheon Metropolitan City, Yeonsu-gu, Incheontower-daero 180beon-gil 11, B-211 (Songdo-dong, The Sharp Songdo Central Park III)'
WHEN NOT MATCHED THEN
    INSERT (ITEM_ID, LOCALE, NAME_LABEL, ADDRESS_LABEL)
    VALUES (1, 'en', '2010 Plastic Surgery Clinic', 'Incheon Metropolitan City, Yeonsu-gu, Incheontower-daero 180beon-gil 11, B-211 (Songdo-dong, The Sharp Songdo Central Park III)');

-- 중국어 번역
MERGE INTO ITEM_LIST_I18N i18n
USING (SELECT 1 as ITEM_ID, 'zh' as LOCALE FROM DUAL) src
ON (i18n.ITEM_ID = src.ITEM_ID AND i18n.LOCALE = src.LOCALE)
WHEN MATCHED THEN
    UPDATE SET 
        i18n.NAME_LABEL = '2010整形外科诊所',
        i18n.ADDRESS_LABEL = '仁川广域市延寿区仁川塔大道180号路11号B-211室（松岛洞，The Sharp松岛中央公园III）'
WHEN NOT MATCHED THEN
    INSERT (ITEM_ID, LOCALE, NAME_LABEL, ADDRESS_LABEL)
    VALUES (1, 'zh', '2010整形外科诊所', '仁川广域市延寿区仁川塔大道180号路11号B-211室（松岛洞，The Sharp松岛中央公园III）');

-- 일본어 번역
MERGE INTO ITEM_LIST_I18N i18n
USING (SELECT 1 as ITEM_ID, 'ja' as LOCALE FROM DUAL) src
ON (i18n.ITEM_ID = src.ITEM_ID AND i18n.LOCALE = src.LOCALE)
WHEN MATCHED THEN
    UPDATE SET 
        i18n.NAME_LABEL = '2010形成外科クリニック',
        i18n.ADDRESS_LABEL = '仁川広域市延寿区仁川タワー大路180番路11、B-211（ソンド洞、The SharpソンドセントラルパークIII）'
WHEN NOT MATCHED THEN
    INSERT (ITEM_ID, LOCALE, NAME_LABEL, ADDRESS_LABEL)
    VALUES (1, 'ja', '2010形成外科クリニック', '仁川広域市延寿区仁川タワー大路180番路11、B-211（ソンド洞、The SharpソンドセントラルパークIII）');

-- 7. 데이터 확인
SELECT * FROM ITEM_LIST_I18N WHERE ITEM_ID = 1;
