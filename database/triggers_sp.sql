CREATE OR REPLACE FUNCTION validate_area_coordinates() 
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se há conflitos de coordenadas entre norte-sul ou leste-oeste
    IF (NEW.norte > 0 AND NEW.sul > 0) OR 
       (NEW.leste > 0 AND NEW.oeste > 0) THEN
        RAISE EXCEPTION 'Erro: A coordenada não pode ter valores preenchidos para norte e sul ao mesmo tempo ou leste e oeste ao mesmo tempo.';
    END IF;

    -- Verifica se ambas as coordenadas são zero para norte-sul ou leste-oeste
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
