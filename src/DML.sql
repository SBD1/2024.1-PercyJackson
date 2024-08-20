/*
    Este arquivo irá listar operações que serão feitas no jogo e que futuramente serão transformadas
    em triggers ou stored procedures.
*/

-- Começo Criação de Personagem  --

/*
    Primeiro o jogador irá escolher o nome deste personagem. Se estiver disponível, o banco
    irá criar o personagem
*/

INSERT INTO tipoPersonagem (nome, tipo)
VALUES
    ('Nome', 'J');

/*
    Depois o jogador irá escolher um Deus para ser o pai/mae. A escolho do Deus defini os atributos
    básicos do jogador
*/

SELECT *
FROM deus
WHERE nome = deusEscolhido;

/*
    Com o Deus escolhido, é possível criar a tupla de Jogador
*/

INSERT INTO jogador (nome, forca, intelecto, agilidade, combate, deus, areaAtual)
VALUES
    ('Natan', forcaDeus, intelectoDeus, agilidadeDeus, combateDeus, 'deusEscolhido', 'Acampamento');

-- Fim Criação de Personagem  --

-- Começo Subir de Nível  --

/*
    Sempre que o jogador receber pontos de experiência, será necessário checar se ele subiu de nível.
    Primeiro, é feito uma busca para saber os pontos de experiência necessários para o próximo nível
*/

SELECT pontosExperiencia
FROM nivel
WHERE id = nivelJogador + 1;

/*
    Se o pontos de experiência atual do jogador for menor que o pontos de experiência do próximo nível, nada acontece.
    Se o pontos de experiência atual do jogador for maior ou igual aos pontos de experiência do próximo nível, o jogador sobre de nível.
*/

UPDATE jogador
SET nivel = nivelJogador + 1
WHERE nome = nomeJogador;

-- Fim Subir de Nível  --

-- Começo Combate --

/*
    Ao começar um combate, será necessário pegar as informações dos Inimigos geradores dos inimigosConcretos.
*/

SELECT *
FROM inimigo
WHERE nome = nomeConcreto;

/*
    Sempre que o jogador acertar um ataque em um inimigo concreto, será necessário atualizar a vida atual dele
*/

UPDATE inimigoConcreto
SET vidaAtual = vidaAtual - danoCausado
WHERE nomeConcreto = nomeAlvo;

/*
    Quando o jogador derrotar um inimigo, ele irá desaparecer da área e irá voltar para o "Armazem de Inimigos Concretos" para ser reutilizado depois.
    Isso significa que a área do inimigoConcreto será null e a sua vida voltará ao valor normal
*/

UPDATE inimigoConcreto
SET vidaAtual = vidamaxInimigo, areaAtual = null
WHERE nomeConcreto = nomeAlvo;

/*
    Se o jogador receber dano suficiente para zerar a vida dele, ele irá recuar do combate retornando para a área anterior
    e sua vida ficará com valor 1 em vez de 0. O jogador terá mais chances de vencer sem morrer, ele só irá perder se a equipe inimiga capturar a bandeira de sua equipe (depois de X turnos)
*/

UPDATE jogador
SET vidaAtual = 1, areaAtual = areaAnterior
WHERE nome = nomeJogador;

/*
    Ao fim do combate, será registrado o resultado na tabela de abate.
    Se o jogador vencer o combate, o resultado será "true".
    Se o inimigo vencer o combate, o resultado será "false".
*/

INSERT INTO abate (nomeJogador, nomeInimigo, vitoriaJogador)
VALUES
    ('nomeJogador', 'nomeInimigo', true);

-- Fim Combate --

-- Inserção de Item no inventário de um jogador

INSERT INTO itemInventario (jogador, item)
VALUES ('nome', 'item');

/*
    Deve ter um trigger para calcular a carga máxima do inventário. O cálculo deve ser 2 * força + 5
*/


-- Exclusão de Item do inventário de um jogador

DELETE FROM itemInventario
WHERE jogador = 'nome'
  AND item = 'item';

-- Recupera todos os itens de inventário de um jogador específico
SELECT item, classificacao
FROM itemInventario item
JOIN tipoItem ON item = nome
WHERE item.jogador = 'Clara';

-- Exibe todas as áreas onde um determinado inimigo pode ser encontrado e a quantidade de vida que ele ainda possui
SELECT nomeConcreto, areaAtual, vidaAtual, nome
FROM inimigoConcreto
JOIN inimigo ON inimigoConcreto.inimigo = inimigo.nome
WHERE inimigo.nome = 'Harpia';

-- Encontrar jogadores que possuem pelo menos um item de defesa.
SELECT DISTINCT jogador.nome
FROM jogador
JOIN itemInventario item ON jogador.nome = item.jogador
JOIN tipoItem ON item.item = tipoItem.nome
WHERE tipoItem.classificacao = 'Defesa';

--  Listar todos os jogadores que foram derrotados em combate contra um inimigo específico.
SELECT nomeJogador, nomeInimigo
FROM abate
WHERE vitoriaJogador = false AND nomeInimigo = 'Ciclope';

-- Listar Itens Mágicos que Melhoram o Combate e a Defesa
SELECT nome, modCombate, modDefesa
FROM magico
WHERE modCombate > 0 AND modDefesa > 0;

-- Listar as áreas onde há pelo menos um jogador e um monstro ao mesmo tempo.
SELECT area.nome, jogador.nome, inimigoConcreto.nomeconcreto
FROM area
JOIN jogador ON jogador.areaAtual = area.nome
JOIN inimigoConcreto ON inimigoConcreto.areaAtual = area.nome;
