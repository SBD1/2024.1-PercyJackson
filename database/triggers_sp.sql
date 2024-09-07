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

