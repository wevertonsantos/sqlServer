-- Definição de cursor
/*

Cursos é uma estrutura implementada no T-SQL que permite uma interatividade
linha a linha através de uma determinada ordem.

Frases para uso do Cursor:

. Declaração - Onde definimos qual consulta SQL estará sendo carregada ao Cursor;
. Abertura: Abrimos o cursor para percorrê-lo linha a linha;
. Posiciona na primeira linha do Cursor;
. Percorre linha a linha até o seu final;
. Fecha o Cursor;
. Limpa o Cursor da memória.

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

-- Achando o valor total do crédito

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