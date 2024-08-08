CREATE DOMAIN AtributoInicial AS INTEGER
    CHECK (VALUE >= 0 AND VALUE <= 5);

CREATE DOMAIN IntPositivo AS INTEGER
    CHECK (VALUE >= 0);

CREATE TABLE regiao
(
    nome        VARCHAR(15),
    descricao   TEXT        NOT NULL,
    nivel       INTEGER     NOT NULL,
    
    PRIMARY KEY(nome)
);

CREATE TABLE desafio
(
    id       SERIAL,
    tipo     CHAR   NOT NULL CHECK(tipo = 'A' OR tipo = 'P')
    
    PRIMARY KEY(id)
);

CREATE TABLE area
(
    nome            VARCHAR(15),
    regiaoAtual     VARCHAR(15) NOT NULL,
    desafio         INTEGER     NOT NULL,
    
    PRIMARY KEY(nome),
    FOREIGN KEY(regiaoAtual)    REFERENCES regiao(nome)         ON DELETE RESTRICT,
    FOREIGN KEY(desafio)        REFERENCES desafio(id)   ON DELETE RESTRICT
);

CREATE TABLE armadilha
(
    id                  SERIAL,
    descricao           TEXT        NOT NULL,
    DTForca             INTEGER     NOT NULL,
    DTAgilidade         INTEGER     NOT NULL,
    DTInteligencia      INTEGER     NOT NULL,
    areaTeletransporte  VARCHAR(15) DEFAULT NULL,
    
    PRIMARY KEY(id),
    FOREIGN KEY(id)                 REFERENCES desafio(id)          ON DELETE RESTRICT,
    FOREIGN KEY(areaTeletransporte) REFERENCES area(nome)           ON DELETE RESTRICT
);

CREATE TABLE provacao
(
    id                  SERIAL,
    descricao           TEXT        NOT NULL,
    DTForca             INTEGER     NOT NULL,
    DTAgilidade         INTEGER     NOT NULL,
    DTInteligencia      INTEGER     NOT NULL,
    recompensa          INTEGER     NOT NULL,
    
    PRIMARY KEY(id),
    FOREIGN KEY(id)     REFERENCES desafio(id)   ON DELETE RESTRICT
    /*
    TODO: Descomentar quando as tabelas de itens foram criadas
    FOREIGN KEY(recompensa) REFERENCES item(id)           ON DELETE RESTRICT
    */
);


CREATE TABLE nivel
(
    id                  INTEGER,
    pontosExperiencia   IntPositivo NOT NULL,
    
    PRIMARY KEY(id)
);

CREATE TABLE deus
(
    nome                VARCHAR(15),
    forcaInicial        AtributoInicial NOT NULL,
    intelectoInicial    AtributoInicial NOT NULL,
    agilidadeInicial    AtributoInicial NOT NULL,
    combateInicial      AtributoInicial NOT NULL,
    
    PRIMARY KEY(nome)
);

CREATE TABLE tipoPersonagem
(
    nome    VARCHAR(15),
    tipo    CHAR NOT NULL CHECK(tipo = 'J' OR tipo = 'I'),
    
    PRIMARY KEY(nome)
);

CREATE TABLE inimigo
(
    nome                VARCHAR(15),
    defesa              IntPositivo NOT NULL,
    vidaMax             IntPositivo NOT NULL,
    forca               IntPositivo NOT NULL,
    intelecto           IntPositivo NOT NULL,
    agilidade           IntPositivo NOT NULL,
    combate             IntPositivo NOT NULL,
    pontosExperiencia   IntPositivo NOT NULL,
    nivel               INTEGER NOT NULL,
    
    PRIMARY KEY(nome),
    FOREIGN KEY(nome)   REFERENCES tipoPersonagem(nome) ON DELETE RESTRICT,
    FOREIGN KEY(nivel)  REFERENCES nivel(id)            ON DELETE RESTRICT
);

CREATE TABLE jogador
(
    nome VARCHAR(15),
    defesa              IntPositivo NOT NULL DEFAULT 10,
    vidaMax             IntPositivo NOT NULL DEFAULT 50,
    forca               IntPositivo NOT NULL,
    intelecto           IntPositivo NOT NULL,
    agilidade           IntPositivo NOT NULL,
    combate             IntPositivo NOT NULL,
    carga               IntPositivo NOT NULL DEFAULT 2,
    vidaAtual           IntPositivo NOT NULL DEFAULT 50 CHECK(vidaAtual <= vidaMax),
    experienciaAtual    IntPositivo NOT NULL DEFAULT 0,
    armadura            INTEGER,
    arma                INTEGER,
    itemMagico          INTEGER,
    deus                VARCHAR(15), 
    areaAtual           VARCHAR(15) NOT NULL,
    nivel               INTEGER NOT NULL DEFAULT 1,
    
    PRIMARY KEY(nome),
    FOREIGN KEY(nome)   REFERENCES tipoPersonagem(nome) ON DELETE RESTRICT,
    FOREIGN KEY(deus)   REFERENCES deus(nome)           ON DELETE RESTRICT,
    FOREIGN KEY(nivel)  REFERENCES nivel(id)            ON DELETE RESTRICT,
    /*
    TODO: Descomentar quando as tabelas de itens foram criadas

    FOREIGN KEY(armadura) REFERENCES defesa(id) ON DELETE RESTRICT,
    FOREIGN KEY(arma) REFERENCES ataque(id) ON DELETE RESTRICT,
    FOREIGN KEY(itemMagico) REFERENCES magico(id) ON DELETE RESTRICT,
    */
    FOREIGN KEY(areaAtual) REFERENCES area(nome) ON DELETE RESTRICT
);

CREATE TABLE inimigoConcreto
(
    nomeConcreto    VARCHAR(15),
    vidaAtual       IntPositivo   NOT NULL, /* Criar Trigger para definir a vidaAtual como a vidaMax do inimigo de referência */
    inimigo         VARCHAR(15),
    areaAtual       VARCHAR(15) NOT NULL,
    loot            INTEGER NOT NULL,
    
    PRIMARY KEY(nomeConcreto),
    FOREIGN KEY(inimigo) REFERENCES inimigo(nome) ON DELETE RESTRICT,
    /*
    TODO: Descomentar quando as tabelas de itens foram criadas

    FOREIGN KEY(loot) REFERENCES tipoItem(id) ON DELETE RESTRICT,
    */
    FOREIGN KEY(areaAtual) REFERENCES area(nome) ON DELETE RESTRICT
);

CREATE TABLE abate
(
    nomeJogador     VARCHAR(15),
    nomeInimigo     VARCHAR(15),
    quantidade      INTEGER NOT NULL DEFAULT 0,
    
    PRIMARY KEY(nomeJogador, nomeInimigo),
    FOREIGN KEY(nomeJogador) REFERENCES jogador(nome) ON DELETE RESTRICT,
    FOREIGN KEY(nomeInimigo) REFERENCES inimigo(nome) ON DELETE RESTRICT
);