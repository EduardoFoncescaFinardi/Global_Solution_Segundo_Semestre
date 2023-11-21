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
    
drop sequence seq_autentica;
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
    
drop sequence seq_paciente;
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
    
drop sequence seq_unid_hospitalar;
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
    
drop sequence seq_quadro_clinico;    
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
    
drop sequence seq_consulta;    
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
    
drop sequence seq_telefone_paciente;        
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
    
drop sequence seq_endereco_paciente;    
-----------------------------------------------------------------------------------------------   

CREATE TABLE T_TD_IMAGENS(
    id_imagem NUMERIC,
    link_url VARCHAR(1000) NOT NULL,
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

drop sequence seq_imagem; 
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


INSERT INTO T_TD_PACIENTE (id_paciente,nm_paciente,nr_cpf ,nr_rg ,dt_nascimento,fl_sexo ,tip_grupo_sanguineo,id_autentica) VALUES (seq_paciente.nextval, 'João Silva', '12345678901', ' 123456789', '15/05/1990 ', 'm', 'A+', id_autentica );
INSERT INTO T_TD_PACIENTE (id_paciente,nm_paciente,nr_cpf ,nr_rg ,dt_nascimento,fl_sexo ,tip_grupo_sanguineo,id_autentica) VALUES (seq_paciente.nextval, 'Maria Oliveira', '98765432109', '987654321', '22/08/1985', 'F', 'B-', id_autentica );
INSERT INTO T_TD_PACIENTE (id_paciente,nm_paciente,nr_cpf ,nr_rg ,dt_nascimento,fl_sexo ,tip_grupo_sanguineo,id_autentica) VALUES (seq_paciente.nextval, 'Carlos Santos', '34567890123', '345678901', '10/02/1982', 'M', 'O+', id_autentica );
INSERT INTO T_TD_PACIENTE (id_paciente,nm_paciente,nr_cpf ,nr_rg ,dt_nascimento,fl_sexo ,tip_grupo_sanguineo,id_autentica) VALUES (seq_paciente.nextval, 'Ana Souza', '78901234567', '789012345', '05/12/1988', 'F', 'AB+', id_autentica );
INSERT INTO T_TD_PACIENTE (id_paciente,nm_paciente,nr_cpf ,nr_rg ,dt_nascimento,fl_sexo ,tip_grupo_sanguineo,id_autentica) VALUES (seq_paciente.nextval, 'Pedro Pereira', '23456789012', '234567890', '20/09/1995', 'M', 'O-', id_autentica );
INSERT INTO T_TD_PACIENTE (id_paciente,nm_paciente,nr_cpf ,nr_rg ,dt_nascimento,fl_sexo ,tip_grupo_sanguineo,id_autentica) VALUES (seq_paciente.nextval, 'Fernanda Lima', '56789012345', '567890123', '18/04/1980', 'F', 'A-', id_autentica );
INSERT INTO T_TD_PACIENTE (id_paciente,nm_paciente,nr_cpf ,nr_rg ,dt_nascimento,fl_sexo ,tip_grupo_sanguineo,id_autentica) VALUES (seq_paciente.nextval, 'Roberto Costa', '89012345678', '890123456', '08/07/1976', 'M', 'B+', id_autentica );






drop sequence seq_autentica;
drop sequence seq_paciente;
drop sequence seq_unid_hospitalar;
drop sequence seq_quadro_clinico;
drop sequence seq_consulta;    
drop sequence seq_telefone_paciente;     
drop sequence seq_endereco_paciente; 
drop sequence seq_imagem; 



DECLARE
    id_autentica NUMBER;
    id_paciente NUMBER;
    id_endereco NUMBER;
    id_telefone NUMBER;
    id_imagem NUMBER;
    id_consulta NUMBER;
    id_quadro_clinico NUMBER;
    id_unid_hospitalar NUMBER;
    
BEGIN
    --------------------1
    INSERT INTO T_TD_AUTENTICA (id_autentica, login, senha, st_login) VALUES (seq_autentica.nextval, 'login1','senha1', 'a');
    INSERT INTO t_td_unid_hospitalar (id_unid_hospitalar,razao_social ,nr_logradouro, CEP, dt_cadastro ) values (seq_unid_hospitalar.nextval,'NOTRE DAME INTERMEDICA SAUDE S.A.', 867 ,01311100, '17/11/2023');
    
    SELECT seq_unid_hospitalar.currval INTO id_unid_hospitalar FROM DUAL;
    SELECT seq_autentica.currval INTO id_autentica FROM DUAL;
    
    INSERT INTO T_TD_PACIENTE (id_paciente, nm_paciente, nr_cpf, nr_rg, dt_nascimento, fl_sexo, tip_grupo_sanguineo, id_autentica)VALUES (seq_paciente.nextval, 'Lucca', '52300893851', '550174448', '19/08/2004', 'm', 'O-', id_autentica);
    
    SELECT seq_paciente.currval INTO id_paciente FROM DUAL;
    
    INSERT INTO T_TD_ENDERECO_PACIENTE(id_endereco,CEP,nr_logradouro,ds_ponto_referencia,id_paciente)  VALUES(seq_endereco_paciente.nextval,'01543001', 1006,'perto do ponto de onibus',id_paciente);
    
    INSERT INTO T_TD_TELEFONE_PACIENTE (id_telefone,nr_ddi,nr_ddd,nr_telefone,tp_telefone,id_paciente) VALUES(seq_telefone_paciente.nextval,55, 11, 944642004,'celular', id_paciente);
    
    INSERT INTO T_TD_IMAGENS (id_imagem, link_url, dt_envio, id_paciente) VALUES (seq_imagem.nextval,'.jpg', '11/11/2023', id_paciente);
    
    INSERT INTO T_TD_CONSULTA (id_consulta, dt_hr_consulta, tel_central, id_paciente, id_unid_hospitalar) values (seq_consulta.nextval,'08/11/2023',33333333,id_paciente, id_unid_hospitalar);
    
    INSERT INTO T_TD_QUADRO_CLINICO (id_quadro_clinico,ds_alergias,id_paciente) VALUES (seq_quadro_clinico.nextval,'Alergia começou ontem e piorou durante a noite', id_paciente);
-------------------------------------2   
    INSERT INTO T_TD_AUTENTICA (id_autentica, login, senha, st_login) VALUES (seq_autentica.nextval, 'login2','senha2', 'a');
    
    SELECT seq_autentica.currval INTO id_autentica FROM DUAL;
    
    INSERT INTO T_TD_PACIENTE (id_paciente, nm_paciente, nr_cpf, nr_rg, dt_nascimento, fl_sexo, tip_grupo_sanguineo, id_autentica) VALUES (seq_paciente.nextval, 'Eduardo', '12312312333', '112341114', '19/08/2004', 'm', 'A -', id_autentica);
    
    SELECT seq_paciente.currval INTO id_paciente FROM DUAL;
    
    INSERT INTO T_TD_ENDERECO_PACIENTE(id_endereco,CEP,nr_logradouro,ds_ponto_referencia,id_paciente) VALUES(seq_endereco_paciente.nextval,'01543001', 1006,'perto do ponto de onibus',id_paciente);
    
    INSERT INTO T_TD_TELEFONE_PACIENTE (id_telefone,nr_ddi,nr_ddd,nr_telefone,tp_telefone,id_paciente) VALUES(seq_telefone_paciente.nextval,55, 11, 944642004,'celular', id_paciente);
    
    INSERT INTO T_TD_IMAGENS (id_imagem, link_url, dt_envio, id_paciente) VALUES (seq_imagem.nextval, 'urldaimagem' , '11/11/2023', id_paciente);
    
    INSERT INTO T_TD_CONSULTA (id_consulta, dt_hr_consulta, tel_central, id_paciente, id_unid_hospitalar) values (seq_consulta.nextval,'08/11/2023',33333333,id_paciente,id_unid_hospitalar);
    
    INSERT INTO T_TD_QUADRO_CLINICO (id_quadro_clinico,ds_alergias,id_paciente) VALUES (seq_quadro_clinico.nextval,'Alergia começou ontem e piorou durante a noite', id_paciente);
    
    -------------------3
    INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login3','senha3', 'a');
    
    -- Obtendo o valor atual da sequência seq_autentica
    SELECT seq_autentica.currval INTO id_autentica FROM DUAL;
    
    -- Inserções nas tabelas T_TD_PACIENTE
    INSERT INTO T_TD_PACIENTE (id_paciente, nm_paciente, nr_cpf, nr_rg, dt_nascimento, fl_sexo, tip_grupo_sanguineo, id_autentica) VALUES (seq_paciente.nextval, 'Angélica', '33333333332', '122321214', '19/08/2004', 'm', 'A -', id_autentica);
    
    -- Obtendo o valor atual da sequência seq_paciente
    SELECT seq_paciente.currval INTO id_paciente FROM DUAL;

    INSERT INTO T_TD_ENDERECO_PACIENTE (id_endereco, CEP, nr_logradouro, ds_ponto_referencia, id_paciente) VALUES (seq_endereco_paciente.nextval, '10078901', 567, 'perto do mercado', id_paciente);

    INSERT INTO T_TD_TELEFONE_PACIENTE (id_telefone,nr_ddi,nr_ddd,nr_telefone,tp_telefone,id_paciente) VALUES(seq_telefone_paciente.nextval,55, 11, 12345678, 'fixo',id_paciente);
    
    INSERT INTO T_TD_IMAGENS (id_imagem, link_url, dt_envio, id_paciente) VALUES (seq_imagem.nextval, '.jpg','12/11/2023', id_paciente);
    
    INSERT INTO T_TD_CONSULTA (id_consulta, dt_hr_consulta, tel_central, id_paciente, id_unid_hospitalar) VALUES (seq_consulta.nextval, '09/11/2023', 33333333, id_paciente,id_unid_hospitalar);
    
    INSERT INTO T_TD_QUADRO_CLINICO (id_quadro_clinico,ds_alergias,id_paciente) VALUES (seq_quadro_clinico.nextval,'Irritação na pele persistente, acompanhada de coceira intensa', id_paciente);
-------------------4
    INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login4','senha4', 'a');

    SELECT seq_autentica.currval INTO id_autentica FROM DUAL;

    INSERT INTO T_TD_PACIENTE (id_paciente,nm_paciente,nr_cpf ,nr_rg ,dt_nascimento,fl_sexo ,tip_grupo_sanguineo,id_autentica) VALUES (seq_paciente.nextval, 'Maria Oliveira', '98765432109', '987654321', '22/08/1985', 'F', 'B-', id_autentica );

    SELECT seq_paciente.currval INTO id_paciente FROM DUAL;

    INSERT INTO T_TD_ENDERECO_PACIENTE (id_endereco, CEP, nr_logradouro, ds_ponto_referencia, id_paciente)VALUES (seq_endereco_paciente.nextval, '02145012', 789, 'perto da farmácia', id_paciente);
    
    INSERT INTO T_TD_TELEFONE_PACIENTE (id_telefone,nr_ddi,nr_ddd,nr_telefone,tp_telefone,id_paciente) VALUES(seq_telefone_paciente.nextval,55, 11, 987654321, 'celular' ,id_paciente);
    
    INSERT INTO T_TD_IMAGENS (id_imagem, link_url, dt_envio, id_paciente) VALUES (seq_imagem.nextval, '.jpg','13/11/2023', id_paciente);
    
    INSERT INTO T_TD_CONSULTA (id_consulta, dt_hr_consulta, tel_central, id_paciente, id_unid_hospitalar) VALUES (seq_consulta.nextval, '10/11/2023', 33333333, id_paciente,id_unid_hospitalar);
    
    INSERT INTO T_TD_QUADRO_CLINICO (id_quadro_clinico,ds_alergias,id_paciente) VALUES (seq_quadro_clinico.nextval,'Vermelhidão e descamação da pele devido a exposição a alérgenos', id_paciente);
-------------------5
    INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login5','senha5', 'a');

    SELECT seq_autentica.currval INTO id_autentica FROM DUAL;

    INSERT INTO T_TD_PACIENTE (id_paciente,nm_paciente,nr_cpf ,nr_rg ,dt_nascimento,fl_sexo ,tip_grupo_sanguineo,id_autentica) VALUES (seq_paciente.nextval, 'João Silva', '12345678901', ' 123456789', '15/05/1990 ', 'm', 'A+', id_autentica );

    SELECT seq_paciente.currval INTO id_paciente FROM DUAL;
    
    INSERT INTO T_TD_ENDERECO_PACIENTE (id_endereco, CEP, nr_logradouro, ds_ponto_referencia, id_paciente) VALUES (seq_endereco_paciente.nextval, '03056789', 456, 'perto do supermercado', id_paciente);

    INSERT INTO T_TD_TELEFONE_PACIENTE (id_telefone,nr_ddi,nr_ddd,nr_telefone,tp_telefone,id_paciente) VALUES (seq_telefone_paciente.nextval,55, 11, 58877665, 'fixo',id_paciente);
    
    INSERT INTO T_TD_IMAGENS (id_imagem, link_url, dt_envio, id_paciente) VALUES (seq_imagem.nextval, '.jpg','14/11/2023', id_paciente);
    
    INSERT INTO T_TD_CONSULTA (id_consulta, dt_hr_consulta, tel_central, id_paciente, id_unid_hospitalar) VALUES (seq_consulta.nextval, '11/11/2023', 33333333, id_paciente,id_unid_hospitalar);
    
    INSERT INTO T_TD_QUADRO_CLINICO (id_quadro_clinico,ds_alergias,id_paciente) VALUES (seq_quadro_clinico.nextval,'Agravamento dos sintomas durante períodos de estresse emocional', id_paciente);
-------------------6
    INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login6','senha6', 'a');
    
    SELECT seq_autentica.currval INTO id_autentica FROM DUAL;

    INSERT INTO T_TD_PACIENTE (id_paciente,nm_paciente,nr_cpf ,nr_rg ,dt_nascimento,fl_sexo ,tip_grupo_sanguineo,id_autentica) VALUES (seq_paciente.nextval, 'Carlos Santos', '34567890123', '345678901', '10/02/1982', 'M', 'O+', id_autentica );

    SELECT seq_paciente.currval INTO id_paciente FROM DUAL;
    
    INSERT INTO T_TD_ENDERECO_PACIENTE (id_endereco, CEP, nr_logradouro, ds_ponto_referencia, id_paciente)VALUES (seq_endereco_paciente.nextval, '04067890', 321, 'perto da escola', id_paciente);
    
    INSERT INTO T_TD_TELEFONE_PACIENTE (id_telefone,nr_ddi,nr_ddd,nr_telefone,tp_telefone,id_paciente) VALUES(seq_telefone_paciente.nextval, 55, 11, 911223344, 'celular',id_paciente);
    
    INSERT INTO T_TD_IMAGENS (id_imagem, link_url, dt_envio, id_paciente) VALUES (seq_imagem.nextval, '.jpg','15/11/2023', id_paciente);
    
    INSERT INTO T_TD_CONSULTA (id_consulta, dt_hr_consulta, tel_central, id_paciente, id_unid_hospitalar) VALUES (seq_consulta.nextval, '12/11/2023', 33333333, id_paciente, id_unid_hospitalar);
    
    INSERT INTO T_TD_QUADRO_CLINICO (id_quadro_clinico,ds_alergias,id_paciente) VALUES (seq_quadro_clinico.nextval,'Piora da Dermatite Atópica devido à exposição a mudanças climáticas', id_paciente);
-------------------7
    INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login7','senha7', 'a');

    SELECT seq_autentica.currval INTO id_autentica FROM DUAL;

    INSERT INTO T_TD_PACIENTE (id_paciente,nm_paciente,nr_cpf ,nr_rg ,dt_nascimento,fl_sexo ,tip_grupo_sanguineo,id_autentica) VALUES (seq_paciente.nextval, 'Ana Souza', '78901234567', '789012345', '05/12/1988', 'F', 'AB+', id_autentica );

    SELECT seq_paciente.currval INTO id_paciente FROM DUAL;

    INSERT INTO T_TD_ENDERECO_PACIENTE (id_endereco, CEP, nr_logradouro, ds_ponto_referencia, id_paciente) VALUES (seq_endereco_paciente.nextval, '05123456', 789, 'perto da academia', id_paciente);
    
    INSERT INTO T_TD_TELEFONE_PACIENTE (id_telefone,nr_ddi,nr_ddd,nr_telefone,tp_telefone,id_paciente) VALUES(seq_telefone_paciente.nextval, 55, 11, 36543218, 'fixo',id_paciente);
    
    INSERT INTO T_TD_IMAGENS (id_imagem, link_url, dt_envio, id_paciente) VALUES (seq_imagem.nextval, '.jpg','16/11/2023', id_paciente);
    
    INSERT INTO T_TD_CONSULTA (id_consulta, dt_hr_consulta, tel_central, id_paciente, id_unid_hospitalar) VALUES (seq_consulta.nextval, '13/11/2023', 33333333, id_paciente, id_unid_hospitalar);
    
    INSERT INTO T_TD_QUADRO_CLINICO (id_quadro_clinico,ds_alergias,id_paciente) VALUES (seq_quadro_clinico.nextval,'Irritação e vermelhidão na pele devido ao uso de roupas apertadas e sintéticas', id_paciente);
-------------------8
    INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login8','senha8', 'i');

    SELECT seq_autentica.currval INTO id_autentica FROM DUAL;

    INSERT INTO T_TD_PACIENTE (id_paciente,nm_paciente,nr_cpf ,nr_rg ,dt_nascimento,fl_sexo ,tip_grupo_sanguineo,id_autentica) VALUES (seq_paciente.nextval, 'Pedro Pereira', '23456789012', '234567890', '20/09/1995', 'M', 'O-', id_autentica );
    
    SELECT seq_paciente.currval INTO id_paciente FROM DUAL;

    INSERT INTO T_TD_ENDERECO_PACIENTE (id_endereco, CEP, nr_logradouro, ds_ponto_referencia, id_paciente)VALUES (seq_endereco_paciente.nextval, '06034567', 234, 'Perto do hospital', id_paciente);
    
    INSERT INTO T_TD_TELEFONE_PACIENTE (id_telefone,nr_ddi,nr_ddd,nr_telefone,tp_telefone,id_paciente) VALUES(seq_telefone_paciente.nextval, 55, 11, 900112233, 'celular',id_paciente);
    
    INSERT INTO T_TD_IMAGENS (id_imagem, link_url, dt_envio, id_paciente) VALUES (seq_imagem.nextval,'.jpg', '17/11/2023', id_paciente);
    
    INSERT INTO T_TD_CONSULTA (id_consulta, dt_hr_consulta, tel_central, id_paciente, id_unid_hospitalar) VALUES (seq_consulta.nextval, '15/11/2023', 33333333, id_paciente,id_unid_hospitalar);
    
    INSERT INTO T_TD_QUADRO_CLINICO (id_quadro_clinico,ds_alergias,id_paciente) VALUES (seq_quadro_clinico.nextval,'Coceira começou apos contato com perfumes específicos ', id_paciente);
-------------------9
    INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login9','senha9', 'i');

    SELECT seq_autentica.currval INTO id_autentica FROM DUAL;

    INSERT INTO T_TD_PACIENTE (id_paciente,nm_paciente,nr_cpf ,nr_rg ,dt_nascimento,fl_sexo ,tip_grupo_sanguineo,id_autentica) VALUES (seq_paciente.nextval, 'Fernanda Lima', '56789012345', '567890123', '18/04/1980', 'F', 'A-', id_autentica );

    SELECT seq_paciente.currval INTO id_paciente FROM DUAL;

    INSERT INTO T_TD_ENDERECO_PACIENTE (id_endereco, CEP, nr_logradouro, ds_ponto_referencia, id_paciente) VALUES (seq_endereco_paciente.nextval, '07045678', 567, 'perto da padaria', id_paciente);
    
    INSERT INTO T_TD_TELEFONE_PACIENTE (id_telefone,nr_ddi,nr_ddd,nr_telefone,tp_telefone,id_paciente) VALUES(seq_telefone_paciente.nextval, 55, 11, 55557777, 'fixo', id_paciente);
    
    INSERT INTO T_TD_IMAGENS (id_imagem, link_url, dt_envio, id_paciente) VALUES (seq_imagem.nextval, '.jpg', '18/11/2023', id_paciente);
    
    INSERT INTO T_TD_CONSULTA (id_consulta, dt_hr_consulta, tel_central, id_paciente, id_unid_hospitalar) VALUES (seq_consulta.nextval, '16/11/2023', 33333333, id_paciente,id_unid_hospitalar);
    
    INSERT INTO T_TD_QUADRO_CLINICO (id_quadro_clinico,ds_alergias,id_paciente) VALUES (seq_quadro_clinico.nextval,'Coceira começou em época de polinização elevada ', id_paciente);
-------------------10
    INSERT INTO T_TD_AUTENTICA  (id_autentica, login ,  senha ,  st_login  ) VALUES (seq_autentica.nextval, 'login10','senha10', 'i');

    SELECT seq_autentica.currval INTO id_autentica FROM DUAL;

    INSERT INTO T_TD_PACIENTE (id_paciente,nm_paciente,nr_cpf ,nr_rg ,dt_nascimento,fl_sexo ,tip_grupo_sanguineo,id_autentica) VALUES (seq_paciente.nextval, 'Roberto Costa', '89012345678', '890123456', '08/07/1976', 'M', 'B+', id_autentica );

    SELECT seq_paciente.currval INTO id_paciente FROM DUAL;

    INSERT INTO T_TD_ENDERECO_PACIENTE (id_endereco, CEP, nr_logradouro, ds_ponto_referencia, id_paciente)VALUES (seq_endereco_paciente.nextval, '08056789', 890, 'perto do parque', id_paciente);

    INSERT INTO T_TD_TELEFONE_PACIENTE (id_telefone,nr_ddi,nr_ddd,nr_telefone,tp_telefone,id_paciente) VALUES(seq_telefone_paciente.nextval, 55, 11, 933344455, 'celular', id_paciente);

    INSERT INTO T_TD_IMAGENS (id_imagem, link_url, dt_envio, id_paciente) VALUES (seq_imagem.nextval, '.jpg', '19/11/2023', id_paciente);

    INSERT INTO T_TD_CONSULTA (id_consulta, dt_hr_consulta, tel_central, id_paciente, id_unid_hospitalar) VALUES (seq_consulta.nextval, '17/11/2023', 33333333, id_paciente,id_unid_hospitalar);

    INSERT INTO T_TD_QUADRO_CLINICO (id_quadro_clinico,ds_alergias,id_paciente) VALUES (seq_quadro_clinico.nextval,'Alergia começou semana passada e houve uma piora na coceira e ocorreu descamação', id_paciente);

END;




select * from t_Td_autentica;
select * from t_td_paciente;
select * from t_td_imagens;
select * from t_td_quadro_clinico;
select * from t_td_consulta;
select * from t_td_telefone_paciente;
select * from t_td_endereco_paciente;



SELECT
    T_TD_PACIENTE.id_paciente,
    T_TD_PACIENTE.nm_paciente,
    T_TD_PACIENTE.nr_cpf,
    T_TD_PACIENTE.nr_rg,
    T_TD_PACIENTE.dt_nascimento,
    T_TD_PACIENTE.fl_sexo,
    T_TD_PACIENTE.tip_grupo_sanguineo,
    T_TD_AUTENTICA.login,
    T_TD_AUTENTICA.st_login
FROM
    T_TD_PACIENTE
INNER JOIN
    T_TD_AUTENTICA ON T_TD_PACIENTE.id_autentica = T_TD_AUTENTICA.id_autentica
WHERE
    T_TD_PACIENTE.tip_grupo_sanguineo = 'O-';
    
    
    
    
    
    
SELECT
    T_TD_PACIENTE.fl_sexo,
    COUNT(T_TD_PACIENTE.id_paciente) AS total_pacientes
FROM
    T_TD_PACIENTE
GROUP BY
    T_TD_PACIENTE.fl_sexo;    




 

    

delete from t_td_autentica;
delete from t_td_paciente;
delete from t_td_imagens;
delete from t_td_quadro_clinico;
delete from t_td_consulta;
delete from t_td_telefone_paciente;
delete from t_td_endereco_paciente;
