import time
from psycopg2 import sql
from utils import limpar_terminal

def apresentar_jogo():
    print("\033[34mBem-vindo ao RPG Percy Jackson!\033[0m")
    time.sleep(2)
    print("\033[34mPrepare-se para explorar o Acampamento Meio-Sangue e encontrar a bandeira!\033[0m")
    time.sleep(3)
    print("\033[34mA jornada está prestes a começar!\033[0m")
    time.sleep(2)
    limpar_terminal()

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

    cursor.execute("""
        SELECT nome, descricao 
        FROM area 
        WHERE norte = %s AND oeste = %s
    """, (norte, oeste))
    nova_area = cursor.fetchone()

    if not nova_area:
        print("\033[31mNão foi possível encontrar uma nova área nas coordenadas indicadas.\033[0m")
        return area_atual

    cursor.execute("""
        UPDATE jogador 
        SET areaAtual = %s 
        WHERE nome = %s
    """, (nova_area[0], jogador_nome))
    conn.commit()

    nova_regiao = obter_regiao(cursor, nova_area[0])

    print(f"\n\033[43mNova localização\033[0m")
    print(f"\033[32mVocê se moveu para a nova área: {nova_area[0]} - {nova_area[1]}\033[0m")
    if nova_regiao:
        print(f"\033[32mRegião: {nova_regiao[0]} - {nova_regiao[1]}\033[0m\n")

    return nova_area[0]
