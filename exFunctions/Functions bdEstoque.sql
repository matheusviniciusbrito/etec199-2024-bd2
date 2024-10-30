USE dbEstoque
GO

--1
CREATE FUNCTION fcDiaSemanaVenda(@codVenda INT)
    RETURNS VARCHAR(100) AS
BEGIN
    DECLARE @diaSemana VARCHAR(40)
    DECLARE @data DATE
    DECLARE @valorTotalVenda FLOAT
    DECLARE @dia INT

	SET @valorTotalVenda = (SELECT valorTotalVenda FROM tbVenda WHERE codVenda = @codVenda)
	SET @data = (SELECT dataVenda FROM tbVenda WHERE codVenda = @codVenda)

	IF @data IS NULL
		RETURN 'Venda não encontrada'

	SET @data = CONVERT(VARCHAR, @data, 103)



    -- Obter o dia da semana
    SET @dia = DATEPART(DW, @data)

    IF @dia = 1
        SET @diaSemana = 'DOMINGO'
    IF @dia = 2
        SET @diaSemana = 'SEGUNDA-FEIRA'
    IF @dia = 3
        SET @diaSemana = 'TERÇA-FEIRA'
    IF @dia = 4
        SET @diaSemana = 'QUARTA-FEIRA'
    IF @dia = 5
        SET @diaSemana = 'QUINTA-FEIRA'
    IF @dia = 6
        SET @diaSemana = 'SEXTA-FEIRA'
    IF @dia = 7
        SET @diaSemana = 'SÁBADO'

    -- Retornar a string formatada
    RETURN @diaSemana + ' - Código da Venda: ' + CAST(@codVenda AS VARCHAR(10)) + 
           ', Valor Total: ' + CAST(@valorTotalVenda AS VARCHAR(20)) + 
           ', Data: ' + CONVERT(VARCHAR, @data, 103)
END
GO

--teste
SELECT dbo.fcDiaSemanaVenda(1) AS Resultado; 

-- Testando a função para uma venda que não existe
SELECT dbo.fcDiaSemanaVenda(999) AS Resultado;
GO

--2
CREATE FUNCTION fcTotalVendasCliente(@codCliente INT)
	RETURNS VARCHAR(100) AS
BEGIN

	DECLARE @contagem INT
	SET @contagem = (SELECT COUNT(codCliente) FROM tbVenda WHERE codCliente = @codCliente)

	IF @contagem = 0
		RETURN 'Cliente não existe, ou não tem vendas.'

	RETURN 'Cliente de código ' + CAST(@codCliente AS VARCHAR(10)) + ' já realizou ' + CAST(@contagem AS VARCHAR(10)) + ' vendas'
END
GO

--teste
SELECT dbo.fcTotalVendaCliente(1) AS Resultado;
SELECT dbo.fcTotalVendaCliente(2) AS Resultado;
SELECT dbo.fcTotalVendaCliente(999) AS Resultado; --tem que retornar 'Cliente não existe, ou não tem vendas.

GO

--3 (nao tem tabela de vendedor entao eu fiz na tabela cliente)
CREATE FUNCTION fcTotalVendasVendedor(@codVendedor INT, @mes INT)
RETURNS VARCHAR(100) AS
BEGIN
    DECLARE @quantidadeVendas INT;
    DECLARE @valorTotal FLOAT;

	    IF NOT EXISTS (SELECT 1 FROM tbCliente WHERE codCliente = @codVendedor)
        RETURN 'Vendedor de código ' + CAST(@codVendedor AS VARCHAR(10)) + 
               ' não existe no banco de dados.';
    
    SET @quantidadeVendas = (
		SELECT COUNT(*) 
		FROM tbVenda               
			WHERE codCliente = @codVendedor 
			AND MONTH(dataVenda) = @mes);

    SET @valorTotal = (
		SELECT SUM(valorTotalVenda) 
        FROM tbVenda 
			WHERE codCliente = @codVendedor 
			AND MONTH(dataVenda) = @mes);

    IF @quantidadeVendas IS NULL OR @quantidadeVendas = 0
        RETURN 'Vendedor de código ' + CAST(@codVendedor AS VARCHAR(10)) + 
               ' não realizou vendas no mês ' + CAST(@mes AS VARCHAR(10));

    RETURN 'Vendedor de código ' + CAST(@codVendedor AS VARCHAR(10)) + 
           ' teve ' + CAST(@quantidadeVendas AS VARCHAR(10)) + 
           ' vendas e vendeu um total de R$ ' + CAST(@valorTotal AS VARCHAR(10));
