/* 
Uma livraria online deseja criar um banco de dados para gerenciar seu catálogo de livros, autores, clientes e pedidos.

Requisitos:
A livraria vende livros de diversos autores.
Um autor pode ter escrito vários livros, e um livro pode ter múltiplos autores.
Os clientes podem fazer pedidos, e cada pedido pode conter vários livros.
Cada pedido tem uma data e um status (ex: "pendente", "enviado", "entregue").
A livraria deseja armazenar informações dos clientes, como nome, e-mail e endereço.
Cada livro tem título, ano de publicação, preço e uma categoria (ex: "Ficção", "Não Ficção", "Tecnologia").
O estoque dos livros deve ser controlado.

Tarefas:
Identifique as entidades necessárias para este banco de dados.
Determine os atributos de cada entidade.
Defina os relacionamentos entre as entidades e suas cardinalidades.
Crie um diagrama ER representando a estrutura do banco.
Escreva as tabelas em SQL (CREATE TABLE) com chaves primárias e estrangeiras. 


--------------------------------------------------------------------------------------------------------------------------------------
*/ 


/* 
Sera necessario a criacao de 7 tabelas:
	Uma para Autor
	Uma para livro
	Uma para pedidos
	Uma para clientes
	Uma para Autor_Livro Satisfazendo a relacao NxM
	Uma para Livro_Pedido Satisfazendo a relacao NxM
	Uma para Endereco satisfazendo a normalizacao de campo multivalorado

Sendo a Relacao entre elas:
	Autor NxM Livro
	Pedido NxM Livro
	Cliente 1xN Pedido
	Cliente 1x1 Endereco

*/ 



/* Criacao do DATABASE */
CREATE DATABASE PROJETO_LIVRARIA;
USE PROJETO_LIVRARIA;
/* Criacao da Tabela Cliente */
CREATE TABLE CLIENTE(
	idCliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT, /* Chave primaria */
	Nome VARCHAR(100) NOT NULL,
	Email VARCHAR(100),
	CPF CHAR(11) /* NO FORMATO XXXXXXXXXXX */
);


/* Criacao da Tabela Endereco */
CREATE TABLE ENDERECO(
	idEndereco INT NOT NULL PRIMARY KEY AUTO_INCREMENT, /* Chave Primaria */
	Pais VARCHAR(40) NOT NULL,
	Estado VARCHAR(40) NOT NULL,
	Cidade VARCHAR(45) NOT NULL,
	Bairro VARCHAR(45) NOT NULL,
	Rua VARCHAR(50) NOT NULL,
	Numero VARCHAR(10) NOT NULL,
	Complemento VARCHAR(200),
	id_Cliente INT NOT NULL UNIQUE, /* Torna-se necessario o id do cliente responsavel por esse endereco. unico para nenhum cliente ter mais de um endereco. */

	FOREIGN KEY(id_Cliente)
		REFERENCES CLIENTE(idCliente)
);


/* Criacao da Tabela Pedido */
CREATE TABLE PEDIDO(
	idPedido INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	Data CHAR(10), /* No formato xx/xx/xxxx (TROCAR FUTURAMENTE POR DATE) */
	Status VARCHAR(20),
	id_Cliente INT NOT NULL,

	FOREIGN KEY(id_Cliente)
		REFERENCES CLIENTE(idCliente)
);

/* Criacao da Tabela Livro */
CREATE TABLE LIVRO(
	idLivro INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	Titulo VARCHAR(100),
	Ano CHAR(4), /* NO FORMATO XXXX (NAO E POSSIVEL USAR O FORMATO YEAR POR POSSUIR LIVROS ESCRITOS ANTES DE 1901 */
	Preco FLOAT(6,2),
	Categoria VARCHAR(50),
	Estoque INT
);

