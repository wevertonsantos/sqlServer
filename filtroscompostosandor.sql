/* Filtrando por composto */

/* AND e OR */

-- VERDADEIRO AND VERDADEIRO = Verdadeiro
-- FALSO AND VERDADEIRO = Falso
-- VERDADEIRO AND FALSO = Falso
-- FALSO AND FALSO = Falso

-- VERDADEIRO OR VERDADEIRO = Verdadeiro
-- VERDADEIRO OR FALSO = Verdadeiro
-- FALSO OR FALSO = Falso
-- FALSO OR VERDADEIRO = Verdadeiro

-- Só vai vir linhas onde as duas condições forem verdadeiras

SELECT	*
FROM	[TABELA DE CLIENTES]
WHERE	DAY ([DATA DE NASCIMENTO]) = 12
AND		BAIRRO = 'Tijuca'

SELECT	*
FROM	[TABELA DE CLIENTES]
WHERE	YEAR ([DATA DE NASCIMENTO]) = 1995
AND		SEXO = 'M'

SELECT	*
FROM	[TABELA DE CLIENTES]
WHERE	YEAR ([DATA DE NASCIMENTO]) = 1995
AND		SEXO = 'F'

-- Basta uma ser verdadeira para todas serem verdadeiras

SELECT	*
FROM	[TABELA DE CLIENTES]
WHERE	DAY ([DATA DE NASCIMENTO]) = 12
OR		BAIRRO = 'Tijuca'