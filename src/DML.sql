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

INSERT INTO abate (nomeJogador, nomeInimigo, resultado)
VALUES
    ('nomeJogador', 'nomeInimigo', 'resultado');

-- Fim Combate --