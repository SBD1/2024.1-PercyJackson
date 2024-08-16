INSERT INTO nivel (id, pontosExperiencia)
VALUES
    (1, 0),
    (2, 10),
    (3, 25),
    (4, 60),
    (5, 100);

INSERT INTO deus (nome, forcaInicial, intelectoInicial, agilidadeInicial, combateInicial)
VALUES
    ('Zeus', 5, 2, 2, 3),
    ('Atena', 2, 5, 3, 2),
    ('Hermes', 2, 2, 5, 3),
    ('Aries', 3, 2, 2, 5);

INSERT INTO tipoPersonagem (nome, tipo)
VALUES
    ('Lobo', 'I'),
    ('Ciclope', 'I'),
    ('Harpia', 'I'),
    ('Natan', 'J'),
    ('Clara', 'J'),
    ('Charles', 'J'),
    ('Paulo', 'J');

INSERT INTO inimigo (nome, vidaMax, forca, intelecto, agilidade, combate, pontosExperiencia, nivel)
VALUES 
    ('Lobo', 10, 3, 0, 4, 4, 2, 1),
    ('Ciclope', 30, 5, 1, 2, 4, 10, 3),
    ('Harpia', 50, 5, 5, 5, 5, 30, 4);

INSERT INTO jogador (nome, forca, intelecto, agilidade, combate, deus, areaAtual)
VALUES
    ('Natan', 2, 5, 3, 2, 'Atena', 'Acampamento'),
    ('Clara', 2, 2, 5, 3, 'Hermes', 'Acampamento'),
    ('Charles', 3, 2, 2, 5, 'Aries', 'Acampamento'),
    ('Paulo', 5, 2, 2, 3, 'Zeus', 'Acampamento');

INSERT INTO inimigoConcreto (nomeConcreto, vidaAtual, inimigo, areaAtual, loot)
VALUES
    ('Ulfa', 10, 'Lobo', 'Floresta', 'Nectar'),
    ('Scott', 30, 'Ciclope', 'Labirinto', 'Machado do Scott'),
    ('Alecto', 50, 'Harpia', 'Punho de Zeus', 'ContraCorrente');

INSERT INTO abate (nomeJogador, nomeInimigo, resultado)
VALUES
    ('Natan', 'Lobo', 'true'),
    ('Charles', 'Ciclope', 'false'),
    ('Clara', 'Ciclope', 'true'),
    ('Paulo', 'Harpia', 'true');