-- Defini??o de cursor
/*

Cursos ? uma estrutura implementada no T-SQL que permite uma interatividade
linha a linha atrav?s de uma determinada ordem.

Frases para uso do Cursor:

. Declara??o - Onde definimos qual consulta SQL estar? sendo carregada ao Cursor;
. Abertura: Abrimos o cursor para percorr?-lo linha a linha;
. Posiciona na primeira linha do Cursor;
. Percorre linha a linha at? o seu final;
. Fecha o Cursor;
. Limpa o Cursor da mem?ria.

*/ 

-- Exemplo cursor

DECLARE	@NOME	VARCHAR(200)
DECLARE	CURSOR1	CURSOR FOR 
SELECT TOP 4	NOME
FROM			[TABELA DE CLIENTES]
OPEN CURSOR1
FETCH NEXT FROM CURSOR1 INTO @NOME
WHILE @@FETCH_STATUS	=	0
BEGIN
	PRINT @NOME
	FETCH NEXT FROM CURSOR1 INTO @NOME
END

-- Achando o valor total do cr?dito

DECLARE	@LIMITECREDITO_TOTAL	INT
DECLARE	LIMITECRED_CURSOR	CURSOR FOR
SELECT	SUM([LIMITE DE CREDITO])
FROM	[TABELA DE CLIENTES]
OPEN	LIMITECRED_CURSOR
FETCH NEXT FROM	LIMITECRED_CURSOR INTO @LIMITECREDITO_TOTAL
WHILE	@@FETCH_STATUS = 0
BEGIN
	PRINT @LIMITECREDITO_TOTAL
	FETCH NEXT FROM	LIMITECRED_CURSOR INTO @LIMITECREDITO_TOTAL
END

-- Acessando mais de um campo com Cursor

DECLARE	@NOME		VARCHAR(200)
DECLARE	@ENDERECO	VARCHAR(MAX)
DECLARE	CURSORCAMPO CURSOR	FOR
SELECT	NOME, ([ENDERECO 1] + ' - ' + BAIRRO  + ' - '  + CIDADE  + ' - ' + ESTADO  + ' - ' + CEP) ENDCOMPLETO
FROM	[TABELA DE CLIENTES]
OPEN	CURSORCAMPO
FETCH NEXT FROM CURSORCAMPO
INTO			@NOME, @ENDERECO
WHILE			@@FETCH_STATUS = 0
BEGIN
	PRINT			@NOME + ' Endere?o: ' + @ENDERECO
	FETCH NEXT FROM	CURSORCAMPO
	INTO			@NOME, @ENDERECO
END

-- Calculando valor total do faturamento com mais de um campo

DECLARE	@QUANTIDADE	INT
DECLARE	@PRECO		FLOAT
DECLARE	@FATURAMENTOACUM FLOAT
SET		@FATURAMENTOACUM = 0
DECLARE	CURSORFATURAMENTO CURSOR FOR
SELECT		INF.QUANTIDADE, INF.PRE?O
FROM		[NOTAS FISCAIS] NF
INNER JOIN	[ITENS NOTAS FISCAIS] INF
ON			INF.NUMERO = NF.NUMERO
WHERE		MONTH(NF.[DATA]) = 1
AND			YEAR(NF.[DATA]) = 2017
OPEN	CURSORFATURAMENTO
FETCH NEXT FROM		CURSORFATURAMENTO
INTO				@QUANTIDADE, @PRECO
WHILE	@@FETCH_STATUS = 0
BEGIN
	SET			@FATURAMENTOACUM = @FATURAMENTOACUM + (@QUANTIDADE * @PRECO)
	FETCH NEXT FROM	CURSORFATURAMENTO
	INTO			@QUANTIDADE, @PRECO
END
CLOSE		CURSORFATURAMENTO
DEALLOCATE	CURSORFATURAMENTO
PRINT		@FATURAMENTOACUM

/* Gera??o de notas f?scais aleat?rias */

-- Criando n?meros aleat?rios
-- N?meros entre 100 (Min/Inicial) e 500 (Max/Final)

SELECT		ROUND(((500 - 100 - 1) * RAND() + 100), 0)

-- Tabela com n?meros aleat?rios

