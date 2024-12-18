USE dbEncomenda
GO

--a)
CREATE PROCEDURE spInsertCategorias
    @categoria VARCHAR(100)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM tbCategoriaProduto WHERE nomeCategoriaProduto = @categoria)
    BEGIN
        INSERT INTO tbCategoriaProduto(nomeCategoriaProduto) VALUES (@categoria);
    END
    ELSE
    BEGIN
        PRINT 'Categoria j� existe.';
    END
END;

EXEC spInsertCategorias @categoria = 'Bolo Festa';
EXEC spInsertCategorias @categoria = 'Bolo Simples';
EXEC spInsertCategorias @categoria = 'Torta';
EXEC spInsertCategorias @categoria = 'Salgado';
GO

--b)
CREATE PROCEDURE spInsertNomeVerifica
    @nomeProduto VARCHAR(100),
    @precokiloProduto DECIMAL(10, 2),
    @codCategoriaProduto INT
AS
BEGIN
    -- Verifica se a categoria existe
    IF NOT EXISTS (SELECT 1 FROM tbCategoriaProduto WHERE codCategoriaProduto = @codCategoriaProduto)
    BEGIN
        PRINT ('Categoria n�o existe.');
    END
    -- Verifica se o produto j� existe
    ELSE IF EXISTS (SELECT 1 FROM tbProduto WHERE nomeProduto LIKE @nomeProduto)
    BEGIN
        PRINT ('Produto j� existe no estoque.');
    END
    -- Insere o produto se tudo estiver correto
    ELSE
    BEGIN
        INSERT INTO tbProduto (nomeProduto, precokiloProduto, codCategoriaProduto)
        VALUES (@nomeProduto, @precokiloProduto, @codCategoriaProduto);
        
        PRINT ('Produto inserido com sucesso.');
    END
END;


EXEC spInsertNomeVerifica 'Bolo Floresta Negra', 42.00, 1;
EXEC spInsertNomeVerifica 'Bolo Prest�gio', 43.00, 1;
EXEC spInsertNomeVerifica 'Bolo Nutella', 44.00, 1;
EXEC spInsertNomeVerifica 'Bolo Formigueiro', 17.00, 2;
EXEC spInsertNomeVerifica 'Bolo de cenoura', 19.00, 2;
EXEC spInsertNomeVerifica 'Torta de palmito', 45.00, 3;
EXEC spInsertNomeVerifica 'Torta de frango e catupiry', 47.00, 3;
EXEC spInsertNomeVerifica 'Torta de escarola', 44.00, 3;
EXEC spInsertNomeVerifica 'Coxinha frango', 25.00, 4;
EXEC spInsertNomeVerifica 'Esfiha carne', 27.00, 4;
EXEC spInsertNomeVerifica 'Folhado queijo', 31.00, 4;
EXEC spInsertNomeVerifica 'Risoles misto', 29.00, 4;
GO

--c)

CREATE PROCEDURE spCadastroCliente
    @nomeCliente VARCHAR(100),
    @dataNascimentoCliente DATE,
    @ruaCliente VARCHAR(100),
    @numCasaCliente INT,
    @cepCliente VARCHAR(10),
    @bairroCliente VARCHAR(50),
    @cidadeCliente VARCHAR(50),
    @estadoCliente CHAR(2),
    @cpfCliente VARCHAR(11),
    @sexoCliente CHAR(1)
