-- seed_data.sql
-- Supplemental INSERT data for EcommerceDB
-- Designed to surface all anomaly types for analyst.py
-- Run AFTER pipeline.py has created and populated tables (IDs start at 101+ to avoid conflicts)
-- ============================================================

-- ============================================================
-- USERS (IDs 101-150)
-- Includes: whale spenders, varied age/gender/state for geo analysis
-- ============================================================

INSERT INTO users (id, firstName, lastName, maidenName, age, gender, email, phone, username, birthDate, bloodGroup, height, weight, eyeColor, university, role, hair_color, hair_type, addr_street, addr_city, addr_state, addr_postalCode, addr_country, company_name, company_dept, company_title, bank_cardType, bank_currency, bank_iban)
VALUES
(101, 'Marcus',   'Bellamy',  '',          42, 'male',   'marcus.bellamy@email.com',   '555-0101', 'mbellamy',   '1982-03-14', 'A+',  182.00, 88.00,  'Brown', 'NYU',              'user',  'Black',  'Straight', '14 Park Ave',       'New York',      'New York',       '10001', 'USA', 'Apex Corp',       'Finance',   'Director',       'Visa',       'USD', 'GB29NWBK60161331926819'),
(102, 'Serena',   'Walsh',    '',          35, 'female', 'serena.walsh@email.com',     '555-0102', 'swalsh',     '1989-07-22', 'O-',  165.00, 62.00,  'Green', 'UCLA',             'user',  'Blonde', 'Wavy',     '88 Sunset Blvd',    'Los Angeles',   'California',     '90028', 'USA', 'Walsh Media',     'Marketing', 'VP',             'Mastercard', 'USD', 'DE89370400440532013000'),
(103, 'Derek',    'Fontaine', '',          29, 'male',   'derek.fontaine@email.com',   '555-0103', 'dfontaine',  '1995-11-05', 'B+',  175.00, 78.00,  'Blue',  'UT Austin',        'user',  'Brown',  'Straight', '22 Congress Ave',   'Austin',        'Texas',          '78701', 'USA', 'TechStart LLC',   'Engineering','Engineer',       'Visa',       'USD', 'FR7614508059405923Z67020016'),
(104, 'Priya',    'Mehta',    '',          38, 'female', 'priya.mehta@email.com',      '555-0104', 'pmehta',     '1986-01-30', 'AB+', 160.00, 55.00,  'Brown', 'IIT Mumbai',       'user',  'Black',  'Straight', '5 Lakeshore Dr',    'Chicago',       'Illinois',       '60601', 'USA', 'Mehta Ventures',  'Operations','COO',            'Amex',       'USD', 'IT60X0542811101000000123456'),
(105, 'Jerome',   'Castillo', '',          51, 'male',   'jerome.castillo@email.com',  '555-0105', 'jcastillo',  '1973-08-17', 'O+',  178.00, 92.00,  'Hazel', 'Florida State',    'user',  'Gray',   'Wavy',     '301 Brickell Key',  'Miami',         'Florida',        '33131', 'USA', 'Castillo Holdings','Finance',   'CFO',            'Visa',       'USD', 'ES9121000418450200051332'),
(106, 'Amanda',   'Pierce',   '',          27, 'female', 'amanda.pierce@email.com',    '555-0106', 'apierce',    '1997-04-12', 'A-',  168.00, 60.00,  'Green', 'UW Seattle',       'user',  'Red',    'Curly',    '120 Pike St',       'Seattle',       'Washington',     '98101', 'USA', 'Pierce Design',   'Creative',  'Designer',       'Mastercard', 'USD', 'GB29NWBK60161331926820'),
(107, 'Raymond',  'Okafor',   '',          44, 'male',   'raymond.okafor@email.com',   '555-0107', 'rokafor',    '1980-09-03', 'B-',  180.00, 85.00,  'Brown', 'Howard Univ',      'user',  'Black',  'Short',    '789 Peachtree St',  'Atlanta',       'Georgia',        '30309', 'USA', 'Okafor Capital',  'Finance',   'Partner',        'Visa',       'USD', 'DE89370400440532013001'),
(108, 'Linda',    'Sorensen', '',          33, 'female', 'linda.sorensen@email.com',   '555-0108', 'lsorensen',  '1991-12-20', 'O+',  170.00, 65.00,  'Blue',  'Univ of Minnesota','user',  'Blonde', 'Straight', '400 Nicollet Mall', 'Minneapolis',   'Minnesota',      '55401', 'USA', 'Sorensen Co',     'HR',        'Manager',        'Mastercard', 'USD', 'FR7614508059405923Z67020017'),
(109, 'Carlos',   'Reyes',    '',          22, 'male',   'carlos.reyes@email.com',     '555-0109', 'creyes',     '2002-06-08', 'A+',  172.00, 70.00,  'Brown', 'Arizona State',    'user',  'Black',  'Straight', '1 Desert Rd',       'Phoenix',       'Arizona',        '85001', 'USA', 'Reyes Retail',    'Sales',     'Rep',            'Visa',       'USD', 'IT60X0542811101000000123457'),
(110, 'Natalie',  'Kim',      '',          30, 'female', 'natalie.kim@email.com',      '555-0110', 'nkim',       '1994-02-14', 'AB-', 163.00, 57.00,  'Brown', 'Stanford',         'user',  'Black',  'Straight', '900 University Ave','Palo Alto',     'California',     '94301', 'USA', 'Kim Tech',        'Engineering','Lead Dev',       'Amex',       'USD', 'ES9121000418450200051333'),
-- whale users (high spend)
(111, 'Victor',   'Harrington','',         55, 'male',   'victor.harrington@email.com','555-0111', 'vharrington','1969-05-21', 'O+',  183.00, 95.00,  'Gray',  'Harvard',          'user',  'Gray',   'Short',    '10 Commonwealth Ave','Boston',       'Massachusetts',  '02116', 'USA', 'Harrington Group','Executive', 'CEO',            'Amex',       'USD', 'GB29NWBK60161331926821'),
(112, 'Elena',    'Voss',      '',         48, 'female', 'elena.voss@email.com',       '555-0112', 'evoss',      '1976-10-09', 'A+',  167.00, 63.00,  'Green', 'Columbia',         'user',  'Brunette','Wavy',    '55 Central Park W', 'New York',      'New York',       '10023', 'USA', 'Voss Enterprises','Strategy',  'President',      'Amex',       'USD', 'DE89370400440532013002'),
(113, 'Franklin', 'Abreu',     '',         61, 'male',   'franklin.abreu@email.com',   '555-0113', 'fabreu',     '1963-03-30', 'B+',  176.00, 89.00,  'Brown', 'Wharton',          'user',  'White',  'Short',    '200 Biscayne Blvd', 'Miami',         'Florida',        '33132', 'USA', 'Abreu Capital',   'Investments','Chairman',      'Visa',       'USD', 'FR7614508059405923Z67020018'),
-- younger/low spend users
(114, 'Zoe',      'Tran',      '',         19, 'female', 'zoe.tran@email.com',         '555-0114', 'ztran',      '2005-11-11', 'O-',  160.00, 52.00,  'Brown', 'Community College','user',  'Black',  'Long',     '3 Elm St',          'Portland',      'Oregon',         '97201', 'USA', 'Self',            'N/A',       'Student',        'Mastercard', 'USD', 'IT60X0542811101000000123458'),
(115, 'Ethan',    'Brooks',    '',         21, 'male',   'ethan.brooks@email.com',     '555-0115', 'ebrooks',    '2003-07-04', 'A+',  177.00, 74.00,  'Blue',  'Ohio State',       'user',  'Brown',  'Short',    '12 High St',        'Columbus',      'Ohio',           '43215', 'USA', 'Self',            'N/A',       'Student',        'Visa',       'USD', 'ES9121000418450200051334'),
(116, 'Maya',     'Johnson',   '',         26, 'female', 'maya.johnson@email.com',     '555-0116', 'mjohnson',   '1998-09-19', 'B+',  165.00, 61.00,  'Brown', 'Spelman College',  'user',  'Black',  'Natural',  '45 Auburn Ave',     'Atlanta',       'Georgia',        '30312', 'USA', 'Johnson Boutique','Retail',    'Owner',          'Mastercard', 'USD', 'GB29NWBK60161331926822'),
(117, 'Nathan',   'Park',      '',         37, 'male',   'nathan.park@email.com',      '555-0117', 'npark',      '1987-04-25', 'AB+', 174.00, 80.00,  'Brown', 'Caltech',          'user',  'Black',  'Straight', '1200 E California', 'Pasadena',      'California',     '91125', 'USA', 'Park Systems',    'Engineering','Architect',     'Visa',       'USD', 'DE89370400440532013003'),
(118, 'Tiffany',  'Nguyen',    '',         32, 'female', 'tiffany.nguyen@email.com',   '555-0118', 'tnguyen',    '1992-01-07', 'O+',  162.00, 58.00,  'Brown', 'USC',              'user',  'Black',  'Straight', '700 W 7th St',      'Los Angeles',   'California',     '90017', 'USA', 'Nguyen Fashion',  'Design',    'Lead',           'Mastercard', 'USD', 'FR7614508059405923Z67020019'),
(119, 'Gregory',  'Turner',    '',         45, 'male',   'gregory.turner@email.com',   '555-0119', 'gturner',    '1979-08-31', 'A-',  181.00, 91.00,  'Blue',  'Michigan',         'user',  'Brown',  'Short',    '100 Michigan Ave',  'Detroit',       'Michigan',       '48226', 'USA', 'Turner Mfg',      'Operations','Plant Mgr',      'Visa',       'USD', 'IT60X0542811101000000123459'),
(120, 'Sofia',    'Moreno',    '',         28, 'female', 'sofia.moreno@email.com',     '555-0120', 'smoreno',    '1996-03-22', 'B-',  166.00, 59.00,  'Brown', 'UT San Antonio',   'user',  'Brown',  'Wavy',     '500 Commerce St',   'San Antonio',   'Texas',          '78205', 'USA', 'Moreno Events',   'Events',    'Coordinator',    'Mastercard', 'USD', 'ES9121000418450200051335');

