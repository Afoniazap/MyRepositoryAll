Схема БД состоит из четырех таблиц:
Product(maker, model, type)
PC(code, model, speed, ram, hd, cd, price)
Laptop(code, model, speed, ram, hd, price, screen)
Printer(code, model, color, type, price)
Таблица Product представляет производителя (maker), номер модели (model) и тип ('PC' - ПК, 'Laptop' - ПК-блокнот или 'Printer' - принтер). 
Предполагается, что номера моделей в таблице Product уникальны для всех производителей и типов продуктов. В таблице PC для каждого ПК, 
однозначно определяемого уникальным кодом – code, указаны модель – model (внешний ключ к таблице Product), скорость - speed (процессора в мегагерцах), 
объем памяти - ram (в мегабайтах), размер диска - hd (в гигабайтах), скорость считывающего устройства - cd (например, '4x') и цена - price (в долларах). 
Таблица Laptop аналогична таблице РС за исключением того, что вместо скорости CD содержит размер экрана -screen (в дюймах). В таблице Printer для каждой 
модели принтера указывается, является ли он цветным - color ('y', если цветной), тип принтера - type (лазерный – 'Laser', струйный – 'Jet' или матричный – 'Matrix') и цена - price.
1. Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd
		select model,speed,hd 
		from PC where price < 500
2. Найдите производителей принтеров. Вывести: maker
		Select distinct maker 
		from Product 
		where type = 'Printer'
3. Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.
		SELECT
		model, ram, screen
		FROM
		Laptop 	
		WHERE price > 1000 AND model IN (SELECT model FROM Product WHERE type = 'Laptop')
4. Найдите все записи таблицы Printer для цветных принтеров.
		select * from Printer 
		where color = 'y'
5. Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол
		select model, speed, hd 
		from PC
		where cd in ('12x','24x') and price < 600
6. Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.
		select distinct p.maker,
		l.speed 
		from Product p, Laptop l
		where 
		p.model=l.model
		and l.hd >='10'
		and p.type = 'Laptop'
7. Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква)
		SELECT model, price
		FROM PC
		HERE model IN (SELECT model FROM Product WHERE maker = 'B')
		UNION
		SELECT model, price
		FROM Laptop
		WHERE model IN (SELECT model FROM Product WHERE maker = 'B')
		UNION
		SELECT model, price
		FROM Printer
		WHERE model IN (SELECT model FROM Product WHERE maker = 'B')
8. Найдите производителя, выпускающего ПК, но не ПК-блокноты.
		Select distinct maker
		from Product 
		where type ='PC' and maker not in (select maker from Product where type = 'Laptop')
9. Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker
		SELECT DISTINCT Product.maker AS Maker
		FROM Product
		INNER JOIN PC ON Product.model = PC.model
		WHERE PC.speed >= 450;
10. Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price
		SELECT model, price
		FROM Printer
		WHERE price = (SELECT MAX(price) FROM Printer)
11. Найдите среднюю скорость ПК.
		select avg(speed)
		from Pc
12. Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол
		select avg(speed)
		from Laptop
		where price > '1000'
13. Найдите среднюю скорость ПК, выпущенных производителем A.
		Select avg(speed)
		from Pc
		where model in (select model from Product where maker = 'A')
Рассматривается БД кораблей, участвовавших во второй мировой войне. Имеются следующие отношения:
Classes (class, type, country, numGuns, bore, displacement)
Ships (name, class, launched)
Battles (name, date)
Outcomes (ship, battle, result)
Корабли в «классах» построены по одному и тому же проекту, и классу присваивается либо имя первого корабля, построенного по данному проекту, либо названию класса дается имя проекта, которое не совпадает ни с одним из кораблей в БД. Корабль, давший название классу, называется головным.
Отношение Classes содержит имя класса, тип (bb для боевого (линейного) корабля или bc для боевого крейсера), страну, в которой построен корабль, число главных орудий, калибр орудий (диаметр ствола орудия в дюймах) и водоизмещение ( вес в тоннах). В отношении Ships записаны название корабля, имя его класса и год спуска на воду. В отношение Battles включены название и дата битвы, в которой участвовали корабли, а в отношении Outcomes – результат участия данного корабля в битве (потоплен-sunk, поврежден - damaged или невредим - OK).
Замечания. 1) В отношение Outcomes могут входить корабли, отсутствующие в отношении Ships. 2) Потопленный корабль в последующих битвах участия не принимает.

14. Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий
		select s.class, s.name, c.country
		from classes c 
		join Ships s on c.class = s.class
		where numGuns >= '10'
15. Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD
		select hd  
		from PC 
		group by HD
		having count(*) >= 2
16. Найдите пары моделей PC, имеющих одинаковые скорость и RAM. 
	В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i), Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM
		SELECT DISTINCT A.model, B.model, A.speed, A.ram
		FROM PC A, PC B
		WHERE A.speed = B.speed
		AND A.ram = B.ram
		AND A.model > B.model
17. Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК.
	Вывести: type, model, speed
		SELECT DISTINCT 'Laptop' AS type, L.model, L.speed
		FROM Laptop L
		WHERE L.speed < ALL (SELECT P.speed FROM PC P) SQL_DDL
18. Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price
		SELECT p.maker, MIN(pt.price) AS price
		FROM Product p
		JOIN Printer pt ON p.model = pt.model
		WHERE pt.color = 'y'
		GROUP BY p.maker
		HAVING MIN(pt.price) = (
					SELECT MIN(price)
					FROM Printer
					WHERE color = 'y')
19. Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.
Вывести: maker, средний размер экрана.
		SELECT p.maker, AVG(l.screen) AS average_screen_size
		FROM Product p
		JOIN Laptop l ON p.model = l.model
		GROUP BY p.maker
		HAVING COUNT(l.model) > 0;
20. Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК.
		SELECT p.maker, Count(model)
		FROM Product p
		JOIN PC P ON p.model = P.model
		GROUP BY p.maker
		HAVING COUNT(P.model) >= 3;
21. Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC.
Вывести: maker, максимальная цена.
		SELECT P.maker, MAX(PC.price) AS max_price
		FROM Product P
		INNER JOIN PC ON P.model = PC.model
		GROUP BY P.maker;
		
22. Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК с такой же скоростью.
 Вывести: speed, средняя цена.		
		SELECT PC.speed AS speed, AVG(PC.price) AS average_price
		FROM PC
		WHERE PC.speed > 600
		GROUP BY PC.speed
23. Найдите производителей, которые производили бы как ПК
со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц.
Вывести: Maker	
		SELECT maker
		FROM Product
		WHERE model IN (SELECT model FROM PC WHERE speed >= 750)
		INTERSECT
		SELECT maker
		FROM Product
		WHERE model IN (SELECT model FROM Laptop WHERE speed >= 750);
24. Перечислите номера моделей любых типов, имеющих самую высокую цену по всей 
имеющейся в базе данных продукции.
		
		
Первая часть.

Таблица employees

Создать таблицу employees
- id. serial,  primary key,
- employee_name. Varchar(50), not null
Наполнить таблицу employee 70 строками.
1) create table employees(
		id serial primary key,
		employee_name varchar(50) unique not null);

2.1)	DO $$				2.2) 	INSERT INTO employees (employee_name)
BEGIN					select ‘Строка’ ||generate_series(1,70);
FOR i IN 1..70 LOOP						
INSERT INTO employees (employee_name)			
VALUES ('Строка ' || i);					
END LOOP;								
END $$;							
Таблица salary

Создать таблицу salary
- id. Serial  primary key,
- monthly_salary. Int, not null
Наполнить таблицу salary 15 строками:
- 1000
- 1100
- 1200
- 1300
- 1400
- 1500
- 1600
- 1700
- 1800
- 1900
- 2000
- 2100
- 2200
- 2300
- 2400
- 2500
3) create table salary(
		id serial primary key,
		monthly_salary int not null);

4.1)	DO $$				4.2) 	INSERT INTO salary (monthly_salary)
BEGIN								select (1000 + (GENERATE_SERIES(0,14)* 100));
FOR i IN 1..15 LOOP				
INSERT INTO salary (monthly_salary)			
VALUES (1000+(i-1)*100);					
END LOOP;								
END $$;			


Таблица employee_salary

Создать таблицу employee_salary   	create table employee_salary(
- id. Serial  primary key,			id serial primary key,
- employee_id. Int, not null, unique		employee_id int unique not null,
- salary_id. Int, not null			salary_id int not null);
Наполнить таблицу employee_salary 40 строками:
- в 10 строк из 40 вставить несуществующие employee_id

