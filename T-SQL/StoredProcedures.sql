/*

-- Stored Procedures --

São rotinas executadas pelo servidor. Elas possuem grande poder de performance para manipulação de tabelas do SQL SERVER.

As SPs (Stored Procedures) podem ser também definidas pelo usuário (UDF) ou podemos usar uma série de SPs disponíveis pelo SQL SERVER.

Diferença de Stored Procedure e Função:

. Função sempre vai retornar um valor: Escalar ou Tabela
. A SP vai executar um procedimento sem a necessidade de retornar
um valor.
EXEC CalculaComissao @CPF='123333121'

A SP pode até voltar valor. Mas na verdade o que ela faz é modificar
o valor de uma variável enviada a ela:

OUTPUT = Referência

SET @MENSAGEM = "
EXEC CalculaComissao @CPF=@CPF, @MENSAGEM=@MENSAGEM OUTPUT
IF	@MENSAGEM <> "

Uma Stored Procedure tem as seguintes características:

. O seu corpo deve ser delimitado por um BEGIN e END;
. Devemos declarar as variáveis de entrada logo depois do nome da procedure
. Pode ter uma ou mais variáveis de retorno

*/

-- Buscar por clientes e vendedores

CREATE	PROCEDURE BuscaPorEntidades @ENTIDADE AS VARCHAR(10)
AS
BEGIN
IF		@ENTIDADE = 'CLIENTES'
	SELECT	CPF AS IDENTIFICADOR, NOME AS DESCRITOR, BAIRRO AS BAIRRO
	FROM	[TABELA DE CLIENTES]
ELSE IF	@ENTIDADE = 'VENDEDORES'
	SELECT	MATRICULA AS IDENTIFICADOR, NOME AS DESCRITOR, BAIRRO AS BAIRRO
	FROM	[TABELA DE VENDEDORES]
END


EXEC	BuscaPorEntidades @ENTIDADE =	'Vendedores'
EXEC	BuscaPorEntidades @ENTIDADE	=	'Clientes'

-- Acrescentando produtos na busca

CREATE	PROCEDURE BuscaPorEntidadesCompleta @ENTIDADE AS VARCHAR(10)
AS
BEGIN
IF		@ENTIDADE = 'CLIENTES'
	SELECT	CPF AS IDENTIFICADOR, NOME AS DESCRITOR, BAIRRO AS BAIRRO
	FROM	[TABELA DE CLIENTES]
ELSE IF	@ENTIDADE = 'VENDEDORES'
	SELECT	MATRICULA AS IDENTIFICADOR, NOME AS DESCRITOR, BAIRRO AS BAIRRO
	FROM	[TABELA DE VENDEDORES]
ELSE IF @ENTIDADE = 'PRODUTOS'
	SELECT	[CODIGO DO PRODUTO] AS IDENTIFICADOR, [NOME DO PRODUTO] AS NOME
	FROM	[TABELA DE PRODUTOS]
END

EXEC	BuscaPorEntidades @ENTIDADE =	'Vendedores'
EXEC	BuscaPorEntidades @ENTIDADE	=	'Clientes'
EXEC	BuscaPorEntidades @ENTIDADE	=	'Produtos'


-- Procedure para cálculos --

-- Atualizando idade do cliente pela procedure

CREATE	PROCEDURE CalculaIdade
AS
BEGIN
	UPDATE	[TABELA DE CLIENTES]
	SET		IDADE  = DATEDIFF(YEAR, [DATA DE NASCIMENTO], GETDATE())
END

EXEC	CalculaIdade

-- Acrescentando na Stored Procedure a entidade produto

-- Pegando mês, ano e embalagem

