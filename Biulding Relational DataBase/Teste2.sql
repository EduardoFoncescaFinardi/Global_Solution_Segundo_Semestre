CREATE TABLE T_TD_AUTENTICA(
    id_autentica NUMERIC,
    login varchar(100),
    senha varchar(100),
    st_login char(1) check(st_login in ('i', 'a')),
    CONSTRAINT T_TD_AUTENTICA_PK PRIMARY KEY (id_autentica)
    );
DROP TABLE T_TD_AUTENTICA;


CREATE SEQUENCE seq_autentica
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 1000
    NOCYCLE;
------------------------------------------------------------------------------------------
CREATE TABLE T_TD_PACIENTE (
    id_paciente NUMERIC(9),
    nm_paciente VARCHAR(80) NOT NULL,
    nr_cpf NUMERIC(12) NOT NULL UNIQUE,
    nr_rg VARCHAR(15) NOT NULL UNIQUE,
    dt_nascimento DATE NOT NULL,
    fl_sexo CHAR(1) NOT NULL,
    tip_grupo_sanguineo VARCHAR(6) NOT NULL,
    id_autentica NUMERIC,
     CONSTRAINT T_TD_PACIENTE_PK PRIMARY KEY (id_paciente), 
     CONSTRAINT T_TD_PACIENTE_FK FOREIGN KEY (id_autentica) REFERENCES T_TD_AUTENTICA(id_autentica)
    );

DROP TABLE T_TD_PACIENTE;

CREATE SEQUENCE seq_paciente
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 1000
    NOCYCLE;
-------------------------------------------------------------------------------------------
CREATE TABLE T_TD_UNID_HOSPITALAR(
    id_unid_hospitalar NUMERIC(9),
    razao_social varchar(80) NOT NULL,
    nr_logradouro NUMERIC(7),
    CEP numeric(10) NOT NULL,
    dt_cadastro date not null,
    CONSTRAINT T_TD_UNID_HOSPITALAR_PK PRIMARY KEY (id_unid_hospitalar)
    );
    
DROP TABLE T_TD_UNID_HOSPITALAR;

CREATE SEQUENCE seq_unid_hospitalar
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 1000
    NOCYCLE;
    
-----------------------------------------------------------------------------------------------
CREATE TABLE T_TD_QUADRO_CLINICO(
    id_quadro_clinico NUMERIC,
    ds_alergias VARCHAR(1000),
    id_paciente NUMERIC(9),
    CONSTRAINT T_TD_MEDICO_FK PRIMARY KEY (id_quadro_clinico),
    CONSTRAINT T_TD_QUADRO_CLINICO FOREIGN KEY (id_paciente) REFERENCES T_TD_PACIENTE(id_paciente)
    );
    
DROP TABLE T_TD_QUADRO_CLINICO;

CREATE SEQUENCE seq_quadro_clinico
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 1000
    NOCYCLE;  
-----------------------------------------------------------------------------------------------
CREATE TABLE T_TD_CONSULTA(
    id_consulta NUMERIC ,
    dt_hr_consulta date not null,
    tel_central varchar(14),
    id_paciente NUMERIC(9)  not null,
    id_unid_hospitalar NUMERIC(9)  not null,
    CONSTRAINT T_TD_CONSULTA_PK PRIMARY KEY (id_consulta),
    CONSTRAINT T_TD_CONSULTA_PACIENTE_FK FOREIGN KEY (id_paciente) REFERENCES T_TD_PACIENTE(id_paciente),
    CONSTRAINT T_TD_CONSULTA_UNID_HOSPITLAR_FK FOREIGN KEY (id_unid_hospitalar) REFERENCES T_TD_UNID_HOSPITALAR(id_unid_hospitalar)
);

DROP TABLE T_TD_CONSULTA;

    
CREATE SEQUENCE seq_consulta
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 1000
    NOCYCLE;   
-----------------------------------------------------------------------------------------------
CREATE TABLE T_TD_TELEFONE_PACIENTE (
    id_telefone NUMERIC(9) ,
    nr_ddi NUMERIC(3) NOT NULL,
    nr_ddd NUMERIC(3) NOT NULL,
    nr_telefone NUMERIC(10) NOT NULL,
    tp_telefone VARCHAR(20),
    id_paciente NUMERIC(9) NOT NULL,
    CONSTRAINT T_TD_TELEFONE_PACIENTE_PK PRIMARY KEY (id_telefone),
    CONSTRAINT T_TD_TELEFONE_PACIENTE_FK FOREIGN KEY (id_paciente) REFERENCES T_TD_PACIENTE (id_paciente)
    );

DROP TABLE T_TD_TELEFONE_PACIENTE;

CREATE SEQUENCE seq_telefone_paciente
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 1000
    NOCYCLE;    
