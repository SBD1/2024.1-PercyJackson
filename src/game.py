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

def processar_desafio(conn, cursor, jogador_nome, area, desafio_id):
    print(f"\033[33mVocê encontrou um desafio na área: {area}!\033[0m")

    cursor.execute("""
        SELECT tipo 
        FROM desafio
        WHERE id = %s
    """, (desafio_id,))
    tipo_desafio = cursor.fetchone()

    if not tipo_desafio:
        print("\033[31mErro: Desafio não encontrado.\033[0m")
        return

    cursor.execute("""
        SELECT forca, agilidade, intelecto
        FROM jogador
        WHERE nome = %s
    """, (jogador_nome,))
    atributos_jogador = cursor.fetchone()

    if not atributos_jogador:
        print("\033[31mErro: Jogador não encontrado.\033[0m")
        return

    forca_jogador, agilidade_jogador, intelecto_jogador = atributos_jogador

    if tipo_desafio[0] == 'A':
        print(f"\033[33mOh não! Você caiu em uma armadilha. \033[0m")

        cursor.execute("""
            SELECT descricao, DTForca, DTAgilidade, DTInteligencia, areaTeletransporte 
            FROM armadilha
            WHERE desafio = %s
        """, (desafio_id,))
        armadilha = cursor.fetchone()

        if not armadilha:
            print("\033[31mErro: Armadilha não encontrada.\033[0m")
            return

        descricao, DTForca, DTAgilidade, DTInteligencia, area_teletransporte = armadilha
        print(f"\033[33mDetalhes da armadilha: {descricao}\033[0m")

        if (forca_jogador >= DTForca and
            agilidade_jogador >= DTAgilidade and
            intelecto_jogador >= DTInteligencia):
            print(f"\033[32mParabéns {jogador_nome}, você escapou da armadilha!\033[0m")
        else:
            print(f"\033[31mVocê não conseguiu escapar. Você será teletransportado para {area_teletransporte}.\033[0m")
            cursor.execute("""
                UPDATE jogador
                SET areaAtual = %s
                WHERE nome = %s
            """, (area_teletransporte, jogador_nome))
            conn.commit()

    else:
        print(f"\033[33mOk {jogador_nome}! Você tem uma provação pela frente. \033[0m")

        cursor.execute("""
            SELECT descricao, DTForca, DTAgilidade, DTInteligencia, recompensa 
            FROM provacao
            WHERE desafio = %s
        """, (desafio_id,))
        provacao = cursor.fetchone()

        if not provacao:
            print("\033[31mErro: Provação não encontrada.\033[0m")
            return

        descricao, DTForca, DTAgilidade, DTInteligencia, recompensa = provacao
        print(f"\033[33mDetalhes da provação: {descricao}\033[0m")

        if (forca_jogador >= DTForca and
            agilidade_jogador >= DTAgilidade and
            intelecto_jogador >= DTInteligencia):
            print(f"\033[32mParabéns {jogador_nome}, você superou a provação! Você recebeu a recompensa: {recompensa}.\033[0m")

        else:
            print(f"\033[31mVocê falhou na provação e não receberá a recompensa.\033[0m")

def capturar_bandeira(conn, cursor, jogador_nome, area):
    print(f"\033[33mVocê encontrou uma bandeira na área: {area}!\033[0m")
    # cursor.execute("""
    #     UPDATE area 
    #     SET temBandeira = FALSE 
    #     WHERE nome = %s
    # """, (area,))
    # conn.commit()
    print(f"\033[33mParabéns {jogador_nome}, você venceu o jogo!\033[0m")


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
        SELECT nome, descricao, temBandeira, desafio 
        FROM area 
        WHERE norte = %s AND sul = %s AND leste = %s AND oeste = %s
    """, (norte, sul, leste, oeste))
    nova_area = cursor.fetchone()

    temBandeira = nova_area[2]
    desafio = nova_area[3]

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

    if temBandeira:
        capturar_bandeira(conn, cursor, jogador_nome, nova_area[0])
    
    if desafio:
        processar_desafio(conn, cursor, jogador_nome, nova_area[0], desafio)
    
    return nova_area[0]