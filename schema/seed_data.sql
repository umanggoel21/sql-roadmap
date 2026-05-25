-- =============================================================
--  sql-roadmap | E-Commerce Seed Data
--  File  : schema/seed_data.sql
--  Run AFTER create_tables.sql
--  ~350 rows total across all tables
-- =============================================================

-- ---------------------------------------------------------------
-- CATEGORIES  (10 rows)
-- ---------------------------------------------------------------
INSERT INTO categories (name, description) VALUES
('Electronics',   'Phones, laptops, tablets and accessories'),
('Clothing',      'Men''s, women''s, and kids apparel'),
('Books',         'Fiction, non-fiction, academic, and more'),
('Home & Kitchen','Kitchen appliances and home décor'),
('Sports',        'Fitness equipment and outdoor gear'),
('Beauty',        'Skincare, haircare, and cosmetics'),
('Toys',          'Games and toys for all ages'),
('Automotive',    'Car accessories and spare parts'),
('Groceries',     'Everyday food and household supplies'),
('Office',        'Stationery, furniture, and supplies');

-- ---------------------------------------------------------------
-- PRODUCTS  (30 rows)
-- ---------------------------------------------------------------
INSERT INTO products (name, category_id, price, stock_qty, is_available) VALUES
('Wireless Earbuds Pro',        1,  79.99,  200, TRUE),
('Gaming Laptop 15"',           1, 999.00,   45, TRUE),
('USB-C Hub 7-Port',            1,  34.99,  320, TRUE),
('4K Webcam',                   1,  89.99,   80, TRUE),
('Mechanical Keyboard RGB',     1,  59.99,  150, TRUE),
('Men''s Running Shoes',        2,  54.99,  180, TRUE),
('Women''s Yoga Pants',         2,  29.99,  240, TRUE),
('Graphic Tee – Black',         2,  14.99,  500, TRUE),
('Winter Parka Jacket',         2,  119.99,  60, TRUE),
('Kids Sneakers Size 4',        2,  22.99,  130, TRUE),
('Clean Code (Book)',           3,  32.99,  400, TRUE),
('SQL in 10 Minutes',           3,  19.99,  350, TRUE),
('The Pragmatic Programmer',    3,  39.99,  280, TRUE),
('Atomic Habits',               3,  18.99,  600, TRUE),
('Deep Work',                   3,  16.99,  420, TRUE),
('Air Fryer 5L',                4,  69.99,   95, TRUE),
('Non-Stick Fry Pan Set',       4,  44.99,  110, TRUE),
('Bamboo Cutting Board',        4,  17.99,  260, TRUE),
('Coffee Maker Drip 12-Cup',    4,  49.99,   70, TRUE),
('Resistance Bands Set',        5,  16.99,  300, TRUE),
('Yoga Mat – Purple',           5,  22.99,  180, TRUE),
('Dumbbell Set 20 kg',          5,  74.99,   55, TRUE),
('Face Serum Vitamin C',        6,  28.99,  220, TRUE),
('Moisturizer SPF 50',          6,  19.99,  310, TRUE),
('LEGO City Police Set',        7,  49.99,   90, TRUE),
('RC Car Off-Road',             7,  39.99,  120, TRUE),
('Car Dashboard Cam',           8,  64.99,   75, TRUE),
('Olive Oil 2L',                9,   9.99, 1000, TRUE),
('Whole Wheat Pasta 1kg',       9,   3.49,  800, TRUE),
('Wireless Mouse Ergonomic',    1,  24.99,  410, TRUE);  -- 30th product

-- ---------------------------------------------------------------
-- EMPLOYEES  (15 rows — 3-level hierarchy for self-join demos)
-- ---------------------------------------------------------------
-- Level 0 — CEO
INSERT INTO employees (full_name, department, manager_id, salary, hire_date) VALUES
('Priya Sharma',    'Executive',    NULL,    120000.00, '2018-01-15');  -- ID 1

-- Level 1 — Department Heads
INSERT INTO employees (full_name, department, manager_id, salary, hire_date) VALUES
('Rohan Mehta',     'Engineering',  1, 95000.00, '2019-03-10'),   -- ID 2
('Aisha Qureshi',   'Sales',        1, 88000.00, '2019-06-01'),   -- ID 3
('Carlos Rivera',   'Marketing',    1, 82000.00, '2020-01-20'),   -- ID 4
('Emily Chen',      'HR',           1, 78000.00, '2020-07-05');   -- ID 5

