import time
import psycopg2
from psycopg2 import sql

# Configuração da conexão
connection_string = "dbname='percyJacksonMUD' user='postgres' host='db' password='postgres'"

print("Starting the script...")
time.sleep(5)

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

def mover_jogadora(conn, cursor, jogador_nome, area_atual, direcao):
    # Consultando as coordenadas atuais da área
    cursor.execute("""
        SELECT norte, sul, leste, oeste 
        FROM area 
        WHERE nome = %s
    """, (area_atual,))
    area_info = cursor.fetchone()

    if not area_info:
        print("Área atual não encontrada.")
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
        print("Você está no limite do mapa e não pode ir mais nessa direção.")
        return area_atual

    # Buscando a nova área com base nas coordenadas
    cursor.execute("""
        SELECT nome, descricao 
        FROM area 
        WHERE norte = %s AND oeste = %s
    """, (norte, oeste))
    nova_area = cursor.fetchone()

    if not nova_area:
        print("Não foi possível encontrar uma nova área nas coordenadas indicadas.")
        return area_atual

    # Atualizando a área atual no banco de dados
    cursor.execute("""
        UPDATE jogador 
        SET areaAtual = %s 
        WHERE nome = %s
    """, (nova_area[0], jogador_nome))
    conn.commit()

    print(f"Você se moveu para a nova área: {nova_area[0]} - {nova_area[1]}\n")
    return nova_area[0]

try:
    # Conecta ao banco de dados
    print("Connecting to the database...")
    conn = psycopg2.connect(connection_string)
    cursor = conn.cursor()
    print("Connected to the database.")

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
        print(f"Região: {regiao_nome}")
        print(f"Descrição da Região: {regiao_descricao}")
        print(f"Descrição da Área: {area_descricao}")
    else:
        print("Área não encontrada.")

    # Loop principal para comandos de movimento
    while True:
        comando = input("Digite a direção para onde deseja se mover (norte, sul, leste, oeste) ou 'sair' para encerrar: ").lower()

        if comando == "sair":
            print("Encerrando o jogo...")
            break
        elif comando in ["norte", "sul", "leste", "oeste"]:
            area_atual = mover_jogadora(conn, cursor, jogador_nome, area_atual, comando)
        else:
            print("Comando inválido. Tente novamente.")

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
