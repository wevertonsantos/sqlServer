SELECT * FROM [TABELA DE PRODUTOS]

SELECT * FROM [TABELA DE PRODUTOS] WHERE [NOME DO PRODUTO] LIKE '%Litros%'

SELECT * FROM [TABELA DE PRODUTOS] WHERE [NOME DO PRODUTO] LIKE 'Litros%'

SELECT	*
FROM	[TABELA DE PRODUTOS]
WHERE	[NOME DO PRODUTO]
LIKE	'Linha%'

SELECT * FROM [TABELA DE PRODUTOS] WHERE [NOME DO PRODUTO] LIKE '%Litros%' AND [SABOR] = 'Laranja'

SELECT	*
FROM	[TABELA DE CLIENTES]
WHERE	[NOME]
LIKE	'%Mattos'