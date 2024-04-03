USE bdEstoque
GO

INSERT INTO tbCliente (nomeCliente, cpfCliente, emailCliente, sexoCliente, dataNascimentoCliente)
VALUES	
	('Armando José Santana', '12345678900', 'armandojsantana@outlook.com', 'm', '1961-02-21')
	,('Sheila Carvalho Leal', '45678909823', 'scarvalho@ig.com.br', 'f', '1978-09-13')
	,('Carlos Henrique Souza', '76598278299', 'chenrique@ig.com.br', 'm', '1981-09-08')
	,('Maria Aparecida Souza', '87365309899', 'mapdasouza@outlook.com', 'f', '1962-07-07')
	,('Adriana Nogueira Silva', '76354309388', 'drica1977@ig.com.br', 'f', '1977-04-09')
	,('Paulo Henrique Silva', '87390123111', 'phsilva80@hotmail.com', 'm', '1987-02-02');
 
INSERT INTO tbFabricante (nomeFabricante)
VALUES	
	('Unilever')
	,('P&G')
	,('Bunge');
 
INSERT INTO tbFornecedor (nomeFornecedor, contatoFornecedor)
VALUES	
	('Atacadão', 'Carlos Santos')
	,('Assai', 'Maria Stella')
	,('Roldão', 'Paulo César');
 
INSERT INTO tbProduto (descricaoProduto, valorProduto, quantidadeProduto, codFabricante, codFornecedor)
VALUES	
	('Amaciante Downy', 5.76, 1500, 2, 1)
	,('Amaciante Comfort', 5.45, 2300, 1, 1)
	,('Sabão em pó OMO', 5.99, 1280, 1, 2)
	,('Margarina Qualy', 4.76, 2500, 3, 1)
	,('Salsicha hot dog Sadia', 6.78, 2900, 3, 1)
	,('Mortadela Perdigão', 2.50, 1200, 3, 3)
	,('Hamburguer Sadia', 9.89, 1600, 3, 1)
	,('Fralda Pampers', 36.00, 340, 2, 3)
	,('Xampu Seda', 5.89, 800, 1, 2)
	,('Condicionador Seda', 6.50, 700, 1, 3);
 
INSERT INTO tbVenda (dataVenda, valorTotalVenda, codCliente)
VALUES  
    ('2014-02-01', 4500, 1)
    ,('2014-02-03', 3400, 1)
    ,('2014-02-10', 2100, 2)
    ,('2014-02-15', 2700, 3)
    ,('2014-03-17', 560, 3)
    ,('2014-04-09', 1200, 4)
    ,('2014-05-07', 3500, 5)
    ,('2014-05-07', 3400, 1)
    ,('2014-05-05', 4000, 2);
 
INSERT INTO tbItensVenda (codVenda, codProduto, quantidadeItensVenda, subTotalItensVenda)
VALUES	
	(1, 1, 200, 1500)
	,(1, 2, 300, 3000) 
	,(2, 4, 120, 1400)
	,(2, 2, 200, 1000)
	,(2, 3, 130, 1000)
	,(3, 5, 200, 2100)
	,(4, 4, 120, 1000)
	,(4, 5, 450, 700)
	,(5, 5, 200, 560)
	,(6, 7, 200, 600)
	,(6, 6, 300, 600) 
	,(8, 1, 300, 2500)
	,(8, 2, 200, 1000)
	,(9, 6, 250, 1700)
	,(9, 5, 200, 1700)
	,(10, 4, 1000, 4000);

 
SELECT * FROM tbCliente
SELECT * FROM tbFornecedor
SELECT * FROM tbFabricante
SELECT * FROM tbItensVenda
SELECT * FROM tbVenda
SELECT * FROM tbProduto