/* Criacao da Tabela Livro_Pedido (resolvendo o relacionamento muitos para muitos) */
CREATE TABLE Livro_Pedido(
	id_Pedido INT NOT NULL,
	id_Livro INT NOT NULL,

	PRIMARY KEY(id_Pedido, id_Livro),

	FOREIGN KEY(id_Pedido)
		REFERENCES PEDIDO(idPedido),

	FOREIGN KEY(id_Livro)
		REFERENCES LIVRO(idLivro)
);

/* Criacao da Tabela Autor */
CREATE TABLE AUTOR(
	idAutor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	Nome_Autor VARCHAR(100)
);

/* Criacao da Tabela Autor_Livro (resolvendo o relacionamento muitos para muitos) */
CREATE TABLE AUTOR_LIVRO(
	id_Autor INT NOT NULL,
	id_Livro INT NOT NULL,

	PRIMARY KEY(id_Autor, id_Livro),

	FOREIGN KEY(id_Autor)
		REFERENCES AUTOR(idAutor),

	FOREIGN KEY(id_Livro)
		REFERENCES LIVRO(idLivro)
);



/* Inserindo 10 Clientes */
INSERT INTO CLIENTE (Nome, Email, CPF) VALUES
('João Silva', 'joao.silva@email.com', '12345678901'),
('Maria Oliveira', 'maria.oliveira@email.com', '23456789012'),
('Carlos Souza', 'carlos.souza@email.com', '34567890123'),
('Ana Lima', 'ana.lima@email.com', '45678901234'),
('Pedro Costa', 'pedro.costa@email.com', '56789012345'),
('Fernanda Rocha', 'fernanda.rocha@email.com', '67890123456'),
('Lucas Mendes', 'lucas.mendes@email.com', '78901234567'),
('Juliana Martins', 'juliana.martins@email.com', '89012345678'),
('Ricardo Almeida', 'ricardo.almeida@email.com', '90123456789'),
('Camila Ferreira', 'camila.ferreira@email.com', '01234567890');

/* Inserindo 10 Endereços */
INSERT INTO ENDERECO (Pais, Estado, Cidade, Bairro, Rua, Numero, Complemento, id_Cliente) VALUES
('Brasil', 'SP', 'São Paulo', 'Centro', 'Rua A', '100', NULL, 1),
('Brasil', 'RJ', 'Rio de Janeiro', 'Copacabana', 'Rua B', '200', 'Apto 301', 2),
('Brasil', 'MG', 'Belo Horizonte', 'Savassi', 'Rua C', '50', NULL, 3),
('Brasil', 'RS', 'Porto Alegre', 'Moinhos', 'Rua D', '77', NULL, 4),
('Brasil', 'SC', 'Florianópolis', 'Centro', 'Rua E', '120', NULL, 5),
('Brasil', 'PR', 'Curitiba', 'Água Verde', 'Rua F', '90', NULL, 6),
('Brasil', 'BA', 'Salvador', 'Barra', 'Rua G', '45', NULL, 7),
('Brasil', 'PE', 'Recife', 'Boa Viagem', 'Rua H', '250', NULL, 8),
('Brasil', 'CE', 'Fortaleza', 'Meireles', 'Rua I', '130', NULL, 9),
('Brasil', 'GO', 'Goiânia', 'Setor Bueno', 'Rua J', '180', NULL, 10);

/* Inserindo 10 Pedidos */
INSERT INTO PEDIDO (Data, Status, id_Cliente) VALUES
('10/02/2025', 'Enviado', 1),
('11/02/2025', 'Processando', 2),
('12/02/2025', 'Entregue', 3),
('13/02/2025', 'Cancelado', 4),
('14/02/2025', 'Enviado', 5),
('15/02/2025', 'Entregue', 6),
('16/02/2025', 'Processando', 7),
('17/02/2025', 'Enviado', 8),
('18/02/2025', 'Cancelado', 9),
('19/02/2025', 'Entregue', 10);

