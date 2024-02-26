-----------------------------

drop database producaodb;

-----------------------------


--Database
create database producaodb
go

use producaodb
go

--Tables
create table fabricantes(
codfabricante smallint primary key identity(1,1),
nomefabricante varchar(30)
);

create table produtos(
codproduto int primary key identity(10,1),
nomeproduto varchar(30),
codfabricante smallint,
foreign key (codfabricante) references fabricantes(codfabricante)
);

create table lotes(
numlote int primary key identity(100,1),
datavalidade date,
precounitario decimal(10,2),
quantidade smallint default 100,
valorlote decimal(10,2),
codproduto int,
foreign key(codproduto) references produtos(codproduto)
);


--Inserts
insert into fabricantes(nomefabricante) values
('Clear'),
('Rexona'),
('Jhonson & Jhonson'),
('Coleston'),
('Ancora')

insert into produtos(nomeproduto, codfabricante) values
('Sabonete em barra',2),
('Shampoo Anticaspa',1),
('Desodorante Aerosol Neutro',2),
('Sabonete Liquido',2),
('Protetor Solar 30',3),
('Shampoo 2 em 1',2),
('Desodorante Aerosol Morango', 2),
('Shampoo Anticaspa',2),
('Protetor Solar 60',3),
('Desodorante Rollon',1),
('Sabonete de Glicerina',5)

---------------------------------------------------------------------------------------------
--Update
update lotes
set valorlote = quantidade * precounitario
where numlote >=100;


---------------------------------------------------------------------------------------------


-- Inserindo registros na tabela lOTE.
INSERT INTO lotes ( datavalidade, precounitario, quantidade, codproduto) VALUES ('2028-08-05', 9.90, 500, 18);
INSERT INTO lotes ( datavalidade, precounitario, quantidade, codproduto) VALUES ('2027-05-01', 8.47, 500, 10);
INSERT INTO lotes ( datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES ('2028-06-02', 11.50, 750, DEFAULT, 19);
INSERT INTO lotes ( datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES ('2026-02-01', 12.37, 383, DEFAULT, 18);
INSERT INTO lotes ( datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES ('2027-01-01', 10.00, 400, DEFAULT, 17);
INSERT INTO lotes ( datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES ('2026-04-07', 11.50, DEFAULT, DEFAULT, 15);
INSERT INTO lotes ( datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES ('2023-06-08', 10.30, 320, DEFAULT, 17);
INSERT INTO lotes ( datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES ('2024-10-20', 13.90, 456, DEFAULT, 12);
INSERT INTO lotes ( datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES ('2026-07-20', 7.53, 750, DEFAULT, 13);
INSERT INTO lotes ( datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES ('2025-05-13', 8.00, 720, DEFAULT, 11);
INSERT INTO lotes ( datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES ('2027-06-05', 9.50, 860, DEFAULT, 13);
INSERT INTO lotes ( datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES ('2028-03-02', 14.50, 990, DEFAULT, 14);
INSERT INTO lotes ( datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES ('2028-04-05', 11.40, 430, DEFAULT, 14);
INSERT INTO lotes ( datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES ('2025-06-04', 11.30, 200, DEFAULT, 12);
INSERT INTO lotes ( datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES ('2027-10-06', 12.76, 380, DEFAULT, 19);
INSERT INTO lotes ( datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES ('2028-11-06', 8.30, 420, DEFAULT, 17);
INSERT INTO lotes ( datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES ('2027-10-20', 8.99, 361, DEFAULT, 19);
INSERT INTO lotes ( datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES ('2024-11-15', 10.09, 713, DEFAULT, 11);



-----------------------------------------------------
-----------------------TESTES------------------------
-----------------------------------------------------


--Lotes com data de validade para 
select * from lotes where year(datavalidade)='2024';

--Quantos lotes possuem data de validade
select count(datavalidade)
from lotes
where year(datavalidade)='2025';

--Quantos lotes existem para cada produto
select count(numlote) from lotes;

--Qual o valor total de lotes de um determinado produto
select sum(valorlote) as Total from lotes;

--Criar lista ordenada de lotes por data de validade
select * from lotes order by datavalidade asc;

--Selecionar lotes com validade entre fevereiro de 2024 e junho de 2026
select * from lotes
where year(datavalidade) between '2024' and '2026'
order by datavalidade asc;

--Listar os lotes com valor de lote acima da média entre todos os valores de lote do banco.
insert into lotes (datavalidade, precounitario, quantidade, valorlote, codproduto) values
('2029-12-28',3.78,1223,default,20);

--Alterar o preço do Sabonete de Glicerina com uma redução de 15% no preço cadastrado
update lotes
set precounitario = precounitario * 0.85
where codproduto = 20;

--Excluir o Shampoo Anticaspa da Rexona.
delete from lotes
where codproduto = 17


delete from produtos
where nomeproduto = ('Shampoo Anticaspa') 
and codfabricante = 2


--Altere a tabela lote de forma que o armazenamento do preço unitário do produto seja feito usando apenas duas casas decimais
--Previamente realizado na configuração inicial

------------------------------------------------------------------------------------------------------------------------------

--Altere a tabela lote inserindo uma coluna chamada STATUSLOTE. Essa
--coluna pode armazenar valores como “Recall”, “Liberado”. Como
--padrão, esse campo recebe valor de “Analise”. A coluna deve ser
--varchar e receber no máximo 9 caracteres.
alter table lotes
add statuslote varchar(9)
default 'Analise';
--
update lotes
set statuslote = 'Analise'
where numlote >=100;

--Alterar o status dos lotes de acordo com a tabela abaixo

update lotes
set statuslote = 'recall'
where numlote in (107, 108, 116);

update lotes
set statuslote = 'Liberado'
where numlote in (113, 117, 112, 109, 114);

--Criar uma lista com a quantidade de lotes que estão classificados com cada um dos status existentes

select statuslote, count(statuslote) 
from lotes
group by statuslote;

--Apresentar uma lista com as quantidades de produtos fornecidas por cada fabricante.

select sum(quantidade) as Total
from lotes
