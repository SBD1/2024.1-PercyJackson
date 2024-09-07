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
    fronteira = False

    # Movimentação para o Norte
    if direcao == "norte":
        if sul == 0:  # Jogador está no Norte
            if norte == 30:  # Está na fronteira do Norte
                fronteira = True
                print("\033[31mVocê está na fronteira do mapa ao norte e não pode ir mais nessa direção.\033[0m")
            else:  # Pode mover-se para o Norte
                norte += 10
        elif norte == 0:  # Jogador está no Sul
            if sul == 10:  # Vai mover para o Norte
                sul = 0
                norte = 10
            else:
                sul -= 10  # Mover dentro do Sul

    # Movimentação para o Sul
    elif direcao == "sul":
        if norte == 0:  # Jogador está no Sul
            if sul == 30:  # Está na fronteira do Sul
                fronteira = True
                print("\033[31mVocê está na fronteira do mapa ao sul e não pode ir mais nessa direção.\033[0m")
            else:  # Pode mover-se para o Sul
                sul += 10
        elif sul == 0:  # Jogador está no Norte
            if norte == 10:  # Vai mover para o Sul
                norte = 0
                sul = 10
            else:
                norte -= 10  # Mover dentro do Norte

    # Movimentação para o Leste
    elif direcao == "leste":
        if oeste == 0:  # Jogador está no Leste
            if leste == 90:  # Está na fronteira do Leste
                fronteira = True
                print("\033[31mVocê está na fronteira do mapa ao leste e não pode ir mais nessa direção.\033[0m")
            else:  # Pode mover-se para o Leste
                leste += 10
        elif leste == 0:  # Jogador está no Oeste
            if oeste == 10:  # Vai mover para o Leste
                oeste = 0
                leste = 10
            else:
                oeste -= 10  # Mover dentro do Oeste

    # Movimentação para o Oeste
    elif direcao == "oeste":
        if leste == 0:  # Jogador está no Oeste
            if oeste == 90:  # Está na fronteira do Oeste
                fronteira = True
                print("\033[31mVocê está na fronteira do mapa ao oeste e não pode ir mais nessa direção.\033[0m")
            else:  # Pode mover-se para o Oeste
                oeste += 10
        elif oeste == 0:  # Jogador está no Leste
            if leste == 10:  # Vai mover para o Oeste
                leste = 0
                oeste = 10
            else:
                leste -= 10  # Mover dentro do Leste

    else:
        print("\033[31mDireção inválida.\033[0m")
        return area_atual

    # Buscando a nova área com base nas coordenadas atualizadas
    cursor.execute("""
        SELECT nome, descricao 
        FROM area 
        WHERE norte = %s AND sul = %s AND leste = %s AND oeste = %s
    """, (norte, sul, leste, oeste))
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
