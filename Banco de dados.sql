## criar database
create database Estoque;

## criar ususário
create user 'user_estoque'@'localhost' identified by '1234';

## premissões
grant all on * . * to  'user_estoque'@'localhost';

## criar tabela produtos
create table Products (
id_product int auto_increment,
product_name varchar(45) not null,
description varchar(250) not null,
unit_price decimal(10,2) not null,
primary key(id_product));

## criar tabela entradas
create table Stock_Entry (
id_entry int auto_increment,
id_produto int not null,
amount_product decimal(10,2) not null,
date_entry date not null,
primary key(id_entry));

/*
Criar restrição para a chave estrangeira: 
alter table <tabela_origem> add constraint <nome_restrição> foreing key 
(<campo_tabela_origem>) references <tabela_destino> (<campo_tabela_destino>)
--- ou ---
ALTER TABLE `estoque`.`stock_entry` 
ADD INDEX `id_product_idx` (`id_produto`);
ALTER TABLE `estoque`.`stock_entry` 
ADD CONSTRAINT `id_product`
  FOREIGN KEY (`id_produto`)
  REFERENCES `estoque`.`products` (`id_product`);
*/

## criar tabela saidas
create table Stock_Exits (
id_exit int auto_increment,
id_produto int not null,
amount_product decimal(10,2) not null,
date_exit date not null,
primary key(id_exit));

ALTER TABLE `estoque`.`stock_exits` 
ADD INDEX `id_product_idx` (`id_produto`);
ALTER TABLE `estoque`.`stock_exits` 
ADD CONSTRAINT `id_product`
  FOREIGN KEY (`id_produto`)
  REFERENCES `estoque`.`products` (`id_product`);