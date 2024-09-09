-------------------------------TRIGGERS E SP PARA ÁREA--------------------------------------------------

-- Verifica se as coordenadas de áreas inseridas são válidas
CREATE OR REPLACE FUNCTION validate_area_coordinates() 
RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.norte > 0 AND NEW.sul > 0) OR 
       (NEW.leste > 0 AND NEW.oeste > 0) THEN
        RAISE EXCEPTION 'Erro: A coordenada não pode ter valores preenchidos para norte e sul ao mesmo tempo ou leste e oeste ao mesmo tempo.';
    END IF;

    IF (NEW.norte = 0 AND NEW.sul = 0) OR 
       (NEW.leste = 0 AND NEW.oeste = 0) THEN
        RAISE EXCEPTION 'Erro: A coordenada deve ter um valor Norte ou Sul e um valor Leste ou Oeste';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_area
BEFORE INSERT ON area
FOR EACH ROW
EXECUTE FUNCTION validate_area_coordinates();

CREATE TRIGGER before_update_area
BEFORE UPDATE ON area
FOR EACH ROW
EXECUTE FUNCTION validate_area_coordinates();

CREATE OR REPLACE FUNCTION verificar_tipo_desafio(_idDesafio INT, _tipoEsperado CHAR)
RETURNS BOOLEAN AS $$
DECLARE
    _tipoDesafio CHAR;
BEGIN
    -- Seleciona o tipo do desafio (A para armadilha, P para provação)
    SELECT tipo INTO _tipoDesafio
    FROM desafio
    WHERE id = _idDesafio;

    -- Verifica se o tipo do desafio corresponde ao tipo esperado
    IF _tipoDesafio = _tipoEsperado THEN
        RETURN TRUE;
    ELSE
        RAISE EXCEPTION 'Erro: O desafio com id % é do tipo %, mas o esperado era %', _idDesafio, _tipoDesafio, _tipoEsperado;
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION verificar_armadilha()
RETURNS TRIGGER AS $$
BEGIN
    -- Chama a função verificar_tipo_desafio para garantir que o desafio é do tipo "A"
    PERFORM verificar_tipo_desafio(NEW.desafio, 'A');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verificar_armadilha
BEFORE INSERT ON armadilha
FOR EACH ROW
EXECUTE FUNCTION verificar_armadilha();

CREATE OR REPLACE FUNCTION verificar_provacao()
RETURNS TRIGGER AS $$
BEGIN
    -- Chama a função verificar_tipo_desafio para garantir que o desafio é do tipo "P"
    PERFORM verificar_tipo_desafio(NEW.desafio, 'P');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verificar_provacao
BEFORE INSERT ON provacao
FOR EACH ROW
EXECUTE FUNCTION verificar_provacao();

CREATE FUNCTION criar_jogador(nome VARCHAR(15), deus VARCHAR(15)) RETURNS VOID AS $criarJogador$
DECLARE
    forcaInicialTemp AtributoInicial;
    agilidadeInicialTemp AtributoInicial;
    intelectoInicialTemp AtributoInicial;
    combateInicialTemp AtributoInicial;
BEGIN

    SELECT forcaInicial, agilidadeInicial, intelectoInicial, combateInicial 
    INTO forcaInicialTemp, agilidadeInicialTemp, intelectoInicialTemp, combateInicialTemp
    FROM deus D
    WHERE D.nome = deus;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Deus não encontrado!';
    END IF;

    INSERT INTO tipoPersonagem(nome, tipo)
    VALUES (nome, 'J');

    INSERT INTO Jogador(nome, forca, intelecto, agilidade, combate, deus)
    VALUES (nome, forcaInicialTemp, intelectoInicialTemp, agilidadeInicialTemp, combateInicialTemp, deus);

END;
$criarJogador$ LANGUAGE plpgsql;

CREATE FUNCTION atualizaVidaInimigo() RETURNS TRIGGER AS $atualizaVidaInimigo$
BEGIN
    IF new.vidaatual <= 0 THEN
        new.vidaatual := 0;
        new.areaatual := null;
    END IF;

    RETURN NEW;
END;
$atualizaVidaInimigo$ LANGUAGE plpgsql;