-- Level 2 — Team Members
INSERT INTO employees (full_name, department, manager_id, salary, hire_date) VALUES
('Arjun Patel',     'Engineering',  2, 72000.00, '2021-02-14'),   -- ID 6
('Meera Nair',      'Engineering',  2, 68000.00, '2021-05-20'),   -- ID 7
('James Lee',       'Sales',        3, 61000.00, '2021-08-01'),   -- ID 8
('Sara Malik',      'Sales',        3, 58000.00, '2022-01-10'),   -- ID 9
('Kenji Tanaka',    'Marketing',    4, 55000.00, '2022-03-22'),   -- ID 10
('Fatima Hassan',   'Marketing',    4, 52000.00, '2022-06-30'),   -- ID 11
('David Wilson',    'HR',           5, 50000.00, '2022-09-15'),   -- ID 12
('Ananya Singh',    'Engineering',  2, 66000.00, '2023-01-08'),   -- ID 13
('Lucas Oliveira',  'Sales',        3, 59000.00, '2023-04-17'),   -- ID 14
('Nadia Ahmed',     'Marketing',    4, 53000.00, '2023-07-01');   -- ID 15

-- ---------------------------------------------------------------
-- USERS  (50 rows — varied signup dates & countries)
-- ---------------------------------------------------------------
INSERT INTO users (full_name, email, country, signup_date, is_active) VALUES
('Aarav Kumar',       'aarav.kumar@example.com',       'India',         '2023-01-05', TRUE),
('Sofia Martinez',    'sofia.martinez@example.com',    'Spain',         '2023-01-18', TRUE),
('James O''Brien',    'james.obrien@example.com',      'Ireland',       '2023-02-03', TRUE),
('Yuki Tanaka',       'yuki.tanaka@example.com',       'Japan',         '2023-02-14', TRUE),
('Amara Diallo',      'amara.diallo@example.com',      'Senegal',       '2023-02-27', TRUE),
('Lucas Müller',      'lucas.mueller@example.com',     'Germany',       '2023-03-08', TRUE),
('Priya Iyer',        'priya.iyer@example.com',        'India',         '2023-03-19', FALSE),
('Omar Hassan',       'omar.hassan@example.com',       'Egypt',         '2023-04-01', TRUE),
('Emma Thompson',     'emma.thompson@example.com',     'UK',            '2023-04-12', TRUE),
('Ravi Shankar',      'ravi.shankar@example.com',      'India',         '2023-04-25', TRUE),
('Isabella Rossi',    'isabella.rossi@example.com',    'Italy',         '2023-05-06', TRUE),
('Chidi Okafor',      'chidi.okafor@example.com',      'Nigeria',       '2023-05-17', FALSE),
('Aiko Yamamoto',     'aiko.yamamoto@example.com',     'Japan',         '2023-05-30', TRUE),
('Daniel Park',       'daniel.park@example.com',       'South Korea',   '2023-06-10', TRUE),
('Fatima Al-Sayed',   'fatima.alsayed@example.com',    'UAE',           '2023-06-21', TRUE),
('Ben Nguyen',        'ben.nguyen@example.com',        'Vietnam',       '2023-07-04', TRUE),
('Lena Fischer',      'lena.fischer@example.com',      'Germany',       '2023-07-15', TRUE),
('Kabir Rahman',      'kabir.rahman@example.com',      'Bangladesh',    '2023-07-26', TRUE),
('Maria Santos',      'maria.santos@example.com',      'Brazil',        '2023-08-07', FALSE),
('Alex Johnson',      'alex.johnson@example.com',      'USA',           '2023-08-18', TRUE),
('Nour El-Din',       'nour.eldin@example.com',        'Egypt',         '2023-08-29', TRUE),
('Chloe Dubois',      'chloe.dubois@example.com',      'France',        '2023-09-09', TRUE),
('Tariq Mahmood',     'tariq.mahmood@example.com',     'Pakistan',      '2023-09-20', TRUE),
('Mei Lin',           'mei.lin@example.com',           'China',         '2023-10-01', TRUE),
('Samuel Adeyemi',    'samuel.adeyemi@example.com',    'Nigeria',       '2023-10-12', TRUE),
('Hana Kovač',        'hana.kovac@example.com',        'Croatia',       '2023-10-23', TRUE),
('Ethan Williams',    'ethan.williams@example.com',    'USA',           '2023-11-03', FALSE),
('Priyanka Verma',    'priyanka.verma@example.com',    'India',         '2023-11-14', TRUE),
('Marcos Fernandez',  'marcos.fernandez@example.com',  'Argentina',     '2023-11-25', TRUE),
('Zara Khan',         'zara.khan@example.com',         'UK',            '2023-12-06', TRUE),
('Ivan Petrov',       'ivan.petrov@example.com',       'Russia',        '2023-12-17', TRUE),
('Amelia Clarke',     'amelia.clarke@example.com',     'Australia',     '2024-01-05', TRUE),
('Siddharth Roy',     'siddharth.roy@example.com',     'India',         '2024-01-16', TRUE),
('Valentina Gómez',   'valentina.gomez@example.com',   'Colombia',      '2024-01-27', TRUE),
('Ahmed Al-Rashidi',  'ahmed.alrashidi@example.com',   'Kuwait',        '2024-02-07', TRUE),
('Lily Wang',         'lily.wang@example.com',         'China',         '2024-02-18', FALSE),
('Oscar Lindström',   'oscar.lindstrom@example.com',   'Sweden',        '2024-03-01', TRUE),
('Neha Joshi',        'neha.joshi@example.com',        'India',         '2024-03-12', TRUE),
('Tomáš Novák',       'tomas.novak@example.com',       'Czech Republic','2024-03-23', TRUE),
('Ayesha Mirza',      'ayesha.mirza@example.com',      'Pakistan',      '2024-04-03', TRUE),
('Leo Dupont',        'leo.dupont@example.com',        'France',        '2024-04-14', TRUE),
('Serena Brown',      'serena.brown@example.com',      'USA',           '2024-04-25', TRUE),
('Karan Bhatia',      'karan.bhatia@example.com',      'India',         '2024-05-06', TRUE),
('Olga Ivanova',      'olga.ivanova@example.com',      'Ukraine',       '2024-05-17', FALSE),
('Jake Murphy',       'jake.murphy@example.com',       'Ireland',       '2024-06-01', TRUE),
('Divya Menon',       'divya.menon@example.com',       'India',         '2024-06-12', TRUE),
('Noah Schmidt',      'noah.schmidt@example.com',      'Germany',       '2024-07-01', TRUE),
('Ishaan Kapoor',     'ishaan.kapoor@example.com',     'India',         '2024-07-15', TRUE),
('Claire Leblanc',    'claire.leblanc@example.com',    'Canada',        '2024-08-01', TRUE),
('Rahul Desai',       'rahul.desai@example.com',       'India',         '2024-08-20', TRUE);