INSERT INTO users (id, firstName, lastName, maidenName, age, gender, email, phone, username, birthDate, bloodGroup, height, weight, eyeColor, university, role, hair_color, hair_type, addr_street, addr_city, addr_state, addr_postalCode, addr_country, company_name, company_dept, company_title, bank_cardType, bank_currency, bank_iban)
VALUES
(121, 'Brian',    'Coleman',   '',         40, 'male',   'brian.coleman@email.com',    '555-0121', 'bcoleman',   '1984-06-15', 'O+',  179.00, 86.00,  'Green', 'Purdue',           'user',  'Brown',  'Short',    '200 N Meridian St', 'Indianapolis',  'Indiana',        '46204', 'USA', 'Coleman Pharma',  'R&D',       'Director',       'Visa',       'USD', 'GB29NWBK60161331926823'),
(122, 'Danielle', 'Fox',       '',         23, 'female', 'danielle.fox@email.com',     '555-0122', 'dfox',       '2001-02-28', 'A+',  164.00, 57.00,  'Green', 'UNC Chapel Hill',  'user',  'Blonde', 'Long',     '140 Franklin St',   'Chapel Hill',   'North Carolina', '27514', 'USA', 'Fox Media',       'Content',   'Intern',         'Mastercard', 'USD', 'DE89370400440532013004'),
(123, 'Isaac',    'Graham',    '',         36, 'male',   'isaac.graham@email.com',     '555-0123', 'igraham',    '1988-10-10', 'B+',  176.00, 82.00,  'Brown', 'Duke',             'user',  'Black',  'Straight', '300 Chapel Hill Rd','Durham',        'North Carolina', '27701', 'USA', 'Graham Law',      'Legal',     'Partner',        'Amex',       'USD', 'FR7614508059405923Z67020020'),
(124, 'Olivia',   'Santos',    '',         31, 'female', 'olivia.santos@email.com',    '555-0124', 'osantos',    '1993-05-16', 'O-',  168.00, 62.00,  'Brown', 'Boston Univ',      'user',  'Brown',  'Curly',    '800 Boylston St',   'Boston',        'Massachusetts',  '02199', 'USA', 'Santos Wellness', 'Health',    'Manager',        'Visa',       'USD', 'IT60X0542811101000000123460'),
(125, 'Malik',    'Washington','',         47, 'male',   'malik.washington@email.com', '555-0125', 'mwashington','1977-12-01', 'AB+', 182.00, 93.00,  'Brown', 'Georgetown',       'user',  'Black',  'Short',    '1600 Penn Ave NW',  'Washington',    'DC',             '20001', 'USA', 'Washington Assoc','Consulting', 'Principal',      'Amex',       'USD', 'ES9121000418450200051336');

