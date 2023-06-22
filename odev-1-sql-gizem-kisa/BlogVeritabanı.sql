
-----------------------------TABLOLARIN OLUŞTURULMASI--------------------------------------
-------------------------------------------------------------------------------------------
--1.Adım: Users table
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  username VARCHAR(255) UNIQUE NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  creation_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  is_active BOOLEAN NOT NULL DEFAULT true
);

--2.Adım: Categories table
CREATE TABLE categories (
  category_id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE NOT NULL,
  creation_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--3. Adım: Posts table
CREATE TABLE posts (
  post_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  category_id INT NOT NULL,
  title VARCHAR(50) NOT NULL,
  content TEXT NOT NULL,
  view_count INT NOT NULL DEFAULT 0,
  creation_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  is_published BOOLEAN NOT NULL DEFAULT false,
  FOREIGN KEY (user_id) REFERENCES users (user_id),
  FOREIGN KEY (category_id) REFERENCES categories (category_id)
);

--4.Adım Comments table
CREATE TABLE comments (
  comment_id SERIAL PRIMARY KEY,
  post_id INT NOT NULL,
  user_id INT,
  comment TEXT NOT NULL,
  creation_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  is_confirmed BOOLEAN NOT NULL DEFAULT false,
  FOREIGN KEY (post_id) REFERENCES posts (post_id),
  FOREIGN KEY (user_id) REFERENCES users (user_id)
);

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
------------------------- TABLO VERİLERİNİN OLUŞTURULMASI-------------------------------

--1. users tablosunda minimum 2 kullanıcı bulunmalıdır.
--eklemelerin tamamı "users(2).sql" dosyasındadır. Burada sadece 5/250 gönderi bulunmaktadır.
insert into users (username, email, creation_date) values ('wdall0', 'oolley0@facebook.com', '10/7/2022');
insert into users (username, email, creation_date) values ('jgarnar1', 'ypershouse1@hp.com', '5/16/2023');
insert into users (username, email, creation_date) values ('cbernet2', 'aearie2@comcast.net', '4/20/2023');
insert into users (username, email, creation_date) values ('gshill3', 'mknowlden3@chicagotribune.com', '2/12/2023');
insert into users (username, email, creation_date) values ('gframpton4', 'kdilliston4@ox.ac.uk', '11/28/2022');


--2. posts tablosunda farklı kategorilerde, farklı görüntülenme sayılarında ve farklı
--başlıklarda minimum 50 gönderi bulunmalıdır.

--eklemelerin tamamı "posts.sql" dosyasındadır. Burada sadece 3/55 gönderi bulunmaktadır.
insert into posts (user_id, category_id, title, content, view_count, creation_date) 
values (1, 1, 'Nanny Mcig Bang)', ' pacificus', 1, '2/8/2023');
insert into posts (user_id, category_id, title, content, view_count, creation_date) 
values (2, 3, 'My Bloody Valentine', 'Vanellus chilensis', 2, '4/17/2023');
insert into posts (user_id, category_id, title, content, view_count, creation_date) 
values (3, 4, 'The Gilded Cage', 'Zosterops pallidus', 3, '6/26/2022');


--3. categories tablosunda minimum 3 kategori bulunmalıdır.
INSERT INTO categories (name) VALUES
  ('Travel'),
  ('Movies'),
  ('At'),
  ('Animation'),
  ('Bushcraft'),
  ('Book');


--4. comments tablosunda farklı gönderilere ait, farklı kullanıcılara ait veya kullanıcısı
--olmayan toplam minimum 250 yorum bulunmalıdır. 
--Burada 3/500 gönderi belirtilmiştir. Tüm veriler "comments.sql" dosyasında mevcuttur.
insert into comments (post_id, user_id, comment, creation_date) values (34, 115, 'South Big Horn County Airport', '2023-02-14');
insert into comments (post_id, user_id, comment, creation_date) values (39, 142, 'Blackbushe Airport', '2023-01-12');
insert into comments (post_id, user_id, comment, creation_date) values (17, 54, 'Gaylord Regional Airport', '2022-10-03');


--5. Verilerin creation_date bilgileri birbirinden farklı olmalıdır. (Bu koşul sağlandı)


--------------------------VERİTABANINDA GERÇEKLEŞTİRMEK İSTEDİĞİMİZ İŞLEMLER-----------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

--1. Tüm blog yazılarını başlıkları, yazarları ve kategorileriyle birlikte getirin.

SELECT p.title, u.username AS author, c.name AS category
FROM posts p
JOIN users u ON p.user_id = u.user_id
JOIN categories c ON p.category_id = c.category_id;

--2. En son yayınlanan 5 blog yazısını başlıkları, yazarları ve yayın tarihleriyle birlikte
--alın.

SELECT p.title, u.username AS author, p.creation_date AS publish_date
FROM posts p
JOIN users u ON p.user_id = u.user_id
ORDER BY p.creation_date DESC
LIMIT 5;



--3. Her blog yazısı için yorum sayısını gösterin.

SELECT p.title, COUNT(c.comment_id) AS comment_count
FROM posts p
LEFT JOIN comments c ON p.post_id = c.post_id
GROUP BY p.post_id, p.title;




--4. Tüm kayıtlı kullanıcıların kullanıcı adlarını ve e-posta adreslerini gösterin.

SELECT username, email
FROM users;



--5. En son 10 yorumu, ilgili gönderi başlıklarıyla birlikte alın.

SELECT c.comment, p.title
FROM comments c
INNER JOIN posts p ON c.post_id = p.post_id
ORDER BY c.creation_date DESC
LIMIT 10;


--6. Belirli bir kullanıcı tarafından yazılan tüm blog yazılarını bulun.

SELECT p.title, p.content
FROM posts p
INNER JOIN users u ON p.user_id = u.user_id
WHERE u.username = 'erosennin';



--7. Her kullanıcının yazdığı toplam gönderi sayısını alın.

SELECT u.username, COUNT(p.post_id) AS total_posts
FROM users u
LEFT JOIN posts p ON u.user_id = p.user_id
GROUP BY u.username;

--8. Her kategoriyi, kategorideki gönderi sayısıyla birlikte gösterin.

SELECT c.name AS category_name, COUNT(p.post_id) AS post_count
FROM categories c
LEFT JOIN posts p ON c.category_id = p.category_id
GROUP BY c.name;

--9. Gönderi sayısına göre en popüler kategoriyi bulun.

SELECT c.name AS category_name, COUNT(p.post_id) AS post_count
FROM categories c
JOIN posts p ON c.category_id = p.category_id
GROUP BY c.name
ORDER BY COUNT(p.post_id) DESC
LIMIT 1;

--10. Gönderilerindeki toplam görüntülenme sayısına göre en popüler kategoriyi bulun.

WITH populer_kategori AS (
  SELECT c.name AS category_name, SUM(p.view_count) AS total_views
  FROM categories c
  JOIN posts p ON c.category_id = p.category_id
  GROUP BY c.name
  ORDER BY SUM(p.view_count) DESC
  LIMIT 1
)
SELECT *
FROM populer_kategori;



--11. En fazla yoruma sahip gönderiyi alın.

SELECT p.title, COUNT(c.comment_id) AS total_comments
FROM posts p
JOIN comments c ON p.post_id = c.post_id
GROUP BY p.title
ORDER BY COUNT(c.comment_id) DESC
LIMIT 1;


--12. Belirli bir gönderinin yazarının kullanıcı adını ve e-posta adresini gösterin.

SELECT u.username, u.email
FROM users u
JOIN posts p ON u.user_id = p.user_id
WHERE p.post_id = 56;

--13. Başlık veya içeriklerinde belirli bir anahtar kelime bulunan tüm gönderileri bulun.

SELECT *
FROM posts
WHERE title ILIKE 'THE%' OR content ILIKE 'the%';

--14. Belirli bir kullanıcının en son yorumunu gösterin.

SELECT *
FROM comments
WHERE user_id = 4
ORDER BY creation_date DESC
LIMIT 1;


--15. Gönderi başına ortalama yorum sayısını bulun.

SELECT AVG(comment_count) AS average_comment_count
FROM (
  SELECT post_id, COUNT(*) AS comment_count
  FROM comments
  GROUP BY post_id
) AS comment_counts;

--16. Son 30 günde yayınlanan gönderileri gösterin.

SELECT *
FROM posts
WHERE creation_date >= NOW() - INTERVAL '30 days';


--17. Belirli bir kullanıcının yaptığı yorumları alın.

SELECT *
FROM comments
WHERE user_id = (SELECT user_id FROM users WHERE username = 'naruto');


--18. Belirli bir kategoriye ait tüm gönderileri bulun.

SELECT *
FROM posts
WHERE category_id = (SELECT category_id FROM categories WHERE name = 'Animation');


--19. 5'ten az yazıya sahip kategorileri bulun.

SELECT c.category_id, c.name, COUNT(p.post_id) AS post_count
FROM categories c
LEFT JOIN posts p ON c.category_id = p.category_id
GROUP BY c.category_id, c.name
HAVING COUNT(p.post_id) < 5;

--20. Hem bir yazı hem de bir yoruma sahip olan kullanıcıları gösterin.

SELECT u.user_id, u.username
FROM users u
INNER JOIN posts p ON u.user_id = p.user_id
INNER JOIN comments c ON u.user_id = c.user_id
GROUP BY u.user_id, u.username
HAVING COUNT(DISTINCT p.post_id) > 0 AND COUNT(DISTINCT c.comment_id) > 0;



--21. En az 2 farklı yazıya yorum yapmış kullanıcıları alın.

SELECT u.user_id, u.username
FROM users u
INNER JOIN comments c ON u.user_id = c.user_id
GROUP BY u.user_id, u.username
HAVING COUNT(DISTINCT c.post_id) >= 2;


--22. En az 3 yazıya sahip kategorileri görüntüleyin.

SELECT c.category_id, c.name, COUNT(DISTINCT p.post_id) AS post_count
FROM categories c
INNER JOIN posts p ON c.category_id = p.category_id
GROUP BY c.category_id, c.name
HAVING COUNT(DISTINCT p.post_id) >= 3;


--23. 5'ten fazla blog yazısı yazan yazarları bulun.

SELECT u.user_id, u.username, COUNT(p.post_id) AS post_count
FROM users u
INNER JOIN posts p ON u.user_id = p.user_id
GROUP BY u.user_id, u.username
HAVING COUNT(p.post_id) > 5;


--24. Bir blog yazısı yazmış veya bir yorum yapmış kullanıcıların e-posta adreslerini
--görüntüleyin. (UNION kullanarak)

SELECT email FROM users WHERE user_id IN (
  SELECT DISTINCT user_id FROM posts
  UNION
  SELECT DISTINCT user_id FROM comments
);


--25. Bir blog yazısı yazmış ancak hiç yorum yapmamış yazarları bulun.

SELECT DISTINCT u.username
FROM users u
JOIN posts p ON u.user_id = p.user_id
LEFT JOIN comments c ON p.post_id = c.post_id
WHERE c.comment_id IS NULL;
