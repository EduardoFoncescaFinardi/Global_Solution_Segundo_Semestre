import requests
from pprint import pprint
import json
from flask import Flask, render_template, request, redirect, url_for, jsonify
import cx_Oracle
cx_Oracle.init_oracle_client(lib_dir=r"C:\instantclient_21_12")

#connection
def getConnection():
    try:
        connection = cx_Oracle.connect("RM98624", "291002", "oracle.fiap.com.br/ORCL")
        # connection = cx_Oracle.connect(user="a", password="b", host="c", port="1521", service="ORCL") 
        print("conexão: ", connection.version)
        return connection
    except Exception as e:
        print(f'Erro ao obter conexão: {e}')

def dados_dados_gerais():
  cadastro_list = []

  nm_paciente = input("Nome completo:")
  cadastro_list.append(nm_paciente)

  nr_cpf = input("CPF:")
  cadastro_list.append(nr_cpf)           

  nr_rg = input("RG:")
  cadastro_list.append(nr_rg)    

  dt_nascimento = input("Data de Nascimento:")
  cadastro_list.append(dt_nascimento)   

  fl_sexo = input("Genêro(Responder com 'm' para masculino e 'f' para feminino):")
  cadastro_list.append(fl_sexo)

  Grupo_sanguineo = input("Grupo sanguíneo (Exemplo: 'A-'):")
  cadastro_list.append(Grupo_sanguineo)
  print("-----------------------------------------------------------------------------------------------------")
  return cadastro_list

def dados_localizacao():
  endereco_list = []
  cep = input("CEP:")
  endereco_list.append(cep) 

  nr_logradouro = input("número de logradouro:")
  endereco_list.append(nr_logradouro)  

  ds_ponto_referencia = input("ponto de referência:")
  endereco_list.append(ds_ponto_referencia) 
  print("-----------------------------------------------------------------------------------------------------")
  return endereco_list   

def dados_telefonicos():
  telefone_list = []

  ddi = input("ddi:")
  telefone_list.append(ddi) 
    
  ddd = input("ddd:")
  telefone_list.append(ddd) 

  nr_telefone = input("número de telefone:")
  telefone_list.append(nr_telefone) 
  
  tp_telefone = input("tipo de telefone:")
  telefone_list.append(tp_telefone) 
  print("-----------------------------------------------------------------------------------------------------")    
  return telefone_list

def login(cadastro_senha, cadastro_login):
    Login = input("Login:")
    Senha = input("Senha:")

    if Login != cadastro_login or Senha != cadastro_senha:
        print("Login inválido, tente novamente!")
        Login = input("Login:")
        Senha = input("Senha:")

def menu_de_funcionalidades(): 
    menu_de_funcionalidades_input = int(input("""MENU DE FUNCINALIDADES!
1 - Análise de fotos;
2 - adicionar dados ao seu quadro clínico!;
3 - Visualizar dados pessoais;
Seleção:"""))
    return menu_de_funcionalidades_input

def QUADRO_CLINICO_PREENCHIMENTO():
    lista_quadro_clinico = []
    ds_alergias = input("Descrição de alergias a medicamentos:")
    lista_quadro_clinico.append(ds_alergias)
    return lista_quadro_clinico

##########################################################################
##########################################################################
##########################################################################
def CREATE_TABLE_AUTENTICA():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_autentica = """
    CREATE TABLE T_TD_AUTENTICA(
    id_autentica NUMERIC,
    login varchar(100),
    senha varchar(100),
    CONSTRAINT T_TD_AUTENTICA_PK PRIMARY KEY (id_autentica)
    )"""

    try:
        cursor.execute(sql_autentica)
        print("Tabela Autentica criada")

    except Exception as e:
        print(f'Erro ao criar a tabela Autentica: {e}')

    finally:
        cursor.close
        conn.close

def CREATE_TABLE_PACIENTE():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_paciente = """
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
    )"""

    try:
        cursor.execute(sql_paciente)
        print("Tabela Paciente criada")

    except Exception as e:
        print(f'Erro ao criar a tabela Paciente: {e}')

    finally:
        cursor.close
        conn.close

def CREATE_TABLE_UNID_HOSPITALAR():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_unid_hosp = """
    CREATE TABLE T_TD_UNID_HOSPITALAR(
    id_unid_hospitalar NUMERIC(9),
    razao_social varchar(80) NOT NULL,
    nr_logradouro NUMERIC(7),
    CEP numeric(10) NOT NULL,
    dt_cadastro date not null,
    CONSTRAINT T_TD_UNID_HOSPITALAR_PK PRIMARY KEY (id_unid_hospitalar)
    )"""

    try:
        cursor.execute(sql_unid_hosp)
        print("Tabela Unid_Hospitalar criada")

    except Exception as e:
        print(f'Erro ao criar a tabela Unid_Hospitalar: {e}')

    finally:
        cursor.close
        conn.close