-- ============================================================
-- PRODUCTS (IDs 101-150)
-- Includes: dead stock, price outliers, missing brand, duplicate SKUs, varied ratings
-- ============================================================

INSERT INTO products (id, title, description, category, price, discountPercentage, rating, stock, brand, sku, weight, availabilityStatus, returnPolicy, warrantyInformation, minimumOrderQuantity, thumbnail, tags, dim_width, dim_height, dim_depth, meta_createdAt, meta_updatedAt, meta_barcode)
VALUES
-- Normal products
(101, 'ProSound Headphones X1',   'Premium noise-canceling headphones', 'audio',           249.99, 10.00, 4.5, 45,  'ProSound',     'PSX1-2024',   1, 'In Stock',    '30-day return', '1 year warranty',  1, 'https://img.example.com/101.jpg', 'audio,headphones', 19.50, 8.00, 22.00, '2024-01-10', '2024-06-01', '1234567890101'),
(102, 'EcoBlend Coffee Maker',    'Sustainable 12-cup coffee maker',   'kitchen',         89.99,  5.00,  4.2, 80,  'EcoBlend',     'ECB-CM12',    4, 'In Stock',    '30-day return', '2 year warranty',  1, 'https://img.example.com/102.jpg', 'kitchen,coffee',   30.00, 35.00, 25.00, '2024-01-12', '2024-06-01', '1234567890102'),
(103, 'FlexRun Sneakers M',       'Lightweight running shoes mens',    'footwear',        75.00,  8.00,  4.0, 120, 'FlexRun',      'FRN-SNKM',    1, 'In Stock',    '60-day return', '6 month warranty', 1, 'https://img.example.com/103.jpg', 'footwear,running', 12.00, 10.00, 30.00, '2024-01-15', '2024-06-01', '1234567890103'),
(104, 'LuminaDesk Lamp Pro',      'Smart LED desk lamp with USB',      'furniture',       55.00,  12.00, 4.3, 200, 'Lumina',       'LDP-2024',    2, 'In Stock',    '30-day return', '1 year warranty',  1, 'https://img.example.com/104.jpg', 'furniture,lighting',15.00, 45.00, 15.00, '2024-01-20', '2024-06-01', '1234567890104'),
(105, 'ActiveFit Yoga Mat',       'Non-slip 6mm yoga mat',             'sports',          35.00,  0.00,  4.6, 300, 'ActiveFit',    'AFY-MAT6',    2, 'In Stock',    '30-day return', '1 year warranty',  2, 'https://img.example.com/105.jpg', 'sports,yoga',      61.00, 0.60, 61.00, '2024-01-22', '2024-06-01', '1234567890105'),
(106, 'SkinGlow Serum 30ml',      'Anti-aging vitamin C serum',        'beauty',          65.00,  0.00,  4.7, 150, 'SkinGlow',     'SG-SRM30',    0, 'In Stock',    '30-day return', 'None',             1, 'https://img.example.com/106.jpg', 'beauty,skincare',  4.00,  9.00,  4.00,  '2024-01-25', '2024-06-01', '1234567890106'),
(107, 'UrbanPack Backpack 30L',   'Water-resistant commuter backpack', 'accessories',     85.00,  5.00,  4.1, 95,  'UrbanPack',    'UPK-30L',     1, 'In Stock',    '30-day return', '1 year warranty',  1, 'https://img.example.com/107.jpg', 'accessories,bags', 35.00, 50.00, 18.00, '2024-02-01', '2024-06-01', '1234567890107'),
(108, 'TechGuard Phone Case i15', 'Shockproof case for iPhone 15',     'electronics',     25.00,  0.00,  3.8, 500, 'TechGuard',    'TGC-I15',     0, 'In Stock',    '30-day return', 'None',             1, 'https://img.example.com/108.jpg', 'electronics,cases',8.00,  1.00,  16.00, '2024-02-05', '2024-06-01', '1234567890108'),
(109, 'NutriBlend Pro Blender',   '1200W professional blender',        'kitchen',         129.99, 7.50,  4.4, 60,  'NutriBlend',   'NBP-1200W',   5, 'In Stock',    '30-day return', '3 year warranty',  1, 'https://img.example.com/109.jpg', 'kitchen,blender',  25.00, 40.00, 25.00, '2024-02-10', '2024-06-01', '1234567890109'),
(110, 'VaultSafe Wallet RFID',    'Slim RFID-blocking leather wallet', 'accessories',     45.00,  0.00,  4.5, 180, 'VaultSafe',    'VSW-RFID',    0, 'In Stock',    '30-day return', 'None',             1, 'https://img.example.com/110.jpg', 'accessories,wallet',10.00, 1.00,  8.00,  '2024-02-14', '2024-06-01', '1234567890110'),

-- DEAD STOCK — high stock, never appears in cart_items (product_ids 111-115)
(111, 'RetroChic Fax Machine',    'Fax/printer combo unit',            'electronics',     199.00, 0.00,  2.1, 480, 'RetroChic',    'RC-FAX01',    8, 'In Stock',    '30-day return', '1 year warranty',  1, 'https://img.example.com/111.jpg', 'electronics,fax',  40.00, 30.00, 35.00, '2024-01-05', '2024-06-01', '1234567890111'),
(112, 'DustCollect VHS Cleaner',  'VHS head cleaning tape',            'electronics',     14.99,  0.00,  1.8, 950, 'DustCollect',  'DC-VHS01',    0, 'In Stock',    'No return',     'None',             5, 'https://img.example.com/112.jpg', 'electronics,vhs',  2.00,  1.00,  12.00, '2024-01-05', '2024-06-01', '1234567890112'),
(113, 'OldSchool Dial-Up Modem',  '56K dial-up modem USB',             'electronics',     49.00,  0.00,  1.5, 320, 'OldSchool',    'OS-DUM56',    1, 'In Stock',    'No return',     'None',             1, 'https://img.example.com/113.jpg', 'electronics,modem',18.00, 4.00,  25.00, '2024-01-05', '2024-06-01', '1234567890113'),
(114, 'BasicPlain Cotton Tee XS', 'Plain white cotton t-shirt XS',     'clothing',        8.99,   0.00,  2.3, 1200,NULL,           'BPT-WXS',     0, 'In Stock',    '30-day return', 'None',             10,'https://img.example.com/114.jpg', 'clothing,tshirt',  25.00, 1.00,  35.00, '2024-01-05', '2024-06-01', '1234567890114'),
(115, 'Obsolete GPS Unit v1',     'Standalone GPS, 2005 maps',         'electronics',     89.00,  0.00,  1.2, 210, 'MapOld',       'GPS-V1-05',   2, 'In Stock',    'No return',     'None',             1, 'https://img.example.com/115.jpg', 'electronics,gps',  12.00, 6.00,  15.00, '2024-01-05', '2024-06-01', '1234567890115'),

