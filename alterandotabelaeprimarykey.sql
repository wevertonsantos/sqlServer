/* ALTER COLUMN: Modificar coluna definida */

ALTER TABLE [TABELA DE PRODUTOS]
ALTER COLUMN [CODIGO DO PRODUTO]
VARCHAR (10) NOT NULL

ALTER TABLE [TABELA DE VENDEDORES]
ALTER COLUMN [MATRICULA]
VARCHAR (10) NOT NULL

ALTER TABLE [TABELA DE VENDEDORES]
ADD CONSTRAINT PK_VENDEDORES
PRIMARY KEY CLUSTERED ([MATRICULA])