id
employee_id
salary_id
1
3
7
2
1
4
3
5
9
4
40
13
5
23
4
6
11
2
7
52
10
8
15
13
9
26
4
10
16
1
11
33
7
...
...
...


  INSERT INTO employee_salary (employee_id, salary_id)
SELECT
  	  CASE
      	  WHEN n <= 30 THEN n
      	  ELSE n + 69
    	END,
	n
    FROM generate_series(1, 40) AS n;

Таблица roles

Создать таблицу roles		create table roles(
- id. Serial  primary key,		id serial primary key,
- role_name. int, not null, unique	role_name int unique not null,
Поменять тип столба role_name с   ALTER TABLE roles
 int на varchar(30)  			ALTER COLUMN role_name TYPE varchar(30);


Наполнить таблицу roles 20 строками:	INSERT INTO roles (role_name)
						Values (‘Junior Python developer’),
							(‘...’);

id
role_name
1
Junior Python developer
2
Middle Python developer
3
Senior Python developer
4
Junior Java developer
5
Middle Java developer
6
Senior Java developer
7
Junior JavaScript developer
8
Middle JavaScript developer
9
Senior JavaScript developer
10
Junior Manual QA engineer
11
Middle Manual QA engineer
12
Senior Manual QA engineer
13
Project Manager
14
Designer
15
HR
16
CEO
17
Sales manager
18
Junior Automation QA engineer
19
Middle Automation QA engineer
20
Senior Automation QA engineer



Таблица roles_employee

Создать таблицу roles_employee 			create table roles_employee(
- id. Serial  primary key,				id serial primary key,
- employee_id. Int, not null, unique (внешний ключ для таблицы employees, поле id)      
										employee_id int REFERENCES employees(id), 
- role_id. Int, not null (внешний ключ для таблицы roles, поле id) 
										role_id int REFERENCES roles(id));

 Наполнить таблицу roles_employee 40 строками: 
													INSERT INTO roles_employee    (employee_id, role_id) 
													SELECT (random() * 70 + 1)::integer,
															(random() * 20 + 1)::integer
																FROM generate_series(1, 40);




 1. Вывести все поля и все строки.
Select * from tableName;
 2. Вывести всех студентов в таблице
Select * from students;
 3. Вывести только Id пользователей
Select id from students;
 4. Вывести только имя пользователей
Select name from students;
 5. Вывести только email пользователей
Select email from students;
 6. Вывести имя и email пользователей
Select name, email from students;
 7. Вывести id, имя, email и дату создания пользователей
Select id, name, email, created_on  from students;
 8. Вывести пользователей где password 12333
Select * from students where password = ‘12333’;
 9. Вывести пользователей которые были созданы 2021-03-26 00:00:00
Select * from students where created_on = ‘2021-03-26 00:00:00’;
 10. Вывести пользователей где в имени есть слово Анна
Select * from students where name like '%Anna%';
 11. Вывести пользователей где в имени в конце есть 8
Select * from students where name like '%8';
 12. Вывести пользователей где в имени в есть буква а
Select * from students where name like '%a%';
 13. Вывести пользователей которые были созданы 2021-07-12 00:00:00
Select * from students where created_on = ‘2021-07-12 00:00:00’;

 14. Вывести пользователей которые были созданы 2021-07-12 00:00:00 и имеют пароль 1m313
Select * from students where created_on = '2021-07-12 00:00:00' and password = '1m313';
 15. Вывести пользователей которые были созданы 2021-07-12 00:00:00 и у которых в имени есть слово Andrey
Select * from students where created_on = '2021-07-12 00:00:00' and name like '%Andrey%';
 16. Вывести пользователей которые были созданы 2021-07-12 00:00:00 и у которых в имени есть цифра 8
Select * from students where created_on = '2021-07-12 00:00:00' and name like '%8%';
 17. Вывести пользователя у которых id равен 110
Select * from students where id = '110';
 18. Вывести пользователя у которых id равен 153
Select * from students where id = '153';
 19. Вывести пользователя у которых id больше 140
Select * from students where id > '140';
 20. Вывести пользователя у которых id меньше 130
Select * from students where id < '130';
 21. Вывести пользователя у которых id меньше 127 или больше 188
Select * from students where id < '127' or id > '188';
 22. Вывести пользователя у которых id меньше либо равно 137
Select * from students where id <= '137';
 23. Вывести пользователя у которых id больше либо равно 137
Select * from students where id >= '137';
 24. Вывести пользователя у которых id больше 180 но меньше 190
Select * from students where id > '180' and id < '190';
 25. Вывести пользователя у которых id между 180 и 190
Select * from students where id between 180 and 190;
 26. Вывести пользователей где password равен 12333, 1m313, 123313
Select * from students where password in ('12333','1m313','123313');
 27. Вывести пользователей где created_on равен 2020-10-03 00:00:00, 2021-05-19 00:00:00, 2021-03-26 00:00:00
Select * from students where created_on in ('2020-10-03 00:00:00','2021-05-19 00:00:00','2021-03-26 00:00:00');
 28. Вывести минимальный id 
Select min(id) from students; 
 29. Вывести максимальный.
Select max(id) from students;
 30. Вывести количество пользователей
Select count(*) from students;
 31. Вывести id пользователя, имя, дату создания пользователя. Отсортировать по порядку возрастания даты добавления пользоватлеля.
Select id, name, created_on from students order by created_on ;

 32. Вывести id пользователя, имя, дату создания пользователя. Отсортировать по порядку убывания даты добавления пользоватлеля.
Select id, name, created_on from students order by created_on desc ;

SQL HomeWork 2. Joins

Подключится к 
Host: 159.69.151.133
Port: 5056
DB: подключение к той таблице где делали DDL операции
User: подключение к тем пользователем каким делали DDL операции
Pass: 123
Если для какого-то кейса надо сделать дополнительную таблицу, наполнить её данными, то делайте )

 1. Вывести всех работников чьи зарплаты есть в базе, вместе с зарплатами.
