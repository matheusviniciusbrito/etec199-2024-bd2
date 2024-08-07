USE bdRecursosHumanos

--a) Criar uma view para exibir a quantidade de funcion�rios por nome de departamento;
CREATE VIEW vwFuncionariosDepartamento AS 
	SELECT tbDepartamento.nomeDepartamento, COUNT(codFuncionario) AS qtdFuncionarios 
	FROM tbDepartamento
		INNER JOIN tbFuncionario ON tbDepartamento.codDepartamento = tbFuncionario.codDepartamento
	GROUP BY
		tbDepartamento.nomeDepartamento;

--b)Usando a view anterior, exibir somente o nome do departamento que possui o menor n�mero de funcion�rios
SELECT nomeDepartamento 
FROM vwFuncionariosDepartamento 
WHERE qtdFuncionarios = (SELECT MIN(qtdFuncionarios) FROM vwFuncionariosDepartamento);

--c) Criar uma view para exibir a soma dos sal�rios por nome de departamento
CREATE VIEW vwSalarioDepartamento AS
    SELECT tbDepartamento.nomeDepartamento, SUM(tbFuncionario.salarioFuncionario) AS somaSalario
    FROM tbDepartamento
		INNER JOIN tbFuncionario ON tbDepartamento.codDepartamento = tbFuncionario.codDepartamento
    GROUP BY tbDepartamento.nomeDepartamento;

--d) Utilizando a view do exerc�cio anterior, mostrar somente a maior soma dentre os departamentos

SELECT nomeDepartamento, somaSalario
FROM vwSalarioDepartamento
WHERE somaSalario = (SELECT MAX(somaSalario) FROM vwSalarioDepartamento)

--e)Criar uma view para exibir somente o nome dos funcion�rios e o nome dos departamentos daqueles funcion�rios que n�o possuem dependentes

CREATE VIEW vwFuncionarios AS
	SELECT tbFuncionario.nomeFuncionario, tbDepartamento.nomeDepartamento 
	FROM tbFuncionario
		INNER JOIN tbDepartamento ON tbFuncionario.codFuncionario = tbDepartamento.codFuncionario
	GROUP BY tb



SELECT * FROM vwFuncionariosDepartamento
SELECT * FROM tbFuncionario