AS
BEGIN
    -- Verifica se o CPF do cliente j� est� cadastrado
    IF EXISTS (SELECT cpfCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
    BEGIN
        PRINT ('Cliente cpf ' + @cpfCliente + ' j� cadastrado');
    END
    -- Verifica se o bairro � 'Guaianases' ou 'Itaquera'
    ELSE IF @bairroCliente = 'Guaianases' OR @bairroCliente = 'Itaquera'
    BEGIN
        INSERT INTO tbCliente(nomeCliente, dataNascimentoCliente, ruaCliente, numCasaCliente, cepCliente, bairroCliente, cidadeCliente, estadoCliente, cpfCliente, sexoCliente)
        VALUES (@nomeCliente, @dataNascimentoCliente, @ruaCliente, @numCasaCliente, @cepCliente, @bairroCliente, @cidadeCliente, @estadoCliente, @cpfCliente, @sexoCliente);

        PRINT ('Cliente ' + @nomeCliente + ' inserido com sucesso');
    END
    -- Caso o bairro n�o seja atendido pela confeitaria
    ELSE
    BEGIN
        PRINT ('N�o foi poss�vel cadastrar o cliente ' + @nomeCliente + ' pois o bairro ' + @bairroCliente + ' n�o � atendido pela confeitaria');
    END
END;


-- Samira Fatah
EXEC spCadastroCliente 
    @nomeCliente = 'Samira Fatah',
    @dataNascimentoCliente = '1990-05-05',
    @ruaCliente = 'Rua Aguape�',
    @numCasaCliente = 1000,
    @cepCliente = '08.090-000',
    @bairroCliente = 'Guaianases',
    @cidadeCliente = 'S�o Paulo',
    @estadoCliente = 'SP',
    @cpfCliente = '12345678901',
    @sexoCliente = 'F';

-- Celia Nogueira
EXEC spCadastroCliente 
    @nomeCliente = 'Celia Nogueira',
    @dataNascimentoCliente = '1992-06-06',
    @ruaCliente = 'Rua Andes',
    @numCasaCliente = 234,
    @cepCliente = '08.456-090',
    @bairroCliente = 'Guaianases',
    @cidadeCliente = 'S�o Paulo',
    @estadoCliente = 'SP',
    @cpfCliente = '23456789012',
    @sexoCliente = 'F';

-- Paulo Cesar Siqueira
EXEC spCadastroCliente 
    @nomeCliente = 'Paulo Cesar Siqueira',
    @dataNascimentoCliente = '1984-04-04',
    @ruaCliente = 'Rua Castelo do Piau�',
    @numCasaCliente = 232,
    @cepCliente = '08.109-000',
    @bairroCliente = 'Itaquera',
    @cidadeCliente = 'S�o Paulo',
    @estadoCliente = 'SP',
    @cpfCliente = '34567890123',
    @sexoCliente = 'M';

-- Rodrigo Favaroni
EXEC spCadastroCliente 
    @nomeCliente = 'Rodrigo Favaroni',
    @dataNascimentoCliente = '1991-04-09',
    @ruaCliente = 'Rua Sans�o Castelo Branco',
    @numCasaCliente = 10,
    @cepCliente = '08.431-090',
    @bairroCliente = 'Guaianases',
    @cidadeCliente = 'S�o Paulo',
    @estadoCliente = 'SP',
    @cpfCliente = '45678901234',
    @sexoCliente = 'M';

-- Fl�via Regina Brito
EXEC spCadastroCliente 
    @nomeCliente = 'Fl�via Regina Brito',
    @dataNascimentoCliente = '1992-04-22',
    @ruaCliente = 'Rua Mariano Moro',
    @numCasaCliente = 300,
    @cepCliente = '08.200-123',
    @bairroCliente = 'Itaquera',
    @cidadeCliente = 'S�o Paulo',
    @estadoCliente = 'SP',
    @cpfCliente = '56789012345',
    @sexoCliente = 'F';
GO


--d)
CREATE PROCEDURE spCriarEncomenda
    @cpfCliente VARCHAR(11),
    @dataEncomenda DATE,
    @valorTotalEncomenda DECIMAL(10, 2),
    @dataEntregaEncomenda DATE
AS
BEGIN
    -- Verificar se o cliente est� cadastrado e obter o codCliente e nomeCliente
    DECLARE @codCliente INT;
    DECLARE @nomeCliente VARCHAR(100);

    SELECT @codCliente = codCliente, @nomeCliente = nomeCliente 
    FROM tbCliente 
    WHERE cpfCliente = @cpfCliente;

    IF @codCliente IS NULL
    BEGIN
        PRINT('N�o foi poss�vel efetivar a encomenda pois o cliente com CPF ' + @cpfCliente + ' n�o est� cadastrado');
        RETURN;
    END

    -- Verificar se a data de entrega n�o � menor do que a data da encomenda
    IF @dataEntregaEncomenda < @dataEncomenda
    BEGIN
        PRINT('N�o � poss�vel entregar uma encomenda antes da encomenda ser realizada');
        RETURN;
    END

    -- Inserir a encomenda
    INSERT INTO tbEncomenda(dataEncomenda, codCliente, valorTotalEncomenda, dataEntregaEncomenda)
    VALUES (@dataEncomenda, @codCliente, @valorTotalEncomenda, @dataEntregaEncomenda);
    
    -- Obter o n�mero da encomenda rec�m-criada
    DECLARE @codEncomenda INT;
    SET @codEncomenda = SCOPE_IDENTITY();

    -- Exibir mensagem de sucesso
	PRINT('Encomenda ' + CAST(@codEncomenda AS VARCHAR(10)) + ' para o cliente ' + @nomeCliente + ' efetuada com sucesso');
