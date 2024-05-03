USE Scientists;
SELECT 'This is SQL Exercise, Practice and Solution';

-- Escreva uma query para exibir o nome como “Nome do Projeto” e as horas como “Tempo de Trabalho” de cada projeto.
SELECT Name AS "Nome do Projeto", Hours AS "Tempo de Trabalho" FROM Projects;

-- Escreva uma query para exibir o nome dos cientistas em ordem alfabética.
SELECT Name FROM Scientists
ORDER BY Name ASC;

-- Escreva uma query para exibir o nome dos Projetos em ordem alfabética descendente.
SELECT Name FROM Projects
order by Name DESC;

-- Escreva uma query que exiba a string “O projeto Name precisou de Hours horas para ser concluído.” para cada projeto.
SELECT CONCAT('O projeto ',' ', Name,' ', 'Precisou de',' ', Hours,' ', ' horas para ser concluído') as resultado FROM Projects;

-- Escreva uma query para exibir o nome e as horas dos três projetos com a maior quantidade de horas.
SELECT Name AS 'Nome do Projeto', Hours AS 'Horas do projeto' FROM Projects
ORDER BY Hours DESC LIMIT 3;

-- Escreva uma query para exibir o código de todos os projetos da tabela AssignedTo sem que haja repetições.alter.
SELECT DISTINCT Project FROM AssignedTo;

-- Escreva uma query para exibir o nome do projeto com maior quantidade de horas.
SELECT Name, Hours FROM Projects
ORDER BY Hours DESC LIMIT 1;

-- Escreva uma query para exibir o nome do segundo projeto com menor quantidade de horas.
SELECT Name FROM Projects
ORDER BY Hours ASC LIMIT 1 OFFSET 1;

-- Escreva uma query para exibir todas as informações dos cinco projetos com a menor quantidade de horas.
SELECT * FROM Projects
ORDER BY Hours ASC LIMIT 5;

-- Escreva uma query que exiba a string “Existem Number cientistas na tabela Scientists.”, em que Number se refira a quantidade de cientistas.
SELECT CONCAT('Existem ', COUNT(Name), ' cientistas na tabela Scientists') FROM Scientists;

-- 



-----------------------------------------------------------------------------------------------------------------------------------------------------------------




USE Store;
SELECT 'This is SQL Exercise, Practice and Solution';

-- Vamos lá! Faça uma consulta na tabela itens que retorne todos os dados em que a coluna name comece com as letras GR.
SELECT * FROM itens
WHERE name LIKE 'GR%';

-- Agora, escreva uma query para retornar da tabela supplies os dados em que a coluna item_id possua o valor 2. Organize o resultado por ordem alfabética de supplier_id.
SELECT * FROM supplies
WHERE item_id = 2 ORDER BY supplier_id;

-- Em seguida, faça uma consulta para exibir item_id, price e supplier_id de supplies em que o valor de supplier_id tenha a letra N.
SELECT item_id, price, supplier_id from supplies
WHERE supplier_id LIKE '%n%';

-- Avante, falta pouco! Escreva uma query para exibir todas as informações de suppliers que são empresas limitadas (LTDA). Ordene esses resultados em ordem alfabética decrescente.
SELECT * FROM suppliers 
Where name LIKE '%LTDA%' ORDER BY name DESC;

-- Agora, faça uma consulta para exibir o número de empresas (suppliers) que contém a letra F no código.
SELECT COUNT(id) from suppliers
Where id Like '%F%';

-- Quase lá! Agora escreva uma query para exibir de supplies, itens que custam mais de $15 e menos de $40. Ordene os resultados por ordem crescente.
SELECT * FROM supplies
Where price between 16 and 39;

-- Por fim, faça uma query para exibir o número de vendas (sales) feitas entre os dias 15/04/2018 e 30/07/2019.
SELECT COUNT(*) FROM sales
where DATE(order_date) between '2018-04-15' and '2019-07-30';


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Insira um novo funcionário na tabela sakila.staff
INSERT INTO sakila.staff  (first_name, last_name, address_id, email, store_id, active, username, password)
values('João', 'Fabris', 2, 'exemplo@gamil.com', 1, 1, 'joaofabris', '123123');

SELECT * FROM sakila.staff
WHERE first_name like 'João';

