CREATE DATABASE dbEncomenda
USE dbEncomenda
GO

CREATE TABLE tbCategoriaProduto (
    codCategoriaProduto INT PRIMARY KEY IDENTITY(1,1),
    nomeCategoriaProduto VARCHAR(100) NOT NULL
);

CREATE TABLE tbProduto (
    codProduto INT PRIMARY KEY IDENTITY(1,1),
    nomeProduto VARCHAR(100) NOT NULL,
    precokiloProduto DECIMAL(10, 2) NOT NULL,
    codCategoriaProduto INT NOT NULL,
    FOREIGN KEY (codCategoriaProduto) REFERENCES tbCategoriaProduto(codCategoriaProduto)
);

CREATE TABLE tbCliente (
    codCliente INT PRIMARY KEY IDENTITY(1,1),
    nomeCliente VARCHAR(100) NOT NULL,
    dataNascimentoCliente DATE NOT NULL,
    ruaCliente VARCHAR(100) NOT NULL,
    numCasaCliente INT NOT NULL,
    cepCliente VARCHAR(10) NOT NULL,
    bairroCliente VARCHAR(50) NOT NULL,
    cidadeCliente VARCHAR(50) NOT NULL,
    estadoCliente CHAR(2) NOT NULL,
    cpfCliente VARCHAR(11) UNIQUE NOT NULL,
    sexoCliente CHAR(1) NOT NULL
);

CREATE TABLE tbEncomenda (
    codEncomenda INT PRIMARY KEY IDENTITY(1,1),
    dataEncomenda DATE NOT NULL,
    codCliente INT NOT NULL,
    valorTotalEncomenda DECIMAL(10, 2) NOT NULL,
    dataEntregaEncomenda DATE NOT NULL,
    FOREIGN KEY (codCliente) REFERENCES tbCliente(codCliente)
);

CREATE TABLE tbItensEncomenda (
    codItensEncomenda INT PRIMARY KEY IDENTITY(1,1),
    codEncomenda INT NOT NULL,
    codProduto INT NOT NULL,
    quantidadekilos DECIMAL(10, 2) NOT NULL,
    subTotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (codEncomenda) REFERENCES tbEncomenda(codEncomenda),
    FOREIGN KEY (codProduto) REFERENCES tbProduto(codProduto)
);
