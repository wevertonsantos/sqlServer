/*

-- Stored Procedures --

S�o rotinas executadas pelo servidor. Elas possuem grande poder de performance para manipula��o de tabelas do SQL SERVER.

As SPs (Stored Procedures) podem ser tamb�m definidas pelo usu�rio (UDF) ou podemos usar uma s�rie de SPs dispon�veis pelo SQL SERVER.

Diferen�a de Stored Procedure e Fun��o:

. Fun��o sempre vai retornar um valor: Escalar ou Tabela
. A SP vai executar um procedimento sem a necessidade de retornar
um valor.
EXEC CalculaComissao @CPF='123333121'

A SP pode at� voltar valor. Mas na verdade o que ela faz � modificar
o valor de uma vari�vel enviada a ela:

OUTPUT = Refer�ncia

SET @MENSAGEM = "
EXEC CalculaComissao @CPF=@CPF, @MENSAGEM=@MENSAGEM OUTPUT
IF	@MENSAGEM <> "

Uma Stored Procedure tem as seguintes caracter�sticas:

. O seu corpo deve ser delimitado por um BEGIN e END;
. Devemos declarar as vari�veis de entrada logo depois do nome da procedure
. Pode ter uma ou mais vari�veis de retorno

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


-- Procedure para c�lculos --

-- Atualizando idade do cliente pela procedure

CREATE	PROCEDURE CalculaIdade
AS
BEGIN
	UPDATE	[TABELA DE CLIENTES]
	SET		IDADE  = DATEDIFF(YEAR, [DATA DE NASCIMENTO], GETDATE())
END

EXEC	CalculaIdade

-- Acrescentando na Stored Procedure a entidade produto

-- Pegando m�s, ano e embalagem

SELECT		MONTH(NF.[DATA]) M�S, YEAR(NF.[DATA]) ANO, TB.EMBALAGEM, NF.IMPOSTO
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