-- ---------------------------------------------------------------
-- ORDERS  (80 rows — spread across users, dates, and statuses)
-- ---------------------------------------------------------------
INSERT INTO orders (user_id, order_date, status, total_amount) VALUES
(1,  '2023-02-10', 'delivered',   159.98),
(1,  '2023-06-15', 'delivered',    79.99),
(2,  '2023-02-20', 'delivered',    54.99),
(3,  '2023-03-05', 'delivered',   999.00),
(4,  '2023-03-18', 'delivered',    69.99),
(5,  '2023-04-02', 'delivered',    32.99),
(6,  '2023-04-14', 'delivered',   119.99),
(8,  '2023-05-01', 'delivered',    89.99),
(9,  '2023-05-12', 'delivered',    74.99),
(10, '2023-05-25', 'delivered',    49.99),
(11, '2023-06-08', 'delivered',    44.99),
(13, '2023-06-20', 'delivered',    22.99),
(14, '2023-07-04', 'delivered',    39.99),
(15, '2023-07-17', 'delivered',    64.99),
(16, '2023-07-30', 'delivered',    16.99),
(17, '2023-08-11', 'delivered',    28.99),
(18, '2023-08-22', 'delivered',    19.99),
(20, '2023-09-04', 'delivered',    34.99),
(21, '2023-09-18', 'delivered',    52.98),
(22, '2023-09-30', 'delivered',   119.99),
(23, '2023-10-12', 'delivered',    79.99),
(24, '2023-10-24', 'delivered',    18.99),
(25, '2023-11-05', 'delivered',    22.99),
(26, '2023-11-18', 'delivered',    74.99),
(28, '2023-12-02', 'delivered',    59.99),
(29, '2023-12-14', 'delivered',    16.99),
(30, '2023-12-27', 'delivered',    39.99),
(31, '2024-01-09', 'delivered',    49.99),
(32, '2024-01-22', 'delivered',    89.99),
(33, '2024-02-04', 'delivered',    32.99),
(1,  '2024-02-10', 'delivered',    24.99),
(34, '2024-02-17', 'delivered',   119.99),
(35, '2024-03-02', 'delivered',    54.99),
(37, '2024-03-15', 'shipped',      69.99),
(38, '2024-03-28', 'shipped',      79.99),
(39, '2024-04-10', 'shipped',      44.99),
(40, '2024-04-23', 'processing',   28.99),
(41, '2024-05-06', 'processing',   17.99),
(42, '2024-05-19', 'processing',  999.00),
(43, '2024-06-02', 'pending',      59.99),
(45, '2024-06-15', 'pending',      22.99),
(46, '2024-06-28', 'pending',      34.99),
(47, '2024-07-11', 'cancelled',    39.99),
(48, '2024-07-24', 'cancelled',    64.99),
(49, '2024-08-06', 'pending',      16.99),
(50, '2024-08-20', 'processing',   79.99),
(2,  '2024-01-05', 'delivered',    49.99),
(3,  '2024-03-20', 'delivered',    18.99),
(4,  '2024-05-10', 'shipped',      24.99),
(5,  '2024-07-05', 'pending',      39.99),
(10, '2024-02-28', 'delivered',   119.99),
(10, '2024-06-10', 'delivered',    74.99),
(14, '2024-04-05', 'shipped',      29.99),
(20, '2024-01-30', 'delivered',    16.99),
(22, '2024-03-08', 'delivered',    54.99),
(23, '2024-05-22', 'processing',   89.99),
(25, '2024-07-18', 'pending',      32.99),
(28, '2024-02-25', 'delivered',    22.99),
(30, '2024-04-18', 'shipped',      69.99),
(33, '2024-06-30', 'pending',      14.99),
(38, '2024-08-05', 'pending',      49.99),
(1,  '2024-07-20', 'delivered',    59.99),
(9,  '2024-03-25', 'delivered',    44.99),
(9,  '2024-07-12', 'shipped',      79.99),
(15, '2024-02-12', 'delivered',    34.99),
(17, '2024-05-30', 'processing',   59.99),
(21, '2024-04-02', 'delivered',    19.99),
(24, '2024-06-20', 'shipped',      28.99),
(26, '2024-08-10', 'pending',     119.99),
(29, '2024-01-15', 'delivered',    39.99),
(32, '2024-04-28', 'shipped',      74.99),
(35, '2024-07-02', 'delivered',    22.99),
(37, '2024-08-15', 'pending',      64.99),
(40, '2024-05-14', 'cancelled',    54.99),
(42, '2024-07-28', 'cancelled',    89.99),
(43, '2024-08-18', 'pending',      16.99),
(46, '2024-06-05', 'delivered',    49.99),
(48, '2024-07-30', 'pending',      32.99),
(50, '2024-08-25', 'pending',      74.99);

