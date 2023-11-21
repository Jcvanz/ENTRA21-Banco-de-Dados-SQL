-- Active: 1699287688735@@127.0.0.1@3306@estoque
-- Active: 1699287688735@@127.0.0.1@3306@estoque

## Criando o database
CREATE DATABASE Estoque;

## Criando o usuário
CREATE USER 'user_estoque'@'localhost' IDENTIFIED BY '1234';

## Concedendo as premissões para o usuário 
GRANT ALL ON * . * TO  'user_estoque'@'localhost';

## Comandao para ver se foi criado o usuário
SELECT user FROM mysql.user;

## criar tabela produtos
create table Products (
id_product int auto_increment,
product_name varchar(45) not null,
unit_price decimal(10,2) not null,
desc_product varchar(150) not null,
primary key(id_product));

## criar tabela entradas
create table Stock_Entry (
id_entry int auto_increment,
id_produto int not null,
amount_product int not null,
date_entry date not null,
primary key(id_entry));

## criar tabela saidas
create table Stock_Exits (
id_exit int auto_increment,
id_produto int not null,
amount_product int not null,
date_exit date not null,
primary key(id_exit));

## Alterando a tabela stock_exits para acrescentar a FOREIGN KEY id_produto (referente a tabela products)
ALTER TABLE Estoque.stock_exits 
ADD CONSTRAINT id_product
FOREIGN KEY (id_produto)
REFERENCES estoque.products (id_product);

## Alterando a tabela stock_entry para acrescentar a FOREIGN KEY id_produto (referente a tabela products)
ALTER TABLE estoque.stock_entry
ADD CONSTRAINT id_produto
FOREIGN KEY (id_produto)
REFERENCES estoque.products (id_product);

## Inserindo produtos na tabela products, através do INSERT INTO   
INSERT INTO estoque.products (product_name, unit_price, desc_product) VALUES 
('Tênis ADIDAS Masc', 150.99, 'Tênis disponível nas cores: azul, branco, vermelho, amarelo'),
('Tênis ADIDAS Fem', 170.99, 'Tênis disponível nas cores: azul, branco, vermelho, amarelo') ,
('Tênis NIKE Masc', 200.99, 'Tênis disponível nas cores: azul, branco, vermelho, amarelo'),
('Tênis NIKE Fem', 50.99, 'Tênis disponível nas cores: azul, branco, vermelho, amarelo'),
('Tênis UMBRO Masc', 100.99, 'Tênis disponível nas cores: azul, branco, vermelho, amarelo'),
('Tênis VANS Masc', 124.99, 'Tênis disponível nas cores: azul, branco, vermelho, amarelo'),
('Tênis VANS Masc', 130.99, 'Tênis disponível nas cores: azul, branco, vermelho, amarelo'),
('Tênis PUMA Masc', 308.99, 'Tênis disponível nas cores: azul, branco, vermelho, amarelo'),
('Tênis PUMA Fem', 50.99, 'Tênis disponível nas cores: azul, branco, vermelho, amarelo'),
('Tênis ADIDAS Masc', 260.99, 'Tênis disponível nas cores: azul, branco, vermelho, amarelo'),
('Tênis NIKE Masc', 400.99, 'Tênis disponível nas cores: azul, branco, vermelho, amarelo');

## Utilizando o SELECT para ver se foi adicionado corretamente
SELECT * FROM products;

## Inserindo produtos na tabela stock_entry, através do INSERT INTO   
INSERT INTO estoque.stock_entry (id_produto, amount_product, date_entry) VALUES 
(1, 10, NOW()),
(2, 10, NOW()),
(3, 8, NOW()),
(4, 5, NOW()),
(5, 1, NOW()),
(6, 3, NOW()),
(7, 9, NOW()),
(8, 5, NOW()),
(9, 7, NOW()),
(10, 8, NOW()),
(11, 10, NOW());

## Utilizando o SELECT para ver se foi adicionado corretamente
SELECT * FROM stock_entry;

## Inserindo produtos na tabela stock_entry, através do INSERT INTO   
INSERT INTO estoque.stock_exits (id_produto, amount_product, date_exit) VALUES 
(1, 10, NOW()),
(2, 10, NOW()),
(3, 8, NOW()),
(4, 5, NOW()),
(5, 1, NOW()),
(6, 3, NOW()),
(7, 9, NOW()),
(8, 5, NOW()),
(9, 7, NOW()),
(10, 8, NOW()),
(11, 10, NOW());

## Utilizando o SELECT para ver se foi adicionado corretamente
SELECT * FROM stock_entry;

## Utilizando o UPDATE para alterar a quantidade de produtos
UPDATE stock_exits
SET amount_product = 2
WHERE id_produto = 1;

## Utilizando o SELECT para ver se foi atualizado corretamente
SELECT * FROM stock_exits;

## Deletando o último registro de saída
DELETE FROM stock_exits
WHERE id_exit = 11;





alter table stock_entry 
drop COLUMN amount_product ;