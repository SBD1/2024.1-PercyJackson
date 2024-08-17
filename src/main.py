import time
from config.database import Database
from sqlalchemy import text

print("Starting the script...")
time.sleep(5)

# Define a string de conexão com o banco de dados
connection_string = "postgresql+psycopg2://postgres:postgres@db:5432/percyJacksonMUD"

# Instancia a classe Database
db = Database(connection_string)

try:
    # Conecta ao banco de dados
    db.connect()

    nome = input("Por favor, insira seu nome: ")

    print(f"Olá, {nome}! Seja bem vindo!")

except Exception as e:
    print(f"An error occurred: {e}")

finally:
    # Fecha a conexão com o banco
    db.close_connection()

print("Script finished.")
