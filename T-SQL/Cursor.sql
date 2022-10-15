-- Defini��o de cursor
/*

Cursos � uma estrutura implementada no T-SQL que permite uma interatividade
linha a linha atrav�s de uma determinada ordem.

Frases para uso do Cursor:

. Declara��o - Onde definimos qual consulta SQL estar� sendo carregada ao Cursor;
. Abertura: Abrimos o cursor para percorr�-lo linha a linha;
. Posiciona na primeira linha do Cursor;
. Percorre linha a linha at� o seu final;
. Fecha o Cursor;
. Limpa o Cursor da mem�ria.

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

-- Achando o valor total do cr�dito

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