def CREATE_TABLE_QUADRO_CLINICO():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_quadro_clinico = """
    CREATE TABLE T_TD_QUADRO_CLINICO(
    id_quadro_clinico NUMERIC,
    ds_alergias VARCHAR(1000),
    id_paciente NUMERIC(9),
    CONSTRAINT T_TD_MEDICO_FK PRIMARY KEY (id_quadro_clinico),
    CONSTRAINT T_TD_QUADRO_CLINICO FOREIGN KEY (id_paciente) REFERENCES T_TD_PACIENTE(id_paciente)
    )"""

    try:
        cursor.execute(sql_quadro_clinico)
        print("Tabela Quadro_Clinico criada")

    except Exception as e:
        print(f'Erro ao criar a tabela Quadro_Clinico: {e}')

    finally:
        cursor.close
        conn.close

def CREATE_TABLE_CONSULTA():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_consulta = """
    CREATE TABLE T_TD_CONSULTA(
    id_consulta NUMERIC ,
    dt_hr_consulta date not null,
    tel_central varchar(14),
    id_paciente NUMERIC(9)  not null,
    id_unid_hospitalar NUMERIC(9)  not null,
    CONSTRAINT T_TD_CONSULTA_PK PRIMARY KEY (id_consulta),
    CONSTRAINT T_TD_CONSULTA_PACIENTE_FK FOREIGN KEY (id_paciente) REFERENCES T_TD_PACIENTE(id_paciente),
    CONSTRAINT T_TD_CONSULTA_UNID_HOSPITLAR_FK FOREIGN KEY (id_unid_hospitalar) REFERENCES T_TD_UNID_HOSPITALAR(id_unid_hospitalar)
)"""

    try:
        cursor.execute(sql_consulta)
        print("Tabela Consulta criada")

    except Exception as e:
        print(f'Erro ao criar a tabela Consulta: {e}')

    finally:
        cursor.close
        conn.close

def CREATE_TABLE_TELEFONE_PACIENTE():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_telefone_pac = """
    CREATE TABLE T_TD_TELEFONE_PACIENTE (
    id_telefone NUMERIC(9) ,
    nr_ddi NUMERIC(3) NOT NULL,
    nr_ddd NUMERIC(3) NOT NULL,
    nr_telefone NUMERIC(10) NOT NULL,
    tp_telefone VARCHAR(20),
    id_paciente NUMERIC(9) NOT NULL,
    CONSTRAINT T_TD_TELEFONE_PACIENTE_PK PRIMARY KEY (id_telefone),
    CONSTRAINT T_TD_TELEFONE_PACIENTE_FK FOREIGN KEY (id_paciente) REFERENCES T_TD_PACIENTE (id_paciente)
    )"""

    try:
        cursor.execute(sql_telefone_pac)
        print("Tabela Telefone_Paciente criada")

    except Exception as e:
        print(f'Erro ao criar a tabela Telefone_Paciente: {e}')

    finally:
        cursor.close
        conn.close

def CREATE_TABLE_ENDERECO_PACIENTE():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_endereco_pac = """
    CREATE TABLE T_TD_ENDERECO_PACIENTE(
    id_endereco NUMERIC(9),
    CEP VARCHAR(8) NOT NULL,
    nr_logradouro NUMERIC(7)NOT NULL,
    ds_ponto_referencia VARCHAR(30),
    id_paciente NUMERIC(9),
    CONSTRAINT T_TD_ENDERECO_PACIENTE_PK PRIMARY KEY(id_endereco),
    CONSTRAINT T_TD_ENDERECO_PACIENTE_FK FOREIGN KEY (id_paciente) REFERENCES T_TD_PACIENTE(id_paciente)
    )"""

    try:
        cursor.execute(sql_endereco_pac)
        print("Tabela Endereco_Paciente criada")

    except Exception as e:
        print(f'Erro ao criar a tabela Endereco_Paciente: {e}')

    finally:
        cursor.close
        conn.close      

def CREATE_TABLE_IMAGENS():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_imagens = """
    CREATE TABLE T_TD_IMAGENS(
    id_imagem NUMERIC,
    link_url VARCHAR(1000) NOT NULL,
    dt_envio DATE NOT NULL,
    id_paciente NUMERIC(9),
    CONSTRAINT T_TD_IMAGENS_PK PRIMARY KEY (id_imagem),
    CONSTRAINT T_TD_IMAGENS_FK FOREIGN KEY (id_paciente) REFERENCES T_TD_PACIENTE (id_paciente)
    )"""

    try:
        cursor.execute(sql_imagens)
        print("Tabela Imagens criada")

    except Exception as e:
        print(f'Erro ao criar a tabela Imagens: {e}')

    finally:
        cursor.close()
        conn.close() 