/* Inserindo 10 Livros */
INSERT INTO LIVRO (Titulo, Ano, Preco, Categoria, Estoque) VALUES
('O Senhor dos Anéis', '1954', 59.90, 'Fantasia', 10),
('1984', '1949', 39.90, 'Ficção Científica', 8),
('Dom Quixote', '1605', 29.90, 'Clássico', 15),
('Harry Potter', '1997', 49.90, 'Fantasia', 12),
('O Pequeno Príncipe', '1943', 19.90, 'Infantil', 20),
('A Arte da Guerra', '500', 25.90, 'Estratégia', 5),
('Crime e Castigo', '1866', 35.90, 'Romance', 7),
('O Hobbit', '1937', 45.90, 'Fantasia', 10),
('Percy Jackson', '2005', 39.90, 'Aventura', 9),
('Cem Anos de Solidão', '1967', 42.90, 'Ficção', 6);

/* Inserindo 10 Autores */
INSERT INTO AUTOR (Nome_Autor) VALUES
('J.R.R. Tolkien'),
('George Orwell'),
('Miguel de Cervantes'),
('J.K. Rowling'),
('Antoine de Saint-Exupéry'),
('Sun Tzu'),
('Fiódor Dostoiévski'),
('Gabriel García Márquez'),
('Rick Riordan'),
('Victor Hugo');

/* Inserindo relações Autor_Livro (Muitos para Muitos) */
INSERT INTO AUTOR_LIVRO (id_Autor, id_Livro) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(1, 8),
(9, 9),
(8, 10);

/* Inserindo relações Livro_Pedido (Muitos para Muitos) */
INSERT INTO Livro_Pedido (id_Pedido, id_Livro) VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 4),
(3, 5),
(4, 6),
(5, 7),
(6, 8),
(7, 9),
(8, 10);


/* Usando o JOIN */

SELECT Nome, Email, Pais, Estado, Cidade, Bairro, Rua, Numero, Complemento
FROM CLIENTE
INNER JOIN ENDERECO
ON idCliente = id_Cliente;
+-----------------+---------------------------+--------+--------+----------------+-------------+-------+--------+-------------+
| Nome            | Email                     | Pais   | Estado | Cidade         | Bairro      | Rua   | Numero | Complemento |
+-----------------+---------------------------+--------+--------+----------------+-------------+-------+--------+-------------+
| João Silva      | joao.silva@email.com      | Brasil | SP     | São Paulo      | Centro      | Rua A | 100    | NULL        |
| Maria Oliveira  | maria.oliveira@email.com  | Brasil | RJ     | Rio de Janeiro | Copacabana  | Rua B | 200    | Apto 301    |
| Carlos Souza    | carlos.souza@email.com    | Brasil | MG     | Belo Horizonte | Savassi     | Rua C | 50     | NULL        |
| Ana Lima        | ana.lima@email.com        | Brasil | RS     | Porto Alegre   | Moinhos     | Rua D | 77     | NULL        |
| Pedro Costa     | pedro.costa@email.com     | Brasil | SC     | Florianópolis  | Centro      | Rua E | 120    | NULL        |
| Fernanda Rocha  | fernanda.rocha@email.com  | Brasil | PR     | Curitiba       | Água Verde  | Rua F | 90     | NULL        |
| Lucas Mendes    | lucas.mendes@email.com    | Brasil | BA     | Salvador       | Barra       | Rua G | 45     | NULL        |
| Juliana Martins | juliana.martins@email.com | Brasil | PE     | Recife         | Boa Viagem  | Rua H | 250    | NULL        |
| Ricardo Almeida | ricardo.almeida@email.com | Brasil | CE     | Fortaleza      | Meireles    | Rua I | 130    | NULL        |
| Camila Ferreira | camila.ferreira@email.com | Brasil | GO     | Goiânia        | Setor Bueno | Rua J | 180    | NULL        |
+-----------------+---------------------------+--------+--------+----------------+-------------+-------+--------+-------------+

