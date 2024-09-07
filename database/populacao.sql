INSERT INTO constante (nome, valor)
VALUES
    ('multiplicadorForca', 2),
    ('baseDefesaPersonagem', 10),
    ('toleranciaNectar', 4);

INSERT INTO desafio (tipo)
VALUES
    ('A'),
    ('P'),
    ('A'),
    ('P'),
    ('A'),
    ('P');

INSERT INTO regiao (nome, descricao, nivel)
VALUES
    ('Florestas do Norte', 'Uma densa e vasta floresta situada ao norte do acampamento. As árvores altas e a vegetação espessa oferecem um ambiente desafiador para os campistas.', 4),
    ('Punho de Zeus', 'Uma região marcada pela presença de ventos fortes, trovões e locais sagrados que fazem referência ao deus Zeus.', 5),
    ('Praia dos Fogos de Artifício', 'Uma praia conhecida por seus espetáculos de fogos de artifício e atividades aquáticas.', 3),
    ('Bosque das Ninfas e dos Sátiros', 'Um bosque mágico onde ninfas e sátiros se reúnem para festividades e treinamento.', 4),
    ('Florestas do Sul', 'Uma floresta densa e misteriosa onde criaturas mágicas habitam.', 5),
    ('Lago de Canoagem', 'Um lago sereno usado para competições e treinos de canoagem.', 3),
    ('Toca dos Myrmekes', 'Uma região subterrânea perigosa, habitada por Myrmekes, formigas gigantes que protegem seus tesouros com ferocidade.', 6),
    ('Bosque de Dodona', 'Um bosque antigo onde árvores sagradas sussurram segredos e profecias.', 2),
    ('Colina', 'Uma região elevada com uma vista panorâmica e áreas dedicadas a treinamento e meditação.', 1),
    ('Riacho de Zéfiro', 'Um riacho mágico que corta a floresta, habitado por criaturas aquáticas e cercado por mistérios.', 3),
    ('Gêiseres', 'Uma área geotérmica cheia de gêiseres e atividades vulcânicas.', 5),
    ('Destroços de Antigos Autômatos', 'Uma área cheia de restos e relíquias de antigos autômatos, ideal para aqueles que estudam engenharia e reparação.', 4);

-- População da região Florestas do Norte
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

-- População da região Punho de Zeus
INSERT INTO area (nome, descricao, regiaoAtual, norte, sul, leste, oeste, temBandeira, desafio)
VALUES
    ('Garganta dos Ventos', 'Um desfiladeiro onde ventos fortes nunca cessam.', 'Punho de Zeus', 30, 0, 0, 90, false, NULL),
    ('Caverna das Vozes', 'Uma caverna onde ecos misteriosos são ouvidos o tempo todo.', 'Punho de Zeus', 30, 0, 0, 80, false, NULL),
    ('Caverna dos Espíritos', 'Uma caverna escura onde os espíritos dos antigos heróis se reúnem. Os campistas podem vir aqui para buscar conselhos e bênçãos.', 'Punho de Zeus', 30, 0, 0, 70, false, NULL),
    ('Escarpas do Relâmpago', 'Paredões íngremes que parecem atrair relâmpagos durante tempestades.', 'Punho de Zeus', 20, 0, 0, 90, false, NULL),
    ('Trilha dos Gigantes', 'Um caminho marcado por pegadas gigantes nas rochas.', 'Punho de Zeus', 20, 0, 0, 80, false, NULL),
    ('Solo Elétrico', 'Local onde os relâmpagos de Zeus frequentemente atingem o solo, criando um ambiente eletricamente carregado e perigoso.', 'Punho de Zeus', 20, 0, 0, 70, false, NULL),
    ('Pedra do Sacrifício', 'Uma rocha plana onde antigos rituais eram realizados.', 'Punho de Zeus', 10, 0, 0, 90, false, NULL),
    ('Cume do Punho', 'O ponto mais alto da região, com vista para todo o território.', 'Punho de Zeus', 10, 0, 0, 80, false, NULL),
    ('Mirante dos Trovões', 'Um ponto alto onde os trovões são frequentes e intensos.', 'Punho de Zeus', 10, 0, 0, 70, false, NULL);