##########################################################################
##########################################################################
##########################################################################
def CREATE_SEQ_AUTENTICA():
    conn = getConnection()
    cursor = conn.cursor()

    create_sequence_query = """
    CREATE SEQUENCE seq_autentica
        START WITH 1
        INCREMENT BY 1
        MINVALUE 0
        MAXVALUE 1000
        NOCYCLE
    """
    
    try:
        cursor.execute(create_sequence_query)
        conn.commit()
        print("Sequência seq_autentica criada com sucesso.")
    except Exception as e:
        print(f'Erro ao criar a sequência: {e}')
    finally:
        cursor.close()
        conn.close()

def CREATE_SEQ_PACIENTE():
    conn = getConnection()
    cursor = conn.cursor()

    create_sequence_query = """
    CREATE SEQUENCE seq_paciente
        START WITH 1
        INCREMENT BY 1
        MINVALUE 0
        MAXVALUE 1000
        NOCYCLE
    """    
    try:
        cursor.execute(create_sequence_query)
        conn.commit()
        print("Sequência seq_paciente criada com sucesso.")
    except Exception as e:
        print(f'Erro ao criar a sequência: {e}')
    finally:
        cursor.close()
        conn.close()

def CREATE_SEQ_UNID_HOSPITALAR():
    conn = getConnection()
    cursor = conn.cursor()

    create_sequence_query = """
    CREATE SEQUENCE seq_unid_hospitalar
        START WITH 1
        INCREMENT BY 1
        MINVALUE 0
        MAXVALUE 1000
        NOCYCLE
    """
    
    try:
        cursor.execute(create_sequence_query)
        conn.commit()
        print("Sequência seq_unid_hospitalar criada com sucesso.")
    except Exception as e:
        print(f'Erro ao criar a sequência: {e}')
    finally:
        cursor.close()
        conn.close()

def CREATE_SEQ_QUADRO_CLINICO():
    conn = getConnection()
    cursor = conn.cursor()

    create_sequence_query = """
    CREATE SEQUENCE seq_quadro_clinico
        START WITH 1
        INCREMENT BY 1
        MINVALUE 0
        MAXVALUE 1000
        NOCYCLE
    """
    
    try:
        cursor.execute(create_sequence_query)
        conn.commit()
        print("Sequência seq_quadro_clinico criada com sucesso.")
    except Exception as e:
        print(f'Erro ao criar a sequência: {e}')
    finally:
        cursor.close()
        conn.close()   

def CREATE_SEQ_CONSULTA():
    conn = getConnection()
    cursor = conn.cursor()

    create_sequence_query = """
    CREATE SEQUENCE seq_consulta
        START WITH 1
        INCREMENT BY 1
        MINVALUE 0
        MAXVALUE 1000
        NOCYCLE 
    """
    
    try:
        cursor.execute(create_sequence_query)
        conn.commit()
        print("Sequência seq_consulta criada com sucesso.")
    except Exception as e:
        print(f'Erro ao criar a sequência: {e}')
    finally:
        cursor.close()
        conn.close()

def CREATE_SEQ_TELEFONE_PACIENTE():
    conn = getConnection()
    cursor = conn.cursor()

    create_sequence_query = """
    CREATE SEQUENCE seq_telefone_paciente
        START WITH 1
        INCREMENT BY 1
        MINVALUE 0
        MAXVALUE 1000
        NOCYCLE
    """
    
    try:
        cursor.execute(create_sequence_query)
        conn.commit()
        print("Sequência seq_telefone_paciente criada com sucesso.")
    except Exception as e:
        print(f'Erro ao criar a sequência: {e}')
    finally:
        cursor.close()
        conn.close()

def CREATE_SEQ_ENDERECO_PACIENTE():
    conn = getConnection()
    cursor = conn.cursor()

    create_sequence_query = """
    CREATE SEQUENCE seq_endereco_paciente
        START WITH 1
        INCREMENT BY 1
        MINVALUE 0
        MAXVALUE 1000
        NOCYCLE  
    """
    
    try:
        cursor.execute(create_sequence_query)
        conn.commit()
        print("Sequência seq_endereco_paciente criada com sucesso.")
    except Exception as e:
        print(f'Erro ao criar a sequência: {e}')
    finally:
        cursor.close()
        conn.close()