-- Feito o exercício anterior, vamos agora para o nível 2. Insira dois funcionários novos em apenas uma query.
INSERT INTO sakila.staff (first_name, last_name, address_id, email, store_id, active, username, password)
values('Jeff', 'Bezos', 2, 'jeffbezos@gmail.com', 1, 1, 'jeffb', 'ImTheChamp'),
    ('Sekiro', 'Okami', 2, 'sekirowolf@gmail.com', 1, 1, 'okami', 'SekiroTheSamurai');

-- Selecione os cinco primeiros nomes e sobrenomes da tabela sakila.customer e cadastre essas pessoas como atores na tabela sakila.actor.
INSERT INTO sakila.actor(first_name, last_name)
SELECT first_name, last_name
FROM sakila.customer
ORDER BY customer_id
LIMIT 5;

-- Cadastre três categorias de uma vez só na tabela sakila.category.
INSERT INTO sakila.category (name)
VALUES 
	('Sci-Fi'),
    ('Fantasy'),
    ('Biography');

-- Cadastre uma nova loja na tabela sakila.store.
INSERT INTO sakila.store(manager_staff_id, address_id)
VALUES (3,3);

-- cadastre 'joe' na tabela actor, aonde o id é 1,2,3
SET SQL_SAFE_UPDATES = 0;
UPDATE sakila.actor
SET first_name = 'JOE'
WHERE actor_id IN (1,2,3);

UPDATE sakila.actor
SET first_name = (
CASE actor_id WHEN 1 THEN 'JOE' -- se actor_id = 1, alterar first_name para 'JOE'
              WHEN 2 THEN 'DAVIS' -- se actor_id = 2, alterar first_name para 'DAVIS'
              WHEN 3 THEN 'CAROLINE' -- se actor_id = 3, alterar first_name para 'CAROLINE'
          ELSE first_name -- em todos os outros casos, mantém-se o first_name
END);

-- Delete GRACE, sabendo que ele tem referencias entre outras tabelas
DELETE FROM sakila.film_actor
WHERE actor_id = 7; -- actor_id = 7 GRACE

DELETE FROM sakila.film_actor
WHERE actor_id = 7; -- actor_id = 7 GRACE

-- Exclua do banco de dados o ator com o nome de “KARL”.
-- Primeiro descubra os IDs relacionados ao nome
SELECT actor_id
FROM sakila.actor
WHERE first_name = 'KARL';

-- Em seguida, apague suas referências
DELETE FROM sakila.film_actor
WHERE actor_id = 12;

-- Depois exclua o item original
DELETE FROM sakila.actor
WHERE first_name = 'KARL';

-- Exclua da tabela film_text todos os registros que possuem a palavra “saga” em suas descrições.
DELETE FROM sakila.film_text
WHERE DESCRIPTION LIKE '%saga%';

-- Apague da maneira mais performática possível todos os registros das tabelas film_actor e film_category.
TRUNCATE sakila.film_actor;
TRUNCATE sakila.film_category;

-- Usando o IF na tabela sakila.film, exiba o id do filme, o título e uma coluna extra chamada ‘filme visto?’, em que deve-se avaliar se o nome do filme é ‘ACE GOLDFINGER‘. Caso seja, exiba “OK”. Caso contrário, exiba “FALTA ASSISTIR”. Não esqueça de usar um alias para renomear a coluna da condicional.
SELECT
    film_id,
    title,
    IF(title = 'ACE GOLDFINGER', 'OK', 'FALTA ASSISTIR') AS 'filme visto?'
FROM sakila.film;


-- Usando o CASE na tabela sakila.film, exiba o título, a classificação indicativa (rating) e uma coluna extra que vamos chamar de ‘grupo-alvo’ em que colocaremos a classificação do filme de acordo com as seguintes siglas:
G: “Livre para todas as idades”;
PG: “Maiores de 10 anos”;
PG-13: “Maiores de 13 anos”;
R: “Maiores de 17 anos”;
Se não cair em nenhuma das classificações anteriores: “Proibido para menores de idade”.



SELECT
    title, 
    rating, 
    CASE
        WHEN rating = 'G' THEN 'Livre para todas as idades'
        WHEN rating = 'PG' THEN 'Maiores de 10 anos' 
        WHEN rating = 'PG-13' THEN 'Maiores de 13 anos'
        WHEN rating = 'R' THEN 'Maiores de 17 anos'
        ELSE 'Proibido para menores de idade'
    END AS 'grupo-alvo'