Select e.employee_name from employees e
join salary s on e.id = s.id
where s.monthly_salary is not null;
 2. Вывести всех работников у которых ЗП меньше 2000.
Select e.employee_name from employees e
join salary s on e.id = s.id
where s.monthly_salary < 2000;
 3. Вывести все зарплатные позиции, но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
select s.monthly_salary
from salary s
left join employees e on s.id = e.id
where e.id is null;
 4. Вывести все зарплатные позиции  меньше 2000 но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
Select e.employee_name from employees e
join salary s on e.id = s.id
where s.monthly_salary < 2000;
 5. Найти всех работников кому не начислена ЗП.
Select e.employee_name from employees e
join salary s on e.id = s.id
where s.monthly_salary = 0 ;
 6. Вывести всех работников с названиями их должности.
Select e.employee_name, r.role_name from employees e
join roles r on e.id = r.id;
 7. Вывести имена и должность только Java разработчиков.
Select e.employee_name, r.role_name from employees e
join roles r on e.id = r.id
where role_name like '%Java';
 8. Вывести имена и должность только Python разработчиков.
Select e.employee_name, r.role_name from employees e
join roles r on e.id = r.id
where role_name like '%Python%';
 9. Вывести имена и должность всех QA инженеров.
Select e.employee_name, r.role_name from employees e
join roles r on e.id = r.id
where role_name like '%QA%';
 10. Вывести имена и должность ручных QA инженеров.
Select e.employee_name, r.role_name from employees e
join roles r on e.id = r.id
where role_name like '%Manual QA%';
 11. Вывести имена и должность автоматизаторов QA
Select e.employee_name, r.role_name from employees e
join roles r on e.id = r.id
where role_name like '%Automation QA%';
 12. Вывести имена и зарплаты Junior специалистов
Select e.employee_name, s.monthly_salary from employees e
join salary s on e.id = s.id
join roles r on s.id = r.id
where role_name like '%Junior%';
 13. Вывести имена и зарплаты Middle специалистов
Select e.employee_name, s.monthly_salary from employees e
join salary s on e.id = s.id
join roles r on s.id = r.id
where role_name like '%Middle%';
 14. Вывести имена и зарплаты Senior специалистов
Select e.employee_name, s.monthly_salary from employees e
join salary s on e.id = s.id
join roles r on s.id = r.id
where role_name like '%Middle%';
 15. Вывести зарплаты Java разработчиков
Select s.monthly_salary from salary s
join roles r on s.id = r.id
where role_name like '%Java%';
 16. Вывести зарплаты Python разработчиков