-- PRICE OUTLIERS — high rating + very low price (underpriced)
(116, 'GemCut Diamond Bracelet',  'Genuine diamond tennis bracelet',   'jewelry',         29.99,  0.00,  4.9, 5,   'GemCut',       'GCB-DIAM1',   0, 'In Stock',    '30-day return', 'Lifetime warranty',1, 'https://img.example.com/116.jpg', 'jewelry,diamond',  18.00, 0.50,  18.00, '2024-03-01', '2024-06-01', '1234567890116'),
(117, 'PureLens Camera 4K Pro',   '4K mirrorless camera body',         'electronics',     39.99,  0.00,  4.8, 8,   'PureLens',     'PLC-4KPR',    1, 'In Stock',    '30-day return', '2 year warranty',  1, 'https://img.example.com/117.jpg', 'electronics,camera',12.00, 9.00, 8.00,  '2024-03-05', '2024-06-01', '1234567890117'),

-- PRICE OUTLIERS — low rating + very high price (overpriced)
(118, 'LuxBrand Sunglasses',      'Fashion sunglasses basic UV',       'accessories',     899.00, 0.00,  1.9, 30,  'LuxBrand',     'LXB-SNG01',   0, 'In Stock',    'No return',     'None',             1, 'https://img.example.com/118.jpg', 'accessories,fashion',14.00, 5.00, 16.00, '2024-03-10', '2024-06-01', '1234567890118'),
(119, 'EliteShoe Basic Canvas',   'Plain canvas shoe, no support',     'footwear',        549.00, 0.00,  2.0, 22,  'EliteShoe',    'ELS-CNVS',    1, 'In Stock',    'No return',     'None',             1, 'https://img.example.com/119.jpg', 'footwear,canvas',  27.00, 11.00, 30.00, '2024-03-12', '2024-06-01', '1234567890119'),

-- DUPLICATE SKUs (same SKU as 101 and 103)
(120, 'ProSound Headphones X1 B', 'Budget version same SKU error',     'audio',           149.99, 5.00,  3.2, 20,  'ProSound',     'PSX1-2024',   1, 'In Stock',    '30-day return', '6 month warranty', 1, 'https://img.example.com/120.jpg', 'audio,headphones', 19.00, 8.00,  22.00, '2024-03-15', '2024-06-01', '1234567890120'),
(121, 'FlexRun Sneakers M v2',    'Same SKU re-listed',                'footwear',        79.00,  3.00,  3.9, 40,  'FlexRun',      'FRN-SNKM',    1, 'In Stock',    '30-day return', '6 month warranty', 1, 'https://img.example.com/121.jpg', 'footwear,running', 12.00, 10.00, 30.00, '2024-03-18', '2024-06-01', '1234567890121'),

-- MISSING BRAND (NULL brand)
(122, 'Generic USB Hub 7-Port',   '7-port USB 3.0 hub',                'electronics',     19.99,  0.00,  3.5, 400, NULL,           'GEN-USB7P',   0, 'In Stock',    '30-day return', '1 year warranty',  1, 'https://img.example.com/122.jpg', 'electronics,usb',  12.00, 3.00,  8.00,  '2024-04-01', '2024-06-01', '1234567890122'),
(123, 'Unbranded Notebook A5',    'Plain ruled notebook 200 pages',    'stationery',      4.99,   0.00,  3.1, 2000,NULL,           'UNB-NTA5',    0, 'In Stock',    '30-day return', 'None',             5, 'https://img.example.com/123.jpg', 'stationery,notebook',14.80, 21.00, 1.00, '2024-04-01', '2024-06-01', '1234567890123'),

-- MISSING CATEGORY (NULL category)
(124, 'MysteryBox Gadget Set',    'Assorted electronics bundle',       NULL,              149.00, 10.00, 3.0, 75,  'GadgetCo',     'GCO-MYS01',   3, 'In Stock',    '30-day return', '6 month warranty', 1, 'https://img.example.com/124.jpg', 'electronics,bundle',30.00, 20.00, 25.00, '2024-04-05', '2024-06-01', '1234567890124'),

-- STOCKOUT RISK — very low stock (1-5 units), high demand items (appear many times in cart_items)
(125, 'HyperCharge Laptop 15"',   'Ultra-thin 15" laptop 16GB RAM',   'electronics',     1199.99,3.00,  4.7, 3,   'HyperCharge',  'HCL-15U16',   2, 'Low Stock',   '30-day return', '2 year warranty',  1, 'https://img.example.com/125.jpg', 'electronics,laptop',34.00, 1.80, 23.00, '2024-04-10', '2024-06-01', '1234567890125'),
(126, 'FlexRun Trail Shoe W',     'Womens trail running shoe',         'footwear',        95.00,  5.00,  4.6, 4,   'FlexRun',      'FRN-TRLW',    1, 'Low Stock',   '60-day return', '6 month warranty', 1, 'https://img.example.com/126.jpg', 'footwear,trail',   12.00, 10.00, 30.00, '2024-04-15', '2024-06-01', '1234567890126'),
(127, 'SoundBar Ultra 5.1',       '5.1 channel home soundbar',        'audio',           449.00, 5.00,  4.8, 2,   'ProSound',     'PSB-51UL',    8, 'Low Stock',   '30-day return', '2 year warranty',  1, 'https://img.example.com/127.jpg', 'audio,soundbar',   100.00, 12.00, 20.00,'2024-04-20', '2024-06-01', '1234567890127'),

