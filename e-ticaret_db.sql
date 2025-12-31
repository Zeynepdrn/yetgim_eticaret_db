-- ######################################################
-- TABLO OLUŞTURMA
-- ######################################################
CREATE TABLE "customers" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "surname" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "register_date" DATE NOT NULL,
    "city" VARCHAR(255) NOT NULL,
    "country" VARCHAR(255) NOT NULL
);

ALTER TABLE
    "customers" ADD PRIMARY KEY ("id");

ALTER TABLE
    "customers" ADD CONSTRAINT "customers_email_unique" UNIQUE ("email");


CREATE TABLE "products" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "purchase_price" DECIMAL(10, 2) NOT NULL,
    "sale_price" DECIMAL(10, 2) NOT NULL,
    "stock" INTEGER NOT NULL,
    "category_id" INTEGER NOT NULL
);

ALTER TABLE
    "products" ADD PRIMARY KEY ("id");


CREATE TABLE "orders" (
    "id" SERIAL NOT NULL,
    "order_date" DATE NOT NULL,
    "cargo_company_id" INTEGER NOT NULL,
    "status" VARCHAR(255) NOT NULL,
    "customer_id" INTEGER NOT NULL,
    "shipping_address_id" INTEGER NOT NULL
);

ALTER TABLE
    "orders" ADD PRIMARY KEY ("id");


CREATE TABLE "order_details" (
    "id" SERIAL NOT NULL,
    "amount" INTEGER NOT NULL,
    "unit_price" DECIMAL(10, 2) NOT NULL,
    "discount_rate" DECIMAL(5, 2) DEFAULT 0,
    "purchase_price" DECIMAL(10, 2) NOT NULL,
    "product_id" INTEGER NOT NULL,
    "order_id" INTEGER NOT NULL
);

ALTER TABLE
    "order_details" ADD PRIMARY KEY ("id");

ALTER TABLE
    "order_details"
    ADD CONSTRAINT "order_details_amount_check"
    CHECK ("amount" > 0);


CREATE TABLE "categories" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" TEXT NOT NULL
);

ALTER TABLE
    "categories" ADD PRIMARY KEY ("id");


CREATE TABLE "cargo_companies" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL
);

ALTER TABLE
    "cargo_companies" ADD PRIMARY KEY ("id");


CREATE TABLE "shipping_addresses" (
    "id" SERIAL NOT NULL,
    "city" VARCHAR(255) NOT NULL,
    "country" VARCHAR(255) NOT NULL,
    "open_address" TEXT NOT NULL,
    "zip_code" VARCHAR(255) NOT NULL
);

ALTER TABLE
    "shipping_addresses" ADD PRIMARY KEY ("id");


ALTER TABLE
    "order_details"
    ADD CONSTRAINT "order_details_product_id_foreign"
    FOREIGN KEY ("product_id") REFERENCES "products" ("id");

ALTER TABLE
    "order_details"
    ADD CONSTRAINT "order_details_order_id_foreign"
    FOREIGN KEY ("order_id") REFERENCES "orders" ("id");

ALTER TABLE
    "products"
    ADD CONSTRAINT "products_category_id_foreign"
    FOREIGN KEY ("category_id") REFERENCES "categories" ("id");

ALTER TABLE
    "orders"
    ADD CONSTRAINT "orders_cargo_company_id_foreign"
    FOREIGN KEY ("cargo_company_id") REFERENCES "cargo_companies" ("id");

ALTER TABLE
    "orders"
    ADD CONSTRAINT "orders_customer_id_foreign"
    FOREIGN KEY ("customer_id") REFERENCES "customers" ("id");

ALTER TABLE
    "orders"
    ADD CONSTRAINT "orders_shipping_address_id_foreign"
    FOREIGN KEY ("shipping_address_id") REFERENCES "shipping_addresses" ("id");

-- ######################################################
-- DUMMY DATA EKLEME
-- ######################################################
INSERT INTO categories (name, description) VALUES
('Elektronik', 'Telefon, bilgisayar ve elektronik ürünler'),
('Giyim', 'Erkek ve kadın giyim ürünleri'),
('Kitap', 'Basılı kitap ve eğitim materyalleri'),
('Ev & Yaşam', 'Ev eşyaları ve yaşam ürünleri');

INSERT INTO cargo_companies (name) VALUES
('Yurtiçi Kargo'),
('Aras Kargo'),
('MNG Kargo'),
('PTT Kargo');

INSERT INTO customers (name, surname, email, register_date, city, country) VALUES
('Ahmet', 'Yılmaz', 'ahmet@gmail.com', '2023-01-10', 'İstanbul', 'Türkiye'),
('Ayşe', 'Demir', 'ayse@gmail.com', '2023-02-15', 'Ankara', 'Türkiye'),
('Mehmet', 'Kaya', 'mehmet@gmail.com', '2023-03-20', 'İzmir', 'Türkiye'),
('Elif', 'Çelik', 'elif@gmail.com', '2023-04-05', 'Bursa', 'Türkiye'),
('Can', 'Aydın', 'can@gmail.com', '2023-05-12', 'İstanbul', 'Türkiye'),
('Zeynep', 'Koç', 'zeynep@gmail.com', '2023-06-18', 'Antalya', 'Türkiye'),
('Burak', 'Şahin', 'burak@gmail.com', '2023-07-25', 'Konya', 'Türkiye'),
('Ece', 'Öztürk', 'ece@gmail.com', '2023-08-02', 'İstanbul', 'Türkiye'),
('Emre', 'Arslan', 'emre@gmail.com', '2023-09-14', 'Adana', 'Türkiye'),
('Seda', 'Güneş', 'seda@gmail.com', '2023-10-30', 'İzmir', 'Türkiye');

