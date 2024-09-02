CREATE DATABASE dbEncomendas
USE dbEncomendas
GO

CREATE TABLE tbCategoriaProduto (
    codCategoriaProduto INT PRIMARY KEY IDENTITY(1,1),
    nomeCategoriaProduto VARCHAR(100) NOT NULL
);

CREATE TABLE tbProduto (
    codProduto INT PRIMARY KEY IDENTITY(1,1),
    nomeProduto VARCHAR(100) NOT NULL,
    precokiloProduto DECIMAL(10, 2) NOT NULL,
    codCategoriaProduto INT,
    FOREIGN KEY (codCategoriaProduto) REFERENCES tbCategoriaProduto(codCategoriaProduto)
);

CREATE TABLE tbCliente (
    codCliente INT PRIMARY KEY IDENTITY(1,1),
    nomeCliente VARCHAR(100) NOT NULL,
    dataNascimentoCliente DATE,
    ruaCliente VARCHAR(100),
    numCasaCliente INT,
    cepCliente VARCHAR(10),
    bairroCliente VARCHAR(50),
    cidadeCliente VARCHAR(50),
    estadoCliente CHAR(2),
    cpfCliente VARCHAR(11) UNIQUE,
    sexoCliente CHAR(1)
);

CREATE TABLE tbEncomenda (
    codEncomenda INT PRIMARY KEY IDENTITY(1,1),
    dataEncomenda DATE NOT NULL,
    codCliente INT,
    valorTotalEncomenda DECIMAL(10, 2) NOT NULL,
    dataEntregaEncomenda DATE NOT NULL,
    FOREIGN KEY (codCliente) REFERENCES tbCliente(codCliente)
);

CREATE TABLE tbItensEncomenda (
    codItensEncomenda INT PRIMARY KEY IDENTITY(1,1),
    codEncomenda INT,
    codProduto INT,
    quantidadekilos DECIMAL(10, 2) NOT NULL,
    subTotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (codEncomenda) REFERENCES tbEncomenda(codEncomenda),
    FOREIGN KEY (codProduto) REFERENCES tbProduto(codProduto)
);