END;
GO

-- Encomenda 1
EXEC spCriarEncomenda
    @cpfCliente = '12345678901',  -- CPF do Cliente 1
    @dataEncomenda = '2015-08-08',
    @valorTotalEncomenda = 450.00,
    @dataEntregaEncomenda = '2015-08-15';

-- Encomenda 2
EXEC spCriarEncomenda
    @cpfCliente = '23456789012',  -- CPF do Cliente 2
    @dataEncomenda = '2015-10-10',
    @valorTotalEncomenda = 200.00,
    @dataEntregaEncomenda = '2015-10-15';

-- Encomenda 3
EXEC spCriarEncomenda
    @cpfCliente = '34567890123',  -- CPF do Cliente 3
    @dataEncomenda = '2015-10-10',
    @valorTotalEncomenda = 150.00,
    @dataEntregaEncomenda = '2015-12-10';

-- Encomenda 4
EXEC spCriarEncomenda
    @cpfCliente = '12345678901',  -- CPF do Cliente 1
    @dataEncomenda = '2015-10-06',
    @valorTotalEncomenda = 250.00,
    @dataEntregaEncomenda = '2015-10-12';

-- Encomenda 5
EXEC spCriarEncomenda
    @cpfCliente = '45678901234',  -- CPF do Cliente 4
    @dataEncomenda = '2015-10-05',
    @valorTotalEncomenda = 150.00,
    @dataEntregaEncomenda = '2015-10-12';

GO
--e)

CREATE PROCEDURE spInsertItemEncomenda
    @codEncomenda INT,
    @codProduto INT,
    @quantidadeKilos DECIMAL(10, 2),
    @subTotal DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO tbItensEncomenda (codEncomenda, codProduto, quantidadeKilos, subTotal)
    VALUES (@codEncomenda, @codProduto, @quantidadeKilos, @subTotal);
	PRINT('Item da encomenda cadastrado com sucesso!')
END;

-- Inserindo os itens da encomenda 1
EXEC spInsertItemEncomenda
    @codEncomenda = 1,
    @codProduto = 1,
    @quantidadeKilos = 2.5,
    @subTotal = 105.00;

EXEC spInsertItemEncomenda
    @codEncomenda = 1,
    @codProduto = 10,
    @quantidadeKilos = 2.6,
    @subTotal = 70.00;

EXEC spInsertItemEncomenda
    @codEncomenda = 1,
    @codProduto = 9,
    @quantidadeKilos = 6.0,
    @subTotal = 150.00;

EXEC spInsertItemEncomenda
    @codEncomenda = 1,
    @codProduto = 12,
    @quantidadeKilos = 4.3,
    @subTotal = 125.00;

-- Inserindo os itens da encomenda 2
EXEC spInsertItemEncomenda
    @codEncomenda = 2,
    @codProduto = 9,
    @quantidadeKilos = 8.0,
    @subTotal = 200.00;

-- Inserindo os itens da encomenda 3
EXEC spInsertItemEncomenda
    @codEncomenda = 3,
    @codProduto = 11,
    @quantidadeKilos = 3.2,
    @subTotal = 100.00;

EXEC spInsertItemEncomenda
    @codEncomenda = 3,
    @codProduto = 9,
    @quantidadeKilos = 2.0,
    @subTotal = 50.00;

-- Inserindo os itens da encomenda 4
EXEC spInsertItemEncomenda
    @codEncomenda = 4,
    @codProduto = 2,
    @quantidadeKilos = 3.5,
    @subTotal = 150.00;

EXEC spInsertItemEncomenda
    @codEncomenda = 4,
    @codProduto = 3,
    @quantidadeKilos = 2.2,
    @subTotal = 100.00;

-- Inserindo o item da encomenda 5
EXEC spInsertItemEncomenda
    @codEncomenda = 5,
    @codProduto = 6,
    @quantidadeKilos = 3.4,
    @subTotal = 150.00;
GO

--fa)

CREATE PROCEDURE spAumentarPrecoBoloFesta
AS
BEGIN
    UPDATE tbProduto
    SET precokiloProduto = precokiloProduto * 1.10
    WHERE codCategoriaProduto = 1; -- C�digo da categoria "Bolo festa"
END;

EXEC spAumentarPrecoBoloFesta
GO

-- fb) Aplicar desconto de 20% nos produtos da categoria �Bolo simples�
CREATE PROCEDURE spDescontoBoloSimples
AS
BEGIN
    UPDATE tbProduto
    SET precokiloProduto = precokiloProduto * 0.80
    WHERE codCategoriaProduto = 2; -- C�digo da categoria "Bolo simples"
