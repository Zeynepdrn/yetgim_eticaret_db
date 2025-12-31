# 🛒 E-Ticaret Satış Analizi | SQL + Power BI Projesi

Bu proje, bir e-ticaret sistemine ait verilerin **PostgreSQL** üzerinde modellenmesi, örnek verilerle doldurulması ve **Power BI** kullanılarak analiz edilip görselleştirilmesini kapsamaktadır.

Projenin amacı; ilişkisel veritabanı tasarımı, SQL sorguları, VIEW kullanımı ve Power BI raporlama süreçlerini uçtan uca uygulamaktır.

---

## 📌 Proje Kapsamı

### 🔹 1. Veritabanı Tasarımı
- E-ticaret senaryosuna uygun **ER Diyagramı** drawSQL kullanılarak oluşturuldu.
- Tablolar arasında **Primary Key** ve **Foreign Key** ilişkileri tanımlandı.
- Veri tekrarını önleyecek şekilde normalize edilmiş yapı kuruldu.

Kullanılan ana tablolar:
- `customers`
- `products`
- `categories`
- `orders`
- `order_details`
- `shipping_addresses`
- `cargo_companies`

---

### 🔹 2. PostgreSQL Tablo Oluşturma
- Tüm tablolar `SERIAL` primary key yapısıyla oluşturuldu.
- Gerekli alanlar için:
  - `UNIQUE` (email)
  - `CHECK` (amount > 0)
  - `NOT NULL`
  - `FOREIGN KEY` kısıtları tanımlandı.
- Para alanları için `DECIMAL`, tarih alanları için `DATE` veri tipleri kullanıldı.

---

### 🔹 3. Dummy Data Ekleme
- Raporların anlamlı olması için **gerçek hayata yakın örnek veriler** eklendi.
- Veriler:
  - Farklı ayları kapsayacak şekilde
  - Kategori ve ürün bazında dağılım oluşturacak şekilde
  - Top 10 ürün, satış trendi ve sepet analizi yapılabilecek biçimde hazırlandı.

---

### 🔹 4. SQL VIEW Oluşturma

Power BI tarafında daha sade, performanslı ve okunabilir veri modeli oluşturmak amacıyla SQL tarafında VIEW’lar oluşturulmuştur.  
Hesaplama gerektiren alanlar (ciro, maliyet ve kâr) SQL tarafında yapılmış, Power BI tarafında ise yalnızca toplulaştırma ve analiz işlemleri gerçekleştirilmiştir.

#### 📊 vw_sales_details
- Sipariş, müşteri, ürün ve kategori tablolarını tek tabloda birleştirir.
- Her sipariş kalemi için satışa ait detayları içerir.
- Aşağıdaki metrikler SQL tarafında hesaplanmıştır:
  - Ciro (revenue)
  - Maliyet (cost)
  - Kâr (profit)
- Power BI raporlarında ana analiz tablosu olarak kullanılmıştır.

#### 📊 vw_monthly_sales
- Sipariş tarihine göre aylık satış özetlerini sunar.
- Aylık bazda toplam:
  - Ciro
  - Maliyet
  - Kâr
  değerlerini içerir.
- Satış trendi analizlerinde (aylık ciro değişimi) kullanılmıştır.

---

## 📊 Power BI Raporlama

Power BI, PostgreSQL veritabanına bağlanarak VIEW’lar üzerinden analiz yapılmıştır.

### Oluşturulan Görseller:

- 📈 **Satış Trendi**
  - Alan Grafiği ile aylık ciro değişimi

- 📊 **En Çok Satan Ürünler**
  - Çubuk Grafik ile Top 10 ürün analizi (ürün adedi bazlı)

- 🗺 **Coğrafi Satış Haritası**
  - Şehirlere göre sipariş yoğunluğu (sipariş sayısı)

- 🌳 **Kategori Kârlılığı**
  - Ağaç Haritası ile kategori bazlı kâr dağılımı

- 🛒 **Sepet Analizi (KPI Kartları)**
  - Ortalama Sepet Tutarı
  - Ortalama Ürün Sayısı
 
- 🎛 **Dilimleyiciler**
  - Müşteri
  - Kategori

---

## 🧮 Kullanılan DAX Ölçülerinden Bazıları

SQL VIEW’lar içerisinde hesaplanan alanlar Power BI tarafında tekrar hesaplanmamış, DAX ölçüleri ile yalnızca toplulaştırma ve oran hesaplamaları yapılmıştır.

```DAX
Toplam Ciro =
SUM ( 'public vw_sales_details'[revenue] )

Sipariş Sayısı =
DISTINCTCOUNT ( 'public vw_sales_details'[order_id] )

Ortalama Sepet Tutarı =
DIVIDE (
    [Toplam Ciro],
    [Sipariş Sayısı]
)



