import time
from databaseConection import connect_to_db, close_connection
from game import criar_jogador, apresentar_jogo, obter_area_atual, mover_jogador, pegar_item_area, conversar_com_aliado
from psycopg2 import sql

def start_game():
    try:
        conn, cursor = connect_to_db()

        apresentar_jogo()
        
        jogador_nome = criar_jogador(cursor, conn)
        area_atual = obter_area_atual(cursor, jogador_nome)

        query_area = sql.SQL("""
            SELECT r.nome, r.descricao, a.nome, a.descricao
            FROM area a
            JOIN regiao r ON a.regiaoAtual = r.nome
            WHERE a.nome = %s
        """)

        cursor.execute(query_area, (area_atual,))
        area_result = cursor.fetchone()

        if area_result:
            regiao_nome, regiao_descricao, area_nome, area_descricao = area_result
            print(f"\033[43mSua localização\033[0m")
            print(f"\033[32mRegião: {regiao_nome}\033[0m")
            print(f"\033[32mDescrição da Região: {regiao_descricao}\033[0m")
            print(f"\033[32mÁrea: {area_nome}\033[0m")
            print(f"\033[32mDescrição da Área: {area_descricao}\033[0m")
        else:
            print("\033[31mÁrea não encontrada.\033[0m")

        # Chamar a função para pegar itens disponíveis na área atual
        pegar_item_area(conn, cursor, jogador_nome)

        conversar_com_aliado(conn, cursor, area_nome, jogador_nome)
        

        while True:
            comando = input("\nDigite a direção para onde deseja se mover (norte, sul, leste, oeste) ou 'sair' para encerrar: ").lower()

            if comando == "sair":
                print("\033[34mEncerrando o jogo...\033[0m")
                break
            elif comando in ["norte", "sul", "leste", "oeste"]:
                # Mover o jogador para a nova área
                area_atual = mover_jogador(conn, cursor, jogador_nome, area_atual, comando)

                # Após mover, verificar se há itens na nova área
                pegar_item_area(conn, cursor, jogador_nome)

                conversar_com_aliado(conn, cursor, area_atual, jogador_nome)
            else:
                print("\033[31mComando inválido. Tente novamente.\033[0m")

    except Exception as e:
        print(f"An error occurred: {e}")

    finally:
        # Fechar a conexão com o banco de dados
        close_connection(conn, cursor)
        print("Script finished.")
