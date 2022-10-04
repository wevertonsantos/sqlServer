/*
Vai incrementar valores, automaticamente

Apenas 1 campo IDENTITY por tabela

Propriedade IDENTITY será especificada na criação da tabela
*/

-- Criando IDENTITY (Auto-incremento)

CREATE TABLE	TAB_IDENTITY
(
ID			INT IDENTITY (100,5) NOT NULL,
DESCRITOR	VARCHAR(10) NULL
)

SELECT		*
FROM		TAB_IDENTITY

INSERT	INTO	TAB_IDENTITY
(
DESCRITOR
)
VALUES
(
'CLIENTE W'
)
,
(
'CLIENTE X'
),
(
'CLIENTE Y'
),
(
'CLIENTE Z'
)