USE bdVeiculossss
GO

CREATE TRIGGER tgAtualizaPontuacao
ON tbMultas AFTER INSERT
AS
	BEGIN		
		DECLARE @pontuacao INT, @idMotorista INT, @pontuacaoAtual INT;

		SET @pontuacao = (SELECT pontosMulta FROM inserted);
		SET @idMotorista = (
			SELECT tbVeiculo.idMotorista FROM tbVeiculo
				INNER JOIN inserted ON inserted.idVeiculo = tbVeiculo.idVeiculo
		);

		UPDATE tbMotorista SET pontuacaoAcumulada = pontuacaoAcumulada + @pontuacao
		WHERE idMotorista = @idMotorista
				
		SET @pontuacaoAtual = (
		SELECT pontuacaoAcumulada FROM tbMotorista
		WHERE idMotorista = @idMotorista
		);
					
		IF @pontuacaoAtual >= 20
		BEGIN
			PRINT('Você alcançou 20 pontos na sua carteira! Sua habilitação pode ser suspensa!')
		END
	END

-- Inserindo motoristas com ids 4, 5, e 6
INSERT INTO tbMotorista (nomeMotorista, dataNascimentoMotorista, cpfMotorista, CNHMotorista, pontuacaoAcumulada)
VALUES 
('Carlos Silva', '1985-05-12', '12345678901', '1234567890', 0),
('Ana Pereira', '1990-09-23', '10987654322', '0987654321', 10), -- CPF alterado
('João Souza', '1992-02-15', '11122334456', '1122334455', 15); -- CPF alterado

-- Inserindo veículos com ids correspondentes aos motoristas
INSERT INTO tbVeiculo (modeloVeiculo, placa, renavam, anoVeiculo, idMotorista)
VALUES 
('Fusca', 'ABC1234', '12345678900', 1975, 1),
('Civic', 'XYZ5678', '09876543210', 2018, 2),
('Ka', 'JKL4321', '56789012345', 2020, 3);

-- Inserindo multas
INSERT INTO tbMultas (dataMulta, horaMulta, pontosMulta, idVeiculo)
VALUES ('2024-10-02', '09:15', 7, 2)  -- Civic (idVeiculo = 2)
('2024-10-01', '14:30', 5, 1),  -- Fusca (idVeiculo = 1)

('2024-10-03', '11:45', 10, 3); -- Ka (idVeiculo = 3


