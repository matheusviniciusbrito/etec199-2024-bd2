CREATE DATABASE bdVeiculos;
GO
USE bdVeiculos;
GO


CREATE TABLE tbMotorista (
    idMotorista INT PRIMARY KEY IDENTITY(1,1),
    nomeMotorista VARCHAR(100) NOT NULL,
    dataNascimentoMotorista DATE NOT NULL,
    cpfMotorista CHAR(11) NOT NULL UNIQUE,
    CNHMotorista VARCHAR(20) NOT NULL,
    pontuacaoAcumulada INT NOT NULL
);

CREATE TABLE tbVeiculo (
    idVeiculo INT PRIMARY KEY IDENTITY(1,1),
    modeloVeiculo VARCHAR(50) NOT NULL,
    placa CHAR(7) NOT NULL UNIQUE,
    renavam VARCHAR(11) NOT NULL UNIQUE,
    anoVeiculo INT NOT NULL,
    idMotorista INT FOREIGN KEY REFERENCES tbMotorista(idMotorista) ON DELETE SET NULL
);

CREATE TABLE tbMultas (
    idMulta INT PRIMARY KEY IDENTITY(1,1),
    dataMulta DATE NOT NULL,
    horaMulta TIME NOT NULL,
    pontosMulta INT NOT NULL,
    idVeiculo INT FOREIGN KEY REFERENCES tbVeiculo(idVeiculo) ON DELETE CASCADE
);
