USE bdExTriggers
/*ex1*/
CREATE TRIGGER trAtualizarPontuaçãoMotorista
ON tbMultas
AFTER INSERT
AS
BEGIN
	UPDATE tbMotorista
	SET pontuacaoAcumulada = pontuacaoAcumulada + m.pontosMulta
	FROM tbMotorista AS mot
	INNER JOIN tbVeiculo AS v ON v.idMotorista = mot.idMotorista
	INNER JOIN inserted AS m ON v.idVeiculo = m.idVeiculo;
	DECLARE @pontuacaoAtual INT;

	SELECT @pontuacaoAtual = pontuacaoAcumulada
	FROM tbMotorista AS mot
	INNER JOIN tbVeiculo AS v ON v.idMotorista = mot.idMotorista
	INNER JOIN inserted AS m ON v.idVeiculo = m.idVeiculo;

	IF @pontuacaoAtual >=20
	BEGIN
		PRINT 'Você alcançou 20 pontos na sua carteira! Sua habilitação pode ser suspensa!'
	END;
END;

INSERT INTO tbMultas (dataMulta, horaMulta, pontosMulta, idVeiculo)
VALUES ('2024-10-15', '12:41', 10, 1);

/*2*/
CREATE TRIGGER tr_AtualizaSaldoDeposito
ON tbDeposito
AFTER INSERT
AS
BEGIN
    UPDATE tbContaCorrente
    SET saldoConta = saldoConta + inserted.valorDeposito
    FROM tbContaCorrente
    INNER JOIN inserted ON tbContaCorrente.numConta = inserted.numConta;
END;



CREATE TRIGGER tr_AtualizaSaldoSaque
ON tbSaque
AFTER INSERT
AS
BEGIN
    DECLARE @saldoAtual DECIMAL(18, 2);
    DECLARE @valorSaque DECIMAL(18, 2);
    DECLARE @numConta INT;

    SELECT @valorSaque = s.valorSaque, @numConta = s.numConta
    FROM inserted AS s;

    SELECT @saldoAtual = saldoConta
    FROM tbContaCorrente
    WHERE numConta = @numConta;

    IF @saldoAtual >= @valorSaque
    BEGIN
        UPDATE tbContaCorrente
        SET saldoConta = saldoConta - @valorSaque
        WHERE numConta = @numConta;
    END
    ELSE
    BEGIN
        PRINT('Saldo insuficiente para realizar o saque.');
    END;
END;

-- A conta 1 tem saldo inicial de 1000.00
INSERT INTO tbSaque (valorSaque, numConta, dataSaque, horaSaque)
VALUES (200.00, 1, '2024-10-17', '10:00');  -- Saldo restante deverá ser 800.00

SELECT * FROM tbContaCorrente

-- A conta 1 agora tem saldo de 800.00
INSERT INTO tbSaque (valorSaque, numConta, dataSaque, horaSaque)
VALUES (800.00, 1, '2024-10-17', '11:00');  -- Saldo restante deverá ser 0.00

-- A conta 1 agora tem saldo 0.00
INSERT INTO tbSaque (valorSaque, numConta, dataSaque, horaSaque)
VALUES (100.00, 1, '2024-10-17', '12:00');  -- Deve retornar erro ou não permitir

-- A conta 2 tem saldo inicial de 2500.50
INSERT INTO tbSaque (valorSaque, numConta, dataSaque, horaSaque)
VALUES (1000.00, 2, '2024-10-17', '14:00');  -- Saldo restante deverá ser 1500.50

-- A conta 3 tem saldo de 1500.75
INSERT INTO tbSaque (valorSaque, numConta, dataSaque, horaSaque)
VALUES (2000.00, 3, '2024-10-17', '15:00');  -- Deve retornar erro ou não permitir
