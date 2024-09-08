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
DROP TRIGGER IF EXISTS verificar_carga_antes_insercao ON itemInventario;
DROP TRIGGER IF EXISTS atualizar_atributos_apos_insercao ON itemInventario;
DROP FUNCTION IF EXISTS verificar_carga_inventario(VARCHAR, VARCHAR);
DROP FUNCTION IF EXISTS validar_insercao_item_inventario();
DROP FUNCTION IF EXISTS atualizar_atributos_jogador(VARCHAR, VARCHAR);
DROP FUNCTION IF EXISTS trigger_atualizar_atributos();

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