def CREATE_SEQ_IMAGEM():
    conn = getConnection()
    cursor = conn.cursor()

    create_sequence_query = """
    CREATE SEQUENCE seq_imagem
        START WITH 1
        INCREMENT BY 1
        MINVALUE 0
        MAXVALUE 1000
        NOCYCLE  
    """  

    try:
        cursor.execute(create_sequence_query)
        conn.commit()
        print("Sequência seq_imagem criada com sucesso.")
    except Exception as e:
        print(f'Erro ao criar a sequência: {e}')
    finally:
        cursor.close()
        conn.close()   

##########################################################################
##########################################################################
##########################################################################
def INSERT_TABLE_AUTENTICA(lista_login_senha):
  conn = getConnection()
  cursor = conn.cursor()

  sql_query = "INSERT INTO T_TD_AUTENTICA (id_autentica, login, senha) VALUES (:0,:1,:2)"

  try:

      cursor.execute("SELECT seq_autentica.NEXTVAL FROM dual")
      nextval_result = cursor.fetchone()

      if nextval_result:
          id_autentica = nextval_result[0]


          cursor.execute(sql_query, (id_autentica, lista_login_senha[0], lista_login_senha[1]))
          conn.commit()
          print("Cadastro do Paciente efetuado com sucesso. ID Auntentica:", id_autentica)

          cursor.execute("SELECT seq_autentica.currval FROM dual")
          result = cursor.fetchone()
          if result:
              lgid_autentica = result[0]
              return lgid_autentica

          else:
            print(f"Erro ao obter o último valor gerado pela sequência: {e}")
      else:
        print("Erro ao obter o próximo valor da sequência")

  except Exception as e:
      print(f'Erro ao inserir o registro de Autentica: {e}')
  finally:
      cursor.close()
      conn.close()

def INSERT_TABLE_PACIENTE(cadastro_list, lgid_autentica):
    conn = getConnection()
    cursor = conn.cursor()

    sql_query = "INSERT INTO T_TD_PACIENTE (id_paciente, nm_paciente, nr_cpf, nr_rg, dt_nascimento, fl_sexo, tip_grupo_sanguineo, id_autentica) VALUES (:0,:1,:2,:3, TO_DATE(:4, 'dd/mm/yyyy'), :5, :6, :7)"

    try:

        cursor.execute("SELECT seq_paciente.NEXTVAL FROM dual")
        nextval_result = cursor.fetchone()

        if nextval_result:
            id_paciente = nextval_result[0]

            cursor.execute(sql_query, (id_paciente, cadastro_list[0], cadastro_list[1], cadastro_list[2], cadastro_list[3], cadastro_list[4], cadastro_list[5], lgid_autentica))
            conn.commit()
            print("Registro de Paciente inserido com sucesso.ID Paciente:", id_paciente)

            cursor.execute("SELECT seq_paciente.currval FROM dual")
            result = cursor.fetchone()
            if result:
              lgi_paciente = result[0]
              return lgi_paciente
            else:
              print(f"Erro ao obter o último valor gerado pela sequência: {e}")
        else:
          print("Erro ao obter o próximo valor da sequência")

    except Exception as e:
        print(f'Erro ao inserir o registro de Paciente: {e}')
    finally:
        cursor.close()
        conn.close()

def INSERT_TABLE_ENDERECO_PACIENTE(endereco_list, lgi_paciente):
    conn = getConnection()
    cursor = conn.cursor()

    sql_query = "INSERT INTO T_TD_ENDERECO_PACIENTE (ID_ENDERECO, CEP, NR_LOGRADOURO, DS_PONTO_REFERENCIA, ID_PACIENTE) VALUES (:0,:1,:2,:3,:4)"

    try:

        cursor.execute("SELECT SEQ_ENDERECO_PACIENTE.NEXTVAL FROM dual")
        nextval_result = cursor.fetchone()

        if nextval_result:
            id_endereco = nextval_result[0]

            cursor.execute(sql_query, (id_endereco, endereco_list [0], endereco_list [1], endereco_list [2], lgi_paciente))
            conn.commit()
            print("Registro de Endereco do paciente inserido com sucesso.ID Endereço:", id_endereco)

            cursor.execute("SELECT SEQ_ENDERECO_PACIENTE.currval FROM dual")
            result = cursor.fetchone()
            if result:
              lgi_endereco = result[0]
              return lgi_endereco
            else:
              print(f"Erro ao obter o último valor gerado pela sequência: {e}")
        else:
          print("Erro ao obter o próximo valor da sequência")

    except Exception as e:
        print(f'Erro ao inserir o registro de Endereclo: {e}')
    finally:
        cursor.close()
        conn.close()