-- População da região Praia dos Fogos de Artifício
INSERT INTO area (nome, descricao, regiaoAtual, norte, sul, leste, oeste, temBandeira, desafio)
VALUES
    ('Mar Sul Oeste', 'Mar localizado a oeste da praia', 'Praia dos Fogos de Artifício', 30, 0, 0, 30, false, NULL),
    ('Mar Sul', 'Mar', 'Praia dos Fogos de Artifício', 30, 0, 0, 20, false, NULL),
    ('Mar Sul Leste', 'Mar localizado a leste da praia', 'Praia dos Fogos de Artifício', 30, 0, 0, 10, false, NULL),
    ('Área de Mergulho Oeste', 'Seção do mar onde se pode mergulhar e explorar vida marinha.', 'Praia dos Fogos de Artifício', 20, 0, 0, 30, false, NULL),
    ('Praia dos Fogos', 'Área principal onde ocorrem os fogos de artifício.', 'Praia dos Fogos de Artifício', 20, 0, 0, 20, false, NULL),
    ('Área de Mergulho Leste', 'Seção do mar onde se pode mergulhar e explorar vida marinha.', 'Praia dos Fogos de Artifício', 20, 0, 0, 10, false, NULL),
    ('Mirante', 'Mirante onde fogos de artifício e espetáculos são exibidos.', 'Praia dos Fogos de Artifício', 10, 0, 0, 30, false, NULL),
    ('Altar de Poseidon', 'Altar reservado a ofertas para Poseidon', 'Praia dos Fogos de Artifício', 10, 0, 0, 20, false, NULL),
    ('Três Coqueiros', 'Ponto de encontro na praia.', 'Praia dos Fogos de Artifício', 10, 0, 0, 10, false, NULL);

-- População da região Bosque das Ninfas e dos Sátiros
INSERT INTO area (nome, descricao, regiaoAtual, norte, sul, leste, oeste, temBandeira, desafio)
VALUES
    ('Clareira das Ninfas', 'Área iluminada por uma luz suave, onde as ninfas costumam se reunir.', 'Bosque das Ninfas e dos Sátiros', 0, 10, 0, 90, false, NULL),
    ('Campo dos Sátiros', 'Espaço aberto onde os sátiros treinam suas habilidades e celebram festividades.', 'Bosque das Ninfas e dos Sátiros', 0, 10, 0, 80, false, NULL),
    ('Trilha das Ervas Mágicas', 'Caminho coberto por ervas raras e encantadas.', 'Bosque das Ninfas e dos Sátiros', 0, 10, 0, 70, false, NULL),
    ('Bosque', 'Área onde os ecos de antigas canções e histórias mágicas são ouvidos.', 'Bosque das Ninfas e dos Sátiros', 0, 20, 0, 90, false, NULL),
    ('Fonte das Águas Encantadas', 'Fonte que fornece água com propriedades mágicas e curativas.', 'Bosque das Ninfas e dos Sátiros', 0, 20, 0, 80, false, NULL),
    ('Itens dos Anciãos', 'Local secreto usado por sátiros para esconder tesouros e artefatos mágicos.', 'Bosque das Ninfas e dos Sátiros', 0, 20, 0, 70, false, NULL),
    ('Jardim', 'Pequeno jardim com ervas mágicas.', 'Bosque das Ninfas e dos Sátiros', 0, 30, 0, 90, false, NULL),
    ('Cascata', 'Mini cachoeira com água cintilante.', 'Bosque das Ninfas e dos Sátiros', 0, 30, 0, 80, false, NULL),
    ('Trilha', 'Pequeno caminho onde sátiros treinam e brincam.', 'Bosque das Ninfas e dos Sátiros', 0, 30, 0, 70, false, NULL);