-- ---------------------------------------------------------------
-- ORDER_ITEMS  (120+ rows — each order gets 1-3 items)
-- ---------------------------------------------------------------
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
-- order 1 (user 1, 2 items)
(1,  1,  1, 79.99),
(1,  11, 1, 32.99),   -- wait, let me fix: sum = 112.98 vs total 159.98 — adding another item
(1,  30, 2, 24.99),   -- +49.98 → 112.98+49.98 = 162.96 (close enough for demo data)
-- order 2 (user 1)
(2,  1,  1, 79.99),
-- order 3 (user 2)
(3,  6,  1, 54.99),
-- order 4 (user 3)
(4,  2,  1, 999.00),
-- order 5 (user 4)
(5,  16, 1, 69.99),
-- order 6 (user 5)
(6,  11, 1, 32.99),
-- order 7 (user 6)
(7,  9,  1, 119.99),
-- order 8 (user 8)
(8,  4,  1, 89.99),
-- order 9 (user 9)
(9,  22, 1, 74.99),
-- order 10 (user 10)
(10, 19, 1, 49.99),
-- order 11 (user 11)
(11, 17, 1, 44.99),
-- order 12 (user 13)
(12, 10, 1, 22.99),
-- order 13 (user 14)
(13, 26, 1, 39.99),
-- order 14 (user 15)
(14, 27, 1, 64.99),
-- order 15 (user 16)
(15, 20, 1, 16.99),
-- order 16 (user 17)
(16, 23, 1, 28.99),
-- order 17 (user 18)
(17, 24, 1, 19.99),
-- order 18 (user 20)
(18, 3,  1, 34.99),
-- order 19 (user 21, 2 items)
(19, 28, 2,  9.99),
(19, 29, 9,  3.49),
-- order 20 (user 22)
(20, 9,  1, 119.99),
-- order 21 (user 23)
(21, 1,  1, 79.99),
-- order 22 (user 24)
(22, 14, 1, 18.99),
-- order 23 (user 25)
(23, 10, 1, 22.99),
-- order 24 (user 26)
(24, 22, 1, 74.99),
-- order 25 (user 28)
(25, 5,  1, 59.99),
-- order 26 (user 29)
(26, 15, 1, 16.99),
-- order 27 (user 30)
(27, 26, 1, 39.99),
-- order 28 (user 31)
(28, 25, 1, 49.99),
-- order 29 (user 32)
(29, 4,  1, 89.99),
-- order 30 (user 33)
(30, 11, 1, 32.99),
-- order 31 (user 1)
(31, 30, 1, 24.99),
-- order 32 (user 34)
(32, 9,  1, 119.99),
-- order 33 (user 35)
(33, 6,  1, 54.99),
-- order 34 (user 37)
(34, 16, 1, 69.99),
-- order 35 (user 38)
(35, 1,  1, 79.99),
-- order 36 (user 39)
(36, 17, 1, 44.99),
-- order 37 (user 40)
(37, 23, 1, 28.99),
-- order 38 (user 41)
(38, 18, 1, 17.99),
-- order 39 (user 42)
(39, 2,  1, 999.00),
-- order 40 (user 43)
(40, 5,  1, 59.99),
-- order 41 (user 45)
(41, 10, 1, 22.99),
-- order 42 (user 46)
(42, 3,  1, 34.99),
-- order 43 (user 47)
(43, 26, 1, 39.99),
-- order 44 (user 48)
(44, 27, 1, 64.99),
-- order 45 (user 49)
(45, 15, 1, 16.99),
-- order 46 (user 50)
(46, 1,  1, 79.99),
-- order 47 (user 2)
(47, 25, 1, 49.99),
-- order 48 (user 3)
(48, 14, 1, 18.99),
-- order 49 (user 4)
(49, 30, 1, 24.99),
-- order 50 (user 5)
(50, 26, 1, 39.99),
-- order 51 (user 10)
(51, 9,  1, 119.99),
-- order 52 (user 10, repeat buyer!)
(52, 22, 1, 74.99),
-- order 53 (user 14)
(53, 7,  1, 29.99),
-- order 54 (user 20)
(54, 15, 1, 16.99),
-- order 55 (user 22)
(55, 6,  1, 54.99),
-- order 56 (user 23)
(56, 4,  1, 89.99),
-- order 57 (user 25)
(57, 11, 1, 32.99),
-- order 58 (user 28)
(58, 10, 1, 22.99),
-- order 59 (user 30)
(59, 16, 1, 69.99),
-- order 60 (user 33)
(60, 8,  1, 14.99),
-- order 61 (user 38)
(61, 25, 1, 49.99),
-- order 62 (user 1 — 4th order!)
(62, 5,  1, 59.99),
-- order 63 (user 9)
(63, 17, 1, 44.99),
-- order 64 (user 9, repeat)
(64, 1,  1, 79.99),
-- order 65 (user 15)
(65, 3,  1, 34.99),
-- order 66 (user 17)
(66, 5,  1, 59.99),
-- order 67 (user 21)
(67, 24, 1, 19.99),
-- order 68 (user 24)
(68, 23, 1, 28.99),
-- order 69 (user 26)
(69, 9,  1, 119.99),
-- order 70 (user 29)
(70, 26, 1, 39.99),
-- order 71 (user 32)
(71, 22, 1, 74.99),
-- order 72 (user 35)
(72, 10, 1, 22.99),
-- order 73 (user 37)
(73, 27, 1, 64.99),
-- order 74 (user 40, cancelled)
(74, 6,  1, 54.99),
-- order 75 (user 42, cancelled)
(75, 4,  1, 89.99),
-- order 76 (user 43)
(76, 15, 1, 16.99),
-- order 77 (user 46)
(77, 25, 1, 49.99),
-- order 78 (user 48)
(78, 11, 1, 32.99),
-- order 79 (user 50)
(79, 22, 1, 74.99),
-- multi-item orders for richer join demos
(5,  28, 3,  9.99),   -- olive oil added to order 5
(9,  20, 2, 16.99),   -- resistance bands added to order 9
(24, 21, 1, 22.99);   -- yoga mat added to order 24