Select s.monthly_salary from salary s
join roles r on s.id = r.id
where role_name like '%Python%';
 17. Вывести имена и зарплаты Junior Python разработчиков
Select e.employee_name, s.monthly_salary from employees e
join salary s on e.id = s.id
join roles r on s.id = r.id
where role_name like '%Junior Python%';
 
18. Вывести имена и зарплаты Middle JS разработчиков
Select e.employee_name, s.monthly_salary from employees e
join salary s on e.id = s.id
join roles r on s.id = r.id
where role_name like '%Middle JavaScript%';
 19. Вывести имена и зарплаты Senior Java разработчиков
Select e.employee_name, s.monthly_salary from employees e
join salary s on e.id = s.id
join roles r on s.id = r.id
where role_name like '%Senior Java _%';
 20. Вывести зарплаты Junior QA инженеров
Select s.monthly_salary from salary s
join roles r on s.id = r.id
where role_name like '%Junior% %QA%';
 21. Вывести среднюю зарплату всех Junior специалистов
Select avg(s.monthly_salary) from salary s
join roles r on s.id = r.id
where role_name like '%Junior%';
 22. Вывести сумму зарплат JS разработчиков
Select sum(s.monthly_salary) from salary s
join roles r on s.id = r.id
where role_name like '%JavaScript%';
 23. Вывести минимальную ЗП QA инженеров
Select min(s.monthly_salary) from salary s
join roles r on s.id = r.id
where role_name like '%QA%';
 24. Вывести максимальную ЗП QA инженеров
Select max(s.monthly_salary) from salary s
join roles r on s.id = r.id
where role_name like '%QA%';
 25. Вывести количество QA инженеров
Select count(id) from roles
where role_name like '%QA%';
 26. Вывести количество Middle специалистов.
Select count(id) from roles
where role_name like '%Middle%';
 27. Вывести количество разработчиков
Select count(id) from roles
where role_name like '%developer%';
 28. Вывести фонд (сумму) зарплаты разработчиков.
Select sum(s.monthly_salary) from salary s
join roles r on s.id = r.id
where role_name like '%developer%';
 

29. Вывести имена, должности и ЗП всех специалистов по возрастанию
Select e.employee_name, r.role_name, s.monthly_salary from employees e
join salary s on e.id = s.id
join roles r on s.id = r.id
Order by monthly_salary;
 30. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП от 1700 до 2300
Select e.employee_name, r.role_name, s.monthly_salary from employees e
join salary s on e.id = s.id
join roles r on s.id = r.id
where monthly_salary between 1700 and 2300
Order by monthly_salary;
 31. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП меньше 2300
Select e.employee_name, r.role_name, s.monthly_salary from employees e
join salary s on e.id = s.id
join roles r on s.id = r.id
where monthly_salary <= 2300
Order by monthly_salary;
 32. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП равна 1100, 1500, 2000
Select e.employee_name, r.role_name, s.monthly_salary from employees e
join salary s on e.id = s.id
join roles r on s.id = r.id
where monthly_salary in (1100,1500,2000)
Order by monthly_salary;









































SELECT CustomerName,Price FROM [Customers] c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON od.OrderID = o.OrderID
JOIN Products p ON p.ProductID = od.ProductID
 <scrip>alert(44)</script>
по цепочке подкл таблицы и выводим необходимое

SELECT 'Customers' as TableName , City, CustomerName FROM [Customers]
UNION 
SELECT 'Suppliers' AS TableName, City, ContactName FROM Suppliers
ORDER BY TableName

обьединяем два запроса


SELECT c.* FROM Customers c
LEFT JOIN Orders o 
ON c.CustomerID = o.CustomerID
WHERE OrderID IS NULL


находим людей не сделавших заказ(OrderId IS NULL, IS NOT NULL сделавших)


SELECT ProductName AS "Продукты",Price AS "Цена", Price - Price*0.1 "цена со скидкой",SupplierName,City FROM Suppliers
a JOIN Products b ON a.SupplierID=b.SupplierID


делаем дополнительніе столбики со скидкой и обьединяем табл
SELECT ShipperName,SupplierName FROM Shippers s
JOIN Orders o ON s.ShipperID = o.OrderID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON p.ProductID = od.ProductID
JOIN Suppliers s ON p.SupplierID = s.SupplierID

