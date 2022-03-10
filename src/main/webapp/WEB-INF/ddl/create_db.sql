-- DB名：aobagift
-- ユーザー名：bsuser
-- パスワード：bsadmin
-- テーブル：USER, MNUS, MHCM , MHRM, MHGM, SITE, MHMM, MHSM, MHEM, MHSE, POINF, GFTCKT, EXCHST, PCINF


-- 旧テーブル削除
DROP TABLE USER;
DROP TABLE MNUS;
DROP TABLE MHCM;
DROP TABLE MHRM;
DROP TABLE MHGM;
DROP TABLE SITE;
DROP TABLE MHMM;
DROP TABLE MHSM;
DROP TABLE MHEM;
DROP TABLE MHSE;
DROP TABLE POINF;
DROP TABLE GFTCKT;
DROP TABLE EXCHST;
DROP TABLE PCINF;



-- USERテーブル
CREATE TABLE USER(
    USERNU int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "ユーザー番号",
    USERID varchar(32) NOT NULL UNIQUE COMMENT "ユーザーID",
    PASSWD varchar(32) NOT NULL COMMENT "パスワード",
    ETDTTM timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "入力日時"
);

INSERT INTO USER(USERID, PASSWD) VALUE('a','a');

-- MNUSテーブル
CREATE TABLE MNUS(
    USERNU int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "ユーザー番号",
    USERID varchar(32) NOT NULL UNIQUE COMMENT "ユーザーID",
    PASSWD varchar(32) NOT NULL COMMENT "パスワード",
    ADMINI boolean NOT NULL COMMENT "スーパーユーザー",
    ACTVFG boolean NOT NULL COMMENT "有効フラグ",
    ETDTTM timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "入力日時"
);

INSERT INTO MNUS(USERID, PASSWD, ADMINI, ACTVFG) VALUE('a','a',true,true);




-- MHCMテーブル
CREATE TABLE MHCM(
    CHNLCD varchar(5) NOT NULL UNIQUE PRIMARY KEY COMMENT "チャネルコード",
    CHNLNM varchar(100) NOT NULL UNIQUE COMMENT "チャネル名",
    ETDTTM timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "入力日時"
);

-- MHRMテーブル
CREATE TABLE MHRM(
    REQUCD varchar(8) NOT NULL UNIQUE PRIMARY KEY COMMENT "依頼者コード",
    CHNLCD varchar(5) NOT NULL COMMENT "チャネルコード",
    REQUNM varchar(100) NOT NULL UNIQUE COMMENT "依頼者名",
    ZIPCOD varchar(8) COMMENT "郵便番号",
    STATNM varchar(100) COMMENT "都道府県",
    CITYNM varchar(100) COMMENT "市区町村",
    STRNO1 varchar(100) COMMENT "番地1",
    STRNO2 varchar(100) COMMENT "番地2",
    PHONE1 varchar(11) COMMENT "電話番号1",
    PHONE2 varchar(11) COMMENT "電話番号2",
    EMLADR varchar(100) NOT NULL COMMENT "メールアドレス",
    BANKCD varchar(4) COMMENT "金融機関コード",
    BANKNM varchar(100) COMMENT "銀行名",
    BRNCCD varchar(3) COMMENT "支店コード",
    BANKBR varchar(100) COMMENT "銀行支店名",
    ACNTTY varchar(1) COMMENT "口座区分",
    ACNTNU varchar(7) COMMENT "口座番号",
    ACNTNM varchar(30) COMMENT "口座名義人",
    ETDTTM timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "入力日時"
);