-- PRICE INCONSISTENCY in same category (furniture: $55 lamp vs $4500 sofa vs $12 stool)
(128, 'MasterCraft Leather Sofa', 'Italian leather 3-seater sofa',    'furniture',       4500.00,2.00,  4.5, 10,  'MasterCraft',  'MCF-SOFAL3',  85, 'In Stock',   '30-day return', '5 year warranty',  1, 'https://img.example.com/128.jpg', 'furniture,sofa',   220.00,85.00, 95.00, '2024-05-01', '2024-06-01', '1234567890128'),
(129, 'BasicStool Plain Wood',    'Unfinished pine stool',             'furniture',       12.00,  0.00,  2.8, 500, NULL,           'BST-PINE1',   2, 'In Stock',    '30-day return', 'None',             1, 'https://img.example.com/129.jpg', 'furniture,stool',  35.00, 45.00, 35.00, '2024-05-01', '2024-06-01', '1234567890129'),
(130, 'ArtisanDesk Walnut 60"',   'Solid walnut standing desk',        'furniture',       1299.00,5.00,  4.6, 15,  'ArtisanDesk',  'ADW-60ST',    40, 'In Stock',   '30-day return', '3 year warranty',  1, 'https://img.example.com/130.jpg', 'furniture,desk',   152.00,75.00, 75.00, '2024-05-05', '2024-06-01', '1234567890130'),

-- More normal products to fill out data
(131, 'ClearVision Monitor 27"',  '27" 4K IPS monitor',               'electronics',     379.00, 8.00,  4.4, 55,  'ClearVision',  'CVN-27K4',    7, 'In Stock',    '30-day return', '3 year warranty',  1, 'https://img.example.com/131.jpg', 'electronics,monitor',61.00, 36.00, 8.00,'2024-05-10', '2024-06-01', '1234567890131'),
(132, 'CoolAir Portable Fan',     'USB rechargeable portable fan',     'appliances',      29.99,  0.00,  4.0, 220, 'CoolAir',      'CAF-USB-R',   1, 'In Stock',    '30-day return', '1 year warranty',  1, 'https://img.example.com/132.jpg', 'appliances,fan',   15.00, 15.00, 5.00,  '2024-05-12', '2024-06-01', '1234567890132'),
(133, 'PetCare Dry Food 5kg',     'Premium adult dog dry food',        'pet-supplies',    42.00,  3.00,  4.3, 340, 'PetCare',      'PCT-DDF5K',   5, 'In Stock',    '30-day return', 'None',             2, 'https://img.example.com/133.jpg', 'pets,food',        25.00, 30.00, 15.00, '2024-05-15', '2024-06-01', '1234567890133'),
(134, 'BookShelf Wall Mount',     'Floating wall shelf set of 3',      'furniture',       59.00,  0.00,  4.2, 130, 'ShelfMaster',  'SFM-FLT3S',   4, 'In Stock',    '30-day return', '1 year warranty',  2, 'https://img.example.com/134.jpg', 'furniture,shelf',  80.00, 20.00, 10.00, '2024-05-18', '2024-06-01', '1234567890134'),
(135, 'ThermoQuick Kettle 1.7L',  '1.7L rapid boil kettle',           'kitchen',         45.00,  5.00,  4.1, 90,  'ThermoQuick',  'TQK-17L',     2, 'In Stock',    '30-day return', '2 year warranty',  1, 'https://img.example.com/135.jpg', 'kitchen,kettle',   22.00, 25.00, 15.00, '2024-05-20', '2024-06-01', '1234567890135');

-- ============================================================
-- CARTS (IDs 21-60)
-- Includes: whale spenders, discount abuse, high quantity abandoned-style carts
-- NOTE: totalProducts/totalQuantity filled; no "converted" flag in schema
--       so abandoned = high totalQuantity carts with massive discount
-- ============================================================

INSERT INTO carts (id, userId, total, discountedTotal, totalProducts, totalQuantity)
VALUES
-- WHALE USERS (111, 112, 113) — drive revenue concentration
(21, 111, 8950.00, 8300.00,  8, 14),
(22, 111, 6200.00, 5900.00,  5, 9),
(23, 112, 7400.00, 6850.00,  7, 12),
(24, 113, 9800.00, 9100.00,  9, 18),
(25, 113, 5500.00, 5200.00,  4, 7),

-- DISCOUNT ABUSE — discountedTotal is >60% less than total
(26, 101, 1200.00, 420.00,   3, 5),   -- 65% off
(27, 102, 890.00,  285.00,   2, 4),   -- 68% off
(28, 103, 2100.00, 630.00,   4, 8),   -- 70% off
(29, 104, 450.00,  130.00,   2, 3),   -- 71% off
(30, 105, 750.00,  210.00,   3, 6),   -- 72% off

-- NORMAL CARTS (varied users/states)
(31, 106, 320.00,  295.00,   3, 5),
(32, 107, 185.00,  172.00,   2, 3),
(33, 108, 540.00,  499.00,   4, 7),
(34, 109, 89.99,   82.00,    1, 2),
(35, 110, 425.00,  395.00,   3, 5),
(36, 114, 55.00,   52.00,    2, 3),   -- young/low spend
(37, 115, 75.00,   70.00,    1, 2),   -- young/low spend
(38, 116, 210.00,  195.00,   3, 4),
(39, 117, 1850.00, 1720.00,  3, 4),
(40, 118, 340.00,  310.00,   2, 3),
(41, 119, 680.00,  630.00,   4, 6),
(42, 120, 125.00,  118.00,   2, 3),
(43, 121, 960.00,  890.00,   5, 9),
(44, 122, 44.00,   41.00,    2, 4),   -- young/low spend
(45, 123, 780.00,  720.00,   4, 6),
(46, 124, 295.00,  275.00,   3, 5),
(47, 125, 430.00,  400.00,   3, 5),
-- High quantity carts (potential abandoned)
(48, 101, 3200.00, 2950.00,  6, 22),
(49, 107, 2800.00, 2600.00,  5, 19),
(50, 110, 1950.00, 1800.00,  4, 17),
-- More normal
(51, 102, 560.00,  520.00,   3, 6),
(52, 103, 890.00,  820.00,   4, 7),
(53, 104, 175.00,  165.00,   2, 3),
(54, 108, 320.00,  298.00,   3, 5),
(55, 109, 655.00,  610.00,   4, 8),
(56, 116, 140.00,  132.00,   2, 4),
(57, 117, 2200.00, 2050.00,  3, 5),
(58, 119, 490.00,  455.00,   3, 6),
(59, 120, 85.00,   80.00,    1, 2),
(60, 125, 1100.00, 1020.00,  4, 7);

-- ============================================================
-- CART ITEMS (references carts 21-60 and products 101-135)
-- ============================================================