-----------------------------------------------------------------------------------------------
CREATE TABLE T_TD_ENDERECO_PACIENTE(
    id_endereco NUMERIC(9),
    CEP VARCHAR(8) NOT NULL,
    nr_logradouro NUMERIC(7)NOT NULL,
    ds_ponto_referencia VARCHAR(30),
    id_paciente NUMERIC(9),
    CONSTRAINT T_TD_ENDERECO_PACIENTE_PK PRIMARY KEY(id_endereco),
    CONSTRAINT T_TD_ENDERECO_PACIENTE_FK FOREIGN KEY (id_paciente) REFERENCES T_TD_PACIENTE(id_paciente)
    ); 

DROP TABLE T_TD_ENDERECO_PACIENTE;

CREATE SEQUENCE seq_endereco_paciente
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 1000
    NOCYCLE;   
-----------------------------------------------------------------------------------------------
CREATE TABLE T_TD_MEDICO (
    id_medico NUMERIC,
    nm_medico VARCHAR (25) NOT NULL,
    fl_sexo CHAR(1) NOT NULL,
    tp_especializacao VARCHAR(25) NOT NULL,
    dt_nascimento DATE NOT NULL,
    id_autentica NUMERIC,
    CONSTRAINT T_TD_MEDICO_PK PRIMARY KEY (id_medico),
    CONSTRAINT T_TD_AUTENTICA_MEDICO_FK FOREIGN KEY (id_autentica)REFERENCES T_TD_AUTENTICA (id_autentica)
    );

DROP TABLE T_TD_MEDICO;

CREATE SEQUENCE seq_medico
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 1000
    NOCYCLE;   
-----------------------------------------------------------------------------------------------
CREATE TABLE T_TD_IMAGENS(
    id_imagem NUMERIC,
    dt_envio DATE NOT NULL,
    id_paciente NUMERIC(9),
    CONSTRAINT T_TD_IMAGENS_PK PRIMARY KEY (id_imagem),
    CONSTRAINT T_TD_IMAGENS_FK FOREIGN KEY (id_paciente) REFERENCES T_TD_PACIENTE (id_paciente)
    ); 
    
DROP TABLE T_TD_IMAGENS;

CREATE SEQUENCE seq_imagem
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 1000
    NOCYCLE;   
            
----- INSERT


INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login1','senha1', 'a');

INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login2','senha2', 'a');

INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login3','senha3', 'a');

INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login4','senha4', 'a');

INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login5','senha5', 'a');

INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login6','senha6', 'a');

INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login7','senha7', 'a');

INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login8','senha8', 'i');

INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login9','senha9', 'i');

INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login10','senha10', 'i');



INSERT INTO T_TD_PACIENTE (id_paciente,nm_paciente,nr_cpf ,nr_rg ,dt_nascimento,fl_sexo ,tip_grupo_sanguineo,id_autentica) VALUES (seq_paciente.nextval, 'Lucca', '52300893851', '550174448' , '19/08/2004', 'm', 'O negativo', id_autentica )
;
----- SELECT


DECLARE
   id_autentica NUMBER;
BEGIN
   -- Inserção na Tabela autentica
    INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login1','senha1', 'a');
    INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login2','senha2', 'a');
    INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login3','senha3', 'a'); 

   -- Obtendo o valor atual da sequência seq_CLIENTE
   SELECT seq_autentica.currval INTO id_autentica FROM DUAL;

   -- Início do bloco PL/SQL aninhado
   DECLARE
      id_paciente NUMBER;
   BEGIN
      -- Inserções nas tabelas BICICLETA, GUIDAO, SELIM, QUADRO, RODAS

      INSERT INTO T_TD_PACIENTE (id_paciente,nm_paciente,nr_cpf ,nr_rg ,dt_nascimento,fl_sexo ,tip_grupo_sanguineo,id_autentica) VALUES (seq_paciente.nextval, 'Lucca', '52300893851', '550174448' , '19/08/2004', 'm', 'O negativo', id_autentica );
      INSERT INTO T_TD_PACIENTE (id_paciente,nm_paciente,nr_cpf ,nr_rg ,dt_nascimento,fl_sexo ,tip_grupo_sanguineo,id_autentica) VALUES (seq_paciente.nextval, 'Eduardo', '12312312333', '112341114' , '19/08/2004', 'm', 'A negativo', id_autentica );
      INSERT INTO T_TD_PACIENTE (id_paciente,nm_paciente,nr_cpf ,nr_rg ,dt_nascimento,fl_sexo ,tip_grupo_sanguineo,id_autentica) VALUES (seq_paciente.nextval, 'Angélica', '23423423444', '432547684' , '19/08/2004', 'f', 'B positivo', id_autentica );
    
    
      SELECT seq_paciente.currval INTO id_paciente FROM DUAL;


   END; -- Fim do bloco PL/SQL aninhado

   -- Restante do bloco externo, se houver

END;
