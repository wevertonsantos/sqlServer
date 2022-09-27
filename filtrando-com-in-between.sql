/*
Trazer todo mundo, exceto a que não é manga e 700ml
V vira F
*/

SELECT * FROM [TABELA DE PRODUTOS] WHERE 
NOT ([SABOR] = 'Manga' AND [TAMANHO] = '700 ml')

/*
Trazer todo mundo, exceto quem é manga ou 700ml
(não trás com as duas condições)
*/

SELECT * FROM [TABELA DE PRODUTOS] WHERE 
NOT ([SABOR] = 'Manga' OR [TAMANHO] = '700 ml')

/* Pegar todo mundo que é manga mas ninguém 700ml */

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

/* NOT IN = Não pertence (Não contido) */

SELECT * FROM [TABELA DE PRODUTOS] WHERE 
[SABOR] NOT IN ('Manga', 'Laranja')

SELECT * FROM [TABELA DE PRODUTOS] WHERE 
NOT ([SABOR] = 'Manga' OR [SABOR] ='Laranja')

/* Trazer manga, laranja e quem tem preço maior que 10 reais */

SELECT * FROM [TABELA DE PRODUTOS] WHERE 
[SABOR] IN ('Manga', 'Laranja') AND [PREÇO DE LISTA] > 10

/*
Between and
Entre 10 e 13
*/

SELECT * FROM [TABELA DE PRODUTOS] WHERE 
[SABOR] IN ('Manga', 'Laranja') AND [PREÇO DE LISTA] BETWEEN 10 AND 13

SELECT * FROM [TABELA DE PRODUTOS] WHERE 
[SABOR] IN ('Manga', 'Laranja') AND [PREÇO DE LISTA] >= 10 AND [PREÇO DE LISTA] <= 1