def INSERT_TABLE_TELEFONE_PACIENTE(telefone_list, lgi_paciente):
    conn = getConnection()
    cursor = conn.cursor()

    sql_query = "INSERT INTO T_TD_TELEFONE_PACIENTE (id_telefone,nr_ddi,nr_ddd,nr_telefone,tp_telefone,id_paciente) VALUES (:0,:1,:2,:3,:4,:5)"

    try:

        cursor.execute("SELECT SEQ_TELEFONE_PACIENTE.NEXTVAL FROM dual")
        nextval_result = cursor.fetchone()

        if nextval_result:
            id_telefone = nextval_result[0]

            cursor.execute(sql_query, (id_telefone, telefone_list[0], telefone_list[1], telefone_list[2], telefone_list[3], lgi_paciente))
            conn.commit()
            print("Registro de Telefone do paciente inserido com sucesso.ID Telefone:", id_telefone)

            cursor.execute("SELECT SEQ_TELEFONE_PACIENTE.currval FROM dual")
            result = cursor.fetchone()
            if result:
              lgi_telefone = result[0]
              return lgi_telefone
            else:
              print(f"Erro ao obter o último valor gerado pela sequência: {e}")
        else:
          print("Erro ao obter o próximo valor da sequência")

    except Exception as e:
        print(f'Erro ao inserir o registro de Telefone: {e}')
    finally:
        cursor.close()
        conn.close()

def INSERT_QUADRO_CLINICO(lista_quadro_clinico, lgi_paciente):
    conn = getConnection()
    cursor = conn.cursor()

    sql_query = "INSERT INTO T_TD_QUADRO_CLINICO (id_quadro_clinico,ds_alergias,id_paciente) VALUES (:0, :1, :2)"

    try:

        cursor.execute("SELECT seq_quadro_clinico.NEXTVAL FROM dual")
        nextval_result = cursor.fetchone()

        if nextval_result:
            id_quadro_clinico = nextval_result[0]

            cursor.execute(sql_query, (id_quadro_clinico,lista_quadro_clinico[0], lgi_paciente))
            conn.commit()
            print("Cadastro de Quadro Clinico efetuado com sucesso. ID do Acessorio:", id_quadro_clinico)
        else:
            print("Erro ao obter o próximo valor da sequência")
    except Exception as e:
        print(f'Erro ao cadastrar Quadro Clinico: {e}')
    finally:
        cursor.close()
        conn.close()
##########################################################################
##########################################################################
##########################################################################
def DROP_TABLE_AUTENTICA():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_autentica = """
    DROP TABLE T_TD_AUTENTICA
    """
    try:
        cursor.execute(sql_autentica)
        print("Tabela Autentica dropada")

    except Exception as e:
        print(f'Erro ao dropar a tabela Autentica: {e}')

    finally:
        cursor.close
        conn.close

def DROP_TABLE_PACIENTE():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_paciente = """
    DROP TABLE T_TD_PACIENTE
    """
    try:
        cursor.execute(sql_paciente)
        print("Tabela Paciente dropada")

    except Exception as e:
        print(f'Erro ao dropar a tabela Paciente: {e}')

    finally:
        cursor.close
        conn.close

def DROP_TABLE_UNID_HOSPITALAR():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_unid_hosp = """
    DROP TABLE T_TD_UNID_HOSPITALAR
    """
    try:
        cursor.execute(sql_unid_hosp)
        print("Tabela Unidade Hospitalar dropada")

    except Exception as e:
        print(f'Erro ao dropar a tabela Unid_Hospitalar: {e}')

    finally:
        cursor.close
        conn.close                  

def DROP_TABLE_QUADRO_CLINICO():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_quadro_clinico = """
    DROP TABLE T_TD_QUADRO_CLINICO
    """
    try:
        cursor.execute(sql_quadro_clinico)
        print("Tabela Quadro Clinico dropada")

    except Exception as e:
        print(f'Erro ao dropar a tabela Quadro_Clinico: {e}')

    finally:
        cursor.close
        conn.close  

def DROP_TABLE_CONSULTA():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_consulta = """
    DROP TABLE T_TD_CONSULTA
    """
    try:
        cursor.execute(sql_consulta)
        print("Tabela consulta dropada")

    except Exception as e:
        print(f'Erro ao dropar a tabela consulta: {e}')

    finally:
        cursor.close
        conn.close  

def DROP_TABLE_TELEFONE_PACIENTE():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_tel_paciente = """
    DROP TABLE T_TD_TELEFONE_PACIENTE
    """
    try:
        cursor.execute(sql_tel_paciente)
        print("Tabela Telefone_Paciente dropada")

    except Exception as e:
        print(f'Erro ao dropar a tabela Telefone_Paciente: {e}')

    finally:
        cursor.close
        conn.close  

def DROP_TABLE_ENDERECO_PACIENTE():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_end_paciente = """
   DROP TABLE T_TD_ENDERECO_PACIENTE
    """
    try:
        cursor.execute(sql_end_paciente)
        print("Tabela Endereco_Paciente dropada")

    except Exception as e:
        print(f'Erro ao dropar a tabela Endereco_Paciente: {e}')

    finally:
        cursor.close
        conn.close  

