import time
import psycopg2
from psycopg2 import sql
import os

# Configuração da conexão
connection_string = "dbname='percyJacksonMUD' user='postgres' host='db' password='postgres'"

def limpar_terminal():
    if os.name == 'nt':
        os.system('cls')
    else:
        os.system('clear')

def obter_area_atual(cursor, jogador_nome):
    cursor.execute("""
        SELECT areaAtual
        FROM jogador
        WHERE nome = %s
    """, (jogador_nome,))
    result = cursor.fetchone()
    if result:
        return result[0]
    else:
        raise Exception(f"Jogador {jogador_nome} não encontrado.")

def obter_regiao(cursor, area_nome):
    cursor.execute("""
        SELECT r.nome, r.descricao 
        FROM area a
        JOIN regiao r ON a.regiaoAtual = r.nome
        WHERE a.nome = %s
    """, (area_nome,))
    return cursor.fetchone()

def mover_jogador(conn, cursor, jogador_nome, area_atual, direcao):
    # Consultando as coordenadas atuais da área
    cursor.execute("""
        SELECT norte, sul, leste, oeste 
        FROM area 
        WHERE nome = %s
    """, (area_atual,))
    area_info = cursor.fetchone()

    if not area_info:
        print("\033[31mÁrea atual não encontrada.\033[0m")
        return area_atual

    norte, sul, leste, oeste = area_info

    # Definindo novas coordenadas
    if direcao == "norte" and norte < 30:
        norte += 10
        sul = 0
    elif direcao == "sul" and norte > 10:
        norte -= 10
        sul = 0
    elif direcao == "leste" and oeste > 40:
        oeste -= 10
        leste = 0
    elif direcao == "oeste" and oeste < 60:
        oeste += 10
        leste = 0
    else:
        print("\033[31mVocê está no limite do mapa e não pode ir mais nessa direção.\033[0m")
        return area_atual

    # Buscando a nova área com base nas coordenadas
    cursor.execute("""
        SELECT nome, descricao 
        FROM area 
        WHERE norte = %s AND oeste = %s
    """, (norte, oeste))
    nova_area = cursor.fetchone()

    if not nova_area:
        print("\033[31mNão foi possível encontrar uma nova área nas coordenadas indicadas.\033[0m")
        return area_atual

    # Atualizando a área atual no banco de dados
    cursor.execute("""
        UPDATE jogador 
        SET areaAtual = %s 
        WHERE nome = %s
    """, (nova_area[0], jogador_nome))
    conn.commit()

    # Obter a nova região
    nova_regiao = obter_regiao(cursor, nova_area[0])

    print(f"\n\033[43mNova localização\033[0m")
    print(f"\033[32mVocê se moveu para a nova área: {nova_area[0]} - {nova_area[1]}\033[0m")
    if nova_regiao:
        print(f"\033[32mRegião: {nova_regiao[0]} - {nova_regiao[1]}\033[0m\n")

    return nova_area[0]

def apresentar_jogo():
    print("\033[34mBem-vindo ao RPG Percy Jackson!\033[0m")
    time.sleep(2)
    print("\033[34mPrepare-se para explorar o Acampamento Meio-Sangue e encontrar a bandeira!\033[0m")
    time.sleep(3)
    print("\033[34mA jornada está prestes a começar!\033[0m")
    time.sleep(2)
    limpar_terminal()

print("Starting the script...")
time.sleep(5)

try:
    # Conecta ao banco de dados
    print("Connecting to the database...")
    conn = psycopg2.connect(connection_string)
    cursor = conn.cursor()
    print("Connected to the database.")
    time.sleep(1)
    limpar_terminal()

    apresentar_jogo()

    # Define jogador
    jogador_nome = 'Clara'

    # Obtendo a área atual
    area_atual = obter_area_atual(cursor, jogador_nome)

    # Consulta SQL para buscar o deus e a descrição da área atual
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
        print(f"\033[43mSua localização\033[0m")
        print(f"\033[32mRegião: {regiao_nome}\033[0m")
        print(f"\033[32mDescrição da Região: {regiao_descricao}\033[0m")
        print(f"\033[32mDescrição da Área: {area_descricao}\033[0m")
    else:
        print("\033[31mÁrea não encontrada.\033[0m")

    # Loop principal para comandos de movimento
    while True:
        comando = input("\nDigite a direção para onde deseja se mover (norte, sul, leste, oeste) ou 'sair' para encerrar: ").lower()

        if comando == "sair":
            print("\033[34mEncerrando o jogo...\033[0m")
            break
        elif comando in ["norte", "sul", "leste", "oeste"]:
            area_atual = mover_jogador(conn, cursor, jogador_nome, area_atual, comando)
        else:
            print("\033[31mComando inválido. Tente novamente.\033[0m")

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
