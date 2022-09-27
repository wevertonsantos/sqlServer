/* Comando NOT:

NOT (X = A OR Y = B)
NOT inverte o resultado da consulta

NOT V OR V = F
NOT V OR F = F
NOT F OR V = F
NOT F OR F = V


NOT (X = A AND Y = B)
NOT inverte o resultado da consulta

NOT V AND V = F
NOT V AND F = V
NOT F AND V = V
NOT F AND F = V

Selecionando apenas uma expressão
Inverte somente o resultado da expressão 2
X = A AND NOT (Y = B)

Demistificando NOT e AND

EXEMPLO: ((NOT (V AND F)) AND (V OR F)) OR F
	((NOT (F)) AND (V)) OR F
	((V) AND (V)) OR F
	(V) OR F
	(V)

EXERCÍCIO:
( NOT ( (3>2) OR (4 >= 5) ) AND (5>4) ) OR ( 9 > 0 )
( NOT ( (V) OR (F) ) AND (V) ) OR (V)
( NOT ( (V) ) AND (V) ) OR (V)
(F) AND (V) OR (V)
(F) OR (V)
(V)

*/