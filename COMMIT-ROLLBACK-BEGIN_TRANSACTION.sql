
/*
Transa��o no SQL Server: Uma unidade l�gica de processamento
que visa preservar a integridade e consist�ncia dos dados

BEGIN TRANSACTION: Cria um ponto de estado do banco de dados

COMMIT: Confirmo todas as opera��es entre o BEGIN TRANSACTION
e o comando COMMIT.
Todos os INSERTS, UPDATES ou DELETES ir� ser confirmados e gravados
na base.

ROLLBACK: Tudo que foi feito entre o BEGIN TRANSACTION e o ROLLBACK
ser� desprezado e os dados voltar�o ao status de quando o
BEGIN TRANSACTION foi executado. 
*/


SELECT		*
FROM		VENDEDORES

-- Rodando trace

BEGIN TRANSACTION

-- Comandos

UPDATE		VENDEDORES
SET			[COMISS�O] = [COMISS�O] * 1.15

INSERT INTO		VENDEDORES (
				MATR�CULA
				,NOME
				,BAIRRO
				,[COMISS�O]
				,[DATA ADMISS�O]
				,F�RIAS
				)
VALUES			(
				'99569'
				,'Jo�o da Silva'
				,'Icara�'
				,0.08
				,'2014-09-01'
				,0
				)

-- Rodando ROLLBACK

ROLLBACK

-- Rodando COMMIT

COMMIT