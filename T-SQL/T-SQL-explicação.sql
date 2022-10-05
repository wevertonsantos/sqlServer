/*

** Com a parte de programação do T-SQL poderemos expandir a manutenção
dos nossos bancos de dados. **

*/

-- Podemos usar variáveis para criar uma estrutura dinâmica de atualização de dados

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

-- Execução de Loops

DECLARE		@contador	INT
	SET			@contador	=	1

WHILE (@contador <= 5)
BEGIN
	PRINT	@contador
	SET		@contador = @contador + 1
END

-- Functions e Stored Procedures

/* Criar funções que retorna dados e execução do processo */