CREATE TRIGGER updateInimigoConcreto
BEFORE UPDATE ON inimigoConcreto
FOR EACH ROW EXECUTE FUNCTION atualizaVidaInimigo();

CREATE FUNCTION atualizaVidaJogador() RETURNS TRIGGER AS $atualizaVidaJogador$
BEGIN
    IF new.vidaatual <= 0 THEN
        new.vidaatual := 1;
    END IF;

    RETURN NEW;
END;
$atualizaVidaJogador$ LANGUAGE plpgsql;

CREATE TRIGGER updateJogador
BEFORE UPDATE ON jogador
FOR EACH ROW EXECUTE FUNCTION atualizaVidaJogador();
-------------------------------TRIGGERS E SP PARA INVENTÁRIO--------------------------------------------------

-- Verifica se o item a ser adicionado cabe no inventário do jogador
CREATE OR REPLACE FUNCTION verificar_carga_inventario(jogador_nome VARCHAR, novo_item_nome VARCHAR)
RETURNS BOOLEAN AS $$
DECLARE
    carga_atual INTEGER := 0;
    carga_maxima INTEGER;
    peso_item INTEGER;
BEGIN
    -- Calcula a carga atual do inventário do jogador
    SELECT COALESCE(SUM(todos_itens.peso), 0)
    INTO carga_atual
    FROM itemInventario ii
    JOIN inventario i ON ii.jogador = i.jogador
    JOIN (
        SELECT nome, peso FROM ataque
        UNION ALL
        SELECT nome, peso FROM defesa
        UNION ALL
        SELECT nome, peso FROM magico
        UNION ALL
        SELECT nome, peso FROM consumivel
    ) AS todos_itens ON todos_itens.nome = ii.item
    WHERE i.jogador = jogador_nome;

    -- Pega a carga máxima do inventário do jogador
    SELECT cargaMaxima
    INTO carga_maxima
    FROM inventario
    WHERE jogador = jogador_nome;

    -- Obtém o peso do novo item que está sendo inserido
    SELECT peso
    INTO peso_item
    FROM (
        SELECT nome, peso FROM ataque
        UNION ALL
        SELECT nome, peso FROM defesa
        UNION ALL
        SELECT nome, peso FROM magico
        UNION ALL
        SELECT nome, peso FROM consumivel
    ) AS todos_itens
    WHERE nome = novo_item_nome;

    -- Verifica se a nova carga ultrapassará a carga máxima permitida
    IF (carga_atual + peso_item) > carga_maxima THEN
        RETURN FALSE; -- Inserção inválida
    ELSE
        RETURN TRUE; -- Inserção válida
    END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION validar_insercao_item_inventario()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se a adição do item ultrapassa a carga máxima
    IF NOT verificar_carga_inventario(NEW.jogador, NEW.item) THEN
        RAISE EXCEPTION 'Carga máxima do inventário excedida para o jogador %.', NEW.jogador;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger associada à tabela itemInventario
CREATE TRIGGER verificar_carga_antes_insercao
BEFORE INSERT ON itemInventario
FOR EACH ROW
EXECUTE FUNCTION validar_insercao_item_inventario();


-- Modifica os pontos de força, agilidade, intelecto e combate do jogador ao pegar um item

CREATE OR REPLACE FUNCTION atualizar_atributos_jogador(jogador_nome VARCHAR, item_nome VARCHAR)
RETURNS VOID AS $$
DECLARE
    -- Variáveis para armazenar os modificadores de atributos dos itens
    mod_forca INTEGER := 0;
    mod_intelecto INTEGER := 0;
    mod_agilidade INTEGER := 0;
    mod_combate INTEGER := 0;