def DROP_TABLE_IMAGENS():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_imagens = """
    DROP TABLE T_TD_IMAGENS
    """
    try:
        cursor.execute(sql_imagens)
        print("Tabela Imagens dropada")

    except Exception as e:
        print(f'Erro ao dropar a tabela Imagens: {e}')

    finally:
        cursor.close
        conn.close
##########################################################################
##########################################################################
##########################################################################
def DROP_SEQ_AUTENTICA():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_autentica = """
    DROP SEQUENCE seq_autentica
    """
    try:
        cursor.execute(sql_autentica)
        print("Sequencia Autentica dropada")

    except Exception as e:
        print(f'Erro ao dropar a Sequencia Autentica: {e}')

    finally:
        cursor.close()
        conn.close()

def DROP_SEQ_PACIENTE():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_paciente = """
    DROP SEQUENCE seq_paciente
    """
    try:
        cursor.execute(sql_paciente)
        print("Sequencia Paciente dropada")

    except Exception as e:
        print(f'Erro ao dropar a Sequencia Paciente: {e}')

    finally:
        cursor.close()
        conn.close()

def DROP_SEQ_UNID_HOSPITALAR():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_unid_hosp = """
    DROP SEQUENCE seq_unid_hospitalar
    """
    try:
        cursor.execute(sql_unid_hosp)
        print("Sequencia Unid_Hospitalar dropada")

    except Exception as e:
        print(f'Erro ao dropar a Sequencia Unid_Hospitalar: {e}')

    finally:
        cursor.close()
        conn.close()                  

def DROP_SEQ_QUADRO_CLINICO():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_quadro_clinico = """
    DROP SEQUENCE seq_quadro_clinico
    """
    try:
        cursor.execute(sql_quadro_clinico)
        print("Sequencia Quadro_Clinico dropada")

    except Exception as e:
        print(f'Erro ao dropar a Sequencia Quadro_Clinico: {e}')

    finally:
        cursor.close()
        conn.close()  

def DROP_SEQ_CONSULTA():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_consulta = """
    DROP SEQUENCE seq_consulta
    """
    try:
        cursor.execute(sql_consulta)
        print("Sequencia consulta dropada")

    except Exception as e:
        print(f'Erro ao dropar a Sequencia consulta: {e}')

    finally:
        cursor.close()
        conn.close()  

def DROP_SEQ_TELEFONE_PACIENTE():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_tel_paciente = """
    DROP SEQUENCE seq_telefone_paciente
    """
    try:
        cursor.execute(sql_tel_paciente)
        print("Sequencia Telefone_Paciente dropada")

    except Exception as e:
        print(f'Erro ao dropar a Sequencia Telefone_Paciente: {e}')

    finally:
        cursor.close()
        conn.close()  

def DROP_SEQ_ENDERECO_PACIENTE():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_end_paciente = """
   DROP SEQUENCE seq_endereco_paciente
    """
    try:
        cursor.execute(sql_end_paciente)
        print("Sequencia Endereco_Paciente dropada")

    except Exception as e:
        print(f'Erro ao dropar a Sequencia Endereco_Paciente: {e}')

    finally:
        cursor.close()
        conn.close()

def DROP_SEQ_IMAGENS():
    conn = getConnection()
    cursor = conn.cursor() #variável de execução do cursos
    sql_imagens = """
    DROP SEQUENCE seq_imagem
    """
    try:
        cursor.execute(sql_imagens)
        print("Sequencia Imagens dropada")

    except Exception as e:
        print(f'Erro ao dropar a Sequencia Imagens: {e}')

    finally:
        cursor.close()
        conn.close()
##########################################################################
##########################################################################
##########################################################################
def SELECT_PACIENTE():
    conn = getConnection()
    cursor = conn.cursor()

    sql_query = "SELECT * FROM T_TD_PACIENTE"

    try:
        cursor.execute(sql_query)
        print("Dados do Paciente exibidos")

        rows = cursor.fetchall()
        dados_pacientes = []

        for row in rows:
            dados_pacientes.append({
                'id_paciente': row[0],
                'nm_paciente': row[1],
                'nr_cpf': row[2],
                'nr_rg': row[3],
                'dt_nascimento': row[4].strftime("%d/%m/%Y"),
                'fl_sexo': row[5],
                'tip_grupo_sanguineo': row[6],
                'id_autentica': row[7]
            })

        exportar_para_json(dados_pacientes, 'dados_pacientes.json')

    except Exception as e:
        print(f'Erro ao Mostrar Dados do Paciente: {e}')
    finally:
        cursor.close()
        conn.close()

