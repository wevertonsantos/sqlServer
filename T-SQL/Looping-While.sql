
-- Looping com WHILE

DECLARE	
 @LIMITE_MINIMO	INT
,@LIMITE_MAXIMO	INT

SET	@LIMITE_MINIMO	=	1
SET	@LIMITE_MAXIMO	=	10


WHILE	@LIMITE_MINIMO <= @LIMITE_MAXIMO
BEGIN
	PRINT	@LIMITE_MINIMO
	SET		@LIMITE_MINIMO	=	@LIMITE_MINIMO + 1
END

-- Looping com WHILE e BREAK

DECLARE	
 @LIMITE_MINIMO	INT
,@LIMITE_MAXIMO	INT
,@LIMITE_BREAK	INT

SET	@LIMITE_MINIMO	=	1
SET	@LIMITE_MAXIMO	=	10
SET	@LIMITE_BREAK	=	8

WHILE	@LIMITE_MINIMO <= @LIMITE_MAXIMO
BEGIN
	PRINT	@LIMITE_MINIMO
	SET		@LIMITE_MINIMO	=	@LIMITE_MINIMO + 1
IF	@LIMITE_MINIMO	=	@LIMITE_BREAK
	BEGIN
		PRINT 'Saindo por causa do BREAK'
		BREAK
	END
END

-- Exerc�cio I - (N�mero de notas para diversos dias)

DECLARE
 @DATA_INICIAL	DATE
,@DATA_FINAL	DATE
,@NUMNOTAS		INT

SET		@DATA_INICIAL	=	'20170101'
SET		@DATA_FINAL		=	'20170110'

WHILE	@DATA_INICIAL	<	@DATA_FINAL
	BEGIN
		PRINT	@DATA_INICIAL
		SELECT	@DATA_INICIAL	=	(DATEADD(DAY,1,@DATA_INICIAL))
		SELECT	@NUMNOTAS = COUNT(*)
		FROM	[NOTAS FISCAIS]
		WHERE	[DATA] = @DATA_INICIAL
		PRINT	@NUMNOTAS
	END


-- Loop para inserir registros em uma tabela

IF	OBJECT_ID('TABELA_NUMEROS','U')	IS NOT NULL
	DROP	TABLE	TABELA_NUMEROS

CREATE	TABLE	TABELA_NUMEROS
(
 [NUMERO]	INT
,[STATUS]	VARCHAR(200)
)

DECLARE
 @LIMITE_MINIMO		INT
,@LIMITE_MAXIMO		INT
,@CONTADOR_NOTAS	INT

SET	@LIMITE_MINIMO	=	1
SET	@LIMITE_MAXIMO	=	1000

SET NOCOUNT ON
WHILE	@LIMITE_MINIMO <= @LIMITE_MAXIMO
BEGIN
	SELECT	@CONTADOR_NOTAS	=	COUNT(*)
	FROM	[NOTAS FISCAIS]
	WHERE	NUMERO			=	@LIMITE_MINIMO
	IF		@CONTADOR_NOTAS > 0
	INSERT	INTO	TABELA_NUMEROS (
									 [NUMERO]
									,[STATUS]
									)
	VALUES							(
									@LIMITE_MINIMO, '� nota fiscal'
									)
	ELSE
	INSERT	INTO	TABELA_NUMEROS (
									 [NUMERO]
									,[STATUS]
									)
	VALUES							(
									@LIMITE_MINIMO, 'N�o � nota fiscal'
									)
	SET		@LIMITE_MINIMO	=	@LIMITE_MINIMO + 1
END

SELECT		*
FROM		TABELA_NUMEROS

-- Exerc�cio II (Incluindo dia e o n�mero de notas em uma tabela)

IF	OBJECT_ID('TABELA_NOTAS', 'U')	IS NOT NULL
	DROP	TABLE	TABELA_NOTAS


	CREATE	TABLE	TABELA_NOTAS
	(
	 [DATA_NOTAS]	DATE
	,[NUMERO_NOTAS]	INT
	)

DECLARE
 @DATA_INICIAL	DATE
,@DATA_FINAL	DATE
,@NUMNOTAS		INT

SET		@DATA_INICIAL	=	'20170101'
SET		@DATA_FINAL		=	'20170110'

SET	NOCOUNT	ON
WHILE	@DATA_INICIAL	<=	@DATA_FINAL
	BEGIN
		SELECT	@DATA_INICIAL	=	(DATEADD(DAY,1,@DATA_INICIAL))
		SELECT	@NUMNOTAS = COUNT(*)
		FROM	[NOTAS FISCAIS]
		WHERE	[DATA] = @DATA_INICIAL
		INSERT	INTO	TABELA_NOTAS
		(
		 [DATA_NOTAS]
		,[NUMERO_NOTAS]
		)
		VALUES						
		(
		 @DATA_INICIAL
		,@NUMNOTAS
		)
	END

	SELECT		*
	FROM		TABELA_NOTAS
