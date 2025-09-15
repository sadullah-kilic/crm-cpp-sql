-- 0. Müşteri Tablosu
CREATE TABLE IF NOT EXISTS musteri (
    musteri_id INT AUTO_INCREMENT PRIMARY KEY,
    ad VARCHAR(50),
    soyad VARCHAR(50),
    email VARCHAR(150), -- e-posta için biraz daha uzun
    telefon VARCHAR(20)
);

-- 1. İletişim Kayıtları Tablosu
CREATE TABLE IF NOT EXISTS iletisim (
    iletisim_id INT AUTO_INCREMENT PRIMARY KEY,
    musteri_id INT,
    tarih DATETIME,
    konu VARCHAR(255),
    detay TEXT,
    FOREIGN KEY (musteri_id) REFERENCES musteri(musteri_id) ON DELETE CASCADE
);

-- 2. Ürünler Tablosu
CREATE TABLE IF NOT EXISTS urun (
    urun_id INT AUTO_INCREMENT PRIMARY KEY,
    urun_adi VARCHAR(100),
    fiyat DECIMAL(10,2) NOT NULL
);

-- 3. Satış Tablosu
-- toplam_fiyat artık tutulmuyor, dinamik hesaplanacak (SUM ile)
CREATE TABLE IF NOT EXISTS satis (
    satis_id INT AUTO_INCREMENT PRIMARY KEY,
    musteri_id INT,
    satis_tarihi DATETIME DEFAULT NOW(),
    FOREIGN KEY (musteri_id) REFERENCES musteri(musteri_id) ON DELETE CASCADE
);

-- 4. Satış Detayları Tablosu
CREATE TABLE IF NOT EXISTS satis_detay (
    satis_detay_id INT AUTO_INCREMENT PRIMARY KEY,
    satis_id INT,
    urun_id INT,
    adet INT NOT NULL,
    fiyat DECIMAL(10,2) NOT NULL, -- o anki ürün fiyatı
    FOREIGN KEY (satis_id) REFERENCES satis(satis_id) ON DELETE CASCADE,
    FOREIGN KEY (urun_id) REFERENCES urun(urun_id)
);

-- 5. Kullanıcılar Tablosu
-- şifre artık HASH'li şekilde tutulmalı
CREATE TABLE IF NOT EXISTS kullanici (
    kullanici_id INT AUTO_INCREMENT PRIMARY KEY,
    kullanici_adi VARCHAR(50) UNIQUE,
    sifre_hash VARCHAR(255) NOT NULL
);

-- ------------------------------
-- Örnek Veri Ekleme
-- ------------------------------

INSERT INTO musteri (ad, soyad, email, telefon) VALUES
('sadullah', 'kilic', 'muhammetsadullah1@gmail.com', '5551234567');

INSERT INTO iletisim (musteri_id, tarih, konu, detay) VALUES
(1, NOW(), 'Ürün Bilgisi', 'Müşteri ürün hakkında bilgi istedi.');

INSERT INTO urun (urun_adi, fiyat) VALUES
('Ürün A', 150.00),
('Ürün B', 250.50);

INSERT INTO satis (musteri_id) VALUES
(1);

INSERT INTO satis_detay (satis_id, urun_id, adet, fiyat) VALUES
(1, 1, 2, 150.00),
(1, 2, 1, 250.50);

-- şifre hashlenmiş olarak eklenmeli (örnek: SHA2 ile)
INSERT INTO kullanici (kullanici_adi, sifre_hash) VALUES
('admin', SHA2('sifre1234', 256));
