CREATE TABLE empresa.empregado (
	rg_num INT,
	rg_estado CHAR(2),
	pnome VARCHAR(20),
	snome VARCHAR(20),
	sexo CHAR,
	salario NUMERIC(10, 2),
	data_nascimento DATE,
	sup_rg_num INT,
	sup_rg_estado CHAR(2),
	dept_num_trabalha INT,
	CONSTRAINT pk_empregado PRIMARY KEY (rg_num, rg_estado),
	CONSTRAINT fk_empregado_has_supervisor FOREIGN KEY (sup_rg_num, sup_rg_estado) REFERENCES empresa.empregado (rg_num, rg_estado)
);
INSERT INTO empresa.empregado
VALUES (
		1,
		'PR',
		'Joana',
		'Azevedo',
		'f',
		5500,
		'2001-12-20',
		NULL,
		NULL,
		NULL
	);
INSERT INTO empresa.empregado (
		rg_num,
		rg_estado,
		pnome,
		snome,
		salario,
		sexo,
		data_nascimento
	)
VALUES (
		333,
		'PR',
		'João',
		'Silva',
		6000,
		'm',
		TO_DATE('dd-mm-yyyy', '04-12-1997')
	);
SELECT *
FROM empresa.empregado;
CREATE TABLE empresa.departamento (
	num INT,
	nome VARCHAR(100),
	ger_rg_num INT,
	ger_rg_estado CHAR(2),
	ger_data_inicio DATE DEFAULT current_date,
	CONSTRAINT pk_departamento PRIMARY KEY (num),
	CONSTRAINT uk_departamento_nome UNIQUE (nome),
	CONSTRAINT fk_departamento_has_manager FOREIGN KEY (ger_rg_estado, ger_rg_num) REFERENCES empresa.empregado(rg_estado, rg_num)
);
ALTER TABLE empresa.departamento
ALTER COLUMN nome
SET NOT NULL;
DELETE FROM empresa.departamento
WHERE nome IS NULL;
INSERT INTO empresa.departamento (num)
VALUES (1);
SELECT *
FROM empresa.departamento;