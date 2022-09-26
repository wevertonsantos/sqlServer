/* Listando dados de uma tabela -------- */

/*
TOP (1000) = Lista os primeiros 1000 registros
SELECT = Lista
FROM = Onde [NOME DA TABELA] */

SELECT TOP (1000) [CPF]
      ,[NOME]
      ,[ENDERECO 1]
      ,[ENDERECO 2]
      ,[BAIRRO]
      ,[CIDADE]
      ,[ESTADO]
      ,[CEP]
      ,[DATA DE NASCIMENTO]
      ,[IDADE]
      ,[SEXO]
      ,[LIMITE DE CREDITO]
      ,[VOLUME DE COMPRA]
      ,[PRIMEIRA COMPRA]
  FROM [SUCOS_VENDAS].[dbo].[TABELA DE CLIENTES]

/* * = Todos */

  SELECT *
  FROM [TABELA DE CLIENTES]

 /* Selecionar tabelas  */

    SELECT [CPF],
    [NOME]
 	FROM [TABELA DE CLIENTES]

/* AS = Alterar alias (nome fantásia) */

  SELECT [CPF] AS CLIENTES,
  [NOME] AS IDENTIFICADOR
  FROM [TABELA DE CLIENTES]

	SELECT
	[NOME] AS CLIENTES,
	[CPF] AS IDENTIFICADOR
	FROM [TABELA DE CLIENTES]