/*
-----------------------------------------------------------------------------------------------------------------------------------
*/

SELECT Nome, Email, CPF, Data, Status
FROM CLIENTE
INNER JOIN PEDIDO
ON idCliente = id_Cliente;
+-----------------+---------------------------+-------------+------------+-------------+
| Nome            | Email                     | CPF         | Data       | Status      |
+-----------------+---------------------------+-------------+------------+-------------+
| João Silva      | joao.silva@email.com      | 12345678901 | 10/02/2025 | Enviado     |
| Maria Oliveira  | maria.oliveira@email.com  | 23456789012 | 11/02/2025 | Processando |
| Carlos Souza    | carlos.souza@email.com    | 34567890123 | 12/02/2025 | Entregue    |
| Ana Lima        | ana.lima@email.com        | 45678901234 | 13/02/2025 | Cancelado   |
| Pedro Costa     | pedro.costa@email.com     | 56789012345 | 14/02/2025 | Enviado     |
| Fernanda Rocha  | fernanda.rocha@email.com  | 67890123456 | 15/02/2025 | Entregue    |
| Lucas Mendes    | lucas.mendes@email.com    | 78901234567 | 16/02/2025 | Processando |
| Juliana Martins | juliana.martins@email.com | 89012345678 | 17/02/2025 | Enviado     |
| Ricardo Almeida | ricardo.almeida@email.com | 90123456789 | 18/02/2025 | Cancelado   |
| Camila Ferreira | camila.ferreira@email.com | 01234567890 | 19/02/2025 | Entregue    |
+-----------------+---------------------------+-------------+------------+-------------+

/*
-----------------------------------------------------------------------------------------------------------------------------------
*/

/* Juntando duas Tabelas NxM */
SELECT AUTOR.Nome_Autor, LIVRO.Titulo, LIVRO.Categoria, LIVRO.Preco
FROM AUTOR

INNER JOIN AUTOR_LIVRO
	ON AUTOR.idAutor = AUTOR_LIVRO.id_Autor

INNER JOIN LIVRO
	ON LIVRO.idLivro = AUTOR_LIVRO.id_Livro;
+---------------------------+----------------------+----------------------+-------+
| Nome_Autor                | Titulo               | Categoria            | Preco |
+---------------------------+----------------------+----------------------+-------+
| J.R.R. Tolkien            | O Senhor dos Anéis   | Fantasia             | 59.90 |
| George Orwell             | 1984                 | Ficção Científica    | 39.90 |
| Miguel de Cervantes       | Dom Quixote          | Clássico             | 29.90 |
| J.K. Rowling              | Harry Potter         | Fantasia             | 49.90 |
| Antoine de Saint-Exupéry  | O Pequeno Príncipe   | Infantil             | 19.90 |
| Sun Tzu                   | A Arte da Guerra     | Estratégia           | 25.90 |
| Fiódor Dostoiévski        | Crime e Castigo      | Romance              | 35.90 |
| J.R.R. Tolkien            | O Hobbit             | Fantasia             | 45.90 |
| Rick Riordan              | Percy Jackson        | Aventura             | 39.90 |
| Gabriel García Márquez    | Cem Anos de Solidão  | Ficção               | 42.90 |
+---------------------------+----------------------+----------------------+-------+

/*
-----------------------------------------------------------------------------------------------------------------------------------
*/

SELECT LIVRO.Titulo, LIVRO.Preco, PEDIDO.Data, PEDIDO.Status
FROM LIVRO

INNER JOIN Livro_Pedido
	ON Livro_Pedido.id_Livro = LIVRO.idLivro

INNER JOIN PEDIDO
	ON PEDIDO.idPedido = Livro_Pedido.id_Pedido
