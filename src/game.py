import time
from psycopg2 import sql, DatabaseError
from utils import limpar_terminal
import random

def criar_jogador(cursor, conn):
    cursor.execute("""
        SELECT nome
        FROM deus
    """)
    result = cursor.fetchall()
    print("Escolha o seu pai/mãe divino(a)")
    for indice, deus in enumerate(result):
        print(f"{indice} - {deus[0]}")
    
    while True:
        try:
            numDeus = int(input("Digite o número correspondente ao Deus/Deusa: "))

            if 0 <= numDeus < len(result):
                break
            else: 
                print("Deus/Deusa inexistente!")
        except ValueError:
            print("Entrada inválida. Digite um número.")
    
    while True:
        try:
            nomeJogador = input("Digite o nome do seu Personagem: ")
            cursor.execute("""
                SELECT criar_jogador(%s, %s)
            """, (nomeJogador, result[numDeus][0]))

            conn.commit()
            print("\033[4;32mPersonagem criado com sucesso!\033[0m")
            break
        except (Exception, DatabaseError) as error:
            print("Esse nome não está disponível. Tente outro")
            conn.rollback()
    
    return nomeJogador

def enfrentar_inimigo(cursor, areaAtual, nomeJogador):
    cursor.execute("""
        SELECT *
        FROM inimigoConcreto
        WHERE areaAtual = %s
    """, (areaAtual,))
    inimigoConcreto = cursor.fetchone()
    if inimigoConcreto:
        print(f"\033[4;31mInimigo encontrado. Prepare-se para enfrentrar {inimigoConcreto[0]}\033[0m")
        vidaAtualInimigo = inimigoConcreto[1]
        cursor.execute("""
            SELECT forca, intelecto, agilidade, combate
            FROM inimigo
            WHERE nome = %s
        """, (inimigoConcreto[2],))
        inimigo = cursor.fetchone()

        cursor.execute("""
            SELECT vidaAtual, forca, intelecto, agilidade, combate
            FROM jogador
            WHERE nome = %s
        """, (nomeJogador,))
        jogador = cursor.fetchone()
        vidaAtualJogador = jogador[0]

        cursor.execute("""
            SELECT valor
            FROM constante
            WHERE nome = 'baseDefesaPersonagem'
        """)
        defesaBase = cursor.fetchone()

        while True:
            comando = input("Digite o que você deseja fazer (atacar, fugir, confundir): ")

            if comando == 'atacar': 
                dadoAtaque = random.randint(1, 20)
                if dadoAtaque + jogador[4] > defesaBase[0] + inimigo[2]:
                    print(f"\033[4;32mVocê acertou o Ataque! {inimigoConcreto[0]} levou {jogador[1]} de dano\033[0m")
                    cursor.execute("""
                        UPDATE inimigoConcreto
                        SET vidaAtual = vidaAtual - %s
                        WHERE nomeConcreto = %s
                    """, (jogador[1], inimigoConcreto[0],))

                    vidaAtualInimigo = vidaAtualInimigo - jogador[1]
                    if vidaAtualInimigo <= 0:
                        print('\033[4;32mVocê derrotou o inimigo, combate encerrado!\033[0m')
                        break
                else:
                    print('\033[4;31mVocê errou o Ataque!\033[0m')
            elif comando == 'fugir':
                dadoAgilidadeJogador = random.randint(1, 20)
                dadoAgilidadeInimigo = random.randint(1, 20)

                if dadoAgilidadeJogador + jogador[3] > dadoAgilidadeInimigo + inimigo[2]:
                    print('\033[4;32mVocê conseguiu escapar! Combate finalizado\033[0m')
                    break
                else:
                    print('\033[4;31mO inimigo foi mais rápido e te alcançou. Prepare-se para continuar na luta\033[0m')
            elif comando == 'confundir':
                dadoIntelectoJogador = random.randint(1, 20)
                dadoIntelectoInimigo = random.randint(1, 20)

                if dadoIntelectoJogador + jogador[2] > dadoIntelectoInimigo + inimigo[1]:
                    print('\033[4;32mVocê confundiu o inimigo com uma conta de matemática e conseguiu escapar! Combate finalizado\033[0m')
                    break
                else:
                    print('\033[4;31mO inimigo ignorou a sua pergunta. Prepare-se para continuar na luta\033[0m')
            else:
                print('Comando inválido. Tente outro')
            
            if comando in ["atacar", "fugir", "confundir"]:
                dadoAtaqueInimigo = random.randint(1, 20)
                if dadoAtaqueInimigo + inimigo[3] > defesaBase[0] + jogador[3]:
                    print(f"\033[4;31mO inimigo acertou o Ataque! Você levou {inimigo[0]} de dano!\033[0m")

                    cursor.execute("""
                        UPDATE jogador
                        SET vidaAtual = vidaAtual - %s
                        WHERE nome = %s
                    """, (inimigo[0], nomeJogador,))
                    vidaAtualJogador = vidaAtualJogador - inimigo[0]
                    if vidaAtualJogador <= 0:
                        print('\033[4;31mO inimigo te derrotou! Você conseguiu escapar por um fio e se escondeu. Combate encerrado!\033[0m')
                        break
                else:
                    print('\033[4;32mO inimigo errou o Ataque!\033[0m')
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

            print(f"\033[43mNova localização\033[0m")
            exibir_informacoes_area(cursor, area_teletransporte)

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
            
            cursor.execute("""
                INSERT INTO itemInventario (jogador, item)
                VALUES (%s, %s)
            """, (jogador_nome, recompensa))
            conn.commit()

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
    
    enfrentar_inimigo(cursor, nova_area[0], jogador_nome)
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
