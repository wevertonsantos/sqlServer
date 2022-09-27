/*
Trazer todo mundo, exceto a que n�o � manga e 700ml
V vira F
*/

SELECT * FROM [TABELA DE PRODUTOS] WHERE 
NOT ([SABOR] = 'Manga' AND [TAMANHO] = '700 ml')

/*
Trazer todo mundo, exceto quem � manga ou 700ml
(n�o tr�s com as duas condi��es)
*/

SELECT * FROM [TABELA DE PRODUTOS] WHERE 
NOT ([SABOR] = 'Manga' OR [TAMANHO] = '700 ml')

/* Pegar todo mundo que � manga mas ningu�m 700ml */

SELECT * FROM [TABELA DE PRODUTOS] WHERE 
[SABOR] = 'Manga' AND NOT ( [TAMANHO] = '700 ml')

/*
IN = Contido (pertence)
Todo mundo que for manga ou laranja
*/

SELECT * FROM [TABELA DE PRODUTOS] WHERE 
[SABOR] IN ('Manga', 'Laranja')

SELECT * FROM [TABELA DE PRODUTOS] WHERE 
[SABOR] = 'Manga' OR [SABOR] ='Laranja'

/* NOT IN = N�o pertence (N�o contido) */

SELECT * FROM [TABELA DE PRODUTOS] WHERE 
[SABOR] NOT IN ('Manga', 'Laranja')

SELECT * FROM [TABELA DE PRODUTOS] WHERE 
NOT ([SABOR] = 'Manga' OR [SABOR] ='Laranja')

/* Trazer manga, laranja e quem tem pre�o maior que 10 reais */

SELECT * FROM [TABELA DE PRODUTOS] WHERE 
[SABOR] IN ('Manga', 'Laranja') AND [PRE�O DE LISTA] > 10

/*
Between and
Entre 10 e 13
*/

SELECT * FROM [TABELA DE PRODUTOS] WHERE 
[SABOR] IN ('Manga', 'Laranja') AND [PRE�O DE LISTA] BETWEEN 10 AND 13

SELECT * FROM [TABELA DE PRODUTOS] WHERE 
[SABOR] IN ('Manga', 'Laranja') AND [PRE�O DE LISTA] >= 10 AND [PRE�O DE LISTA] <= 1