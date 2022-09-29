
SELECT CEILING(12.333223)

SELECT FLOOR(12.333223)

SELECT RAND()

SELECT ROUND(12.33323323, 2)

-- Calcular o valor do imposto pago no ano de 2016, arredondando para o menor inteiro

SELECT		YEAR(DATA) ANO, FLOOR(SUM(IMPOSTO * (QUANTIDADE * PRE�O)))
FROM		[NOTAS FISCAIS] NF
INNER JOIN	[ITENS NOTAS FISCAIS] INF
ON			NF.NUMERO = INF.NUMERO
WHERE		YEAR(DATA) = 2016
GROUP BY	YEAR(DATA)

SELECT		QUANTIDADE, PRE�O, ROUND((QUANTIDADE * PRE�O), 1)
FROM		[ITENS NOTAS FISCAIS]