END
GO

--teste
SELECT dbo.fcTotalVendasVendedor(1, 2) AS Resultado; --existe, tem que retornar Vendedor de código 1 teve 2 vendas e vendeu um total de R$ 7900
SELECT dbo.fcTotalVendasVendedor(999, 2) AS Resultado; --nao existe esse cod no banco
SELECT dbo.fcTotalVendasVendedor(4, 2) AS Resultado; --existe, tem que retornar Vendedor de código 4 não realizou vendas no mês 2

GO

--4, vale copiar e colar o codigo dos slides? hahahahaha
CREATE FUNCTION fcValidaCPF(@CPF VARCHAR(11))
RETURNS VARCHAR(12) AS
BEGIN
    DECLARE @INDICE INT,
            @SOMA INT,
            @DIG1 INT,
            @DIG2 INT,
            @CPF_TEMP VARCHAR(11),
            @DIGITOS_IGUAIS VARCHAR(12),
            @RESULTADO VARCHAR(12)
    
    SET @RESULTADO = 'CPF INVALIDO'

	IF LEN(@CPF) <> 11
    RETURN @RESULTADO
    
    SET @CPF_TEMP = SUBSTRING(@CPF, 1, 1)
    SET @INDICE = 1
    SET @DIGITOS_IGUAIS = 'CPF VALIDO'
    
    WHILE (@INDICE <= 11)
    BEGIN
        IF SUBSTRING(@CPF, @INDICE, 1) <> @CPF_TEMP
            SET @DIGITOS_IGUAIS = 'CPF INVALIDO'
        
        SET @INDICE = @INDICE + 1
    END;
    
    -- Caso os dígitos não sejam todos iguais, começo o cálculo dos dígitos
    IF @DIGITOS_IGUAIS = 'CPF INVALIDO' 
    BEGIN
        -- Cálculo do 1º dígito
        SET @SOMA = 0
        SET @INDICE = 1
        
        WHILE (@INDICE <= 9)
        BEGIN
            SET @SOMA = @SOMA + CONVERT(INT, SUBSTRING(@CPF, @INDICE, 1)) * (11 - @INDICE);
            SET @INDICE = @INDICE + 1
        END
        
        SET @DIG1 = 11 - (@SOMA % 11)
        IF @DIG1 > 9
            SET @DIG1 = 0;
        
        -- Cálculo do 2º dígito
        SET @SOMA = 0
        SET @INDICE = 1
        
        WHILE (@INDICE <= 10)
        BEGIN
            SET @SOMA = @SOMA + CONVERT(INT, SUBSTRING(@CPF, @INDICE, 1)) * (12 - @INDICE);
            SET @INDICE = @INDICE + 1
        END
        
        SET @DIG2 = 11 - (@SOMA % 11)
        IF @DIG2 > 9
            SET @DIG2 = 0;
        
        -- Validando
        IF (@DIG1 = SUBSTRING(@CPF, LEN(@CPF) - 1, 1)) AND (@DIG2 = SUBSTRING(@CPF, LEN(@CPF), 1))
            SET @RESULTADO = 'CPF VALIDO'
        ELSE
            SET @RESULTADO = 'CPF INVALIDO'
    END
    
    RETURN @RESULTADO
END
GO

--TESTE
SELECT dbo.CPF_VALIDO('12345678909') AS Resultado;  -- Esperado: 'CPF VALIDO'
SELECT dbo.CPF_VALIDO('12345678900') AS Resultado;  -- Esperado: 'CPF INVALIDO'
SELECT dbo.CPF_VALIDO('00000000000') AS Resultado;  -- Esperado: 'CPF INVALIDO'
SELECT dbo.CPF_VALIDO('923') AS Resultado;  -- Esperado: 'CPF INVALIDO'





