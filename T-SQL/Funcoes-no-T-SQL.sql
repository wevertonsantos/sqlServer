/*

Funções são rotinas que efetuam um determinado processamento e retornam
um valor (Escalar(qualquer tipo de dado) ou uma tabela)

Uma função UDF escalar é aquela que retorna um valor.
Possui as seguintes características:

. O seu corpo deve ser delimitado por um BEGIN e END;
. Deve sempre retornar um valor através do comando RETURN;
. Após o nome da função devemos declarar as variáveis de entrada

*/

-- Função que retorna o faturamento de cada nota

CREATE	FUNCTION	FaturamentoNota (@NUMERO AS INT)
RETURNS	FLOAT
AS
BEGIN
	DECLARE	@FATURAMENTO	FLOAT
	SELECT	@FATURAMENTO	=	SUM(QUANTIDADE * PREÇO)
								FROM	[ITENS NOTAS FISCAIS]
								WHERE	NUMERO = @NUMERO
	RETURN	@FATURAMENTO
END

SELECT	NUMERO, [dbo].[FaturamentoNota](NUMERO) AS FATURAMENTO
FROM	[NOTAS FISCAIS]

-- Exercício I (Função para obter o número de notas fiscais)

CREATE	FUNCTION	NumeroNotas(@DATANOTAS AS DATE)
RETURNS	INT
AS
BEGIN
	DECLARE	@NUMNOTAS	INT
	SELECT	@NUMNOTAS	=	COUNT(*)
						FROM		[NOTAS FISCAIS]
						WHERE		[DATA]	=	@DATANOTAS
	RETURN	@NUMNOTAS
END

SELECT	[dbo].[NumeroNotas]('20170111') AS NUMERONOTAS

-- Usando funções como tabelas

-- Funções listando notas por cliente

SELECT		*
FROM		[NOTAS FISCAIS]
WHERE		CPF = '1471156710'

CREATE	FUNCTION	ListaNotasCliente (@CPF AS VARCHAR(12))
RETURNS	TABLE
AS
RETURN	SELECT		*
		FROM		[NOTAS FISCAIS]
		WHERE		CPF = @CPF

SELECT	*
FROM	ListaNotasCliente('1471156710')

-- Listando o total de notas por cliente

SELECT		CPF, COUNT(*)
FROM		[NOTAS FISCAIS]
WHERE		CPF = '1471156710'
GROUP BY	CPF

CREATE	FUNCTION	TotalNotasCliente(@CPF AS VARCHAR(12))
RETURNS	TABLE
AS
RETURN	SELECT		CPF, COUNT(*) AS [NUM NOTAS]
		FROM		[NOTAS FISCAIS]
		WHERE		CPF = @CPF
		GROUP BY	CPF

SELECT	*
FROM	TotalNotasCliente('1471156710')

SELECT		CPF,(SELECT		COUNT(*)
				 FROM		[dbo].[ListaNotasCliente](CPF)) AS NUM_NOTAS
FROM			[TABELA DE CLIENTES]

-- Duas funções em conjunto

SELECT	A.CPF, A.NUM_NOTAS, B.TOTAL_FATURAMENTO
FROM
(SELECT		CPF,(SELECT		COUNT(*)
				 FROM		[dbo].[ListaNotasCliente](CPF)) AS NUM_NOTAS
FROM			[TABELA DE CLIENTES]) A
INNER JOIN
(
SELECT		CPF, SUM([dbo].[FaturamentoNota](NUMERO)) AS TOTAL_FATURAMENTO
FROM		[NOTAS FISCAIS]
GROUP BY	CPF
) B
ON		A.CPF = B.CPF

-- Função para retornar o número de notas

-- Função para o resultado igual à essa:
SELECT	DISTINCT	*
FROM				[NOTAS FISCAIS]
WHERE				DATA	>=  '20170101'
AND					DATA	<=	'20170110'
--

CREATE	FUNCTION	FuncTabelaNotas(@DATA_INCIAL AS DATE, @DATA_FINAL AS DATE)
RETURNS	TABLE
AS
RETURN	SELECT	DISTINCT	*
		FROM				[NOTAS FISCAIS]
		WHERE				DATA	>=  @DATA_INCIAL
		AND					DATA	<=	@DATA_FINAL

SELECT		*
FROM		[dbo].[FuncTabelaNotas]('20170101', '20170110')

-- Função onde retorna o endereço completo do cliente

CREATE FUNCTION		EnderecoCompleto(
									 @ENDERECO	VARCHAR(100)
									,@CIDADE	VARCHAR(50)
									,@ESTADO	VARCHAR(50)
									,@CEP		VARCHAR(20)
									)
RETURNS VARCHAR(250)
AS
BEGIN
	DECLARE	@ENDERECO_COMPLETO VARCHAR(250)
	SET		@ENDERECO_COMPLETO = @ENDERECO + ' - ' + @CIDADE + ' - ' + @ESTADO + ' - ' + @CEP 
	RETURN	@ENDERECO_COMPLETO
END


SELECT		CPF, [dbo].[EnderecoCompleto]([ENDERECO 1], CIDADE, ESTADO, CEP) AS END_COMPLETO
FROM		[TABELA DE CLIENTES]

-- Alterando função

ALTER	FUNCTION EnderecoCompleto(
									 @ENDERECO	VARCHAR(100)
									,@CIDADE	VARCHAR(50)
									,@ESTADO	VARCHAR(50)
									,@CEP		VARCHAR(20)
									)
RETURNS VARCHAR(250)
AS
BEGIN
	DECLARE	@ENDERECO_COMPLETO VARCHAR(250)
	SET		@ENDERECO_COMPLETO = @ENDERECO + ', ' + @CIDADE + ', ' + @ESTADO + ', ' + @CEP 
	RETURN	@ENDERECO_COMPLETO
END


-- Excluindo uma função

IF OBJECT('EnderecoCompleto3', 'FN') IS NOT NULL
	DROP FUNCTION [dbo].[EnderecoCompleto3]

DROP FUNCTION [dbo].[EnderecoCompleto3]