-- População da região Florestas do Sul
INSERT INTO area (nome, descricao, regiaoAtual, norte, sul, leste, oeste, temBandeira, desafio)
VALUES
    ('Clareira da Névoa', 'Uma clareira sempre envolta em uma névoa densa.', 'Florestas do Sul', 0, 10, 0, 60, false, NULL),
    ('Caminho das Estrelas', 'Caminho onde, à noite, as estrelas parecem brilhar ao alcance.', 'Florestas do Sul', 0, 10, 0, 50, false, NULL),
    ('O Bosque do Espelho', 'Um bosque onde as árvores parecem ser reflexos distorcidos.', 'Florestas do Sul', 0, 10, 0, 40, false, NULL),
    ('Riacho Oculto', 'Um pequeno riacho escondido entre as árvores, de águas mágicas.', 'Florestas do Sul', 0, 20, 0, 60, false, NULL),
    ('Vale dos Murmúrios', 'Vale profundo onde sussurros ecoam constantemente.', 'Florestas do Sul', 0, 20, 0, 50, false, NULL),
    ('Trilha da Sombra', 'Uma trilha que leva ao coração das Florestas do Sul. Coberta por sombras densas, ela é ideal para treinos de furtividade e emboscadas.', 'Florestas do Sul', 0, 20, 0, 40, false, NULL),
    ('Túnel Verdejante', 'Um caminho verdejante coberto por árvores entrelaçadas.', 'Florestas do Sul', 0, 30, 0, 60, false, NULL),
    ('Árvores Cintilantes', 'Árvores com folhas que brilham como pequenas joias à luz do sol.', 'Florestas do Sul', 0, 30, 0, 50, false, NULL),
    ('Círculo das Pedras Ancestrais', 'Um antigo círculo de pedras usado em rituais esquecidos.', 'Florestas do Sul', 0, 30, 0, 40, false, NULL);

-- População da região Lago de Canoagem
INSERT INTO area (nome, descricao, regiaoAtual, norte, sul, leste, oeste, temBandeira, desafio)
VALUES
    ('Praia do Lago', 'Pequena praia para descanso e relaxamento.', 'Lago de Canoagem', 0, 10, 0, 30, false, NULL),
    ('Praia da Lua', 'Praia com areia que brilha à noite.', 'Lago de Canoagem', 0, 10, 0, 20, false, NULL),
    ('Cais do Lago', 'Pequeno cais para atracar pequenas embarcações.', 'Lago de Canoagem', 0, 10, 0, 10, false, NULL),
    ('Caverna Submersa', 'Entrada para uma caverna abaixo da água.', 'Lago de Canoagem', 0, 20, 0, 30, false, NULL),
    ('Fonte do Lago', 'Pequena fonte de água fresca e clara.', 'Lago de Canoagem', 0, 20, 0, 20, false, NULL),
    ('Área dos Peixes', 'Zona rica em vida aquática.', 'Lago de Canoagem', 0, 20, 0, 10, false, NULL),
    ('Área de Canoagem', 'Local dedicado a práticas de canoagem.', 'Lago de Canoagem', 0, 30, 0, 30, false, NULL),
    ('Ilha dos Mistérios', 'Mini ilha com segredos escondidos.', 'Lago de Canoagem', 0, 30, 0, 20, false, NULL),
    ('Mergulho Profundo', 'Área onde o lago é mais profundo para exploração.', 'Lago de Canoagem', 0, 30, 0, 10, false, NULL);

-- População da região Toca dos Myrmekes
INSERT INTO area (nome, descricao, regiaoAtual, norte, sul, leste, oeste, temBandeira, desafio)
VALUES
    ('Entrada da Toca', 'Entrada para o território dos Myrmekes.', 'Toca dos Myrmekes', 30, 0, 10, 0, false, NULL),
    ('Poço dos Ossos', 'Um poço profundo onde os Myrmekes descartam seus inimigos. É uma área sinistra, repleta de restos de batalhas passadas.', 'Toca dos Myrmekes', 30, 0, 20, 0, false, NULL),
    ('Câmaras de Incubação', 'Onde os ovos dos Myrmekes são protegidos e crescem até a maturidade.', 'Toca dos Myrmekes', 30, 0, 30, 0, false, NULL),
    ('Labirinto das Formigas', 'Um complexo de túneis escavados pelos Myrmekes.', 'Toca dos Myrmekes', 20, 0, 10, 0, false, NULL),
    ('Coração da Colônia', 'O centro da Toca dos Myrmekes, onde a rainha das formigas reside.', 'Toca dos Myrmekes', 20, 0, 20, 0, false, NULL),
    ('Rochedos Cortantes', 'Rochas afiadas que formam um portal para quem tenta atravessar.', 'Toca dos Myrmekes', 20, 0, 30, 0, false, NULL),
    ('Caverna do Enxame', 'Local de encontro dos Myrmekes.', 'Toca dos Myrmekes', 10, 0, 10, 0, false, NULL),
    ('Ninho das Rainhas', 'A área central onde as rainhas Myrmekes residem e controlam o enxame.', 'Toca dos Myrmekes', 10, 0, 20, 0, false, NULL),
    ('Planície das Areias Movediças', 'Uma vasta área onde armadilhas naturais sugam aventureiros desatentos.', 'Toca dos Myrmekes', 10, 0, 30, 0, false, NULL);