def SELECT_TELEFONE_PACIENTE():
    conn = getConnection()
    cursor = conn.cursor()

    sql_query = "SELECT * FROM T_TD_TELEFONE_PACIENTE"

    try:
        cursor.execute(sql_query)
        print("Dados do Telefone do Paciente exibidos")

        rows = cursor.fetchall()
        dados_telefones = []

        for row in rows:
            dados_telefones.append({
                'id_telefone': row[0],
                'nr_ddi': row[1],
                'nr_ddd': row[2],
                'nr_telefone': row[3],
                'tp_telefone': row[4],
                'id_paciente': row[5]
            })

        exportar_para_json(dados_telefones, 'dados_telefones.json')

    except Exception as e:
        print(f'Erro ao Mostrar Dados do Telefone do Paciente: {e}')
    finally:
        cursor.close()
        conn.close()

def SELECT_ENDERECO_PACIENTE():
    conn = getConnection()
    cursor = conn.cursor()

    sql_query = "SELECT * FROM T_TD_ENDERECO_PACIENTE"

    try:
        cursor.execute(sql_query)
        print("Dados do Endereço do Paciente exibidos")

        rows = cursor.fetchall()
        dados_enderecos = []

        for row in rows:
            dados_enderecos.append({
                'id_endereco': row[0],
                'CEP': row[1],
                'nr_logradouro': row[2],
                'ds_ponto_referencia': row[3],
                'id_paciente': row[4]
            })

        exportar_para_json(dados_enderecos, 'dados_enderecos.json')

    except Exception as e:
        print(f'Erro ao Mostrar Dados do Endereço do Paciente: {e}')
    finally:
        cursor.close()
        conn.close()

def SELECT_QUADRO_CLINICO():
    conn = getConnection()
    cursor = conn.cursor()

    sql_query = "SELECT * FROM T_TD_QUADRO_CLINICO"

    try:
        cursor.execute(sql_query)
        print("Dados do Quadro clinico do Paciente exibidos")

        rows = cursor.fetchall()
        dados_quadro_clinico = []

        for row in rows:
            dados_quadro_clinico.append({
                'id_quadro_clinico': row[0],
                'ds_alergias': row[1],
                'id_paciente': row[2]
            })

        exportar_para_json(dados_quadro_clinico, 'dados_quadro_clinico.json')

    except Exception as e:
        print(f'Erro ao Mostrar Dados do Quadro clinico do Paciente: {e}')
    finally:
        cursor.close()
        conn.close()
##########################################################################
##########################################################################
##########################################################################
def DELETE_QUADRO_CLINICO():
    conn = getConnection()
    cursor = conn.cursor()

    sql_query = "DELETE FROM T_TD_QUADRO_CLINICO "

    try:
        cursor.execute(sql_query)
        print("Dados do Quadro Clinico deletados")

    except Exception as e:
        print(f'Erro ao Deletar o registro do Quadro Clinico: {e}')
    finally:
        cursor.close()
        conn.close()

def DELETE_TELEFONE_PACIENTE():
    conn = getConnection()
    cursor = conn.cursor()

    sql_query = "DELETE FROM T_TD_TELEFONE_PACIENTE "

    try:
        cursor.execute(sql_query)
        print("Dados do Telefone do Paciente deletados")

    except Exception as e:
        print(f'Erro ao Deletar Dados do Telefone do Paciente: {e}')
    finally:
        cursor.close()
        conn.close()

def DELETE_ENDERECO_PACIENTE():
    conn = getConnection()
    cursor = conn.cursor()

    sql_query = "DELETE FROM T_TD_ENDERECO_PACIENTE "

    try:
        cursor.execute(sql_query)
        print("Dados do Endereço do Paciente deletados")

    except Exception as e:
        print(f'Erro ao Deletar Dados do Endereço do Paciente: {e}')
    finally:
        cursor.close()
        conn.close()

def exportar_para_json(dados, nome_arquivo):
    with open(nome_arquivo, 'w') as arquivo_json:
        json.dump(dados, arquivo_json, indent=2)
    print(f'Dados exportados para {nome_arquivo}')