DECLARE		@TABELA	TABLE (NUMERO INT)
DECLARE		@CONTADOR INT
DECLARE		@CONTADORMAX INT
SET			@CONTADOR = 1
SET			@CONTADORMAX = 100
WHILE		(@CONTADOR < @CONTADORMAX)
BEGIN
	INSERT INTO	 @TABELA (NUMERO)
	VALUES		([dbo].[NumeroAleatorio](0, 1000))
	SET			@CONTADOR = @CONTADOR + 1
END
SELECT		*
FROM		@TABELA

-- Criando view para usar dentro da fun??o 

CREATE VIEW VW_ALEATORIO AS	SELECT RAND() AS VALUE
SELECT		*
FROM		VW_ALEATORIO

CREATE	FUNCTION NumeroAleatorio(@VAL_INIC INT, @VAL_FINAL INT)
RETURNS	INT
AS
BEGIN
	DECLARE		@ALEATORIO			INT
	DECLARE		@ALEATORIO_FLOAT	FLOAT
	SELECT		@ALEATORIO_FLOAT	= VALUE FROM VW_ALEATORIO
	SET			@ALEATORIO = ROUND(((@VAL_FINAL - @VAL_INIC - 1) * @ALEATORIO_FLOAT + @VAL_INIC), 0)
	RETURN		@ALEATORIO
END

SELECT	[dbo].[NumeroAleatorio](1,10)

-- Obtendo cliente aleat?rio

DECLARE		@CLIENTE_ALEATORIO	VARCHAR (12)
DECLARE		@VAL_INICIAL		INT
DECLARE		@VAL_FINAL			INT
DECLARE		@ALEATORIO			INT
DECLARE		@CONTADOR			INT

SET			@CONTADOR = 1
SET			@VAL_INICIAL = 1
SELECT		@VAL_FINAL	 = COUNT(*)
FROM		[TABELA DE CLIENTES]
SET			@ALEATORIO = [dbo].[NumeroAleatorio](@VAL_INICIAL, @VAL_FINAL)
DECLARE		CURSORCLIENTEALEATORIO CURSOR FOR
SELECT		CPF
FROM		[TABELA DE CLIENTES]
OPEN CURSORCLIENTEALEATORIO
FETCH NEXT FROM	CURSORCLIENTEALEATORIO
INTO		@CLIENTE_ALEATORIO
WHILE		@CONTADOR < @ALEATORIO
BEGIN
	FETCH NEXT FROM	CURSORCLIENTEALEATORIO
	INTO			@CLIENTE_ALEATORIO
	SET				@CONTADOR = @CONTADOR + 1
END
CLOSE		CURSORCLIENTEALEATORIO
DEALLOCATE	CURSORCLIENTEALEATORIO
SELECT		@CLIENTE_ALEATORIO

-- Criando fun??o para obter dados das entidades

CREATE FUNCTION	EntidadeAleatoria(@TIPO VARCHAR (12))
RETURNS	VARCHAR (20)
AS
BEGIN
	DECLARE		@ENTIDADE_ALEATORIA	VARCHAR (12)
	DECLARE		@TABELA				TABLE (CODIGO VARCHAR(20))
	DECLARE		@VAL_INICIAL		INT
	DECLARE		@VAL_FINAL			INT
	DECLARE		@ALEATORIO			INT
	DECLARE		@CONTADOR			INT

	IF			@TIPO = 'CLIENTE'
BEGIN
	INSERT INTO @TABELA (CODIGO)
	SELECT		CPF AS CODIGO
	FROM		[TABELA DE CLIENTES]
END
IF			@TIPO = 'VENDEDOR'
BEGIN
	INSERT INTO @TABELA (CODIGO)
	SELECT		MATRICULA AS CODIGO
	FROM		[TABELA DE VENDEDORES]
END
IF			@TIPO = 'PRODUTO'
BEGIN
	INSERT INTO @TABELA (CODIGO)
	SELECT		[CODIGO DO PRODUTO] AS CODIGO
	FROM		[TABELA DE PRODUTOS]
END