+----------------------+-------+------------+-------------+
| Titulo               | Preco | Data       | Status      |
+----------------------+-------+------------+-------------+
| O Senhor dos Anéis   | 59.90 | 10/02/2025 | Enviado     |
| 1984                 | 39.90 | 11/02/2025 | Processando |
| Dom Quixote          | 29.90 | 10/02/2025 | Enviado     |
| Harry Potter         | 49.90 | 12/02/2025 | Entregue    |
| O Pequeno Príncipe   | 19.90 | 12/02/2025 | Entregue    |
| A Arte da Guerra     | 25.90 | 13/02/2025 | Cancelado   |
| Crime e Castigo      | 35.90 | 14/02/2025 | Enviado     |
| O Hobbit             | 45.90 | 15/02/2025 | Entregue    |
| Percy Jackson        | 39.90 | 16/02/2025 | Processando |
| Cem Anos de Solidão  | 42.90 | 17/02/2025 | Enviado     |
+----------------------+-------+------------+-------------+

/*
-----------------------------------------------------------------------------------------------------------------------------------
*/

SELECT CLIENTE.NOME, CLIENTE.CPF, LIVRO.Titulo, LIVRO.Preco, PEDIDO.Data, PEDIDO.Status
FROM CLIENTE

INNER JOIN PEDIDO
	ON CLIENTE.idCliente = PEDIDO.id_Cliente

INNER JOIN LIVRO_PEDIDO
	ON LIVRO_PEDIDO.id_Pedido = PEDIDO.idPedido

INNER JOIN LIVRO
	ON LIVRO.idLivro = LIVRO_PEDIDO.id_Livro;
	

+-----------------+-------------+----------------------+-------+------------+-------------+
| NOME            | CPF         | Titulo               | Preco | Data       | Status      |
+-----------------+-------------+----------------------+-------+------------+-------------+
| João Silva      | 12345678901 | O Senhor dos Anéis   | 59.90 | 10/02/2025 | Enviado     |
| Maria Oliveira  | 23456789012 | 1984                 | 39.90 | 11/02/2025 | Processando |
| João Silva      | 12345678901 | Dom Quixote          | 29.90 | 10/02/2025 | Enviado     |
| Carlos Souza    | 34567890123 | Harry Potter         | 49.90 | 12/02/2025 | Entregue    |
| Carlos Souza    | 34567890123 | O Pequeno Príncipe   | 19.90 | 12/02/2025 | Entregue    |
| Ana Lima        | 45678901234 | A Arte da Guerra     | 25.90 | 13/02/2025 | Cancelado   |
| Pedro Costa     | 56789012345 | Crime e Castigo      | 35.90 | 14/02/2025 | Enviado     |
| Fernanda Rocha  | 67890123456 | O Hobbit             | 45.90 | 15/02/2025 | Entregue    |
| Lucas Mendes    | 78901234567 | Percy Jackson        | 39.90 | 16/02/2025 | Processando |
| Juliana Martins | 89012345678 | Cem Anos de Solidão  | 42.90 | 17/02/2025 | Enviado     |
+-----------------+-------------+----------------------+-------+------------+-------------+


/* ALTERANDO PARA DATA A TABELA PEDIDO */
CREATE TABLE Pedido_backup AS SELECT * FROM Pedido; --BACKUP

ALTER TABLE Pedido ADD COLUMN Data_Formatada DATE; -- ADICIONAR COLUNA DATA FORMATADA

UPDATE Pedido
SET Data_Formatada = STR_TO_DATE(Data, '%d/%m/%Y'); -- TRANSFERINDO OS DADOS DA COLUNA DATA PARA DATA_FORMATADA

ALTER TABLE Pedido DROP COLUMN Data; -- DELETAR COLUNA DATA 

ALTER TABLE Pedido CHANGE Data_Formatada 'Data' DATE NOT NULL; -- ALTERANDO O NOME DA COLUNA DATA_FORMATADA PARA DATA 

ALTER TABLE Pedido MODIFY COLUMN Data DATE NOT NULL AFTER idPedido; -- MOVENDO A NOVA COLUNA DATA 