FROM sakila.film;

-- Monte uma query que exiba a diferença de dias entre '2030-01-20' e hoje.

SELECT DATEDIFF('2030-01-20', NOW());
-- OU
SELECT DATEDIFF('2030-01-20', CURRENT_DATE());

-- Monte uma query exiba a diferença de horas entre '10:25:45' e '11:00:00'.
Monte uma query exiba a diferença de horas entre '10:25:45' e '11:00:00'.

-- Usando a coluna replacement_cost (valor de substituição), vamos encontrar:
SELECT AVG(replacement_cost) FROM sakila.film; -- 19.984000 (Média entre todos registros)
SELECT MIN(replacement_cost) FROM sakila.film; -- 9.99 (Menor valor encontrado)
SELECT MAX(replacement_cost) FROM sakila.film; -- 29.99 (Maior valor encontrado)
SELECT SUM(replacement_cost) FROM sakila.film; -- 19984.00 (Soma de todos registros)
SELECT COUNT(replacement_cost) FROM sakila.film; -- 1000 registros encontrados (Quantidade)

-- agrupe o nome dos atores em quantidade de mesmo nomes que existem 
SELECT first_name, COUNT(*) as Quantidade FROM sakila.actor
GROUP BY first_name;

--  Escreva uma query que exiba o maior salário da tabela. 
SELECT SUM(salary)
FROM hr.employees;	

-- Escreva uma query que exiba a diferença entre o maior e o menor salário.
SELECT MAX(salary) - MIN(salary)
FROM hr.employees;

-- Escreva uma query que exiba a média salarial de cada job_id, ordenando pela média salarial em ordem decrescente.
SELECT job_id, AVG(salary) as 'avg_salary' FROM hr.employees
GROUP BY job_id
ORDER BY avg_salary DESC;

-- Escreva uma query que exiba a quantidade de dinheiro necessária para realizar o pagamento de todas as pessoas funcionárias.
SELECT SUM(salary)
FROM hr.employees;

-- Escreva uma query que exiba quatro informações: o maior salário, o menor salário, a soma de todos os salários e a média dos salários. Todos os valores devem ser formatados para ter apenas duas casas decimais.
SELECT MAX(salary), MIN(salary), SUM(salary), ROUND(AVG(salary), 2)
from hr.employees;

-- Escreva uma query que exiba a quantidade de pessoas que trabalham como pessoas programadoras (it_prog).
select job_id, count(*) as 'total'
FROM hr.employees
WHERE job_id = 'it_prog';

--  Escreva uma query que exiba a quantidade de dinheiro necessária para efetuar o pagamento de cada profissão (job_id).
SELECT job_id, SUM(salary) from hr.employees
GROUP BY job_id;

--  Utilizando a query anterior, faça as alterações para que seja exibido somente a quantidade de dinheiro necessária para cobrir a folha de pagamento das pessoas programadoras (it_prog).
SELECT job_id, SUM(salary) from hr.employees
WHERE job_id = 'it_prog';

-- Escreva uma query que exiba em ordem decrescente a média salarial de todos os cargos, exceto das pessoas programadoras (it_prog).
SELECT job_id, avg(salary) from hr.employees
where job_id <> 'it_prog'
group by job_id
ORDER BY salary DESC;

--  Escreva um query que exiba média salarial e o número de funcionários de todos os departamentos com mais de dez funcionários. Dica: agrupe pelo department_id.
select department_id, avg(salary) as 'avg_salary', count(*) as 'number_employees' from hr.employees
group by department_id
HAVING number_employees > 10;

-- Escreva uma query que atualize a coluna phone_number, de modo que todos os telefones iniciados por 515 agora devem iniciar com 777.
update hr.employees
set phone_number = replace(phone_number, '515', '777')
where phone_number like '515%';

-- Escreva uma query que só exiba as informações dos funcionários cujo o primeiro nome tenha oito ou mais caracteres.
SELECT * from hr.employees
where length(first_name) >= 8;

-- Escreva uma query que exiba as seguintes informações de cada funcionário: id, primeiro nome e ano no qual foi contratado (exiba somente o ano).
select employee_id, first_name, year(hire_date) as 'hire_year' from hr.employees;