SELECT		MONTH(NF.[DATA]) MÊS, YEAR(NF.[DATA]) ANO, TB.EMBALAGEM, NF.IMPOSTO
FROM		[ITENS NOTAS FISCAIS] INF
INNER JOIN	[TABELA DE PRODUTOS] TB
ON			INF.[CODIGO DO PRODUTO] = TB.[CODIGO DO PRODUTO]
INNER JOIN	[NOTAS FISCAIS] NF
ON			NF.NUMERO = INF.NUMERO
WHERE		MONTH(NF.[DATA])	=	'2'
AND			YEAR(NF.[DATA])		=	'2017'
AND			EMBALAGEM = 'Lata'

-- Criando a stored procedure

CREATE	PROCEDURE	AtualizaImposto @MES AS VARCHAR(2), @ANO AS VARCHAR(4), @ALIQUOTA AS FLOAT, @TIPO_PRODUTO AS VARCHAR(8)
AS
BEGIN
	UPDATE		[NOTAS FISCAIS]
	SET			IMPOSTO		=	@ALIQUOTA
	FROM		[ITENS NOTAS FISCAIS] INF
	INNER JOIN	[TABELA DE PRODUTOS] TB
	ON			INF.[CODIGO DO PRODUTO] = TB.[CODIGO DO PRODUTO]
	INNER JOIN	[NOTAS FISCAIS] NF
	ON			NF.NUMERO = INF.NUMERO
	WHERE		MONTH(NF.[DATA])	=	@MES
	AND			YEAR(NF.[DATA])		=	@ANO
	AND			EMBALAGEM			=	@TIPO_PRODUTO
END

EXEC	AtualizaImposto @MES = '02', @ANO = '2017', @ALIQUOTA = 0.16, @TIPO_PRODUTO = 'Lata'

-- SP de sistema 

Todas as características das colunas
EXEC sp_columns @table_name = 'TABELA DE CLIENTES', @table_owner = 'dbo'

Todas as características das tabelas
EXEC sp_tables @table_name	= 'TAB%', @table_owner = 'dbo', @table_qualifier = 'SUCOS_VENDAS'

-- SPs com interface - Entrada escalar

CREATE PROCEDURE	BuscaNotasCliente
 @CPF			AS	VARCHAR(12)
,@DATAINICIAL	AS	DATETIME	=	'20160101'
,@DATAFINAL		AS	DATETIME	=	'20161231'
AS
BEGIN
SELECT		*
FROM		[NOTAS FISCAIS]
WHERE		CPF		=	@CPF
AND			[DATA]	>=	@DATAINICIAL
AND			[DATA]	<=	@DATAFINAL
END

EXEC		BuscaNotasCliente	@CPF = '19290992743'
EXEC		BuscaNotasCliente	@CPF = '19290992743', @DATAINICIAL = '20161201'
EXEC		BuscaNotasCliente	@CPF = '19290992743', @DATAFINAL = '20160131'
EXEC		BuscaNotasCliente	'19290992743'
EXEC		BuscaNotasCliente	'19290992743', '20162301'
EXEC		BuscaNotasCliente	'19290992743', DEFAULT, '20162301'

-- SPs com interface - Entrada tabela

SELECT		TC.CPF, TC.NOME, SUM(INF.QUANTIDADE * INF.PREÇO) FATURAMENTO
FROM		[NOTAS FISCAIS]			NF
INNER JOIN	[ITENS NOTAS FISCAIS]	INF
ON			INF.NUMERO = NF.NUMERO
INNER JOIN	[TABELA DE CLIENTES]	TC
ON			TC.CPF = NF.CPF
AND			YEAR(NF.[DATA]) = 2016
GROUP BY	TC.CPF, TC.NOME

-- Criando lista de clientes

CREATE TYPE	ListaClientes AS TABLE
(CPF VARCHAR(12) NOT NULL)

-- Variável tipo lista, inserir os CPF e rodar o SELECT
-- só trazendo o faturamento dos três CPFs