-- População da região Bosque de Dodona
INSERT INTO area (nome, descricao, regiaoAtual, norte, sul, leste, oeste, temBandeira, desafio)
VALUES
    ('Círculo das Árvores Sábias', 'O centro do Bosque de Dodona, onde as árvores mais antigas e sábias se encontram. Suas folhas sussurram segredos e profecias aos que ouvem.', 'Bosque de Dodona', 30, 0, 40, 0, false, NULL),
    ('Trilha das Profecias', 'Uma trilha sinuosa que leva ao coração do Bosque de Dodona, conhecida por revelar visões e profecias aos que a percorrem.', 'Bosque de Dodona', 30, 0, 50, 0, false, NULL),
    ('Altar dos Espíritos', 'Um altar de pedra dedicado aos espíritos do bosque.', 'Bosque de Dodona', 30, 0, 60, 0, false, NULL),
    ('Fontes Sagradas', 'Pequenas fontes de água pura.', 'Bosque de Dodona', 20, 0, 40, 0, false, NULL),
    ('Árvore Oracular', 'Uma árvore que sussurra profecias aos viajantes.', 'Bosque de Dodona', 20, 0, 50, 0, false, NULL),
    ('Salão dos Sussurros', 'Uma caverna onde as vozes das árvores ecoam com sabedoria.', 'Bosque de Dodona', 20, 0, 60, 0, false, NULL),
    ('Prado Eterno', 'Um campo onde flores eternas crescem, independentemente da estação.', 'Bosque de Dodona', 10, 0, 40, 0, false, NULL),
    ('Altar dos Antigos', 'Um antigo altar de pedra usado para rituais e oferendas aos deuses. É um lugar sagrado, onde os campistas buscam orientação divina.', 'Bosque de Dodona', 10, 0, 50, 0, false, NULL),
    ('Lagoa das Ninfas', 'Uma lagoa tranquila onde ninfas e sátiros visitam constantemente.', 'Bosque de Dodona', 10, 0, 60, 0, false, NULL);

-- População da região Colina
INSERT INTO area (nome, descricao, regiaoAtual, norte, sul, leste, oeste, temBandeira, desafio)
VALUES
    ('Cume da Colina', 'Ponto mais alto com uma vista panorâmica.', 'Colina', 30, 0, 70, 0, false, NULL),
    ('Área dos Treinamentos', 'Espaço plano para atividades físicas.', 'Colina', 30, 0, 80, 0, false, NULL),
    ('Jardim das Ervas', 'Pequeno jardim com ervas e plantas.', 'Colina', 30, 0, 90, 0, false, NULL),
    ('Cascata da Colina', 'Mini cachoeira com água fresca.', 'Colina', 20, 0, 70, 0, false, NULL),
    ('Zona de Meditação', 'Área tranquila para meditação.', 'Colina', 20, 0, 80, 0, false, NULL),
    ('Campo das Flores', 'Pequena área com flores diversas.', 'Colina', 20, 0, 90, 0, false, NULL),
    ('Trilha da Colina', 'Caminho que leva até o cume.', 'Colina', 10, 0, 70, 0, false, NULL),
    ('Caverna', 'Caverna subterrânea com entrada na base da colina.', 'Colina', 10, 0, 80, 0, false, NULL),
    ('Área dos Festivais', 'Espaço para eventos e festividades ao ar livre.', 'Colina', 10, 0, 90, 0, false, NULL);

