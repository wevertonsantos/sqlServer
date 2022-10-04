
/*
Transação no SQL Server: Uma unidade lógica de processamento
que visa preservar a integridade e consistência dos dados

BEGIN TRANSACTION: Cria um ponto de estado do banco de dados

COMMIT: Confirmo todas as operações entre o BEGIN TRANSACTION
e o comando COMMIT.
Todos os INSERTS, UPDATES ou DELETES irá ser confirmados e gravados
na base.

ROLLBACK: Tudo que foi feito entre o BEGIN TRANSACTION e o ROLLBACK
será desprezado e os dados voltarão ao status de quando o
BEGIN TRANSACTION foi executado. 
*/


SELECT		*
FROM		VENDEDORES

-- Rodando trace

BEGIN TRANSACTION

-- Comandos

UPDATE		VENDEDORES
SET			[COMISSÃO] = [COMISSÃO] * 1.15

INSERT INTO		VENDEDORES (
				MATRÍCULA
				,NOME
				,BAIRRO
				,[COMISSÃO]
				,[DATA ADMISSÃO]
				,FÉRIAS
				)
VALUES			(
				'99569'
				,'João da Silva'
				,'Icaraí'
				,0.08
				,'2014-09-01'
				,0
				)

-- Rodando ROLLBACK

ROLLBACK

-- Rodando COMMIT

COMMIT