BEGIN
    -- Verificar se o item é de ataque
    SELECT COALESCE(modForca, 0), COALESCE(modCombate, 0)
    INTO mod_forca, mod_combate
    FROM ataque
    WHERE nome = item_nome;

    IF FOUND THEN
        -- Atualizar atributos se for um item de ataque
        UPDATE jogador
        SET
            forca = forca + mod_forca,
            combate = combate + mod_combate
        WHERE nome = jogador_nome;
        RETURN;
    END IF;

    -- Verificar se o item é de defesa
    SELECT COALESCE(modAgilidade, 0)
    INTO mod_agilidade
    FROM defesa
    WHERE nome = item_nome;

    IF FOUND THEN
        -- Atualizar atributos se for um item de defesa
        UPDATE jogador
        SET
            agilidade = agilidade + mod_agilidade
        WHERE nome = jogador_nome;
        RETURN;
    END IF;

    -- Verificar se o item é mágico
    SELECT COALESCE(modForca, 0), COALESCE(modIntelecto, 0), COALESCE(modAgilidade, 0), COALESCE(modCombate, 0)
    INTO mod_forca, mod_intelecto, mod_agilidade, mod_combate
    FROM magico
    WHERE nome = item_nome;

    IF FOUND THEN
        -- Atualizar atributos se for um item mágico
        UPDATE jogador
        SET
            forca = forca + mod_forca,
            intelecto = intelecto + mod_intelecto,
            agilidade = agilidade + mod_agilidade,
            combate = combate + mod_combate
        WHERE nome = jogador_nome;
        RETURN;
    END IF;

    -- Verificar se o item é consumível
    -- Itens consumíveis não modificam atributos, então nenhuma ação é necessária.

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION trigger_atualizar_atributos()
RETURNS TRIGGER AS $$
BEGIN
    -- Chama a função para atualizar os atributos do jogador
    PERFORM atualizar_atributos_jogador(NEW.jogador, NEW.item);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger associada à tabela itemInventario
CREATE TRIGGER atualizar_atributos_apos_insercao
AFTER INSERT ON itemInventario
FOR EACH ROW
EXECUTE FUNCTION trigger_atualizar_atributos();

CREATE OR REPLACE FUNCTION subtrair_atributos_jogador(jogador_nome VARCHAR, item_nome VARCHAR)
RETURNS VOID AS $$
DECLARE
    -- Variáveis para armazenar os modificadores de atributos dos itens
    mod_forca INTEGER := 0;
    mod_intelecto INTEGER := 0;
    mod_agilidade INTEGER := 0;
    mod_combate INTEGER := 0;
BEGIN
    -- Verificar se o item é de ataque
    SELECT COALESCE(modForca, 0), COALESCE(modCombate, 0)
    INTO mod_forca, mod_combate
    FROM ataque
    WHERE nome = item_nome;

    IF FOUND THEN
        -- Subtrair atributos se for um item de ataque
        UPDATE jogador
        SET
            forca = forca - mod_forca,
            combate = combate - mod_combate
        WHERE nome = jogador_nome;
        RETURN;
    END IF;

    -- Verificar se o item é de defesa
    SELECT COALESCE(modAgilidade, 0)
    INTO mod_agilidade
    FROM defesa
    WHERE nome = item_nome;

    IF FOUND THEN
        -- Subtrair atributos se for um item de defesa
        UPDATE jogador
        SET
            agilidade = agilidade - mod_agilidade
        WHERE nome = jogador_nome;
        RETURN;
    END IF;

    -- Verificar se o item é mágico
    SELECT COALESCE(modForca, 0), COALESCE(modIntelecto, 0), COALESCE(modAgilidade, 0), COALESCE(modCombate, 0)
    INTO mod_forca, mod_intelecto, mod_agilidade, mod_combate
    FROM magico
    WHERE nome = item_nome;

    IF FOUND THEN
        -- Subtrair atributos se for um item mágico
        UPDATE jogador
        SET
            forca = forca - mod_forca,
            intelecto = intelecto - mod_intelecto,
            agilidade = agilidade - mod_agilidade,
            combate = combate - mod_combate
        WHERE nome = jogador_nome;
        RETURN;
    END IF;

    -- Verificar se o item é consumível
    -- Itens consumíveis não modificam atributos, então nenhuma ação é necessária.

END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION trigger_subtrair_atributos()
RETURNS TRIGGER AS $$
BEGIN
    -- Chama a função para subtrair os atributos do jogador
    PERFORM subtrair_atributos_jogador(OLD.jogador, OLD.item);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Trigger associada à tabela itemInventario
CREATE TRIGGER subtrair_atributos_apos_remocao
AFTER DELETE ON itemInventario
FOR EACH ROW
EXECUTE FUNCTION trigger_subtrair_atributos();