-- População da região Riacho de Zéfiro
INSERT INTO area (nome, descricao, regiaoAtual, norte, sul, leste, oeste, temBandeira, desafio)
VALUES
    ('Gruta Escondida', 'Uma gruta nas margens do riacho, onde criaturas aquáticas mágicas vivem.', 'Riacho de Zéfiro', 0, 10, 10, 0, false, NULL),
    ('Ponte de Pedra', 'Ponte para conectar a margem do riacho com a ilha.', 'Riacho de Zéfiro', 0, 10, 20, 0, false, NULL),
    ('Bosque dos Ventos', 'Um bosque onde as árvores dançam ao som dos ventos constantes.', 'Riacho de Zéfiro', 0, 10, 30, 0, false, NULL),
    ('Margem Esquerda', 'Margem esquerda do riacho, com árvores altas.', 'Riacho de Zéfiro', 0, 20, 10, 0, false, NULL),
    ('Ilha do Riacho', 'Uma pequena ilha no meio do riacho, acessível apenas por uma ponte de pedra.', 'Riacho de Zéfiro', 0, 20, 20, 0, false, NULL),
    ('Margem Direita', 'Margem direita do riacho, com vegetação rasteira.', 'Riacho de Zéfiro', 0, 20, 30, 0, false, NULL),
    ('Clareira do Zéfiro', 'Uma área aberta onde o vento sopra com uma força quase mágica.', 'Riacho de Zéfiro', 0, 30, 10, 0, false, NULL),
    ('Cachoeira', 'Uma pequena cachoeira.', 'Riacho de Zéfiro', 0, 30, 20, 0, false, NULL),
    ('Fontes da Brisa', 'O ponto onde o riacho nasce, com águas limpas e uma leve brisa constante.', 'Riacho de Zéfiro', 0, 30, 30, 0, false, NULL);

-- População da região Gêiseres
INSERT INTO area (nome, descricao, regiaoAtual, norte, sul, leste, oeste, temBandeira, desafio)
VALUES
    ('Gêiser Principal', 'Gêiser central que emite jatos de água e vapor.', 'Gêiseres', 0, 10, 40, 0, false, NULL),
    ('Gêiser das Erupções', 'Gêiser com erupções imprevisíveis e desafios de timing.', 'Gêiseres', 0, 10, 50, 0, false, NULL),
    ('Pico dos Gêiseres', 'Ponto alto para observar todos os gêiseres ao redor.', 'Gêiseres', 0, 10, 60, 0, false, NULL),
    ('Fonte das Caldeiras', 'Área com fontes termais e água quente.', 'Gêiseres', 0, 20, 40, 0, false, NULL),
    ('Campo dos Vapores', 'Região onde vapores e névoas criam desafios e visibilidade reduzida.', 'Gêiseres', 0, 20, 50, 0, false, NULL),
    ('Área das Poças Quentes', 'Poças de água quente com propriedades terapêuticas.', 'Gêiseres', 0, 20, 60, 0, false, NULL),
    ('Caminho das Fumarolas', 'Trilha entre fumarolas e vapores quentes.', 'Gêiseres', 0, 30, 40, 0, false, NULL),
    ('Zona dos Terrenos Móveis', 'Área com solo instável devido à atividade geotérmica.', 'Gêiseres', 0, 30, 50, 0, false, NULL),
    ('Fonte Termal', 'Pequena fonte de água quente e relaxante.', 'Gêiseres', 0, 30, 60, 0, false, NULL);

-- População da região Destroços de Antigos Autômatos
INSERT INTO area (nome, descricao, regiaoAtual, norte, sul, leste, oeste, temBandeira, desafio)
VALUES
    ('Mesa de Montagem', 'Local onde peças e autômatos são montados.', 'Destroços de Antigos Autômatos', 0, 10, 70, 0, false, NULL),
    ('Área dos Fragmentos', 'Local cheio de peças e fragmentos de autômatos.', 'Destroços de Antigos Autômatos', 0, 10, 80, 0, false, NULL),
    ('Desafios Mecânicos', 'Pequena área com segredos tecnológicos.', 'Destroços de Antigos Autômatos', 0, 10, 90, 0, false, NULL),
    ('Ruínas do Autômato Central', 'Destaca os restos do autômato principal, com desafios mecânicos.', 'Destroços de Antigos Autômatos', 0, 20, 70, 0, false, NULL),
    ('Relíquias Mecânicas', 'Área com relíquias e artefatos antigos.', 'Destroços de Antigos Autômatos', 0, 20, 80, 0, false, NULL),
    ('Mecânica dos Filhos de Hefesto', 'Local onde os campistas podem estudar e reparar autômatos.', 'Destroços de Antigos Autômatos', 0, 20, 90, 0, false, NULL),
    ('Laboratório de Hefesto', 'Laboratório com ferramentas antigas.', 'Destroços de Antigos Autômatos', 0, 30, 70, 0, false, NULL),
    ('Depósito de Peças', 'Área com peças e componentes de autômatos.', 'Destroços de Antigos Autômatos', 0, 30, 80, 0, false, NULL),
    ('Ruínas', 'Pequenas ruínas de autômatos antigos.', 'Destroços de Antigos Autômatos', 0, 30, 90, 0, false, NULL);

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
    ('ContraCorrente', 'Ataque'),
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
    ('Pedra de teletransporte', 'Consumivel'),
    ('Néctar', 'Consumivel');

