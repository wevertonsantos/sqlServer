/*
ADD CONSTRAINT: Adicionar uma regra
PRIMARY KEY CLUSTERED: A contraint que estou adicionando
� a chave prim�ria 

NULL: Este campo aceita valores nulo
NOT NULL: Este campo n�o aceita valores nulo 
*/

ALTER TABLE [TABELA DE PRODUTOS]
ADD CONSTRAINT PK_PRODUTOS
PRIMARY KEY CLUSTERED ([CODIGO DO PRODUTO])