INSERT INTO shipping_addresses (city, country, open_address, zip_code) VALUES
('İstanbul', 'Türkiye', 'Kadıköy Moda Mah.', '34710'),
('Ankara', 'Türkiye', 'Çankaya Kızılay', '06420'),
('İzmir', 'Türkiye', 'Bornova Merkez', '35040'),
('Bursa', 'Türkiye', 'Nilüfer FSM Bulvarı', '16120'),
('Antalya', 'Türkiye', 'Muratpaşa Lara', '07230'),
('Konya', 'Türkiye', 'Selçuklu Yazır', '42060');

INSERT INTO products (name, purchase_price, sale_price, stock, category_id) VALUES
('iPhone 14', 25000, 32000, 50, 1),
('Laptop', 18000, 24000, 40, 1),
('Bluetooth Kulaklık', 800, 1500, 150, 1),
('Akıllı Saat', 1200, 2500, 100, 1),

('Kot Pantolon', 400, 900, 200, 2),
('Tişört', 150, 400, 300, 2),
('Mont', 900, 1800, 80, 2),

('Roman Kitap', 80, 200, 500, 3),
('Teknik Kitap', 120, 350, 250, 3),

('Kahve Makinesi', 1500, 2600, 60, 4),
('Elektrikli Süpürge', 3000, 5200, 30, 4);

INSERT INTO orders (order_date, cargo_company_id, status, customer_id, shipping_address_id) VALUES
('2024-01-10', 1, 'Teslim Edildi', 1, 1),
('2024-02-14', 2, 'Teslim Edildi', 2, 2),
('2024-03-05', 3, 'Teslim Edildi', 3, 3),
('2024-03-28', 1, 'Teslim Edildi', 4, 4),
('2024-04-12', 2, 'Teslim Edildi', 5, 1),
('2024-05-20', 4, 'Teslim Edildi', 6, 5),
('2024-06-18', 3, 'Teslim Edildi', 7, 6),
('2024-07-07', 1, 'Teslim Edildi', 8, 1),
('2024-08-25', 2, 'Teslim Edildi', 9, 3),
('2024-09-14', 4, 'Teslim Edildi', 10, 3),
('2024-10-30', 1, 'Teslim Edildi', 1, 1),
('2024-11-11', 3, 'Teslim Edildi', 2, 2),
('2024-12-22', 2, 'Teslim Edildi', 5, 1);

INSERT INTO order_details
(amount, unit_price, discount_rate, purchase_price, product_id, order_id)
VALUES
-- Elektronik yoğun
(1, 32000, 0, 25000, 1, 1),
(2, 1500, 0, 800, 3, 1),

(1, 24000, 0, 18000, 2, 2),
(1, 2500, 0, 1200, 4, 2),

(3, 400, 0, 150, 6, 3),
(1, 900, 0, 400, 5, 3),

(1, 1800, 0, 900, 7, 4),

-- Kitap sepetleri
(2, 200, 0, 80, 8, 5),
(1, 350, 0, 120, 9, 5),

-- Ev & yaşam
(1, 2600, 0, 1500, 10, 6),
(1, 5200, 0, 3000, 11, 6),

-- Büyük sepet
(1, 32000, 0, 25000, 1, 7),
(2, 900, 0, 400, 5, 7),
(3, 200, 0, 80, 8, 7),

-- Yıl sonu patlaması
(2, 32000, 0, 25000, 1, 13),
(1, 24000, 0, 18000, 2, 13),
(2, 1500, 0, 800, 3, 13);

-- ######################################################
-- VIEW OLUŞTURMA
-- ######################################################
-- Satış Detay View
CREATE VIEW vw_sales_details AS
SELECT
    o.id AS order_id,
    o.order_date,
    c.id AS customer_id,
    c.city AS customer_city,
    p.id AS product_id,
    p.name AS product_name,
    cat.name AS category_name,
    od.amount,
    od.unit_price,
    od.purchase_price,
    od.discount_rate,
    (od.amount * od.unit_price) AS revenue,
    (od.amount * od.purchase_price) AS cost,
    (od.amount * od.unit_price) - (od.amount * od.purchase_price) AS profit
FROM order_details od
JOIN orders o ON od.order_id = o.id
JOIN customers c ON o.customer_id = c.id
JOIN products p ON od.product_id = p.id
JOIN categories cat ON p.category_id = cat.id;

-- Aylık Satış Özet View
CREATE VIEW vw_monthly_sales AS
SELECT
    DATE_TRUNC('month', o.order_date) AS sales_month,
    SUM(od.amount * od.unit_price) AS total_revenue,
    SUM(od.amount * od.purchase_price) AS total_cost,
    SUM((od.amount * od.unit_price) - (od.amount * od.purchase_price)) AS total_profit
FROM orders o
JOIN order_details od ON o.id = od.order_id
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY sales_month;