-- Ao criar um jogador deve ser criado a tabela inventario
CREATE OR REPLACE FUNCTION criar_inventario_jogador()
RETURNS TRIGGER AS $$
DECLARE
    carga_maxima INTEGER;
BEGIN
    -- Calcula a carga máxima com base na força do jogador
    carga_maxima := (2 * NEW.forca) + 5;

    -- Insere o inventário do jogador com a carga máxima calculada
    INSERT INTO inventario (jogador, cargaMaxima)
    VALUES (NEW.nome, carga_maxima);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger associada à tabela jogador para criar o inventário automaticamente
CREATE TRIGGER trigger_criar_inventario
AFTER INSERT ON jogador
FOR EACH ROW
EXECUTE FUNCTION criar_inventario_jogador();


CREATE OR REPLACE FUNCTION atualizar_carga_maxima_inventario()
RETURNS TRIGGER AS $$
DECLARE
    nova_carga_maxima INTEGER;
BEGIN
    -- Recalcula a carga máxima com base na nova força do jogador
    nova_carga_maxima := (2 * NEW.forca) + 5;

    -- Atualiza a carga máxima no inventário do jogador
    UPDATE inventario
    SET cargaMaxima = nova_carga_maxima
    WHERE jogador = NEW.nome;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger associada à tabela jogador para atualizar a carga máxima automaticamente
CREATE TRIGGER trigger_atualizar_carga_maxima
AFTER UPDATE OF forca ON jogador
FOR EACH ROW
EXECUTE FUNCTION atualizar_carga_maxima_inventario();

--------------------INSERE ITEM--------------------------------
CREATE OR REPLACE FUNCTION inserir_item(
    p_nome VARCHAR(30),
    p_classificacao VARCHAR(15),
    p_areaAtual VARCHAR(35),
    p_descricao TEXT,
    p_peso IntPositivo,
    p_modAgilidade IntPositivo DEFAULT NULL,
    p_modCombate IntPositivo DEFAULT NULL,
    p_modForca IntPositivo DEFAULT NULL,
    p_modIntelecto IntPositivo DEFAULT NULL,
    p_modCarga IntPositivo DEFAULT NULL,
    p_tempoDeRecarga IntPositivo DEFAULT NULL,
    p_tempoAtual IntPositivo DEFAULT 0,
    p_vidaRecuperada IntPositivo DEFAULT NULL,
    p_areaTeletransporte VARCHAR(30) DEFAULT NULL
) RETURNS VOID AS $$
DECLARE
    v_count INT;
