INSERT INTO constante (nome, valor)
VALUES
    ('multiplicadorForca', 2),
    ('baseDefesaPersonagem', 10),
    ('toleranciaNectar', 4);

INSERT INTO regiao (nome, descricao, nivel)
VALUES
    ('Florestas do Norte', 'Uma densa e vasta floresta situada ao norte do acampamento. As árvores altas e a vegetação espessa oferecem um ambiente desafiador para os campistas.', 4);

INSERT INTO area (nome, descricao, regiaoAtual, norte, sul, leste, oeste, temBandeira, desafio)
VALUES
    ('Clareira da Lua Prateada', 'Uma pequena clareira onde a luz da lua brilha intensamente à noite.', 'Florestas do Norte', 30, 0, 0, 60, false, NULL),
    ('O Espelho das Arvores', 'Um lago cristalino que reflete perfeitamente as árvores ao redor.', 'Florestas do Norte', 20, 0, 0, 60, false, NULL),
    ('Storm Cliff', 'Um penhasco alto que oferece uma vista de toda a floresta, mas é perigoso durante tempestades.', 'Florestas do Norte', 10, 0, 0, 60, false, NULL),
    ('Mata Sombria', 'Uma área da floresta onde a luz raramente entra, cheia de perigos.', 'Florestas do Norte', 30, 0, 0, 50, false, NULL),
    ('Gruta das Arvores Ancias', 'Uma gruta escondida cercada por árvores milenares. É um lugar de descanso e meditação, repleto de antigas runas e segredos esquecidos.', 'Florestas do Norte', 20, 0, 0, 50, false, NULL),
    ('Gruta Sombria', 'Uma gruta escura onde a luz do sol raramente entra.', 'Florestas do Norte', 10, 0, 0, 50, false, NULL),
    ('Toca do Lobo', 'Uma caverna escondida onde vivem lobos selvagens.', 'Florestas do Norte', 30, 0, 0, 40, false, NULL),
    ('Wind Stone', 'Uma pedra gigante que emite um som como um uivo quando o vento passa por ela.', 'Florestas do Norte', 20, 0, 0,40, false, NULL),
    ('Campos de Espinhos', 'Um campo vasto coberto de espinhos, onde o solo parece respirar.', 'Florestas do Norte', 10, 0, 0, 40, false, NULL);

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
    ('Natan', 2, 5, 3, 2, 'Atena', 'Storm Cliff'),
    ('Clara', 2, 2, 5, 3, 'Hermes', 'Campos de Espinhos'),
    ('Charles', 3, 2, 2, 5, 'Aries', 'Mata Sombria'),
    ('Paulo', 5, 2, 2, 3, 'Zeus', 'Toca do Lobo');

INSERT INTO inimigoConcreto (nomeConcreto, vidaAtual, inimigo, areaAtual, loot)
VALUES
    ('Ulfa', 10, 'Lobo', 'Clareira da Lua Prateada', 'Nectar'),
    ('Scott', 30, 'Ciclope', 'O Espelho das Arvores', 'Machado do Scott'),
    ('Alecto', 50, 'Harpia', 'Gruta das Arvores Ancias', 'ContraCorrente');

INSERT INTO abate (nomeJogador, nomeInimigo, vitoriaJogador)
VALUES
    ('Natan', 'Lobo', true),
    ('Charles', 'Ciclope', false),
    ('Clara', 'Ciclope', true),
    ('Paulo', 'Harpia', true);

INSERT INTO inventario (jogador, cargaMaxima)
VALUES
    ('Natan', 9),
    ('Charles', 11),
    ('Clara', 9),
    ('Paulo', 15);

INSERT INTO tipoItem (nome, classificacao)
VALUES
    ('Espada de Bronze Celestial', 'Ataque'),
    ('Elmo de Ares', 'Defesa'),
    ('Ambrosia', 'Consumivel'),
    ('Anel de Hermes', 'Magico'),
    ('Machado de Ares', 'Ataque'),
    ('Escudo de Atena', 'Defesa'),
    ('Armadura de Zeus', 'Defesa'),
    ('Cota de Malha de Hefesto', 'Defesa'),
    ('Escudo Mágico de Atena', 'Magico'),
    ('Pingente de Afrodite', 'Magico'),
    ('Bastão de Hécate', 'Magico'),
    ('Néctar', 'Consumivel');

INSERT INTO itemInventario (jogador, item)
VALUES
    ('Natan', 'Espada de Bronze Celestial'),
    ('Clara', 'Anel de Hermes'),
    ('Charles', 'Elmo de Ares'),
    ('Paulo', 'Ambrosia');