-- MHGMテーブル
CREATE TABLE MHGM(
    GIFTID varchar(6) NOT NULL UNIQUE PRIMARY KEY COMMENT "ギフトID",
    GIFTNM varchar(100) NOT NULL COMMENT "ギフト名",
    REQULG varchar(1000) COMMENT "ギフトロゴ（依頼者ロゴ）",
    CHNLCD varchar(5) NOT NULL COMMENT "チャネルコード",
    CHNLNM varchar(100) NOT NULL COMMENT "チャネル名",
    REQUCD varchar(8) NOT NULL COMMENT "依頼者コード",
    REQUNM varchar(100) NOT NULL COMMENT "依頼者名",
    ZIPCOD varchar(8) COMMENT "郵便番号",
    STATNM varchar(100) COMMENT "都道府県",
    CITYNM varchar(100) COMMENT "市区町村",
    STRNO1 varchar(100) COMMENT "番地1",
    STRNO2 varchar(100) COMMENT "番地2",
    PHONE1 varchar(11) COMMENT "電話番号1",
    PHONE2 varchar(11) COMMENT "電話番号2",
    EMLADR varchar(100) COMMENT "メールアドレス",
    BANKCD varchar(4) COMMENT "金融機関コード",
    BANKNM varchar(100) COMMENT "銀行名",
    BRNCCD varchar(3) COMMENT "支店コード",
    BANKBR varchar(100) COMMENT "銀行支店名",
    ACNTTY varchar(1) COMMENT "口座区分",
    ACNTNU varchar(7) COMMENT "口座番号",
    ACNTNM varchar(30) COMMENT "口座名義人",
    GIFTPR varchar(100) NOT NULL COMMENT "ギフト価格",
    GIFTLG varchar(1000) COMMENT "ギフト表示商品（ギフトロゴ）",
    SLFNDT varchar(100) COMMENT "販売終了日",
    PAYETY varchar(1) NOT NULL COMMENT "支払い先区分",
    SITEID varchar(6) COMMENT "サイトID",
    COMMNT varchar(8000) COMMENT "コメント",
    ETDTTM timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "入力日時"
);

-- SITEテーブル
CREATE TABLE SITE(
    SITEID varchar(6) NOT NULL UNIQUE PRIMARY KEY COMMENT "サイトID",
    SITENM varchar(100) NOT NULL UNIQUE COMMENT "サイト名",
    REQULG varchar(1000) COMMENT "サイトロゴ（依頼者ロゴ）",
    CHNLCD varchar(5) NOT NULL COMMENT "チャネルコード",
    CHNLNM varchar(100) NOT NULL COMMENT "チャネル名",
    REQUCD varchar(8) NOT NULL COMMENT "依頼者コード",
    REQUNM varchar(100) NOT NULL COMMENT "依頼者名",
    ZIPCOD varchar(8) COMMENT "郵便番号",
    STATNM varchar(100) COMMENT "都道府県",
    CITYNM varchar(100) COMMENT "市区町村",
    STRNO1 varchar(100) COMMENT "番地1",
    STRNO2 varchar(100) COMMENT "番地2",
    PHONE1 varchar(11) COMMENT "電話番号1",
    PHONE2 varchar(11) COMMENT "電話番号2",
    EMLADR varchar(100) COMMENT "メールアドレス",
    BANKCD varchar(4) COMMENT "金融機関コード",
    BANKNM varchar(100) COMMENT "銀行名",
    BRNCCD varchar(3) COMMENT "支店コード",
    BANKBR varchar(100) COMMENT "銀行支店名",
    ACNTTY varchar(1) COMMENT "口座区分",
    ACNTNU varchar(7) COMMENT "口座番号",
    ACNTNM varchar(30) COMMENT "口座名義人",
    USERID varchar(32) NOT NULL UNIQUE COMMENT "ユーザーID",
    PASSWD varchar(32) NOT NULL COMMENT "パスワード",
    AMOUNT varchar(100) NOT NULL COMMENT "金額",
    STSPDT varchar(100) COMMENT "サイト新規使用停止日",
    AOBEML varchar(100) NOT NULL COMMENT "青葉ギフト宛メールアドレス",
    COMMNT varchar(8000) COMMENT "コメント",
    ETDTTM timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "入力日時"
);

-- MHSMテーブル
CREATE TABLE MHSM(
    SHOPCD varchar(10) NOT NULL UNIQUE PRIMARY KEY COMMENT "ショップコード",
    CHNLCD varchar(5) NOT NULL COMMENT "チャネルコード",
    CHNLNM varchar(100) NOT NULL COMMENT "チャネル名",
    SHOPNM varchar(100) NOT NULL COMMENT "ショップ名",
    SHOPNF varchar(100) COMMENT "ショップ名フリガナ",
    ZIPCOD varchar(8) COMMENT "郵便番号",
    STATNM varchar(100) COMMENT "都道府県",
    CITYNM varchar(100) COMMENT "市区町村",
    STRNO1 varchar(100) COMMENT "番地1",
    STRNO2 varchar(100) COMMENT "番地2",
    PHONE1 varchar(11) COMMENT "電話番号1",
    PHONE2 varchar(11) COMMENT "電話番号2",
    EMLADR varchar(100) NOT NULL COMMENT "メールアドレス",
    BANKCD varchar(4) COMMENT "金融機関コード",
    BANKNM varchar(100) COMMENT "銀行名",
    BRNCCD varchar(3) COMMENT "支店コード",
    BANKBR varchar(100) COMMENT "銀行支店名",
    ACNTTY varchar(1) COMMENT "口座区分",
    ACNTNU varchar(7) COMMENT "口座番号",
    ACNTNM varchar(30) COMMENT "口座名義人",
    SPCADR varchar(100) COMMENT "明細書送付先メールアドレス",
    COMMNT varchar(8000) COMMENT "コメント",
    ETDTTM timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "入力日時"
);

