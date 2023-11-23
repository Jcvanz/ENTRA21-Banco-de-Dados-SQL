-- Active: 1700757653745@@127.0.0.1@3306@estoque
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
desc_product varchar(150) not null,
unit_price decimal(10,2) not null,
primary key(id_product));

## criar tabela entradas
create table Stock_Entry (
id_entry int auto_increment,
id_produto int not null,
qtnProduct_entry int not null,
date_entry date not null,
primary key(id_entry));

## criar tabela saidas
create table Stock_Exits (
id_exit int auto_increment,
id_produto int not null,
qtnProduct_exits int not null,
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
INSERT INTO estoque.stock_entry (id_produto, qtnProduct_entry, date_entry) VALUES 
(1, 10, '2021-02-10'),
(2, 10, '2023-11-19'),
(3, 8, '2020-12-13'),
(4, 5, '2021-01-06'),
(5, 1, '2021-11-08'),
(6, 3, '2020-05-10'),
(7, 9, '2023-11-21'),
(8, 5, '2022-01-15'),
(9, 7, '2020-11-10'),
(10, 8, '2022-07-10'),
(11, 10, '2021-11-10');

## Utilizando o SELECT para ver se foi adicionado corretamente
SELECT * FROM stock_entry;

## Inserindo produtos na tabela stock_entry, através do INSERT INTO   
INSERT INTO estoque.stock_exits (id_produto, qtnProduct_exits, date_exit) VALUES 
(1, 1, NOW()),
(2, 1, NOW()),
(3, 1, NOW()),
(4, 2, NOW()),
(5, 1, NOW()),
(6, 1, NOW()),
(7, 1, NOW()),
(8, 1, NOW()),
(9, 1, NOW()),
(10, 1, NOW()),
(11, 2, NOW());

## Utilizando o SELECT para ver se foi adicionado corretamente
SELECT * FROM stock_exits;

## Utilizando o UPDATE para alterar a quantidade de produtos
UPDATE stock_exits
SET amount_product = 2
WHERE id_produto = 1;

## Deletando o último registro de saída
DELETE FROM stock_exits
WHERE id_exit = 11;

## Listando as operações de entrada em um determinado período
SELECT id_produto, date_entry
FROM stock_entry
WHERE date_entry BETWEEN '2023-10-20' AND '2023-11-22';

## Mostrando as operações de saída de um produto específico
SELECT *
FROM stock_entry
WHERE date_entry = '2023-11-19';

## Calcular o total de entradas de estoque de cada produto
SELECT id_produto, SUM(amount_product) as total_entradas
FROM stock_entry GROUP BY id_produto;

## 
SELECT
    tbprodutos.id_product,
    tbprodutos.product_name,
    tbentradas.total_entrada,
    tbsaidas.total_saida
    (tbentradas.total_entrada) - (tbsaidas.total_saida) as saldo
    FROM estoque.products tbprodutos
INNER JOIN (SELECT id_produto, SUM(qtnProduct_entry) as total_entrada
    FROM estoque.stock_entry
    GROUP BY id_produto) tbentradas
    ON tbprodutos.id_product = tbentradas.id_produto
INNER JOIN (SELECT id_produto, SUM(qtnProduct_exits) as total_saida
    FROM estoque.stock_exits
    GROUP BY id_produto) tbsaidas
    ON tbprodutos.id_product = tbsaidas.id_produto;