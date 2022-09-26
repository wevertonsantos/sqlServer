/*
ADD CONSTRAINT: Adicionar uma regra
PRIMARY KEY CLUSTERED: A contraint que estou adicionando
é a chave primária 

NULL: Este campo aceita valores nulo
NOT NULL: Este campo não aceita valores nulo 
*/

ALTER TABLE [TABELA DE PRODUTOS]
ADD CONSTRAINT PK_PRODUTOS
PRIMARY KEY CLUSTERED ([CODIGO DO PRODUTO])