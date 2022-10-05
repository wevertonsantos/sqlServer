/*

** Com a parte de programa��o do T-SQL poderemos expandir a manuten��o
dos nossos bancos de dados. **

*/

-- Podemos usar vari�veis para criar uma estrutura din�mica de atualiza��o de dados

DECLARE @MeuCurso varchar(20)

SET		@MeuCurso = 'SQL Server'

SELECT	@MeuCurso

-- Comandos de fluxos para controlar o resultado de uma consulta

DECLARE		@Resposta	varchar(20)
DECLARE		@Valor		int

SET			@Valor	=	3

IF			@Valor		<= 10
PRINT		'Valor menor ou igual a 10'
ELSE
PRINT		'Valor maior que 10'

-- Trabalhar com blocos de comandos

BEGIN
	
	SELECT		*
	FROM		TAB_1;

END

-- Execu��o de Loops

DECLARE		@contador	INT
	SET			@contador	=	1

WHILE (@contador <= 5)
BEGIN
	PRINT	@contador
	SET		@contador = @contador + 1
END

-- Functions e Stored Procedures

/* Criar fun��es que retorna dados e execu��o do processo */