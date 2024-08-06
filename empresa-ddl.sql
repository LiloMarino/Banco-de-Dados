CREATE SEQUENCE empresa.departamento_num_seq START 10 INCREMENT 10;
CREATE TABLE CREATE TABLE empresa.trab_em(
    rg_num INT,
    rg_est_exp CHAR(2),
    proj_num INT,
    horas_semana FLOAT DEFAULT 4,
    CONSTRAINT pk_trab_em PRIMARY KEY(rg_num, rg_est_exp, proj_num),
    CONSTRAINT fk_trab_em_empr FOREIGN KEY(rg_num, rg_est_exp) REFERENCES empresa.empregado(rg_num, rg_est_exp) ON DELETE CASCADE,
    CONSTRAINT fk_trab_em_proj FOREIGN KEY(proj_num) REFERENCES empresa.projeto(num) ON DELETE CASCADE,
    CONSTRAINT ck_trab_em_horas CHECK(
        horas_semana >= 4
        AND horas_semana <= 16
    )
) CREATE TABLE empresa.empregado(
    rg_num INT,
    rg_est_exp CHAR(2),
    pnome VARCHAR(20),
    snome VARCHAR(100),
    salario NUMERIC(10, 2),
    endereco VARCHAR(250),
    sexo CHAR,
    dept_num_trabalha INT,
    sup_rg_num INT,
    sup_rg_est_exp CHAR(2),
    CONSTRAINT pk_empregado PRIMARY KEY(rg_num, rg_est_exp),
    CONSTRAINT fk_empr_dept_trabalha FOREIGN KEY(dept_num_trabalha) REFERENCES empresa.departamento(num),
    CONSTRAINT fk_empr_tem_supervisor FOREIGN KEY(sup_rg_num, sup_rg_est_exp) REFERENCES empresa.empregado(rg_num, rg_est_exp) ON DELETE
    SET NULL,
        CONSTRAINT ck_empregado_sexo CHECK (sexo IN ('m', 's', 'o')),
        CONSTRAINT ck_empregado_salario CHECK (salario >= 0.00),
        CONSTRAINT ck_salario_supervisionado CHECK (
            (
                sup_rg_num IS NULL
                AND sup_rg_est_exp IS NULL
            )
            OR salario <= 20000.00
        )
);
CREATE TABLE empresa.projeto(
    num SERIAL,
    nome VARCHAR(150) NOT NULL,
    descricao VARCHAR(1000),
    localizacao VARCHAR(250),
    dept_num INT NOT NULL,
    CONSTRAINT pk_projeto PRIMARY KEY(num),
    CONSTRAINT uk_projeto_nome UNIQUE(nome),
    CONSTRAINT fk_projeto_departamento FOREIGN KEY(dept_num) REFERENCES empresa.departamento(num)
);
CREATE TABLE empresa.departamento_tem_localizacao(
    dept_num INT,
    localizacao VARCHAR(250),
    CONSTRAINT pk_dept_tem_loc PRIMARY KEY(dept_num, localizacao),
    CONSTRAINT fk_dept_loc FOREIGN KEY(dept_num) REFERENCES empresa.departamento(num) ON DELETE CASCADE
);
CREATE TABLE empresa.departamento (
    num INT DEFAULT nextval('empresa.departamento_num_seq'),
    nome VARCHAR(100) NOT NULL,
    ger_rg_num INT NOT NULL,
    ger_rg_est_exp CHAR(2) NOT NULL,
    dt_inicio DATE,
    CONSTRAINT pk PRIMARY KEY(num),
    CONSTRAINT uk_dept_nome UNIQUE(nome),
    CONSTRAINT uk_dept_gerente UNIQUE(ger_rg_num, ger_rg_est_exp),
    CONSTRAINT ck_dept_num CHECK(num % 10 = 0)
);
CREATE TABLE empresa.departamento_tem_localizacao(
    dept_num INT,
    localizacao VARCHAR(250),
    CONSTRAINT pk_dept_tem_loc PRIMARY KEY(dept_num, localizacao),
    CONSTRAINT fk_dept_loc FOREIGN KEY(dept_num) REFERENCES empresa.departamento(num) ON DELETE CASCADE
);
CREATE TABLE empresa.projeto(
    num SERIAL,
    nome VARCHAR(150) NOT NULL,
    descricao VARCHAR(1000),
    localizacao VARCHAR(250),
    dept_num INT NOT NULL,
    CONSTRAINT pk_projeto PRIMARY KEY(num),
    CONSTRAINT uk_projeto_nome UNIQUE(nome),
    CONSTRAINT fk_projeto_departamento FOREIGN KEY(dept_num) REFERENCES empresa.departamento(num)
);
CREATE TABLE empresa.empregado(
    rg_num INT,
    rg_est_exp CHAR(2),
    pnome VARCHAR(20),
    snome VARCHAR(100),
    salario NUMERIC(10, 2),
    endereco VARCHAR(250),
    sexo CHAR,
    dept_num_trabalha INT,
    sup_rg_num INT,
    sup_rg_est_exp CHAR(2),
    CONSTRAINT pk_empregado PRIMARY KEY(rg_num, rg_est_exp),
    CONSTRAINT fk_empr_dept_trabalha FOREIGN KEY(dept_num_trabalha) REFERENCES empresa.departamento(num),
    CONSTRAINT fk_empr_tem_supervisor FOREIGN KEY(sup_rg_num, sup_rg_est_exp) REFERENCES empresa.empregado(rg_num, rg_est_exp) ON DELETE
    SET NULL,
        CONSTRAINT ck_empregado_sexo CHECK (sexo IN ('m', 'f', 'o')),
        CONSTRAINT ck_empregado_salario CHECK (salario >= 0.00),
        CONSTRAINT ck_salario_supervisionado CHECK (
            (
                sup_rg_num IS NULL
                AND sup_rg_est_exp IS NULL
            )
            OR salario <= 20000.00
        )
);
CREATE TABLE empresa.trab_em(
    rg_num INT,
    rg_est_exp CHAR(2),
    proj_num INT,
    horas_semana FLOAT DEFAULT 4,
    CONSTRAINT pk_trab_em PRIMARY KEY(rg_num, rg_est_exp, proj_num),
    CONSTRAINT fk_trab_em_empr FOREIGN KEY(rg_num, rg_est_exp) REFERENCES empresa.empregado(rg_num, rg_est_exp) ON DELETE CASCADE,
    CONSTRAINT fk_trab_em_proj FOREIGN KEY(proj_num) REFERENCES empresa.projeto(num) ON DELETE CASCADE,
    CONSTRAINT ck_trab_em_horas CHECK(
        horas_semana >= 4
        AND horas_semana <= 16
    )
);
CREATE TABLE empresa.dependente(
    pnome VARCHAR(20),
    snome VARCHAR(100),
    sexo CHAR,
    dt_nascimento DATE,
    emp_rg_num INT,
    emp_rg_est_exp CHAR(2),
    CONSTRAINT pk_dependente PRIMARY KEY(pnome, snome, emp_rg_num, emp_rg_est_exp),
    CONSTRAINT fk_trabem_empr FOREIGN KEY(emp_rg_num, emp_rg_est_exp) REFERENCES empresa.empregado(rg_num,rg_est_exp) ON DELETE CASCADE,
    CONSTRAINT ck_dependente_sexo CHECK(sexo IN ('m','f','o'))
);
ALTER TABLE empresa.departamento
    ADD CONSTRAINT fk_dept_tem_gerente
    FOREIGN KEY (ger_rg_num, ger_rg_est_exp)
    REFERENCES empresa.empregado(rg_num, rg_est_exp);