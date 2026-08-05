USE DEMO;

-- Table_8_Functions.sql
-- Demo tables and examples for commonly used MySQL functions
-- Grouped by type with usage comments and variations

-- 1) Demo tables (create if not present)
CREATE TABLE IF NOT EXISTS demo_customers (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100),
	email VARCHAR(150),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	balance DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS demo_orders (
	id INT AUTO_INCREMENT PRIMARY KEY,
	customer_id INT,
	order_date DATE,
	amount DECIMAL(10,2),
	status VARCHAR(20),
	notes TEXT,
	FOREIGN KEY (customer_id) REFERENCES demo_customers(id)
);

CREATE TABLE IF NOT EXISTS demo_texts (
	id INT AUTO_INCREMENT PRIMARY KEY,
	txt TEXT
);

-- 2) Sample data (idempotent inserts for demo)
INSERT IGNORE INTO demo_customers (id, name, email, created_at, balance) VALUES
(1,'Alice Smith','alice@example.com','2023-05-01 10:15:00', 1200.50),
(2,'Bob Jones','bob@example.net','2024-01-12 08:30:00', 15.75),
(3,'Červená Anna','anna@example.cz','2025-07-20 14:00:00', 300.00);

INSERT IGNORE INTO demo_orders (id, customer_id, order_date, amount, status, notes) VALUES
(1,1,'2025-07-01', 199.99, 'shipped','First order'),
(2,1,'2025-07-15', 25.50, 'processing','Repeat small order'),
(3,2,'2024-02-20', 9.99, 'delivered',NULL);

INSERT IGNORE INTO demo_texts (id, txt) VALUES
(1,'  Hello, World!  '),
(2,'MySQL sample, with commas'),
(3,'{"a":1, "b": [1,2,3]}');

-- 3) STRING functions
-- CONCAT / CONCAT_WS: join strings
SELECT CONCAT(name, ' <', email, '>') AS contact FROM demo_customers;
SELECT CONCAT_WS(' - ', id, name, email) FROM demo_customers;

-- LENGTH / CHAR_LENGTH: bytes vs characters (UTF-8)
SELECT name, LENGTH(name) AS bytes, CHAR_LENGTH(name) AS chars FROM demo_customers;

-- LOWER / UPPER: case conversion
SELECT LOWER(name), UPPER(name) FROM demo_customers;

-- TRIM / LTRIM / RTRIM: remove spaces
SELECT CONCAT('>' , TRIM(txt) , '<') FROM demo_texts;

-- REPLACE: replace substrings
-- Use for simple literal replacements; for regex-based replacements use REGEXP_REPLACE (MySQL 8+).
SELECT REPLACE('abc abc', 'a', 'x');

-- SUBSTRING / LEFT / RIGHT: extract parts
-- Note: positions are 1-based. Use SUBSTRING_INDEX to split by delimiters, or LEFT/RIGHT for fixed-length extracts.
SELECT SUBSTRING(name,1,5) FROM demo_customers;
-- Extract local part before '@' using LOCATE; returns empty if '@' not found.
SELECT LEFT(email, LOCATE('@',email)-1) AS local_part FROM demo_customers;

-- LOCATE / INSTR: find position
-- LOCATE(substr, str) returns the position; INSTR(str, substr) has reversed argument order. Both return 0 if not found.
SELECT LOCATE('Smith', name) FROM demo_customers;

-- Examples with NULL handling
SELECT CONCAT_WS(' - ', name, NULL, email) FROM demo_customers; -- skips NULLs

-- 4) NUMERIC functions
-- ABS / CEILING / FLOOR / ROUND
SELECT ABS(-12.3), CEIL(2.1), FLOOR(2.9), ROUND(123.456,2);

-- POWER / SQRT / MOD
SELECT POWER(2,8) AS pow2_8, SQRT(16) AS sqrt16, MOD(10,3) AS mod10_3;

-- SIGN / RAND
-- RAND([seed]) returns a pseudorandom FLOAT in [0,1). Provide a seed for repeatable sequences: RAND(123).
SELECT SIGN(-10), RAND();

-- CAST / CONVERT
-- CAST(expr AS type) converts between types. CONVERT(value, type) is similar; converting datetime to DATE drops the time portion.
SELECT CAST('123.455' AS DECIMAL(6,2)), CONVERT('2025-08-01 12:00:00', DATE);

-- 5) DATE / TIME functions
-- NOW, CURRENT_DATE, CURDATE, CURTIME
SELECT NOW() AS now_ts, CURRENT_DATE() AS today, CURTIME() AS now_time;

-- DATE_ADD / DATE_SUB
SELECT DATE_ADD(CURRENT_DATE, INTERVAL 7 DAY) AS next_week;
SELECT DATE_SUB('2025-08-05', INTERVAL 1 MONTH) AS last_month;

-- DATEDIFF / TIMESTAMPDIFF
SELECT DATEDIFF('2025-08-05','2025-07-01') AS days_between;
-- TIMESTAMPDIFF(unit, datetime1, datetime2) returns the difference as an integer in the specified unit (SECOND, MINUTE, HOUR, DAY, etc.).
SELECT TIMESTAMPDIFF(HOUR, '2025-08-01 00:00:00','2025-08-02 12:00:00') AS hours_between;