BEGIN
    -- Verificar se a área especificada existe na tabela 'area' apenas se p_areaAtual não for nulo
    IF p_areaAtual IS NOT NULL THEN
        SELECT COUNT(*) INTO v_count FROM area WHERE nome = p_areaAtual;
        IF v_count = 0 THEN
            RAISE EXCEPTION 'Área inválida: %', p_areaAtual;
        END IF;
    END IF;


    -- Verificar se a classificação é válida
    IF p_classificacao NOT IN ('Defesa', 'Ataque', 'Consumivel', 'Magico') THEN
        RAISE EXCEPTION 'Classificação inválida';
    END IF;

    -- Verificar se o item já existe na tabela tipoItem
    SELECT COUNT(*) INTO v_count FROM tipoItem WHERE nome = p_nome;
    IF v_count > 0 THEN
        RAISE EXCEPTION 'Item com este nome já existe';
    END IF;

    -- Desativar triggers que impedem inserção direta
    PERFORM set_config('session_replication_role', 'replica', true);
    -- Inserir o item na tabela correspondente com base na classificação
    IF p_classificacao = 'Defesa' THEN
        -- Verificar se os dados necessários para a tabela 'defesa' estão presentes
        IF p_modAgilidade IS NULL THEN
            RAISE EXCEPTION 'modAgilidade é necessário para itens de Defesa.';
        END IF;
        -- Inserir o item na tabela tipoItem após validação da classificação
        INSERT INTO tipoItem (nome, classificacao) VALUES (p_nome, p_classificacao);
        -- Inserir na tabela 'defesa'
        INSERT INTO defesa (nome, areaAtual, descricao, peso, modAgilidade)
        VALUES (p_nome, p_areaAtual, p_descricao, p_peso, p_modAgilidade);

    ELSIF p_classificacao = 'Ataque' THEN
        -- Verificar se os dados necessários para a tabela 'ataque' estão presentes
        IF p_modCombate IS NULL OR p_modForca IS NULL THEN
            RAISE EXCEPTION 'modCombate e modForca são necessários para itens de Ataque.';
        END IF;
        -- Inserir o item na tabela tipoItem após validação da classificação
        INSERT INTO tipoItem (nome, classificacao) VALUES (p_nome, p_classificacao);
        -- Inserir na tabela 'ataque'
        INSERT INTO ataque (nome, areaAtual, descricao, peso, modCombate, modForca)
        VALUES (p_nome, p_areaAtual, p_descricao, p_peso, p_modCombate, p_modForca);

    ELSIF p_classificacao = 'Magico' THEN
        -- Verificar se os dados necessários para a tabela 'magico' estão presentes
        IF p_modCombate IS NULL OR p_modForca IS NULL OR p_modIntelecto IS NULL OR p_modAgilidade IS NULL OR p_modCarga IS NULL OR p_tempoDeRecarga IS NULL THEN
            RAISE EXCEPTION 'modCombate, modForca, modIntelecto, modAgilidade, modCarga e tempoDeRecarga são necessários para itens Mágicos.';
        END IF;
        -- Inserir o item na tabela tipoItem após validação da classificação
        INSERT INTO tipoItem (nome, classificacao) VALUES (p_nome, p_classificacao);
        -- Inserir na tabela 'magico'
        INSERT INTO magico (nome, areaAtual, descricao, peso, modCombate, modForca, modIntelecto, modAgilidade, modCarga, tempoDeRecarga, tempoAtual)
        VALUES (p_nome, p_areaAtual, p_descricao, p_peso, p_modCombate, p_modForca, p_modIntelecto, p_modAgilidade, p_modCarga, p_tempoDeRecarga, p_tempoAtual);

    ELSIF p_classificacao = 'Consumivel' THEN
        -- Verificar se os dados necessários para a tabela 'consumivel' estão presentes
        IF p_vidaRecuperada IS NULL THEN
            RAISE EXCEPTION 'vidaRecuperada é necessário para itens Consumíveis.';
        END IF;
        -- Inserir o item na tabela tipoItem após validação da classificação
        INSERT INTO tipoItem (nome, classificacao) VALUES (p_nome, p_classificacao);
        -- Inserir na tabela 'consumivel'
        INSERT INTO consumivel (nome, areaAtual, descricao, peso, vidaRecuperada, areaTeletransporte)
        VALUES (p_nome, p_areaAtual, p_descricao, p_peso, p_vidaRecuperada, p_areaTeletransporte);
    END IF;
    PERFORM set_config('session_replication_role', 'origin', true);

EXCEPTION
    WHEN OTHERS THEN
        -- Rollback implícito se ocorrer algum erro
        RAISE;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bloquear_insercao_direta() RETURNS TRIGGER AS $$
BEGIN
    RAISE EXCEPTION 'Inserções diretas não são permitidas. Use a função inserir_item().';
END;
$$ LANGUAGE plpgsql;

-- Criar triggers para cada tabela específica
CREATE TRIGGER trg_defesa
BEFORE INSERT ON defesa
FOR EACH ROW
EXECUTE FUNCTION bloquear_insercao_direta();

CREATE TRIGGER trg_ataque
BEFORE INSERT ON ataque
FOR EACH ROW
EXECUTE FUNCTION bloquear_insercao_direta();

CREATE TRIGGER trg_magico
BEFORE INSERT ON magico
FOR EACH ROW
EXECUTE FUNCTION bloquear_insercao_direta();

CREATE TRIGGER trg_consumivel
BEFORE INSERT ON consumivel
FOR EACH ROW
EXECUTE FUNCTION bloquear_insercao_direta();

CREATE TRIGGER trg_tipoItem
BEFORE INSERT ON tipoItem
FOR EACH ROW
EXECUTE FUNCTION bloquear_insercao_direta();

