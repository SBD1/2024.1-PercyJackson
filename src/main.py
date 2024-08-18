import time
import psycopg2
from psycopg2 import sql

# Configuração da conexão
connection_string = "dbname='percyJacksonMUD' user='postgres' host='db' password='postgres'"

print("Starting the script...")
time.sleep(5)

try:
    # Conecta ao banco de dados
    print("Connecting to the database...")
    conn = psycopg2.connect(connection_string)
    cursor = conn.cursor()
    print("Connected to the database.")

    # Define jogador
    jogador_nome = 'Clara'

    # Consulta SQL para buscar o deus e a localização do jogador
    query = sql.SQL("""
        SELECT deus, areaAtual
        FROM jogador
        WHERE nome = %s
    """)

    print("Executing the query...")
    cursor.execute(query, (jogador_nome,))
    result = cursor.fetchone()

    if result:
        deus, area_atual = result
        print(f"Jogador: {jogador_nome}")
        print(f"Deus: {deus}")
        print(f"Área Atual: {area_atual}")

        # Consulta SQL para buscar a região e descrição da área atual
        query_area = sql.SQL("""
            SELECT r.nome, r.descricao, a.descricao
            FROM area a
            JOIN regiao r ON a.regiaoAtual = r.nome
            WHERE a.nome = %s
        """)
        
        cursor.execute(query_area, (area_atual,))
        area_result = cursor.fetchone()

        if area_result:
            regiao_nome, regiao_descricao, area_descricao = area_result
            print(f"Região: {regiao_nome}")
            print(f"Descrição da Região: {regiao_descricao}")
            print(f"Descrição da Área: {area_descricao}")
        else:
            print("Área não encontrada.")
    else:
        print(f"Jogador {jogador_nome} não encontrado.")

except Exception as e:
    print(f"An error occurred: {e}")

finally:
    # Fecha a conexão com o banco
    if cursor:
        cursor.close()
    if conn:
        conn.close()
    print("Connection closed.")

print("Script finished.")