SET			@CONTADOR = 1
SET			@VAL_INICIAL = 1
SELECT		@VAL_FINAL	 = COUNT(*)
FROM		@TABELA
SET			@ALEATORIO = [dbo].[NumeroAleatorio](@VAL_INICIAL, @VAL_FINAL)
DECLARE		CURSORALEATORIO CURSOR FOR
SELECT		CODIGO
FROM		@TABELA
OPEN CURSORALEATORIO
FETCH NEXT FROM	CURSORALEATORIO
INTO		@ENTIDADE_ALEATORIA
WHILE		@CONTADOR < @ALEATORIO
BEGIN
	FETCH NEXT FROM	CURSORALEATORIO
	INTO			@ENTIDADE_ALEATORIA
	SET				@CONTADOR = @CONTADOR + 1
END
CLOSE		CURSORALEATORIO
DEALLOCATE	CURSORALEATORIO
RETURN		@ENTIDADE_ALEATORIA
END

SELECT [dbo].[EntidadeAleatoria]('VENDEDOR')

DECLARE	@CLIENTE	VARCHAR(20)
DECLARE	@VENDEDOR	VARCHAR(20)
DECLARE	@PRODUTO	VARCHAR(20)

SELECT	@CLIENTE =  [dbo].[EntidadeAleatoria]('CLIENTE')
SELECT	@VENDEDOR = [dbo].[EntidadeAleatoria]('VENDEDOR')
SELECT	@PRODUTO =  [dbo].[EntidadeAleatoria]('PRODUTO')

PRINT	@CLIENTE
PRINT	@VENDEDOR
PRINT	@PRODUTO

-- Outros dados da nota fiscal

DECLARE		@CLIENTE	VARCHAR(12)
DECLARE		@VENDEDOR	VARCHAR(12)
DECLARE		@PRODUTO	VARCHAR(12)
DECLARE		@DATA		DATE
DECLARE		@NUMERO		INT
DECLARE		@IMPOSTO	FLOAT
DECLARE		@NUM_ITENS	INT
DECLARE		@CONTADOR	INT
DECLARE		@QUANTIDADE	INT
DECLARE		@PRECO		FLOAT
DECLARE		@LISTAPRODUTO	TABLE (PRODUTO VARCHAR(20))
DECLARE		@AUXPRODUTO		INT

SET			@CLIENTE	= [dbo].[EntidadeAleatoria]('CLIENTE')
SET			@VENDEDOR	= [dbo].[EntidadeAleatoria]('VENDEDOR')
SET			@DATA		=  '20221015'
SELECT		@NUMERO		= MAX(NUMERO) + 1 FROM [NOTAS FISCAIS]
SET			@IMPOSTO	= 0.18
SET			@NUM_ITENS	= [dbo].[NumeroAleatorio](2,10) 
SET			@CONTADOR	= 1

PRINT		'CABE?ARIO'
PRINT		@DATA
PRINT		@CLIENTE
PRINT		@VENDEDOR
PRINT		@IMPOSTO
PRINT		@NUMERO
PRINT	''

	INSERT	INTO	[NOTAS FISCAIS](CPF, MATRICULA, DATA, NUMERO, IMPOSTO)
	VALUES			(@CLIENTE, @VENDEDOR, @DATA, @NUMERO, @IMPOSTO)

PRINT		'ITENS'
WHILE		@CONTADOR	<= @NUM_ITENS
BEGIN
	SET		@PRODUTO	= [dbo].[EntidadeAleatoria]('PRODUTO')
	SELECT	@AUXPRODUTO	= COUNT(*)
	FROM	@LISTAPRODUTO
	WHERE	PRODUTO = @PRODUTO
	IF		@AUXPRODUTO = 0
	BEGIN
		SET		@QUANTIDADE = [dbo].[NumeroAleatorio](5,100)
		SELECT	@PRECO		= [PRE?O DE LISTA] FROM [TABELA DE PRODUTOS] WHERE [CODIGO DO PRODUTO] = @PRODUTO
		PRINT	@NUMERO
		PRINT	@QUANTIDADE
		PRINT	@PRECO
		PRINT	''
		INSERT	INTO	[ITENS NOTAS FISCAIS](NUMERO, [CODIGO DO PRODUTO], QUANTIDADE, PRE?O)
		VALUES			(@NUMERO, @PRODUTO, @QUANTIDADE, @PRECO)
		SET		@CONTADOR	= @CONTADOR + 1
	END
	INSERT INTO @LISTAPRODUTO(PRODUTO)
	VALUES		(@PRODUTO)
END