INSERT INTO cart_items (cart_id, product_id, title, price, quantity, total, discountPercentage, discountedTotal, thumbnail)
VALUES
-- Cart 21 (whale, user 111)
(21, 125, 'HyperCharge Laptop 15"',  1199.99, 2, 2399.98, 3.00, 2327.98, 'https://img.example.com/125.jpg'),
(21, 130, 'ArtisanDesk Walnut 60"',  1299.00, 1, 1299.00, 5.00, 1234.05, 'https://img.example.com/130.jpg'),
(21, 131, 'ClearVision Monitor 27"', 379.00,  3, 1137.00, 8.00, 1046.04, 'https://img.example.com/131.jpg'),
(21, 127, 'SoundBar Ultra 5.1',      449.00,  1, 449.00,  5.00, 426.55,  'https://img.example.com/127.jpg'),
(21, 110, 'VaultSafe Wallet RFID',   45.00,   2, 90.00,   0.00, 90.00,   'https://img.example.com/110.jpg'),
-- Cart 22 (whale, user 111)
(22, 128, 'MasterCraft Leather Sofa',4500.00, 1, 4500.00, 2.00, 4410.00, 'https://img.example.com/128.jpg'),
(22, 104, 'LuminaDesk Lamp Pro',     55.00,   3, 165.00,  12.00, 145.20, 'https://img.example.com/104.jpg'),
-- Cart 23 (whale, user 112)
(23, 125, 'HyperCharge Laptop 15"',  1199.99, 1, 1199.99, 3.00, 1163.99, 'https://img.example.com/125.jpg'),
(23, 131, 'ClearVision Monitor 27"', 379.00,  2, 758.00,  8.00, 697.36,  'https://img.example.com/131.jpg'),
(23, 127, 'SoundBar Ultra 5.1',      449.00,  2, 898.00,  5.00, 853.10,  'https://img.example.com/127.jpg'),
(23, 106, 'SkinGlow Serum 30ml',     65.00,   4, 260.00,  0.00, 260.00,  'https://img.example.com/106.jpg'),
-- Cart 24 (whale, user 113)
(24, 128, 'MasterCraft Leather Sofa',4500.00, 1, 4500.00, 2.00, 4410.00, 'https://img.example.com/128.jpg'),
(24, 130, 'ArtisanDesk Walnut 60"',  1299.00, 2, 2598.00, 5.00, 2468.10, 'https://img.example.com/130.jpg'),
(24, 125, 'HyperCharge Laptop 15"',  1199.99, 1, 1199.99, 3.00, 1163.99, 'https://img.example.com/125.jpg'),
-- Cart 25 (whale, user 113)
(25, 131, 'ClearVision Monitor 27"', 379.00,  3, 1137.00, 8.00, 1046.04, 'https://img.example.com/131.jpg'),
(25, 127, 'SoundBar Ultra 5.1',      449.00,  2, 898.00,  5.00, 853.10,  'https://img.example.com/127.jpg'),

-- Discount abuse carts (26-30)
(26, 101, 'ProSound Headphones X1',  249.99,  2, 499.98,  65.00, 174.99, 'https://img.example.com/101.jpg'),
(26, 109, 'NutriBlend Pro Blender',  129.99,  1, 129.99,  65.00, 45.50,  'https://img.example.com/109.jpg'),
(26, 130, 'ArtisanDesk Walnut 60"',  1299.00, 1, 1299.00, 65.00, 454.65, 'https://img.example.com/130.jpg'),
(27, 125, 'HyperCharge Laptop 15"',  1199.99, 1, 1199.99, 68.00, 383.99, 'https://img.example.com/125.jpg'),
(27, 107, 'UrbanPack Backpack 30L',  85.00,   2, 170.00,  68.00, 54.40,  'https://img.example.com/107.jpg'),
(28, 128, 'MasterCraft Leather Sofa',4500.00, 1, 4500.00, 70.00, 1350.00,'https://img.example.com/128.jpg'),
(28, 101, 'ProSound Headphones X1',  249.99,  1, 249.99,  70.00, 75.00,  'https://img.example.com/101.jpg'),
(29, 131, 'ClearVision Monitor 27"', 379.00,  1, 379.00,  71.00, 109.91, 'https://img.example.com/131.jpg'),
(29, 103, 'FlexRun Sneakers M',      75.00,   1, 75.00,   71.00, 21.75,  'https://img.example.com/103.jpg'),
(30, 125, 'HyperCharge Laptop 15"',  1199.99, 1, 1199.99, 72.00, 335.99, 'https://img.example.com/125.jpg'),
(30, 106, 'SkinGlow Serum 30ml',     65.00,   2, 130.00,  72.00, 36.40,  'https://img.example.com/106.jpg'),

