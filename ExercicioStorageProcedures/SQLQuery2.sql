USE db_EscolaIdiomas

/*EX1*/

CREATE PROCEDURE spBuscaAluno
    @codAluno INT
AS
BEGIN
    SELECT nomeAluno, dataNascAluno
    FROM tbl_aluno
    WHERE codAluno = @codAluno;
END;

DROP PROCEDURE spBuscaAluno

EXEC spBuscaAluno @codAluno = 3;
GO
/*EX2*/
CREATE PROCEDURE spInserirAluno
    @nomeAluno VARCHAR(250),
    @dataNascAluno DATE,
    @rgAluno CHAR(9),
    @naturalidadeAluno CHAR(2)
AS
BEGIN
	INSERT INTO tbl_aluno(nomeAluno, dataNascAluno, rgAluno, naturalidadeAluno)
	VALUES (@nomeAluno, @dataNascAluno, @rgAluno, @naturalidadeAluno)
END;

EXEC spInserirAluno 
    @nomeAluno = 'Carlos Silva', 
    @dataNascAluno = '2002-05-15', 
    @rgAluno = '123456789', 
    @naturalidadeAluno = 'RJ';

SELECT * FROM tbl_aluno;

/*EX3*/
CREATE PROCEDURE spAumentaPrecoCurso
    @nomeCurso VARCHAR(10),
    @percentualAumento DECIMAL(5, 2)
AS
BEGIN
    UPDATE tbl_curso
    SET valorCurso = valorCurso * (1 + @percentualAumento / 100)
    WHERE nomeCurso = @nomeCurso;

    SELECT valorCurso AS NovoValorCurso
    FROM tbl_curso
    WHERE nomeCurso = @nomeCurso;
END;

EXEC spAumentaPrecoCurso 
    @nomeCurso = 'Inglês', 
    @percentualAumento = 10.0;

/*EX4*/
CREATE PROCEDURE spExibeTurma
    @nomeTurma VARCHAR (10)	
AS
BEGIN
    SELECT codTurma, nomeTurma, horarioTurma, codCurso
    FROM tbl_turma
    WHERE nomeTurma = @nomeTurma;
END;

EXEC spExibeTurma @nomeTurma = "1IA";

/*5*/
CREATE PROCEDURE spExibeAlunosPorTurma
    @nomeTurma VARCHAR(10)
AS
BEGIN
    SELECT a.codAluno, a.nomeAluno, a.dataNascAluno
    FROM tbl_aluno a
    INNER JOIN tbl_matricula m ON a.codAluno = m.codAluno
    INNER JOIN tbl_turma t ON m.codTurma = t.codTurma
    WHERE t.nomeTurma = @nomeTurma;
END;

EXEC spExibeAlunosPorTurma @nomeTurma = '1IA';

/*6*/
CREATE PROCEDURE spInsereAlunoComVerificacao
    @nomeAluno VARCHAR(250),
    @dataNascAluno DATE,
    @rgAluno CHAR(9),
    @naturalidadeAluno CHAR(2)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM tbl_aluno WHERE rgAluno = @rgAluno)
    BEGIN
        PRINT 'Aluno com esse RG já existe.';
    END
    ELSE
    BEGIN
        -- Insere o novo aluno, pois o RG não foi encontrado
        INSERT INTO tbl_aluno (nomeAluno, dataNascAluno, rgAluno, naturalidadeAluno)
        VALUES (@nomeAluno, @dataNascAluno, @rgAluno, @naturalidadeAluno);
        PRINT 'Aluno inserido com sucesso.';
    END
END;

EXEC spInsereAlunoComVerificacao 
    @nomeAluno = 'Carlos Silva', 
    @dataNascAluno = '2002-05-15', 
    @rgAluno = '123456789', 
    @naturalidadeAluno = 'RJ';



/*7*/
CREATE PROCEDURE spMatriculaAlunoNoCurso
    @nomeCurso VARCHAR(10),
    @nomeAluno VARCHAR(250)
AS
BEGIN
    DECLARE @codCurso INT;
    DECLARE @codAluno INT;
    DECLARE @codTurma INT;

    -- Verifica se o curso existe
    IF EXISTS (SELECT 1 FROM tbl_curso WHERE nomeCurso = @nomeCurso)
    BEGIN
        SET @codCurso = (SELECT codCurso FROM tbl_curso WHERE nomeCurso = @nomeCurso);
    END
    ELSE
    BEGIN
        PRINT 'Curso não encontrado.';
        RETURN;
    END

    -- Verifica se o aluno existe
    IF EXISTS (SELECT 1 FROM tbl_aluno WHERE nomeAluno LIKE @nomeAluno)
    BEGIN
        SET @codAluno = (SELECT codAluno FROM tbl_aluno WHERE nomeAluno LIKE @nomeAluno);
    END
    ELSE
    BEGIN
        PRINT 'Aluno não encontrado.';
        RETURN;
    END

    -- Verifica se existe uma turma associada ao curso
    IF EXISTS (SELECT 1 FROM tbl_turma WHERE codCurso = @codCurso)
    BEGIN
        SET @codTurma = (SELECT TOP 1 codTurma FROM tbl_turma WHERE codCurso = @codCurso); 
    END
    ELSE
    BEGIN
        PRINT 'Não há turmas disponíveis para este curso.';
        RETURN;
    END

    -- Matricula o aluno na turma correspondente
    INSERT INTO tbl_matricula (dataMatricula, codAluno, codTurma)
    VALUES (GETDATE(), @codAluno, @codTurma);

    PRINT 'Aluno matriculado com sucesso.';
END;


EXEC spMatriculaAlunoNoCurso 
    @nomeCurso = 'Inglês', 
    @nomeAluno = 'Carlo Silva';