DECLARE	@Lista AS ListaClientes
INSERT	INTO	@Lista (CPF)
VALUES
(
 '8502682733'
)
,
(
'8719655770'
)
,
(
'9283760794'
)
SELECT		TC.CPF, TC.NOME, SUM(INF.QUANTIDADE * INF.PREÇO) FATURAMENTO
FROM		[NOTAS FISCAIS]			NF
INNER JOIN	[ITENS NOTAS FISCAIS]	INF
ON			INF.NUMERO = NF.NUMERO
INNER JOIN	[TABELA DE CLIENTES]	TC
ON			TC.CPF = NF.CPF
AND			YEAR(NF.[DATA]) = 2016
INNER JOIN	@Lista LT
ON			LT.CPF = TC.CPF
GROUP BY	TC.CPF, TC.NOME

-- Criando a stored procedure a lista de clientes e retorna o faturamento

CREATE PROCEDURE	FaturamentoClientes2016
@LISTA AS ListaClientes READONLY
AS
SELECT		TC.CPF, TC.NOME, SUM(INF.QUANTIDADE * INF.PREÇO) FATURAMENTO
FROM		[NOTAS FISCAIS]			NF
INNER JOIN	[ITENS NOTAS FISCAIS]	INF
ON			INF.NUMERO = NF.NUMERO
INNER JOIN	[TABELA DE CLIENTES]	TC
ON			TC.CPF = NF.CPF
AND			YEAR(NF.[DATA]) = 2016
INNER JOIN	@LISTA LT
ON			LT.CPF = TC.CPF
GROUP BY	TC.CPF, TC.NOME

-- Passando CPF na SP

DECLARE	@Lista AS ListaClientes
INSERT	INTO	@Lista (CPF)
VALUES
(
 '8502682733'
)
,
(
'5840119709'
)
,
(
'7771579779'
)
EXEC	FaturamentoClientes2016 @LISTA = @Lista

-- Lista de números de notas passando uma tabela como parâmetro

CREATE TYPE	ListaDatasT AS TABLE
(DATA DATE NOT NULL)

CREATE	PROCEDURE	ListaNumeroNotas
@ListaDatas AS ListaDatasT READONLY
AS
SELECT		DATA, COUNT(*) AS NUMERO
FROM		[NOTAS FISCAIS] NF
WHERE		DATA IN	(SELECT DATA FROM @ListaDatas)
GROUP BY	DATA

DECLARE			@ListaDatas	AS ListaDatasT
INSERT	INTO	@ListaDatas (DATA)
VALUES
 ('20160101')
,('20161231')
,('20160131')
EXEC		ListaNumeroNotas @ListaDatas = @ListaDatas

-- SPs com parâmetros de saída

CREATE PROCEDURE RetornaValores
 @CPF			AS	VARCHAR(12)
,@ANO			AS	INT
,@NUM_NOTAS		AS	INT		OUTPUT
,@FATURAMENTO	AS	FLOAT	OUTPUT
AS
BEGIN
SELECT		@NUM_NOTAS = COUNT(*)
FROM		[NOTAS FISCAIS]
WHERE		CPF = @CPF
AND			YEAR([DATA]) =	@ANO

SELECT		@FATURAMENTO = SUM(QUANTIDADE * [PREÇO])
FROM		[ITENS NOTAS FISCAIS] INF
INNER JOIN	[NOTAS FISCAIS]	NF
ON			NF.NUMERO = INF.NUMERO
WHERE		CPF = @CPF
AND			YEAR([DATA]) =	@ANO
END

DECLARE		@NUMERO_NOTAS INT, @FATURAMENTO	FLOAT
DECLARE		@CPF VARCHAR(12), @ANO	INT
SET			@CPF = '19290992743'
SET			@ANO = 2016
EXEC		RetornaValores 
			 @CPF = @CPF
			,@ANO = @ANO
			,@NUM_NOTAS = @NUMERO_NOTAS OUTPUT
			,@FATURAMENTO = @FATURAMENTO OUTPUT
SELECT		@NUMERO_NOTAS, @FATURAMENTO