-- Normal carts (31-47)
(31, 103, 'FlexRun Sneakers M',      75.00,   2, 150.00,  8.00, 138.00,  'https://img.example.com/103.jpg'),
(31, 107, 'UrbanPack Backpack 30L',  85.00,   1, 85.00,   5.00, 80.75,   'https://img.example.com/107.jpg'),
(31, 105, 'ActiveFit Yoga Mat',      35.00,   1, 35.00,   0.00, 35.00,   'https://img.example.com/105.jpg'),
(32, 109, 'NutriBlend Pro Blender',  129.99,  1, 129.99,  7.50, 120.24,  'https://img.example.com/109.jpg'),
(32, 102, 'EcoBlend Coffee Maker',   89.99,   1, 89.99,   5.00, 85.49,   'https://img.example.com/102.jpg'),
(33, 130, 'ArtisanDesk Walnut 60"',  1299.00, 1, 1299.00, 5.00, 1234.05, 'https://img.example.com/130.jpg'),
(34, 105, 'ActiveFit Yoga Mat',      35.00,   2, 70.00,   0.00, 70.00,   'https://img.example.com/105.jpg'),
(35, 101, 'ProSound Headphones X1',  249.99,  1, 249.99,  10.00, 224.99, 'https://img.example.com/101.jpg'),
(35, 106, 'SkinGlow Serum 30ml',     65.00,   2, 130.00,  0.00, 130.00,  'https://img.example.com/106.jpg'),
(36, 108, 'TechGuard Phone Case',    25.00,   1, 25.00,   0.00, 25.00,   'https://img.example.com/108.jpg'),
(36, 132, 'CoolAir Portable Fan',    29.99,   1, 29.99,   0.00, 29.99,   'https://img.example.com/132.jpg'),
(37, 103, 'FlexRun Sneakers M',      75.00,   1, 75.00,   8.00, 69.00,   'https://img.example.com/103.jpg'),
(38, 106, 'SkinGlow Serum 30ml',     65.00,   2, 130.00,  0.00, 130.00,  'https://img.example.com/106.jpg'),
(38, 110, 'VaultSafe Wallet RFID',   45.00,   1, 45.00,   0.00, 45.00,   'https://img.example.com/110.jpg'),
(39, 131, 'ClearVision Monitor 27"', 379.00,  2, 758.00,  8.00, 697.36,  'https://img.example.com/131.jpg'),
(39, 130, 'ArtisanDesk Walnut 60"',  1299.00, 1, 1299.00, 5.00, 1234.05, 'https://img.example.com/130.jpg'),
(40, 103, 'FlexRun Sneakers M',      75.00,   2, 150.00,  8.00, 138.00,  'https://img.example.com/103.jpg'),
(40, 107, 'UrbanPack Backpack 30L',  85.00,   1, 85.00,   5.00, 80.75,   'https://img.example.com/107.jpg'),
(41, 109, 'NutriBlend Pro Blender',  129.99,  2, 259.98,  7.50, 240.48,  'https://img.example.com/109.jpg'),
(41, 135, 'ThermoQuick Kettle 1.7L', 45.00,   2, 90.00,   5.00, 85.50,   'https://img.example.com/135.jpg'),
(42, 133, 'PetCare Dry Food 5kg',    42.00,   3, 126.00,  3.00, 122.22,  'https://img.example.com/133.jpg'),
(43, 130, 'ArtisanDesk Walnut 60"',  1299.00, 1, 1299.00, 5.00, 1234.05, 'https://img.example.com/130.jpg'),
(43, 134, 'BookShelf Wall Mount',    59.00,   2, 118.00,  0.00, 118.00,  'https://img.example.com/134.jpg'),
(44, 123, 'Unbranded Notebook A5',   4.99,    4, 19.96,   0.00, 19.96,   'https://img.example.com/123.jpg'),
(44, 108, 'TechGuard Phone Case',    25.00,   1, 25.00,   0.00, 25.00,   'https://img.example.com/108.jpg'),
(45, 131, 'ClearVision Monitor 27"', 379.00,  1, 379.00,  8.00, 348.68,  'https://img.example.com/131.jpg'),
(45, 101, 'ProSound Headphones X1',  249.99,  1, 249.99,  10.00, 224.99, 'https://img.example.com/101.jpg'),
(46, 109, 'NutriBlend Pro Blender',  129.99,  1, 129.99,  7.50, 120.24,  'https://img.example.com/109.jpg'),
(46, 135, 'ThermoQuick Kettle 1.7L', 45.00,   2, 90.00,   5.00, 85.50,   'https://img.example.com/135.jpg'),
(47, 126, 'FlexRun Trail Shoe W',    95.00,   3, 285.00,  5.00, 270.75,  'https://img.example.com/126.jpg'),

-- High quantity / potential abandoned carts (48-50)
(48, 105, 'ActiveFit Yoga Mat',      35.00,   8, 280.00,  0.00, 280.00,  'https://img.example.com/105.jpg'),
(48, 103, 'FlexRun Sneakers M',      75.00,   5, 375.00,  8.00, 345.00,  'https://img.example.com/103.jpg'),
(48, 107, 'UrbanPack Backpack 30L',  85.00,   4, 340.00,  5.00, 323.00,  'https://img.example.com/107.jpg'),
(48, 133, 'PetCare Dry Food 5kg',    42.00,   5, 210.00,  3.00, 203.70,  'https://img.example.com/133.jpg'),
(49, 101, 'ProSound Headphones X1',  249.99,  6, 1499.94, 10.00,1349.94, 'https://img.example.com/101.jpg'),
(49, 108, 'TechGuard Phone Case',    25.00,   8, 200.00,  0.00, 200.00,  'https://img.example.com/108.jpg'),
(49, 132, 'CoolAir Portable Fan',    29.99,   5, 149.95,  0.00, 149.95,  'https://img.example.com/132.jpg'),
(50, 130, 'ArtisanDesk Walnut 60"',  1299.00, 1, 1299.00, 5.00, 1234.05, 'https://img.example.com/130.jpg'),
(50, 131, 'ClearVision Monitor 27"', 379.00,  2, 758.00,  8.00, 697.36,  'https://img.example.com/131.jpg'),
(50, 134, 'BookShelf Wall Mount',    59.00,   6, 354.00,  0.00, 354.00,  'https://img.example.com/134.jpg'),

-- Remaining carts (51-60)
(51, 102, 'EcoBlend Coffee Maker',   89.99,   2, 179.98,  5.00, 170.98,  'https://img.example.com/102.jpg'),
(51, 135, 'ThermoQuick Kettle 1.7L', 45.00,   2, 90.00,   5.00, 85.50,   'https://img.example.com/135.jpg'),
(52, 101, 'ProSound Headphones X1',  249.99,  2, 499.98,  10.00, 449.98, 'https://img.example.com/101.jpg'),
(52, 127, 'SoundBar Ultra 5.1',      449.00,  1, 449.00,  5.00, 426.55,  'https://img.example.com/127.jpg'),
(53, 108, 'TechGuard Phone Case',    25.00,   1, 25.00,   0.00, 25.00,   'https://img.example.com/108.jpg'),
(53, 132, 'CoolAir Portable Fan',    29.99,   1, 29.99,   0.00, 29.99,   'https://img.example.com/132.jpg'),
(54, 106, 'SkinGlow Serum 30ml',     65.00,   3, 195.00,  0.00, 195.00,  'https://img.example.com/106.jpg'),
(54, 110, 'VaultSafe Wallet RFID',   45.00,   1, 45.00,   0.00, 45.00,   'https://img.example.com/110.jpg'),
(55, 109, 'NutriBlend Pro Blender',  129.99,  2, 259.98,  7.50, 240.48,  'https://img.example.com/109.jpg'),
(55, 102, 'EcoBlend Coffee Maker',   89.99,   1, 89.99,   5.00, 85.49,   'https://img.example.com/102.jpg'),
(56, 105, 'ActiveFit Yoga Mat',      35.00,   2, 70.00,   0.00, 70.00,   'https://img.example.com/105.jpg'),
(56, 133, 'PetCare Dry Food 5kg',    42.00,   1, 42.00,   3.00, 40.74,   'https://img.example.com/133.jpg'),
(57, 131, 'ClearVision Monitor 27"', 379.00,  2, 758.00,  8.00, 697.36,  'https://img.example.com/131.jpg'),
(57, 130, 'ArtisanDesk Walnut 60"',  1299.00, 1, 1299.00, 5.00, 1234.05, 'https://img.example.com/130.jpg'),
(58, 103, 'FlexRun Sneakers M',      75.00,   2, 150.00,  8.00, 138.00,  'https://img.example.com/103.jpg'),
(58, 126, 'FlexRun Trail Shoe W',    95.00,   2, 190.00,  5.00, 180.50,  'https://img.example.com/126.jpg'),
(59, 132, 'CoolAir Portable Fan',    29.99,   1, 29.99,   0.00, 29.99,   'https://img.example.com/132.jpg'),
(59, 108, 'TechGuard Phone Case',    25.00,   1, 25.00,   0.00, 25.00,   'https://img.example.com/108.jpg'),
(60, 101, 'ProSound Headphones X1',  249.99,  2, 499.98,  10.00, 449.98, 'https://img.example.com/101.jpg'),
(60, 127, 'SoundBar Ultra 5.1',      449.00,  1, 449.00,  5.00, 426.55,  'https://img.example.com/127.jpg');

