
-- Controle de fluxo

/*

IS NOT NULL = (Se ele não for nulo) a tabela existe
IS NULL = (Se ele for nulo) a tabela não existe

OBJECT_ID (nome do objeto, tipo do objeto)
OBJECT_ID('TAB_TESTE', 'U')

*/

IF	OBJECT_ID('TAB_TESTE', 'U') IS NOT NULL
	BEGIN
		DROP TABLE	TAB_TESTE
	END

IF	OBJECT_ID('TAB_TESTE', 'U') IS NULL
CREATE	TABLE	TAB_TESTE
(
ID VARCHAR (10)
)

-- Controle do fluxo dos valores de variáveis

SELECT	GETDATE()
SELECT	DATENAME(WEEKDAY, DATEADD(DAY, 4 ,GETDATE()))

DECLARE	@DIA_SEMANA		VARCHAR(20)
DECLARE	@NUMERO_DIAS	INT

SET		@NUMERO_DIAS	=	3
SET		@DIA_SEMANA		=	DATENAME(WEEKDAY, DATEADD(DAY, @NUMERO_DIAS, GETDATE()))
PRINT	@DIA_SEMANA

IF		@DIA_SEMANA = 'Domingo' OR @DIA_SEMANA = 'Sábado'
	PRINT	'Este dia é fim de semana'
ELSE
	PRINT	'Este dia é dia da semana'

-- Exercício I: Testando o número de notas fiscais

DECLARE			@NUMNOTAS	INT
DECLARE			@DATANOTA	DATE

SET				@DATANOTA = '20180301'

SELECT			@NUMNOTAS = COUNT(*)
				FROM	[NOTAS FISCAIS]
				WHERE	[DATA] = @DATANOTA

IF	@NUMNOTAS > 70
	PRINT	'Muita nota'
ELSE
	PRINT	'Pouca nota'

PRINT			@NUMNOTAS

-- Controle do fluxo usando um SELECT

DECLARE		@LIMITE_MAXIMO	FLOAT
DECLARE		@LIMITE_ATUAL	FLOAT
DECLARE		@BAIRRO			VARCHAR(20)

SET			@LIMITE_ATUAL =
							(
							SELECT		SUM([LIMITE DE CREDITO])
							FROM		[TABELA DE CLIENTES]
							WHERE		BAIRRO = 'Jardins'
							)
PRINT		@LIMITE_ATUAL


SET			@BAIRRO			=	'Jardins'
SET			@LIMITE_MAXIMO	=	400000

IF			@LIMITE_MAXIMO <= @LIMITE_ATUAL
BEGIN
	PRINT	'Valor estourou, não é possível abrir novos créditos'
END
ELSE	
BEGIN
	PRINT	'Valor não estourou, é possível abrir novos créditos'
END

-- Exercício II: Testando o número de notas fiscais usando SELECT

DECLARE			@NUMNOTAS	INT
DECLARE			@DATANOTA	DATE

SET				@DATANOTA = '20180301'

IF				(
				SELECT	COUNT(*)
				FROM	[NOTAS FISCAIS]
				WHERE	[DATA] = @DATANOTA
				) > 70
	PRINT	'Muita nota'
ELSE
	PRINT	'Pouca nota'