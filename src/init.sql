CREATE DOMAIN AtributoInicial AS INTEGER
    CHECK (VALUE >= 0 AND VALUE <= 5);

CREATE DOMAIN IntPositivo AS INTEGER
    CHECK (VALUE >= 0);

CREATE TABLE constante
(
    nome VARCHAR(20),
    valor IntPositivo NOT NULL,
    PRIMARY KEY(nome)
);

CREATE TABLE nivel
(
    id INTEGER,
    pontosExperiencia IntPositivo NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE deus
(
    nome VARCHAR(15),
    forcaInicial AtributoInicial NOT NULL,
    intelectoInicial AtributoInicial NOT NULL,
    agilidadeInicial AtributoInicial NOT NULL,
    combateInicial AtributoInicial NOT NULL,
    PRIMARY KEY(nome)
);

CREATE TABLE tipoPersonagem
(
    nome VARCHAR(15),
    tipo CHAR NOT NULL CHECK(tipo = 'J' OR tipo = 'I'),
    PRIMARY KEY(nome)
);

CREATE TABLE inimigo
(
    nome VARCHAR(15),
    vidaMax IntPositivo NOT NULL,
    forca IntPositivo NOT NULL,
    intelecto IntPositivo NOT NULL,
    agilidade IntPositivo NOT NULL,
    combate IntPositivo NOT NULL,
    pontosExperiencia IntPositivo NOT NULL,
    nivel INTEGER NOT NULL,
    PRIMARY KEY(nome),
    FOREIGN KEY(nome) REFERENCES tipoPersonagem(nome) ON DELETE RESTRICT,
    FOREIGN KEY(nivel) REFERENCES nivel(id) ON DELETE RESTRICT
);

CREATE TABLE jogador
(
    nome VARCHAR(15),
    vidaMax IntPositivo NOT NULL DEFAULT 50,
    forca IntPositivo NOT NULL,
    intelecto IntPositivo NOT NULL,
    agilidade IntPositivo NOT NULL,
    combate IntPositivo NOT NULL,
    vidaAtual IntPositivo NOT NULL DEFAULT 50 CHECK(vidaAtual <= vidaMax),
    experienciaAtual IntPositivo NOT NULL DEFAULT 0,
    armadura INTEGER,
    arma INTEGER,
    itemMagico INTEGER,
    deus VARCHAR(15) NOT NULL, 
    areaAtual VARCHAR(15) NOT NULL,
    nivel INTEGER NOT NULL DEFAULT 1,
    PRIMARY KEY(nome),
    FOREIGN KEY(nome) REFERENCES tipoPersonagem(nome) ON DELETE RESTRICT,
    FOREIGN KEY(deus) REFERENCES deus(nome) ON DELETE RESTRICT,
    FOREIGN KEY(nivel) REFERENCES nivel(id) ON DELETE RESTRICT
    /*
    TODO: Descomentar quando as tabelas de itens foram criadas

    FOREIGN KEY(armadura) REFERENCES defesa(id) ON DELETE RESTRICT,
    FOREIGN KEY(arma) REFERENCES ataque(id) ON DELETE RESTRICT,
    FOREIGN KEY(itemMagico) REFERENCES magico(id) ON DELETE RESTRICT,

    TODO: Descomentar quando a tabela de Área for criada
    FOREIGN KEY(areaAtual) REFERENCES area(nome) ON DELETE RESTRICT,
    */
);

CREATE TABLE inimigoConcreto
(
    nomeConcreto VARCHAR(15),
    vidaAtual IntPositivo NOT NULL, /* Criar Trigger para definir a vidaAtual como a vidaMax do inimigo de referência */
    inimigo VARCHAR(15) NOT NULL,
    areaAtual VARCHAR(15),
    loot VARCHAR(25) NOT NULL,
    PRIMARY KEY(nomeConcreto),
    FOREIGN KEY(inimigo) REFERENCES inimigo(nome) ON DELETE RESTRICT
    /*
    TODO: Descomentar quando as tabelas de itens foram criadas

    FOREIGN KEY(loot) REFERENCES tipoItem(id) ON DELETE RESTRICT,

    TODO: Descomentar quando a tabela de Área for criada
    FOREIGN KEY(areaAtual) REFERENCES area(nome) ON DELETE RESTRICT,
    */
);

CREATE TABLE abate
(
    nomeJogador VARCHAR(15),
    nomeInimigo VARCHAR(15),
    dataHorario TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resultado BOOLEAN NOT NULL,
    PRIMARY KEY(nomeJogador, nomeInimigo, dataHorario),
    FOREIGN KEY(nomeJogador) REFERENCES jogador(nome) ON DELETE RESTRICT,
    FOREIGN KEY(nomeInimigo) REFERENCES inimigo(nome) ON DELETE RESTRICT
);

CREATE TABLE inventario
(
    jogador VARCHAR(15),
    cargaMaxima INTEGER NOT NULL CHECK (cargaMaxima >= 5),
    PRIMARY KEY(jogador),
    FOREIGN KEY(jogador) REFERENCES jogador(nome) ON DELETE CASCADE
);

CREATE TABLE tipoItem
(
    nome VARCHAR(30),
    classificacao VARCHAR(15) NOT NULL CHECK (classificacao IN ('Defesa', 'Ataque', 'Consumivel', 'Magico')),
    PRIMARY KEY(nome)
);

CREATE TABLE itemInventario
(
    jogador VARCHAR(15),
    item VARCHAR(30),
    PRIMARY KEY(jogador, item),
    FOREIGN KEY(jogador) REFERENCES jogador(nome) ON DELETE CASCADE,
    FOREIGN KEY(item) REFERENCES tipoItem(nome) ON DELETE CASCADE
);

CREATE TABLE defesa
(
    nome VARCHAR(30),
    areaAtual VARCHAR(15),
    descricao TEXT,
    peso IntPositivo,
    modDefesa IntPositivo,
    PRIMARY KEY(nome), 
    FOREIGN KEY(nome) REFERENCES tipoItem(nome) ON DELETE CASCADE
    -- FOREIGN KEY(areaAtual) REFERENCES area(nome) ON DELETE RESTRICT,
);

CREATE TABLE ataque
(
    nome VARCHAR(30),
    areaAtual VARCHAR(15),
    descricao TEXT,
    peso IntPositivo,
    modCombate IntPositivo,
    modForca IntPositivo,
    PRIMARY KEY(nome), 
    FOREIGN KEY(nome) REFERENCES tipoItem(nome) ON DELETE CASCADE
    -- FOREIGN KEY(areaAtual) REFERENCES area(nome) ON DELETE RESTRICT,
);

CREATE TABLE magico
(
    nome VARCHAR(30),
    areaAtual VARCHAR(15),
    descricao TEXT,
    peso IntPositivo,
    modCombate IntPositivo,
    modForca IntPositivo,
    modDefesa IntPositivo,
    modAgilidade IntPositivo,
    modCarga IntPositivo,
    tempoDeRecarga IntPositivo,
    tempoAtual IntPositivo,
    PRIMARY KEY(nome), 
    FOREIGN KEY(nome) REFERENCES tipoItem(nome) ON DELETE CASCADE
    -- FOREIGN KEY(areaAtual) REFERENCES area(nome) ON DELETE RESTRICT,
);

CREATE TABLE consumivel
(
    nome VARCHAR(30),
    areaAtual VARCHAR(15),
    descricao TEXT,
    peso IntPositivo,
    vidaRecuperada IntPositivo,
    areaTeletransporte VARCHAR(15),
    PRIMARY KEY(nome), 
    FOREIGN KEY(nome) REFERENCES tipoItem(nome) ON DELETE CASCADE
    -- FOREIGN KEY(areaAtual) REFERENCES area(nome) ON DELETE RESTRICT,
    -- FOREIGN KEY(areaTeletransporte) REFERENCES area(nome) ON DELETE RESTRICT
);