-- ============================================================
-- PRODUCT REVIEWS (includes orphaned reviews — product_id 999/998 do not exist)
-- ============================================================

INSERT INTO product_reviews (product_id, rating, comment, review_date, reviewer_name, reviewer_email)
VALUES
-- Normal reviews for real products
(101, 5, 'Best headphones I have ever owned. Noise canceling is incredible.', '2024-02-10', 'Marcus B.',    'marcus.bellamy@email.com'),
(101, 4, 'Great sound quality, comfortable fit, highly recommend.',            '2024-02-15', 'Serena W.',    'serena.walsh@email.com'),
(101, 5, 'Worth every penny. Battery life is fantastic.',                      '2024-03-01', 'Natalie K.',   'natalie.kim@email.com'),
(102, 4, 'Makes great coffee and looks good on the counter.',                  '2024-02-20', 'Linda S.',     'linda.sorensen@email.com'),
(102, 3, 'Decent but takes longer than expected to brew.',                     '2024-03-05', 'Carlos R.',    'carlos.reyes@email.com'),
(103, 5, 'Super lightweight, perfect for long runs.',                          '2024-02-25', 'Derek F.',     'derek.fontaine@email.com'),
(103, 4, 'Good grip and support. Sizing runs a bit small.',                    '2024-03-10', 'Ethan B.',     'ethan.brooks@email.com'),
(105, 5, 'Best yoga mat, non-slip even when sweaty.',                          '2024-03-15', 'Amanda P.',    'amanda.pierce@email.com'),
(105, 5, 'Excellent thickness, joints feel protected.',                        '2024-03-20', 'Maya J.',      'maya.johnson@email.com'),
(106, 5, 'My skin has never looked better. Love this serum.',                  '2024-03-25', 'Tiffany N.',   'tiffany.nguyen@email.com'),
(106, 5, 'Reduced my dark spots in 2 weeks. Amazing product.',                 '2024-04-01', 'Priya M.',     'priya.mehta@email.com'),
(107, 4, 'Fits my laptop and gym gear. Very sturdy.',                          '2024-04-05', 'Gregory T.',   'gregory.turner@email.com'),
(109, 5, 'Super powerful, blends everything smoothly.',                        '2024-04-10', 'Sofia M.',     'sofia.moreno@email.com'),
(109, 4, 'Easy to clean, powerful motor.',                                     '2024-04-15', 'Brian C.',     'brian.coleman@email.com'),
(125, 5, 'Insanely fast laptop. The screen is gorgeous.',                      '2024-04-20', 'Victor H.',    'victor.harrington@email.com'),
(125, 5, 'Best laptop I have used in years. Well worth it.',                   '2024-04-25', 'Nathan P.',    'nathan.park@email.com'),
(126, 5, 'Perfect trail shoe. Light and grippy on rocks.',                     '2024-05-01', 'Olivia S.',    'olivia.santos@email.com'),
(127, 5, 'Incredible soundbar, fills the whole room.',                         '2024-05-05', 'Isaac G.',     'isaac.graham@email.com'),
(128, 5, 'Luxurious sofa. Delivery was smooth and assembly easy.',             '2024-05-10', 'Elena V.',     'elena.voss@email.com'),
(130, 5, 'Solid desk, beautiful walnut grain. Worth the price.',               '2024-05-15', 'Franklin A.',  'franklin.abreu@email.com'),
(130, 4, 'Very sturdy. Took 2 hours to assemble but looks stunning.',          '2024-05-18', 'Malik W.',     'malik.washington@email.com'),
(131, 5, 'Sharp 4K display. Colors are vibrant and accurate.',                 '2024-05-20', 'Nathan P.',    'nathan.park@email.com'),
-- Reviews for dead stock / low rated items
(111, 2, 'Who still needs a fax machine? Bought by mistake.',                  '2024-02-01', 'Zoe T.',       'zoe.tran@email.com'),
(112, 1, 'Completely useless. VCRs have been dead for 20 years.',              '2024-02-05', 'Ethan B.',     'ethan.brooks@email.com'),
(113, 1, 'Do not buy. Dial-up is not available in my area obviously.',         '2024-02-08', 'Carlos R.',    'carlos.reyes@email.com'),
(118, 2, 'Not worth $899. Basic plastic sunglasses.',                          '2024-03-01', 'Danielle F.',  'danielle.fox@email.com'),
(119, 2, 'Fell apart after one week. Way overpriced.',                         '2024-03-05', 'Zoe T.',       'zoe.tran@email.com'),
-- ORPHANED REVIEWS — product_id does not exist in products table
(999, 4, 'Great product, fast shipping!',                                      '2024-01-15', 'Ghost User1',  'ghost1@test.com'),
(998, 3, 'It was okay, not what I expected.',                                  '2024-01-20', 'Ghost User2',  'ghost2@test.com'),
(997, 5, 'Absolutely love this item, ordering again.',                         '2024-01-25', 'Ghost User3',  'ghost3@test.com'),
(996, 1, 'Terrible, returned immediately.',                                    '2024-01-28', 'Ghost User4',  'ghost4@test.com');
