USE dbEncomendas
GO

--a)
CREATE PROCEDURE spInsertCategorias
AS
BEGIN
	INSERT INTO tbCategoriaProduto(nomeCategoriaProduto) VALUES
	('Bolo Festa'),
	('Bolo Simples'),
	('Torta'),
	('Salgado');
END;

EXEC spInsertCategorias;
GO

--b)
CREATE PROCEDURE spInsertNomeVerifica
    @nomeProduto VARCHAR(100),
    @precokiloProduto DECIMAL(10, 2),
    @codCategoriaProduto INT
AS
BEGIN
	IF EXISTS (SELECT 1 FROM tbProduto WHERE nomeProduto like @nomeProduto)
	BEGIN
		PRINT ('Produto ja existe no estoque');
	END
	ELSE
	BEGIN
        INSERT INTO tbProduto (nomeProduto, precokiloProduto, codCategoriaProduto)
        VALUES (@nomeProduto, @precokiloProduto, @codCategoriaProduto);
        
        PRINT ('Produto inserido com sucesso.');
	END
END;

EXEC spInsertNomeVerifica 'Bolo Floresta Negra', 42.00, 1;
EXEC spInsertNomeVerifica 'Bolo Prestígio', 43.00, 1;
EXEC spInsertNomeVerifica 'Bolo Nutella', 44.00, 1;
EXEC spInsertNomeVerifica 'Bolo Formigueiro', 17.00, 2;
EXEC spInsertNomeVerifica 'Bolo de cenoura', 19.00, 2;
EXEC spInsertNomeVerifica 'Torta de palmito', 45.00, 3;
EXEC spInsertNomeVerifica 'Torta de frango e catupiry', 47.00, 3;
EXEC spInsertNomeVerifica 'Torta de escarola', 44.00, 3;
EXEC spInsertNomeVerifica 'Coxinha frango', 25.00, 4;
EXEC spInsertNomeVerifica 'Esfiha carne', 27.00, 4;
EXEC spInsertNomeVerifica 'Folhado queijo', 31.00, 4;

GO

--c)

CREATE PROCEDURE spCadastroCliente
	@nomeCliente VARCHAR(100),
	@dataNascimentoCliente DATE,
	@ruaCliente VARCHAR(100),
	@numCasaCliente INT,
	@cepCliente VARCHAR(10),
	@bairroCliente VARCHAR(50),
	@cpfCliente VARCHAR(11),
	@sexoCliente CHAR(1)
AS
BEGIN
	IF EXISTS (SELECT cpfCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
	BEGIN
		PRINT ('Cliente cpf '+@cpfCliente+' já cadastrado');
	END
	ELSE IF @bairroCliente = 'Guaianases' OR @bairroCliente = 'Itaquera'
	BEGIN
		INSERT INTO tbCliente(nomeCliente, dataNascimentoCliente, ruaCliente, numCasaCliente, cepCliente, bairroCliente, cpfCliente, sexoCliente) VALUES
			(@nomeCliente, @dataNascimentoCliente, @ruaCliente, @numCasaCliente, @cepCliente, @bairroCliente, @cpfCliente, @sexoCliente);

			PRINT ('Cliente '+@nomeCliente+' inserido com sucesso')
	END
	ELSE
	BEGIN
		PRINT ('Não foi possível cadastrar o cliente '+@nomeCliente+' pois o bairro '+@bairroCliente+' não é atendido pela confeitaria');
	END
END;

-- Samira Fatah
EXEC spCadastroCliente 
    @nomeCliente = 'Samira Fatah',
    @dataNascimentoCliente = '1990-05-05',
    @ruaCliente = 'Rua Aguapeí',
    @numCasaCliente = 1000,
    @cepCliente = '08.090-000',
    @bairroCliente = 'Guaianases',
    @cpfCliente = '123.456.789-01',
    @sexoCliente = 'F';

-- Celia Nogueira
EXEC spCadastroCliente 
    @nomeCliente = 'Celia Nogueira',
    @dataNascimentoCliente = '1992-06-06',
    @ruaCliente = 'Rua Andes',
    @numCasaCliente = 234,
    @cepCliente = '08.456-090',
    @bairroCliente = 'Guaianases',
    @cpfCliente = '234.567.890-12',
    @sexoCliente = 'F';

-- Paulo Cesar Siqueira
EXEC spCadastroCliente 
    @nomeCliente = 'Paulo Cesar Siqueira',
    @dataNascimentoCliente = '1984-04-04',
    @ruaCliente = 'Rua Castelo do Piauí',
    @numCasaCliente = 232,
    @cepCliente = '08.109-000',
    @bairroCliente = 'Itaquera',
    @cpfCliente = '345.678.901-23',
    @sexoCliente = 'M';

-- Rodrigo Favaroni
EXEC spCadastroCliente 
    @nomeCliente = 'Rodrigo Favaroni',
    @dataNascimentoCliente = '1991-04-09',
    @ruaCliente = 'Rua Sansão Castelo Branco',
    @numCasaCliente = 10,
    @cepCliente = '08.431-090',
    @bairroCliente = 'Guaianases',
    @cpfCliente = '456.789.012-34',
    @sexoCliente = 'M';

-- Flávia Regina Brito
EXEC spCadastroCliente 
    @nomeCliente = 'Flávia Regina Brito',
    @dataNascimentoCliente = '1992-04-22',
    @ruaCliente = 'Rua Mariano Moro',
    @numCasaCliente = 300,
    @cepCliente = '08.200-123',
    @bairroCliente = 'Itaquera',
    @cpfCliente = '567.890.123-45',
    @sexoCliente = 'F';
GO

--d)
CREATE PROCEDURE spCriarEncomenda
	@cpfCliente VARCHAR(11),
	@dataEncomenda DATE,
	@codCliente INT,
	@valorTotalEncomenda DECIMAL(10, 2),
	@dataEntregaEncomenda DATE