-- MHMMテーブル
CREATE TABLE MHMM(
    MERCCD varchar(10) NOT NULL UNIQUE PRIMARY KEY COMMENT "商品コード",
    SITEID varchar(6) NOT NULL COMMENT "サイトID",
    MERCNM varchar(100) NOT NULL COMMENT "商品名",
    MERCLG varchar(1000) COMMENT "商品画像",
    COMMNT varchar(8000) COMMENT "コメント",
    ETDTTM timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "入力日時"
);

-- MHEMテーブル
CREATE TABLE MHEM(
    EXSHNU int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "番号",
    MERCCD varchar(10) NOT NULL COMMENT "商品コード",
    SHOPCD varchar(10) NOT NULL COMMENT "ショップコード",
    EXCHTM int UNSIGNED DEFAULT 0 NOT NULL COMMENT "商品交換回数",
    ETDTTM timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "入力日時"
);

-- MHSEテーブル
CREATE TABLE MHSE(
    EXSHNU int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "番号",
    GIFTID varchar(6) NOT NULL COMMENT "ギフトID",
    SHOPCD varchar(10) NOT NULL COMMENT "ショップコード",
    EXCHTM int UNSIGNED DEFAULT 0 NOT NULL COMMENT "商品交換回数",
    ETDTTM timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "入力日時"
);

-- POINFテーブル
CREATE TABLE POINF(
    POCD varchar(5) NOT NULL PRIMARY KEY COMMENT "注文コード",
    GIFTID varchar(10) NOT NULL COMMENT "ギフトID",
    SITEID varchar(6) COMMENT "サイトID",
    PCCD varchar(6) NOT NULL COMMENT "購入者コード",
    TCKTNUM int unsigned DEFAULT 0 COMMENT "チケット発行枚数",
    VLDDT date NOT NULL COMMENT "有効期限日"
);

-- GFTCKTテーブル
CREATE TABLE GFTCKT(
    TCKTCD varchar(12) NOT NULL PRIMARY KEY COMMENT "チケットコード",
    POCD varchar(5) NOT NULL COMMENT "注文コード",
    TCKTNO varchar(6) NOT NULL COMMENT "チケットナンバー",
    URL varchar(500) NOT NULL COMMENT "ギフトURL",
    STATUS varchar(1) NOT NULL DEFAULT 0 COMMENT "使用状況"
);

-- EXCHSTテーブル
CREATE TABLE EXCHST(
    EXCID int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "交換ID",
    TCKTCD varchar(12) NOT NULL COMMENT "チケットコード",
    EXCMTHD varchar(1) NOT NULL COMMENT "交換方法",
    SHOPCD varchar(10) COMMENT "交換店舗のショップコード",
    MERCCD varchar(10) COMMENT "交換商品コード",
    EXCDT datetime NOT NULL COMMENT "交換日時"
);

-- PCINFテーブル
CREATE TABLE PCINF(
    PCCD varchar(6) NOT NULL PRIMARY KEY COMMENT "購入者コード",
    CORPLG varchar(1000) COMMENT "購入者ロゴ",
    CORPNM varchar(100) COMMENT "法人名",
    CORPNF varchar(100) COMMENT "法人名フリガナ",
    ZIPCOD varchar(8) COMMENT "郵便番号",
    STATNM varchar(100) COMMENT "都道府県",
    CITYNM varchar(100) COMMENT "市区町村",
    STRNO1 varchar(100) COMMENT "番地１",
    STRNO2 varchar(100) COMMENT "番地２",
    PHONE1 varchar(11) COMMENT "電話番号１",
    PHONE2 varchar(11) COMMENT "電話番号２",
    EMLADR varchar(100) COMMENT "メールアドレス",
    BANKCD varchar(4) COMMENT "金融機関コード",
    BANKNM varchar(100) COMMENT "銀行名",
    BRNCCD varchar(3) COMMENT "支店コード",
    BANKBR varchar(100) COMMENT "銀行支店名",
    ACNTTY varchar(1) COMMENT "口座区分",
    ACNTNU varchar(7) COMMENT "口座番号",
    ACNTNM varchar(30) COMMENT "口座名義人",
    ETDTTM timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "入力日時"
);