-- DATE_FORMAT: formatting
SELECT DATE_FORMAT(created_at, '%Y-%m-%d %H:%i') FROM demo_customers;

-- STR_TO_DATE: parse string to date
SELECT STR_TO_DATE('31/12/2024','%d/%m/%Y');

-- UNIX_TIMESTAMP / FROM_UNIXTIME
-- UNIX_TIMESTAMP(): seconds since 1970-01-01 UTC. FROM_UNIXTIME() converts seconds back to datetime.
SELECT UNIX_TIMESTAMP(NOW()), FROM_UNIXTIME(UNIX_TIMESTAMP());

-- 6) AGGREGATE functions
-- COUNT / SUM / AVG / MIN / MAX
SELECT COUNT(*) AS total_customers, SUM(balance) AS total_balance, AVG(balance) AS avg_balance FROM demo_customers;

-- GROUP_CONCAT
-- GROUP_CONCAT(expr ORDER BY ... SEPARATOR ...) concatenates values per group into a single string.
-- Note: result length is limited by `group_concat_max_len` server variable; use ORDER BY inside GROUP_CONCAT for stable ordering.
SELECT customer_id, GROUP_CONCAT(amount ORDER BY order_date DESC SEPARATOR '; ') FROM demo_orders GROUP BY customer_id;

-- 7) CONTROL / NULL functions
-- IF / IFNULL / COALESCE / NULLIF
SELECT name, IF(balance>1000,'VIP','regular') FROM demo_customers;
SELECT IFNULL((SELECT notes FROM demo_orders WHERE customer_id=3 LIMIT 1),'no notes') AS notes_for_3;
SELECT COALESCE(NULL, NULL, 'first_non_null') AS first_non_null;
SELECT NULLIF(1,1) AS nullif_example; -- returns NULL when equal

-- 8) JSON functions (MySQL JSON support)
-- JSON_EXTRACT / JSON_UNQUOTE / JSON_ARRAY / JSON_OBJECT
-- JSON_EXTRACT returns a JSON value (possibly quoted). JSON_UNQUOTE removes the surrounding quotes to get a SQL scalar.
-- Use -> and ->> as shorthand: column->'$.a' (JSON), column->>'$.a' (unquoted scalar).
SELECT JSON_EXTRACT(txt,'$.a') AS a_val FROM demo_texts WHERE txt LIKE '{%';
SELECT JSON_UNQUOTE(JSON_EXTRACT(txt,'$.b[1]')) FROM demo_texts WHERE txt LIKE '{%';
-- JSON_ARRAY and JSON_OBJECT construct JSON values from SQL values.
SELECT JSON_ARRAY(1,2,'three'), JSON_OBJECT('x', 1, 'y', 'two');

-- 9) CRYPTO / HASH functions
-- MD5 / SHA1 / SHA2
-- MD5, SHA1, SHA2 produce hashes. These are fast but not suitable for password storage; prefer bcrypt/argon2 in application layer.
SELECT MD5('hello'), SHA1('hello'), SHA2('hello',256);

-- 10) AGGREGATE WINDOW examples (MySQL 8+)
-- Running total with window functions
-- Window functions require MySQL 8+. Use `OVER (...)` to compute aggregates per row (running totals, rank, moving averages).
SELECT id, customer_id, amount,
	SUM(amount) OVER (PARTITION BY customer_id ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM demo_orders;

-- 11) OTHER useful functions
-- INSTR vs LOCATE: both find position but slightly different args
SELECT INSTR('abcabc','b'), LOCATE('b','abcabc');

-- FIND_IN_SET: find value in comma list
-- FIND_IN_SET('value', 'a,b,c') returns 1-based position or 0 if not found. Not index-friendly; prefer normalized tables.
SELECT FIND_IN_SET('x','a,b,x,c') AS pos_x;

-- AES_ENCRYPT / AES_DECRYPT usage note (requires key)
-- AES_ENCRYPT returns binary encrypted data; store in VARBINARY. Key management is critical—do NOT hardcode keys in SQL.
-- SELECT AES_DECRYPT(AES_ENCRYPT('secret','key'),'key');

-- 12) EXAMPLES: combined practical queries
-- 1) Customers with orders in last 30 days and formatted name
SELECT c.id, CONCAT(UPPER(SUBSTRING(c.name,1,1)),LOWER(SUBSTRING(c.name,2))) AS nice_name,
	COUNT(o.id) AS orders_last_30
FROM demo_customers c
LEFT JOIN demo_orders o ON o.customer_id = c.id AND o.order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY c.id;

-- 2) Safe numeric conversion and rounding
SELECT id, CAST(balance AS DECIMAL(10,2)) AS bal_2
FROM demo_customers;

-- 3) Extract email local part and domain
SELECT email,
 LEFT(email, LOCATE('@',email)-1) AS local_part,
 SUBSTRING(email, LOCATE('@',email)+1) AS domain_part
FROM demo_customers;

-- 13) NOTES
-- Use CONCAT_WS to skip NULL parts. Use COALESCE to provide fallbacks.
-- Prefer JSON_EXTRACT with path for JSON fields; -> and ->> are shorthand operators (MySQL specific).
-- Date format specifiers: see MySQL DATE_FORMAT docs for %Y %m %d etc.

-- End of `Table_8_Functions.sql` demo
COMMIT;