def main():

    repetir_processo = "S"
    while repetir_processo == "S":
        DROP = int(input("DROP:"))
        if DROP == 1:
            DROP_TABLE_IMAGENS()
            DROP_SEQ_IMAGENS()
            DROP_TABLE_TELEFONE_PACIENTE()
            DROP_SEQ_TELEFONE_PACIENTE()
            DROP_TABLE_ENDERECO_PACIENTE()
            DROP_SEQ_ENDERECO_PACIENTE()
            DROP_TABLE_QUADRO_CLINICO()
            DROP_SEQ_QUADRO_CLINICO()
            DROP_TABLE_CONSULTA()
            DROP_SEQ_CONSULTA()
            DROP_TABLE_UNID_HOSPITALAR()
            DROP_SEQ_UNID_HOSPITALAR()
            DROP_TABLE_PACIENTE()
            DROP_SEQ_PACIENTE()
            DROP_TABLE_AUTENTICA()
            DROP_SEQ_AUTENTICA()

        CREATE = int(input("CREATE:"))
        if CREATE == 1:
            CREATE_TABLE_AUTENTICA()
            CREATE_TABLE_PACIENTE()
            CREATE_TABLE_UNID_HOSPITALAR()
            CREATE_TABLE_ENDERECO_PACIENTE()
            CREATE_TABLE_TELEFONE_PACIENTE()
            CREATE_TABLE_IMAGENS()
            CREATE_TABLE_QUADRO_CLINICO()
            CREATE_TABLE_CONSULTA()

            CREATE_SEQ_AUTENTICA()
            CREATE_SEQ_PACIENTE()
            CREATE_SEQ_UNID_HOSPITALAR()
            CREATE_SEQ_ENDERECO_PACIENTE()
            CREATE_SEQ_TELEFONE_PACIENTE()
            CREATE_SEQ_IMAGEM()
            CREATE_SEQ_QUADRO_CLINICO()
            CREATE_SEQ_CONSULTA()
    #################################################################
        print("Bem-vindo ao TrataDerma! Vamos dar início. Faça seu cadastro!")
        lista_login_senha = []
        cadastro_login = input("defina um Login:")
        lista_login_senha.append(cadastro_login)  
        cadastro_senha = input("defina uma Senha:")
        lista_login_senha.append(cadastro_senha)
        print("Certo, agora nos forneça alguns dados pessoais!")
    #################################################################
        cadastro_list = dados_dados_gerais()
        endereco_list = dados_localizacao()
        telefone_list = dados_telefonicos()
        lgid_autentica = INSERT_TABLE_AUTENTICA(lista_login_senha)
        lgi_paciente = INSERT_TABLE_PACIENTE(cadastro_list, lgid_autentica)
        INSERT_TABLE_ENDERECO_PACIENTE(endereco_list, lgi_paciente)
        INSERT_TABLE_TELEFONE_PACIENTE(telefone_list, lgi_paciente)
        print("Cadastro realizado com sucesso! Agora faça Login!")
    #################################################################
        login(cadastro_senha, cadastro_login)
        menu_de_funcionalidades_input = menu_de_funcionalidades()
        match menu_de_funcionalidades_input:
            case 1: 
                print("""Olá, Fernando! Devido a imcompatibilidade das biblitecas cx_Oracle, TensorFlow e Keras com 
as versões do python, não conseguimos colocar a análise de fotos dentro desse programa, porém ela funciona!
Colocaremos o programa de análise em outro código consumindo uma API feita por nós mesmos mostrando os passos
restantes para conclusão desse case de análise, sendo ela a principal funcionalidade desse sistema! Peço desculpas pelo
inconveniente, infelizmente o tempo estava mto escasso e acabamos não conseguindo arranjar uma solução(caso tivesse uma).""")
            case 2:
                lista_quadro_clinico = QUADRO_CLINICO_PREENCHIMENTO()
                INSERT_QUADRO_CLINICO(lista_quadro_clinico, lgi_paciente)
                Select_QC = int(input("Gostaria de visualizar os dados do Quadro clínico? Se sim, digite 1:"))
                if Select_QC == 1:
                    SELECT_QUADRO_CLINICO()
            case 3:
                menu_dados = int(input("""
1 - Dados pessoais;
2 - Dados telefônicos;
3 - Dados de moradia;
4 - Apagar dados.
Resposta:"""))
                match menu_dados:
                    case 1:
                        SELECT_PACIENTE()
                    
                    case 2:
                        SELECT_TELEFONE_PACIENTE()
                    
                    case 3:
                        SELECT_ENDERECO_PACIENTE()
                    
                    case 4:
                        menu_de_delet = int(input("""
1 - Deletar dados clínicos
2 - deletar dados telefônicos
3 - deletar dados de moradia
Resposta:"""))
                        match menu_de_delet:
                            case 1:
                                DELETE_QUADRO_CLINICO()
                            
                            case 2:
                                DELETE_TELEFONE_PACIENTE()
                            
                            case 3:
                                DELETE_ENDERECO_PACIENTE()

        repetir_processo = input("Gostaria de refazer a pesquisa? Se sim, digite 'S':")
    print("-----------------------------------------------------------------------------")
    print("Obrigado por se utilizar de nossos serviços! Até a próxima!")

main()