SELECT 'Shippers' as TableName, ShipperName  FROM Shippers
UNION
SELECT 'Suppliers' as TableName, SupplierName FROM Suppliers

НАЗІВАЕМ ИМЯ В СТОЛБИКЕ

SELECT ShipperName as Shippers FROM [Shippers]
UNION
SELECT SupplierName as Suppliers FROM Suppliers
ORDER BY Suppliers

SELECT имена_столбцов_таблицы_1, имена_столбцов_таблицы_2 FROM имя_таблицы_1, имя_таблицы_2;


SELECT e.EmployeeID,FirstName, COUNT (o.EmployeeID)
FROM Employees e
Join Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID   //Запрос работников принявших заказі

SELECT e.EmployeeID,FirstName, COUNT (o.EmployeeID)
FROM Employees e
Join Orders o ON e.EmployeeID = o.EmployeeID
WHERE FirstName NOT IN ('Nancy','Andrew','Steven')
GROUP BY e.EmployeeID     //Запрос работников принявших заказі без некоторіх имен

SELECT e.EmployeeID,FirstName, COUNT (o.EmployeeID)
FROM Employees e
Join Orders o ON e.EmployeeID = o.EmployeeID
WHERE FirstName NOT IN ('Nancy','Andrew','Steven')
GROUP BY e.EmployeeID
HAVING COUNT (o.EmployeeID) > 15 //Запрос работников принявших заказі без некоторіх имен и с условием фильтром

SELECT e.EmployeeID, FirstName, COUNT(o.EmployeeID)
FROM Employees AS e
JOIN Orders o ON e.EmployeeID  = o.EmployeeID
WHERE FirstName NOT IN (SELECT FirstName FROM Employees WHERE EmployeeID IN (1,2,3,4,5))
GROUP BY e.EmployeeID
HAVING COUNT(o.EmployeeID) > 15  ////Запрос работников принявших заказі без некоторіх имен и с подзапросом

SELECT Address, SUM(Price) SUM 
FROM Suppliers s
Join Products p ON s.SupplierID = p.SupplierID
GROUP BY Address
HAVING AVG(Price) > 45

SELECT ProductName, Price From Products
Where Price > (Select AVG(Price) From Products)  //назв товара и цена больше средней

SELECT Count(Distinct ShipperID) from Orders  //кол-во перевозчиков


Select Count * from Shippers //кол-во перевозчиков

INSERT INTO Customers(CustomerName,Address,PostalCode)
 Values ('Иван', 'Винница', '353424'),('','','')  //добавляем 

Delete from Customers
where country = 'Mexico'    //удаляем

Delete from Customers
where country is null          

SELECT MAX(amount) FROM sales2005
Данный запрос вернет нам сумму 5000. Для того, чтобы понять кто из
сотрудников получает максимальную зарплату достаточно сделать:
SELECT person FROM sales2005 WHERE amount = 5000
Но в явном виде максимум неизвестен. Сегодня он 5000, а завтра уже
10000. Нужно универсальное решение, которого можно добиться с
помощью использования агрегтов:
SELECT person FROM sales2005
WHERE amount = (SELECT MAX(amount) FROM sales2005)
И получилось! Обратите внимание на синтаксис. Через подзапрос
мы достаём одиночное значение (5000), а дальше оно встаёт в
основной запрос. Таким образом, благодаря подзапросам, мы можем
использовать сколь угодно сложную логику.

Исходя из изученных нами положений, выведем общий синтаксис
запроса:
SELECT [DISTINCT] {список_вывода_через_запятую | *}
FROM таблица_1 AS псевдоним_1
[INNER/LEFT/RIGHT/FULL] JOIN таблица_2 AS псевдоним_2
ON псевдоним_1.поле_1 = псевдоним_2.поле_2
[INNER/LEFT/RIGHT/FULL] JOIN ... --- сколько угодно JOIN’ов
--- возможны множественные условия
--- с AND, OR, IN и т.д.

ON ... AND ...
WHERE условие_отбора_записей
GROUP BY поля_через_запятую
HAVING условие_отбора_групп --- с AND, OR, IN ит.д.
UNION / EXCEPT /INTERSECT --- если ведётся работа с множествами
SELECT .... -- новый запрос (множество) аналогично
...
ORDER BYполя_через_запятую