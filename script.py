import os
import random

import psycopg2
from dotenv import load_dotenv
from faker import Faker

# Carregar as variáveis de ambiente do arquivo .env
load_dotenv()

# Configuração da conexão com o banco de dados PostgreSQL
conn = psycopg2.connect(
    dbname=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT"),
)
cursor = conn.cursor()

# Instanciando o Faker
fake = Faker("pt_BR")


# Função para gerar dados e inserir na tabela
def populate_table(num_records):
    for _ in range(num_records):
        rg_num = fake.random_int(min=10000000, max=99999999)
        rg_estado = fake.state_abbr()
        pnome = fake.first_name()
        snome = fake.last_name()
        sexo = random.choice(["M", "F"])
        salario = round(random.uniform(3000.00, 20000.00), 2)
        data_nascimento = fake.date_of_birth(minimum_age=18, maximum_age=65)

        cursor.execute(
            """
            INSERT INTO empresa.empregado (rg_num, rg_estado, pnome, snome, salario, sexo, data_nascimento) 
            VALUES (%s,%s,%s,%s,%s, %s,%s)
        """,
            (
                rg_num,
                rg_estado,
                pnome,
                snome,
                salario,
                sexo,
                data_nascimento,
            ),
        )

    conn.commit()


# Populando a tabela com 100 registros
populate_table(100)

# Fechando a conexão
cursor.close()
conn.close()
