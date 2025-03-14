/* TeraTl 

Exercícios de fixação. 
1) Crie um banco de dados chamado projeto e conecte-se ao banco.

2) Faça a seguinte modelagem: 
Sr. José quer modernizar a sua oficina, e por enquanto, cadastrar os carros que entram para realizar serviços e os seus respectivos donos.
Sr. José mencionou que cada cliente possui apenas um carro. Um carro possui uma marca. Sr. José também quer saber as cores dos carros para
ter idéia de qual tinta comprar, e informa que um carro pode ter mais de uma cor. Sr José necessita armazenar os telefones dos clientes,
mas não quer que eles sejam obrigatórios. */

-- Necessario uma tabela Cliente
-- Necessario uma tabela Telefone (para resolver o relacionamento Cliente 1xN Telefones)
-- Necessario uma tabela Carro com relacionamento 1x1 com cliente
-- Necessario uma tabela Marca (resolvendo o relacionamento Marca 1xN Carros)
-- Necessario uma tabela Cor
-- Necessario uma tabela Cor_Carro (resolvendo o relacionamento Cor NxN Carro)

-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Criação do Banco
CREATE DATABASE PROJETO_MECANICA;

USE PROJETO_MECANICA;

-------------------------------------------------------------------------------

-- Criação das Tabelas

-- Tabela Cliente
CREATE TABLE Cliente(idCliente INT AUTO_INCREMENT UNIQUE NOT NULL,
					 Nome VARCHAR(100) NOT NULL,
					 CPF CHAR(11) UNIQUE NOT NULL,
					 Email VARCHAR(100) UNIQUE NOT NULL
					 );

ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente
PRIMARY KEY(idCliente);

-- Tabela Telefone
CREATE TABLE Telefone(idTelefone INT AUTO_INCREMENT UNIQUE NOT NULL,
					  Tipo ENUM('RES', 'COM', 'CEL') NOT NULL,
					  Numero VARCHAR(20) UNIQUE NOT NULL,
					  id_Cliente INT
					  );

ALTER TABLE Telefone ADD CONSTRAINT PK_Telefone
PRIMARY KEY(idTelefone);

ALTER TABLE Telefone ADD CONSTRAINT FK_Telefone_Cliente
FOREIGN KEY(id_Cliente) REFERENCES Cliente(idCliente);

-- Tabela Marca 
CREATE TABLE Marca(idMarca INT AUTO_INCREMENT UNIQUE NOT NULL,
				   Marca VARCHAR(45) NOT NULL
				   );

ALTER TABLE Marca ADD CONSTRAINT PK_Marca
PRIMARY KEY(idMarca);

-- Tabela Modelo
CREATE TABLE Modelo(idModelo INT AUTO_INCREMENT UNIQUE NOT NULL,
					Modelo VARCHAR(45) NOT NULL,
					ANO YEAR NOT NULL CHECK(ANO >= 1950),
					id_Marca INT NOT NULL
					);

ALTER TABLE Modelo ADD CONSTRAINT PK_Modelo
PRIMARY KEY(idModelo);

ALTER TABLE Modelo ADD CONSTRAINT FK_Modelo_Marca
FOREIGN KEY(id_Marca) REFERENCES Marca(idMarca);

-- Tabela Cor
CREATE TABLE Cor(idCor INT AUTO_INCREMENT UNIQUE NOT NULL,
				 nomeCor VARCHAR(100)
				 );

ALTER TABLE Cor ADD CONSTRAINT PK_Cor
PRIMARY KEY(idCor);

-- Tabela Carro
CREATE TABLE Carro(idCarro INT AUTO_INCREMENT UNIQUE NOT NULL,
				   Placa CHAR(7) UNIQUE NOT NULL,
				   id_Modelo INT NOT NULL,
				   id_Cliente INT NOT NULL
				   );

ALTER TABLE Carro ADD CONSTRAINT PK_Carro
PRIMARY KEY(idCarro);

ALTER TABLE Carro ADD CONSTRAINT FK_Carro_Modelo
FOREIGN KEY(id_Modelo) REFERENCES Modelo(idModelo);

ALTER TABLE Carro ADD CONSTRAINT FK_Carro_Cliente
FOREIGN KEY(id_Cliente) REFERENCES Cliente(idCliente);

-- Tabela Carro_Cor
CREATE TABLE Carro_Cor(id_Carro INT NOT NULL,
					   id_Cor INT NOT NULL
					   );

ALTER TABLE Carro_Cor ADD CONSTRAINT PK_Carro_Cor
PRIMARY KEY(id_Carro, id_Cor);

ALTER TABLE Carro_Cor ADD CONSTRAINT FK_Carro_Cor_Carro
FOREIGN KEY(id_Carro) REFERENCES Carro(idCarro);

ALTER TABLE Carro_Cor ADD CONSTRAINT FK_Carro_Cor_Cor
FOREIGN KEY(id_Cor) REFERENCES Cor(idCor);

-- Inserir Clientes
INSERT INTO Cliente (Nome, CPF, Email) VALUES
('José da Silva', '12345678901', 'jose.silva@email.com'),
('Maria Oliveira', '23456789012', 'maria.oliveira@email.com'),
('Carlos Souza', '34567890123', 'carlos.souza@email.com'),
('Ana Pereira', '45678901234', 'ana.pereira@email.com'),
('Pedro Santos', '56789012345', 'pedro.santos@email.com');

-- Inserir Telefones
INSERT INTO Telefone (Tipo, Numero, id_Cliente) VALUES
('CEL', '11987654321', 1),
('RES', '1123456789', 1),
('COM', '1133334444', 2),
('CEL', '21912345678', 3),
('CEL', '31987654321', 4);

-- Inserir Marcas de Carros
INSERT INTO Marca (Marca) VALUES
('Toyota'),
('Honda'),
('Ford'),
('Chevrolet'),
('Volkswagen');

-- Inserir Modelos de Carros
INSERT INTO Modelo (Modelo, ANO, id_Marca) VALUES
('Corolla', 2020, 1),
('Civic', 2019, 2),
('Fiesta', 2018, 3),
('Onix', 2021, 4),
('Gol', 2017, 5);

-- Inserir Cores de Carros
INSERT INTO Cor (nomeCor) VALUES
('Preto'),
('Branco'),
('Vermelho'),
('Azul'),
('Prata');

-- Inserir Carros
INSERT INTO Carro (Placa, id_Modelo, id_Cliente) VALUES
('ABC1D23', 1, 1),
('XYZ4E56', 2, 2),
('JKL7F89', 3, 3),
('MNO0G12', 4, 4),
('PQR3H45', 5, 5);

-- Inserir Cores dos Carros (Relacionamento N:N)
INSERT INTO Carro_Cor (id_Carro, id_Cor) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 5),
(2, 3),
(3, 2);