-- . Escreva uma query que exiba as seguintes informações de cada funcionário: id, primeiro nome e mês no qual foi contratado (exiba somente o mês)
select employee_id, first_name, month(hire_date) as 'hire_month' from hr.employees;

-- Escreva uma query que exiba os nomes dos funcionários em letra maiúscula.
select upper(concat(first_name, ' ', last_name)) from hr.employees;

--  Escreva uma query que exiba o sobrenome e a data de contratação de todos os funcionário contratados em julho de 1987.
select last_name, hire_date from hr.employees
where month(hire_date) = 7 and year(hire_date) =1987;

-- Escreva uma query que exiba as seguintes informações de cada funcionário: nome, sobrenome, tempo que trabalha na empresa (em dias).
select first_name, last_name, datediff(current_date(), hire_date) from hr.employees;




-------------------------------------------------------------------------------------------------------------------------------------------------------------



-- Utilizando o INNER JOIN, encontre as vendas nacionais (domestic_sales) e internacionais (international_sales) de cada filme.
select m.title, b.domestic_sales, b.international_sales
from movies m
inner join box_office b on b.movie_id = m.id;

-- Utilizando o INNER JOIN, faça uma busca que retorne o número de vendas para cada filme que possui um número maior de 
-- vendas internacionais (international_sales) do que vendas nacionais (domestic_sales).
select m.title, b.domestic_sales, b.international_sales
from movies m
inner join box_office b on b.movie_id = m.id
where b.international_sales > b.domestic_sales;

-- Utilizando o INNER JOIN, faça uma busca que retorne os filmes e sua avaliação (rating) em ordem decrescente.
select m.title, b.rating
from movies m
inner join box_office b on b.movie_id = m.id
order by rating desc;

-- Utilizando o LEFT JOIN, faça uma busca que retorne todos os dados dos cinemas, mesmo os que não possuem filmes em cartaz e, adicionalmente, 
-- os dados dos filmes que estão em cartaz nestes cinemas. Retorne os nomes dos cinemas em ordem alfabética.
select t.name, t.location, m.title, m.director, m.year, m.length_minutes
from theater t
left join movies m on t.id = m.theater_id
order by t.name;

--  Utilizando o RIGHT JOIN, faça uma busca que retorne todos os dados dos filmes, mesmo os que não estão em cartaz e, adicionalmente, os dados dos cinemas que possuem estes filmes em cartaz.
-- Retorne os nomes dos cinemas em ordem alfabética
select t.id, t.name, t.location, m.title, m.director, m.year, m.length_minutes
from theater t
right join movies m on t.id = m.theater_id
order by t.name;





---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Um zoológico precisa de um banco de dados para armazenar informações sobre os seus animais. As informações a serem armazenadas sobre cada animal são:

-- Nome;

-- Espécie;

-- Sexo;

-- Idade;

-- Localização.

-- Cada animal também possui vários cuidadores, e cada cuidador pode ser responsável por mais de um animal. Além disso, cada cuidador possui um gerente, sendo que cada gerente pode ser responsável por mais de um cuidador.

-- Siga os passos aprendidos no dia de hoje para modelar essa base de dados.



DROP SCHEMA IF EXISTS zoologico;
CREATE SCHEMA zoologico;
USE zoologico;

CREATE TABLE animal(
	animal_id INT PRIMARY KEY auto_increment,
    nome VARCHAR(50) not null,
    especie varchar(50) not null,
    sexo varchar(50) not null,
    idade int not null,
    localizacao varchar(50) not null
);

CREATE TABLE gerente(
	gerente_id int primary key auto_increment,
    nome varchar(50) not null
);

CREATE TABLE cuidador(
	cuidador_id int primary key auto_increment,
    nome varchar(50) not null,
    gerente_id int not null,
    foreign key (gerente_id) references gerente (gerente_id)
);

CREATE TABLE animal_cuidador(
	animal_id int not null,
    cuidador_id int not null,
	CONSTRAINT PRIMARY KEY(animal_id, cuidador_id),
    FOREIGN KEY (animal_id) REFERENCES animal (animal_id),
    FOREIGN KEY (cuidador_id) REFERENCES cuidador (cuidador_id)
);

