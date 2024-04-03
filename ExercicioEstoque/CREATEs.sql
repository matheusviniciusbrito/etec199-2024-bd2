CREATE DATABASE	bdEstoque
GO

USE bdEstoque

 
CREATE TABLE tbVenda (
	codVenda INT IDENTITY (1,1) PRIMARY KEY
	,dataVenda DATE  NOT NULL
	,valorTotalVenda FLOAT  NOT NULL
	,codCliente INT  NOT NULL
 
	FOREIGN KEY (codCliente) REFERENCES tb_cliente (codCliente)
);
 
 
CREATE TABLE tbCliente (
	codCliente INT IDENTITY (1,1) PRIMARY KEY
	,nomeCliente VARCHAR (100)
	,cpfCliente VARCHAR (11)
	,emailCliente VARCHAR (50)
	,sexoCliente CHAR (1)
	,dataNascimentoCliente DATE
);
 
CREATE TABLE tbItensVenda (
	codItensVenda INT IDENTITY (1,1) PRIMARY KEY
	,codVenda INT NOT NULL
	,codProduto INT NOT NULL
	,quantidadeItensVenda INT NOT NULL
	,subTotalItensVenda FLOAT NOT NULL
	,FOREIGN KEY (codVenda) REFERENCES tb_venda (codVenda)
	,FOREIGN KEY (codProduto) REFERENCES tb_produto (codProduto)
);
 
CREATE TABLE tbFabricante (
	codFabricante INT IDENTITY (1,1) PRIMARY KEY
	,nomeFabricante VARCHAR (50) NOT NULL
);
 
CREATE TABLE tbProduto (
	codProduto INT IDENTITY (1,1) PRIMARY KEY
	,descricaoProduto VARCHAR (100) NOT NULL
	,valorProduto FLOAT NOT NULL
	,quantidadeProduto INT NOT NULL
	,codFabricante INT NOT NULL
	,codFornecedor INT NOT NULL
	,FOREIGN KEY (codFabricante) REFERENCES tb_fabricante (codFabricante)
	,FOREIGN KEY (codFornecedor) REFERENCES tb_fornecedor (codFornecedor)
);
 
CREATE TABLE tbFornecedor (
	codFornecedor INT IDENTITY (1,1) PRIMARY KEY
	,nomeFornecedor VARCHAR (50) NOT NULL
	,contadoFornecedor VARCHAR(50) NOT NULL
);