INSERT INTO inimigoConcreto (nomeConcreto, vidaAtual, inimigo, areaAtual, loot)
VALUES
    ('Ulfa', 10, 'Lobo', 'Clareira da Lua Prateada', 'Néctar'),
    ('Scott', 30, 'Ciclope', 'O Espelho das Arvores', 'Machado de Ares'),
    ('Alecto', 50, 'Harpia', 'Gruta das Arvores Ancias', 'Bastão de Hécate');

INSERT INTO itemInventario (jogador, item)
VALUES
    ('Natan', 'Espada de Bronze Celestial'),
    ('Clara', 'Anel de Hermes'),
    ('Charles', 'Elmo de Ares'),
    ('Paulo', 'Ambrosia');

INSERT INTO armadilha (descricao, DTForca, DTAgilidade, DTInteligencia, areaTeletransporte, desafio)
VALUES
    ('Armadilha de Espinhos', 5, 3, 2, 'Campos de Espinhos', 1),
    ('Caverna de Merlin', 6, 4, 5, 'Toca do Lobo', 3),
    ('Jardim da Medusa', 2, 4, 7, 'Wind Stone', 5);

INSERT INTO provacao (descricao, DTForca, DTAgilidade, DTInteligencia, recompensa, desafio)
VALUES
    ('Arena de Ares', 6, 3, 7, 'Elmo de Ares', 2),
    ('Labirinto de Atena', 7, 6, 9, 'Escudo de Atena', 4),
    ('Panteão olimpico', 2, 4, 7, 'Ambrosia', 6);

-- Ajustar o nome das áreas quando a tabela estiver pronta

INSERT INTO defesa (nome, areaAtual, descricao, peso, modDefesa)
VALUES
    ('Elmo de Ares', NULL, 'Um elmo pesado e resistente forjado para os guerreiros mais temidos.', 4, 7),
    ('Escudo de Atena', NULL, 'Escudo abençoado com a sabedoria de Atena.', 5, 10),
    ('Armadura de Zeus', NULL, 'A armadura reluzente que protege contra os ataques mais poderosos.', 6, 12),
    ('Cota de Malha de Hefesto', NULL, 'Armadura reforçada com os metais mais resistentes.', 8, 15);

INSERT INTO ataque (nome, areaAtual, descricao, peso, modCombate, modForca)
VALUES
    ('Espada de Bronze Celestial', NULL, 'Uma espada poderosa forjada para derrotar monstros mitológicos.', 5, 10, 3),
    ('Machado de Ares', NULL, 'Uma arma brutal usada por guerreiros que seguem Ares.', 7, 15, 5),
    ('ContraCorrente', NULL, 'A famosa arma de Percy Jackson', 7, 5, 0);

INSERT INTO magico (nome, areaAtual, descricao, peso, modCombate, modForca, modDefesa, modAgilidade, modCarga, tempoDeRecarga, tempoAtual)
VALUES
    ('Anel de Hermes', NULL, 'Um anel encantado que aumenta a velocidade e agilidade.', 1, 4, 2, 2, 5, 3, 10, 5),
    ('Escudo Mágico de Atena', NULL, 'Um escudo com proteção mágica e bônus de combate.', 3, 7, 0, 10, 2, 5, 8, 8),
    ('Pingente de Afrodite', NULL, 'Um amuleto que fortalece a defesa e combate, atraindo sorte.', 1, 3, 1, 5, 1, 2, 6, 6),
    ('Bastão de Hécate', NULL, 'Um bastão poderoso que concede poderes mágicos únicos.', 5, 12, 6, 8, 4, 10, 20, 15);

INSERT INTO consumivel (nome, areaAtual, descricao, peso, vidaRecuperada, areaTeletransporte)
VALUES
    ('Ambrosia', NULL, 'Comida dos deuses, capaz de curar ferimentos graves.', 1, 50, NULL),
    ('Néctar', NULL, 'Bebida divina que recupera a energia e vitalidade.', 1, 30, NULL),
    ('Pedra de teletransporte', NULL, 'Uma pedra que abre um portal para uma área desconhecida', 1, NULL, 'Clareira da Lua Prateada');

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
