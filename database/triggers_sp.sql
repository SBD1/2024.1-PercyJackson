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