AS
BEGIN
	--pegar nome do cliente
	DECLARE @nomeCliente VARCHAR(100);
	SET @nomeCliente = (SELECT nomeCliente FROM tbCliente WHERE codCliente = @codCliente);

	IF NOT EXISTS (SELECT 1 FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
	BEGIN
		PRINT('Não foi possível efetivar a encomenda pois o cliente '+@nomeCliente+' não está cadastrado');
	END;
	IF @dataEncomenda > @dataEntregaEncomenda
	BEGIN
		PRINT('Não é possível entregar uma encomenda antes da encomenda ser realizada')
	END;
	INSERT INTO tbEncomenda(dataEncomenda, codCliente, valorTotalEncomenda, dataEntregaEncomenda) VALUES
		(@dataEncomenda, @codCliente, @valorTotalEncomenda, @dataEntregaEncomenda)
		
	--pegar cod da encomenda
	DECLARE @codEncomenda INT;
	SET @codEncomenda = SCOPE_IDENTITY();

	PRINT('Encomenda '+@codEncomenda+' para o cliente ' +@nomeCliente+' efetuada com sucesso');
END;

-- Encomenda 1
EXEC spCriarEncomenda
    @cpfCliente = '123.456.789-01',
    @dataEncomenda = '2015-08-08',
    @codCliente = 1,
    @valorTotalEncomenda = 450.00,
    @dataEntregaEncomenda = '2015-08-15';

-- Encomenda 2
EXEC spCriarEncomenda
    @cpfCliente = '234.567.890-12',
    @dataEncomenda = '2015-10-10',
    @codCliente = 2,
    @valorTotalEncomenda = 200.00,
    @dataEntregaEncomenda = '2015-10-15';

-- Encomenda 3
EXEC spCriarEncomenda
    @cpfCliente = '345.678.901-23',
    @dataEncomenda = '2015-10-10',
    @codCliente = 3,
    @valorTotalEncomenda = 150.00,
    @dataEntregaEncomenda = '2015-12-10';

-- Encomenda 4
EXEC spCriarEncomenda
    @cpfCliente = '123.456.789-01',
    @dataEncomenda = '2015-10-06',
    @codCliente = 1,
    @valorTotalEncomenda = 250.00,
    @dataEntregaEncomenda = '2015-10-12';

-- Encomenda 5
EXEC spCriarEncomenda
    @cpfCliente = '456.789.012-34',
    @dataEncomenda = '2015-10-05',
    @codCliente = 4,
    @valorTotalEncomenda = 150.00,
    @dataEntregaEncomenda = '2015-10-12';

