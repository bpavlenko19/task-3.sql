-- Загальна кількість фільмів у кожній категорії (film_category)
SELECT c.name AS category, COUNT(f.film_id) AS film_count
FROM category c
LEFT JOIN film_category fc ON c.category_id = fc.category_id
LEFT JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

--Середня тривалість фільмів у кожній категорії (film_category)
SELECT c.name AS category, AVG(f.length) AS average_duration
FROM category c
LEFT JOIN film_category fc ON c.category_id = fc.category_id
LEFT JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

-- Мінімальна та максимальна тривалість фільмів
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration
FROM film;

-- Загальна кількість клієнтів
SELECT COUNT(customer_id) AS total_customers
FROM customer;

-- Сума платежів по кожному клієнту
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, SUM(p.amount) AS total_payments
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

-- П'ять клієнтів з найбільшою сумою платежів
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, SUM(p.amount) AS total_payments
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_payments DESC
LIMIT 5;

-- Загальна кількість орендованих фільмів кожним клієнтом
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, COUNT(r.rental_id) AS rentals_count
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- Середній вік фільмів у базі даних
SELECT AVG(EXTRACT(YEAR FROM CURRENT_DATE) - f.release_year) AS average_age
FROM film f;

-- Кількість фільмів, орендованих за певний період (змінити дати на необхідні)
SELECT COUNT(r.rental_id) AS rentals_count
FROM rental r
WHERE r.rental_date BETWEEN '2023-01-01' AND '2023-12-31';

-- Сума платежів по кожному місяцю
SELECT DATE_TRUNC('month', p.payment_date) AS month, SUM(p.amount) AS total_payments
FROM payment p
GROUP BY month
ORDER BY month;

-- Максимальна сума платежу, здійснена клієнтом
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, MAX(p.amount) AS max_payment
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

-- Середня сума платежів для кожного клієнта
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, AVG(p.amount) AS average_payment
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

-- Кількість фільмів у кожному рейтингу (rating)
SELECT f.rating, COUNT(f.film_id) AS film_count
FROM film f
GROUP BY f.rating;

-- Середня сума платежів по кожному магазину (store)
SELECT s.store_id, AVG(p.amount) AS average_payment
FROM store s
JOIN customer c ON s.store_id = c.store_id
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY s.store_id;