-- Ajustar o nome das áreas quando a tabela estiver pronta

INSERT INTO defesa (nome, areaAtual, descricao, peso, modDefesa)
VALUES
    ('Elmo de Ares', 'A1', 'Um elmo pesado e resistente forjado para os guerreiros mais temidos.', 4, 7),
    ('Escudo de Atena', 'A2', 'Escudo abençoado com a sabedoria de Atena.', 5, 10),
    ('Armadura de Zeus', 'A3', 'A armadura reluzente que protege contra os ataques mais poderosos.', 6, 12),
    ('Cota de Malha de Hefesto', 'A4', 'Armadura reforçada com os metais mais resistentes.', 8, 15);

INSERT INTO ataque (nome, areaAtual, descricao, peso, modCombate, modForca)
VALUES
    ('Espada de Bronze Celestial', 'A5', 'Uma espada poderosa forjada para derrotar monstros mitológicos.', 5, 10, 3),
    ('Machado de Ares', 'A6', 'Uma arma brutal usada por guerreiros que seguem Ares.', 7, 15, 5);

INSERT INTO magico (nome, areaAtual, descricao, peso, modCombate, modForca, modDefesa, modAgilidade, modCarga, tempoDeRecarga, tempoAtual)
VALUES
    ('Anel de Hermes', 'A7', 'Um anel encantado que aumenta a velocidade e agilidade.', 1, 4, 2, 2, 5, 3, 10, 5),
    ('Escudo Mágico de Atena', 'A8', 'Um escudo com proteção mágica e bônus de combate.', 3, 7, 0, 10, 2, 5, 8, 8),
    ('Pingente de Afrodite', 'A9', 'Um amuleto que fortalece a defesa e combate, atraindo sorte.', 1, 3, 1, 5, 1, 2, 6, 6),
    ('Bastão de Hécate', 'A10', 'Um bastão poderoso que concede poderes mágicos únicos.', 5, 12, 6, 8, 4, 10, 20, 15);

INSERT INTO consumivel (nome, areaAtual, descricao, peso, vidaRecuperada, areaTeletransporte)
VALUES
    ('Ambrosia', 'A11', 'Comida dos deuses, capaz de curar ferimentos graves.', 1, 50, NULL),
    ('Néctar', 'A12', 'Bebida divina que recupera a energia e vitalidade.', 1, 30, NULL);

INSERT INTO Aliado (nome, descricao, nomeArea)
VALUES
    ('Quíron', 'O centauro e treinador dos heróis.', 'Clareira da Lua Prateada'),
    ('Grover', 'O sátiro e melhor amigo de Percy.', 'O Espelho das Arvores'),
    ('Annabeth', 'Filha de Atena, inteligente e estratégica.', 'Mata Sombria');

INSERT INTO Dialogo (numero, frase, nomeAliado, recompensa)
VALUES
    (1, 'Precisamos de sua ajuda, alguns Lobos estão atrapalhando nossos colegas. Pode derrotar 5 deles por nós?', 'Annabeth', NULL),
    (2, 'Muito obrigada! Tome este item para te ajudar nessa missão.', 'Annabeth', 'Néctar'),
    (3, 'Se continuar com essa atitude, iremos perder esta competição!', 'Annabeth', NULL),
    (1, 'Preciso que você mate uma Harpia que está pertubando o Labirinto', 'Quíron', NULL),
    (1, 'Socorroooo, tem um ciclope solto por ai. Acabe com ele por favooorr', 'Grover', NULL);


INSERT INTO Resposta (numero, numeroDialogo, nomeAliado, frase, numeroDialogoDestino, nomeAliadoDestino)
VALUES
    (1, 1, 'Annabeth', 'Pode deixar comigo!', 2, 'Annabeth'),
    (2, 1, 'Annabeth', 'Eles que se virem com esses Lobos. Tenho uma bandeira para capturar!', 3, 'Annabeth'),
    (1, 1, 'Quíron', 'Pode deixar comigo!', NULL, NULL),
    (1, 1, 'Grover', 'Irei acabar com ele!', NULL, NULL);

INSERT INTO Profecia (numeroDialogo, nomeAliado, nomeInimigo, quantAbate, turnosAMais)
VALUES
    (1, 'Annabeth', 'Lobo', 5, 5),
    (1, 'Quíron', 'Harpia', 1, 15),
    (1, 'Grover', 'Ciclope', 1, 8);

INSERT INTO Adquire (nomeJogador, numeroProfecia, completado)
VALUES
    ('Natan', 1, true),
    ('Clara', 2, false),
    ('Charles', 3, true);