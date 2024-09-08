import time
from psycopg2 import sql
from utils import limpar_terminal

def apresentar_jogo():
    limpar_terminal()
    print("\033[34mBem-vindo ao RPG Percy Jackson!\033[0m")
    time.sleep(2)
    print("\033[34mPrepare-se para explorar o Acampamento Meio-Sangue e encontrar a bandeira!\033[0m")
    time.sleep(3)
    print("\033[34mA jornada está prestes a começar!\033[0m\n\n")
    time.sleep(2)

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

def exibir_informacoes_area(cursor, area_nome):
    regiao_info = obter_regiao(cursor, area_nome)
    
    if regiao_info:
        regiao_nome, regiao_descricao = regiao_info
    else:
        print("\033[31mInformações da região não encontradas.\033[0m")
        return

    # Consulta SQL para obter as informações da área
    cursor.execute("""
        SELECT nome, descricao 
        FROM area 
        WHERE nome = %s
    """, (area_nome,))
    area_info = cursor.fetchone()

    if area_info:
        area_nome, area_descricao = area_info
        print(f"\033[32mRegião: {regiao_nome}\033[0m")
        print(f"\033[32mDescrição: {regiao_descricao}\033[0m")
        print(f"\033[32mÁrea: {area_nome}\033[0m")
        print(f"\033[32mDescrição: {area_descricao}\033[0m\n")
    else:
        print("\033[31mInformações da área não encontradas.\033[0m")


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
    fronteira = False  # Flag para verificar se o jogador está na fronteira

    # Movimentação para o Norte
    if direcao == "norte":
        if sul == 0:  # Jogador está no Norte
            if norte == 30:  # Está na fronteira do Norte
                print("\033[31mVocê está na fronteira do mapa ao norte e não pode ir mais nessa direção.\033[0m")
                fronteira = True
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
                print("\033[31mVocê está na fronteira do mapa ao sul e não pode ir mais nessa direção.\033[0m")
                fronteira = True
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
                print("\033[31mVocê está na fronteira do mapa ao leste e não pode ir mais nessa direção.\033[0m")
                fronteira = True
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
                print("\033[31mVocê está na fronteira do mapa ao oeste e não pode ir mais nessa direção.\033[0m")
                fronteira = True
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

    # Se o jogador estiver na fronteira, exibe a localização atual e retorna
    if fronteira:
        print(f"\033[43mLocalização atual\033[0m")
        print(f"\033[32mVocê continua na área: {area_atual}\033[0m")
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
    print(f"\033[43mNova localização\033[0m")
    exibir_informacoes_area(cursor, nova_area[0])

    return nova_area[0]

def pegar_item_area(conn, cursor, jogador_nome):
    try:
        # Obter a área atual do jogador
        cursor.execute("""
            SELECT areaAtual
            FROM jogador
            WHERE nome = %s
        """, (jogador_nome,))
        area_atual = cursor.fetchone()

        if not area_atual:
            print(f"\033[31mJogador {jogador_nome} não encontrado ou área atual inválida.\033[0m")
            return

        area_atual = area_atual[0]

        # Listar itens disponíveis na área atual em todas as tabelas específicas de itens
        cursor.execute("""
            SELECT nome, 'Defesa' AS classificacao FROM defesa WHERE areaAtual = %s
            UNION ALL
            SELECT nome, 'Ataque' AS classificacao FROM ataque WHERE areaAtual = %s
            UNION ALL
            SELECT nome, 'Magico' AS classificacao FROM magico WHERE areaAtual = %s
            UNION ALL
            SELECT nome, 'Consumivel' AS classificacao FROM consumivel WHERE areaAtual = %s
        """, (area_atual, area_atual, area_atual, area_atual))
        itens_disponiveis = cursor.fetchall()

        if not itens_disponiveis:
            print("\033[33mNenhum item disponível nesta área.\033[0m")
            return

        print(f"\033[32mItens disponíveis na área {area_atual}:\033[0m")
        for item in itens_disponiveis:
            item_nome, classificacao = item
            print(f"- {item_nome} ({classificacao})")

            # Perguntar ao usuário se deseja pegar o item
            pegar = input(f"Deseja pegar o item '{item_nome}'? (s/n): ").lower()
            if pegar != 's':
                print(f"\033[33mVocê decidiu não pegar o item {item_nome}.\033[0m")
                continue  # Vai para o próximo item

            try:
                # Tentar adicionar o item ao inventário do jogador
                cursor.execute("""
                    INSERT INTO itemInventario (jogador, item)
                    VALUES (%s, %s)
                """, (jogador_nome, item_nome))
                conn.commit()

                print(f"\033[32mItem {item_nome} adicionado ao inventário de {jogador_nome}.\033[0m")

                # Remover o item da área na tabela correspondente
                if classificacao == 'Defesa':
                    cursor.execute("UPDATE defesa SET areaAtual = NULL WHERE nome = %s", (item_nome,))
                elif classificacao == 'Ataque':
                    cursor.execute("UPDATE ataque SET areaAtual = NULL WHERE nome = %s", (item_nome,))
                elif classificacao == 'Magico':
                    cursor.execute("UPDATE magico SET areaAtual = NULL WHERE nome = %s", (item_nome,))
                elif classificacao == 'Consumivel':
                    cursor.execute("UPDATE consumivel SET areaAtual = NULL WHERE nome = %s", (item_nome,))
                conn.commit()
                print(f"\033[32mItem {item_nome} removido da área {area_atual}.\033[0m")
                
            except Exception as e:
                print(f"\033[31mErro ao adicionar o item {item_nome} ao inventário: {e}\033[0m")

    except Exception as e:
        print(f"\033[31mErro ao tentar pegar o item: {e}\033[0m")