END;

EXEC spDescontoBoloSimples;
GO

-- fc) Aumentar o pre�o dos produtos da categoria �Torta� em 25%
CREATE PROCEDURE spAumentarPrecoTorta
AS
BEGIN
    UPDATE tbProduto
    SET precokiloProduto = precokiloProduto * 1.25
    WHERE codCategoriaProduto = 3; -- C�digo da categoria "Torta"
END;

EXEC spAumentarPrecoTorta;
GO

-- fd) Aumentar o pre�o dos produtos da categoria �Salgado�, exceto a esfiha de carne, em 20%
CREATE PROCEDURE spAumentarPrecoSalgado
AS
BEGIN
    UPDATE tbProduto
    SET precokiloProduto = precokiloProduto * 1.20
    WHERE codCategoriaProduto = 4 -- C�digo da categoria "Salgado"
    AND codProduto <> (
        SELECT codProduto
        FROM tbProduto
        WHERE nomeProduto = 'Esfiha de carne'
    );
END;

EXEC spAumentarPrecoSalgado;
GO

--g)
CREATE PROCEDURE spExcluirCliente
    @cpfCliente VARCHAR(11)
AS
BEGIN
    DECLARE @codCliente INT;
    DECLARE @nomeCliente VARCHAR(100);

    -- Buscar o c�digo do cliente e nome baseado no CPF
    SET @codCliente = (SELECT codCliente FROM tbCliente WHERE cpfCliente = @cpfCliente);
    SET @nomeCliente = (SELECT nomeCliente FROM tbCliente WHERE cpfCliente = @cpfCliente);

    IF @codCliente IS NULL
    BEGIN
        PRINT 'Cliente n�o encontrado.';
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT 1 FROM tbEncomenda WHERE codCliente = @codCliente)
        BEGIN
            PRINT 'Imposs�vel remover esse cliente pois o cliente ' + @nomeCliente + ' possui encomendas';
        END
        ELSE
        BEGIN
            DELETE FROM tbCliente WHERE cpfCliente = @cpfCliente;
            PRINT 'Cliente ' + @nomeCliente + ' removido com sucesso';
        END
    END
END;

EXEC spExcluirCliente
    @cpfCliente = '12345678901'; --teste
GO

--h)
CREATE PROCEDURE spExcluirItemEncomenda
    @codEncomenda INT,
    @codProduto INT
AS
BEGIN
    DECLARE @dataEntregaEncomenda DATE;
    DECLARE @subTotal DECIMAL(10, 2);
    DECLARE @valorTotalEncomenda DECIMAL(10, 2);

	    IF NOT EXISTS (SELECT 1 FROM tbEncomenda WHERE codEncomenda = @codEncomenda)
    BEGIN
        PRINT 'Encomenda n�o encontrada.';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM tbItensEncomenda WHERE codEncomenda = @codEncomenda AND codProduto = @codProduto)
    BEGIN
        PRINT 'O produto especificado n�o existe nesta encomenda.';
        RETURN;
    END

    SET @dataEntregaEncomenda = (SELECT dataEntregaEncomenda FROM tbEncomenda WHERE codEncomenda = @codEncomenda);

    IF @dataEntregaEncomenda > GETDATE()
    BEGIN
        -- busca o subtotal do item que ser� removido
        SET @subTotal = (SELECT subTotal FROM tbItensEncomenda WHERE codEncomenda = @codEncomenda AND codProduto = @codProduto);

        -- calcula novo total da encomenda
        SET @valorTotalEncomenda = (SELECT valorTotalEncomenda FROM tbEncomenda WHERE codEncomenda = @codEncomenda);
        SET @valorTotalEncomenda = @valorTotalEncomenda - @subTotal;

        -- atualiza encomenda com novo valor total
        UPDATE tbEncomenda
        SET valorTotalEncomenda = @valorTotalEncomenda
        WHERE codEncomenda = @codEncomenda;

        -- remove item
        DELETE FROM tbItensEncomenda
        WHERE codEncomenda = @codEncomenda AND codProduto = @codProduto;

        PRINT 'Item removido e valor total da encomenda atualizado com sucesso.';
    END
    ELSE
    BEGIN
        PRINT 'A encomenda j� foi entregue ou ser� entregue hoje. N�o � poss�vel remover itens.';
    END
END;

-- Remover um item de uma encomenda
EXEC spExcluirItemEncomenda
    @codEncomenda = 1,
    @codProduto = 9; 

GO

-- esses deram trabalho em prof 

