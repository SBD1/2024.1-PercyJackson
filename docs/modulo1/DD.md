# Dicionário de Dados

## Introdução

## Tabelas

### Tabela Jogador

| Tabela      | jogador                                                                                                                                     |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará as informações referente ao personagem jogável do usuário                                                                        |
| Observações | Essa tabela é uma especificação de Personagem, a tabela tipoPersonagem será a responsável por armazenar as chaves e o tipo da especificação |

| Nome             | Descrição                                                                                                                                                                                                          | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------ | ------- | ------------------------------------------------------------------ |
| nome             | Nome que irá identificar unicamente o personagem do jogador                                                                                                                                                        | Varchar      | 15      | PK/ FK/ Not Null                                                   |
| defesa           | O número de defesa define a dificuldade para um atacante acertar um ataque. Esse valor é calculado com base no valor de agilidade                                                                                  | Int          |         | Not Null/Default = 10                                              |
| vidaMax          | O limite de vida do personagem. É separado da vida atual do personagem pois ele pode encontrar itens que recuperam a saúde, mas não deve passar desse limite                                                       | Int          |         | Not Null                                                           |
| forca            | O número de força define o quão forte o personagem é. Quanto maior o valor, maiores são as chances do personagem conseguir quebrar/levantar coisas. A força também define quantos itens o personagem pode carregar | Int          |         | Not Null                                                           |
| intelecto        | O número de intelecto define o quão inteligente o personagem é. Quanto maior o valor, maiores são as chances do personagem conseguir desvendar enigmas, confundir/convencer inimigos                               | Int          |         | Not Null                                                           |
| agilidade        | O número de agilidade define o quão rápido o personagem é. Quanto maior o valor, maiores são as chances do personagem conseguir fugir de armadilhas, escapar de inimigos                                           | Int          |         | Not Null                                                           |
| combate          | O número de intelecto define o quão bom em combate o personagem é. Quanto maior o valor, maiores são as chances do personagem conseguir acertar ataques                                                            | Int          |         | Not Null                                                           |
| carga            | O número de carga define o multiplicador para definir quantos itens o personagem pode carregar. A quantidade de peso que o personagem consegue carregar é definido da seguinte forma: carga x forca                | Int          |         | Not Null/ Default = 2                                              |
| vidaAtual        | A vida atual do personagem, ao chegar a 0 o personagem morre e o jogo deve começar do zero                                                                                                                         | Int          |         | Not Null/ Default = 0                                              |
| experienciaAtual | Número de pontos que determina o nível do personagem                                                                                                                                                               | Int          |         | Not Null/ Default = 0                                              |
| armadura         | Referência ao item de defesa que o personagem possui equipado. Oferece bônus no atributo de defesa. Quando o valor for "null", então o personagem não possui nenhum Item de defesa equipado                        | Int          |         | FK                                                                 |
| arma             | Referência ao item de ataque que o personagem possui equipado. Oferece bônus no atributo de força e combate. Quando o valor for "null", então o personagem não possui nenhum Item de ataque equipado               | Int          |         | FK                                                                 |
| itemMagico       | Referência ao item mágico que o personagem possui equipado. Oferece bônus em vários atributos dependendo do item. Quando o valor for "null", então o personagem não possui nenhum Item mágico equipado             | Int          |         | FK                                                                 |
| deus             | Referência ao deus que define os atributos inicias do personagem                                                                                                                                                   | Int          |         | FK/ Not Null                                                       |
| areaAtual        | Referência à área que o personagem se encontra dentro do mapa do jogo                                                                                                                                              | Varchar      | 25      | FK/ Not Null                                                       |
| nivel            | Referência ao nível atual do personagem. Ao atingir os pontos base do próximo nível, o personagem muda para o nível acima do atual                                                                                 | Int          |         | FK/ Not Null/ Default = 1                                          |

### Tabela Inimigo

| Tabela      | inimigo                                                                                                                                                                                                                   |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará as informações referente a um inimigo do jogo. Um inimigo é uma criatura com o objetivo de matar o personagem do jogador                                                                                       |
| Observações | Essa tabela é uma especificação de Personagem, a tabela tipoPersonagem será a responsável por armazenar as chaves e o tipo da especificação. Esta tabela defini uma "ficha" de inimigo que irá gerar "Inimigos Concretos" |

| Nome              | Descrição                                                                                                                                                                                                          | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------ | ------- | ------------------------------------------------------------------ |
| nome              | Nome que irá identificar unicamente o personagem do inimigo                                                                                                                                                        | Varchar      | 15      | PK/ FK/ Not Null                                                   |
| defesa            | O número de defesa define a dificuldade para um atacante acertar um ataque. Esse valor é calculado com base no valor de agilidade                                                                                  | Int          |         | Not Null/ Default = 10                                             |
| vidaMax           | O limite de vida do personagem. É separado da vida atual do personagem pois ele pode encontrar itens que recuperam a saúde, mas não deve passar desse limite                                                       | Int          |         | Not Null                                                           |
| forca             | O número de força define o quão forte o personagem é. Quanto maior o valor, maiores são as chances do personagem conseguir quebrar/levantar coisas. A força também define quantos itens o personagem pode carregar | Int          |         | Not Null                                                           |
| intelecto         | O número de intelecto define o quão inteligente o personagem é. Quanto maior o valor, maiores são as chances do personagem conseguir desvendar enigmas, confundir/convencer inimigos                               | Int          |         | Not Null                                                           |
| agilidade         | O número de agilidade define o quão rápido o personagem é. Quanto maior o valor, maiores são as chances do personagem conseguir fugir de armadilhas, escapar de inimigos                                           | Int          |         | Not Null                                                           |
| combate           | O número de intelecto define o quão bom em combate o personagem é. Quanto maior o valor, maiores são as chances do personagem conseguir acertar ataques                                                            | Int          |         | Not Null                                                           |
| pontosExperiencia | O número de pontos de experiência que um jogador ganha ao derrotar uma instância deste inimigo                                                                                                                     | Int          |         | Not Null                                                           |
| nivel             | Referência ao nível atual do personagem. Diferente do jogador, o nível do inimigo não muda. Ele é usado como referência a fim de balancear os combates                                                             | Int          |         | FK/ Not Null                                                       |

### Tabela TipoPersonagem

| Tabela      | tipoPersonagem                                                                                      |
| ----------- | --------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará a relação de nome do Personagem com o tipo dele, Jogador ou Inimigo                      |
| Observações | Esta tabela possui a finalidade de diferenciar quais personagens são Jogadores e Quais são Inimigos |

| Nome | Descrição                                                                                                                                                             | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ---- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ | ------- | ------------------------------------------------------------------ |
| nome | Nome que irá identificar unicamente um personagem                                                                                                                     | Varchar      | 15      | PK/ Not Null                                                       |
| tipo | Este atributo especifica se o Personagem é um Jogador ou um Inimigo. Os valores permitidos para este atributo será o caracter 'J', para Jogador, ou 'I', para Inimigo | Char         | 1       | Not Null                                                           |

### Tabela Nível

| Tabela      | nivel                                                            |
| ----------- | ---------------------------------------------------------------- |
| Descrição   | Armazenará os pontos necessários para atingir cada um dos níveis |
| Observações |                                                                  |

| Nome              | Descrição                                                                                                                                                                     | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ | ------- | ------------------------------------------------------------------ |
| idNivel           | Um número sequencial que indica o nível de um personagem. Quanto maior o nível, mais poderoso o personagem é                                                                  | SERIAL       |         | PK/Not Null                                                        |
| pontosExperiencia | O número de pontos necessário para atingir o nível. O número de pontos de um nível precisa ser maior do que o anterior. Essa checagem deverá ser feita por meio de um trigger | Int          |         | Not Null                                                           |

### Tabela InimigoConcreto

| Tabela      | inimigoConcreto                                                                                                   |
| ----------- | ----------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará as informações da instância de um inimigo                                                              |
| Observações | Esta tabela existe a fim de reutilizar informações da tabela Inimigo e evitar redundâncias e sobrecarga no banco. |

| Nome         | Descrição                                                                                                                                                                                                                            | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------ | ------- | ------------------------------------------------------------------ |
| nomeConcreto | O nome que identifica unicamente uma instância de Inimigo                                                                                                                                                                            | SERIAL       |         | PK/Not Null                                                        |
| vidaAtual    | A vida atual da instância de Inimigo, ao chegar a 0 a instância é derrotada. O valor inicial deste atributo deve ser o mesmo valor do atributo vidaMax do Inimigo gerador da instância, isso poderá ser feito a partir de um trigger | Int          |         | Not Null                                                           |
| inimigo      | Referência ao Inimigo gerador desta instância                                                                                                                                                                                        | Varchar      | 15      | FK/ Not Null                                                       |
| areaAtual    | Referência à área que o personagem se encontra dentro do mapa do jogo                                                                                                                                                                | Varchar      | 25      | FK/ Not Null                                                       |
| loot         | Referência ao item que o jogador ganha ao derrotar esta instância de Inimigo                                                                                                                                                         | Int          |         | FK/ Not Null                                                       |

### Tabela Abate

| Tabela      | abate                                                                                                                                                                                                                                                                                          |
| ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará a quantidade de instâncias de um mesmo Inimigo que um Jogador derrotou                                                                                                                                                                                                              |
| Observações | Possui uma chave primária composta com os atributos nomeJogador e nomeInimigo. Quando um jogador derrotar um Inimigo, deve verificar se já existe uma tupla de abate com o mesmo Jogador e Inimigo: se não existir, deve criar uma tupla, e se existir, deve incrementar o atributo quantidade |

| Nome        | Descrição                                                                                | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ----------- | ---------------------------------------------------------------------------------------- | ------------ | ------- | ------------------------------------------------------------------ |
| nomeJogador | Nome do jogador que realizou o abate de um Inimigo                                       | Varchar      | 15      | PK/FK Not Null                                                     |
| nomeInimigo | nome do Inimigo derrotado por um Jogador                                                 | Varchar      | 15      | PK/FK Not Null                                                     |
| quantidade  | Número que indica a quantidade de instância de um mesmo Inimigo derrotado por um Jogador | Int          |         | Not Null/ Default = 0                                              |

### Tabela Deus

| Tabela      | deus                                                                                                                                      |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará os atributos iniciais dados ao Personagem que escolhe um Deus/Deusa como seu pai/mãe                                           |
| Observações | Os atributos iniciais de forca, intelecto, agilidade e combate são definidos pelo Deus/Deusa que o Jogador escolher ao criar o personagem |

| Nome             | Descrição                                                             | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ---------------- | --------------------------------------------------------------------- | ------------ | ------- | ------------------------------------------------------------------ |
| nome             | Nome que identifica unicamente um Deus                                | Varchar      | 15      | PK/ Not Null                                                       |
| forcaInicial     | O número de Força inicial do Jogador descendente desse Deus/Deusa     | Int          |         | Not Null                                                           |
| intelectoInicial | O número de Intelecto inicial do Jogador descendente desse Deus/Deusa | Int          |         | Not Null                                                           |
| agilidadeInicial | O número de Agilidade inicial do Jogador descendente desse Deus/Deusa | Int          |         | Not Null                                                           |
| combateInicial   | O número de Combate inicial do Jogador descendente desse Deus/Deusa   | Int          |         | Not Null                                                           |


### Tabela Região

| Tabela      | regiao                                                                                                                                      |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará informações referente as diferentes regiões existentes no mapa                                          |
| Observações | Essa tabela é uma específicação das diferentes regiões, a tabela area é responsável por armazenar as informações das diferentes areas existentes dentro de cada região |

| Nome             | Descrição                                                             | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ---------------- | --------------------------------------------------------------------- | ------------ | ------- | ------------------------------------------------------------------ |
| nome             | Nome que identifica unicamente uma região                                | Varchar      | 15      | PK/ Not Null                                                       |
| descricao    | Descrição detalhada de uma região e suas singularidades     | varchar          |   255      | Not Null                                                           |
| nivel | Referência ao nível da região, é utilizado como referência a fim de balancear os combates e desafios | Int          |         | Not Null                                                           |

### Tabela Área

| Tabela      | area                                                                                                                                      |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará informações referente as diferentes áreas existentes que compõe uma região                                          |
| Observações | Essa tabela é uma específicação de área |

| Nome             | Descrição                                                             | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ---------------- | --------------------------------------------------------------------- | ------------ | ------- | ------------------------------------------------------------------ |
| nome             | Nome que identifica unicamente uma área                                | Varchar      | 15      | PK/ FK/ Not Null                                                       |

### Tabela Desafio

| Tabela      | desafio                                                                                                                                      |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará informações referente aos desafios do jogo. Os desafios são situações ou obstáculos que o jogador deve enfrentar pra receber uma recompensa, escapar de uma armadilha ou alcançar um objetivo específico                                        |
| Observações | Um desafio pode ser uma provação ou armadilha, as tabelas provacao e armadilha, serão responsáveis por armazenar as informações dos diferentes tipos de desafio |

| Nome             | Descrição                                                             | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ---------------- | --------------------------------------------------------------------- | ------------ | ------- | ------------------------------------------------------------------ |
| idDesafio             | Número que identifica unicamente um desafio                                | SERIAL      |      | PK/ Not Null                                                       |
| descricao             | Descrição detalhada de um desafio e suas singularidades                                | int      |      | Not Null                                                       |
| DTForca             | Número de força mínima que um jogador deve possuir para vencer o desafio                                | int      |      | Not Null                                                       |
| DTAgilidade             | Número de agilidade mínima que um jogador deve possuir ppara vencer o desafio                                | int      |      | Not Null
| DTInteligencia             | Número de inteligencia mínima que um jogador deve possuir ppara vencer o desafio                                | int      |      | Not Null
| areaAtual             | Referência à área que o desafio se encontra dentro do mapa do jogo                                | varchar      |   15   | FK/Not Null

### Tabela Armadilha

| Tabela      | armadilha                                                                                                                                      |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará informações referente às armadilhas do jogo. Uma armadilha é uma situação perigosa preparada para pegar o jogador desprevenido, exigindo dele forca, agilidade e inteligencia para escapar                                     |
| Observações | Uma armadilha pode envolver resolver enigmas, enfrentar inimigos, ou superar obstáculos físicos e mentais |

| Nome             | Descrição                                                             | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ---------------- | --------------------------------------------------------------------- | ------------ | ------- | ------------------------------------------------------------------ |
| idArmadilha             | Número que identifica unicamente um desafio                                | SERIAL      |      | PK/ Not Null                                                       |
| areaTeletransporte             | Referência à área que o jogador será teletransportador caso caia na armadilha                                | varchar      |   15   | FK/ Not Null

### Tabela Provação

| Tabela      | provacao                                                                                                                                      |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará informações referente às provações do jogo. Uma provação é uma situação que testa as habilidades e conhecimentos ou moral do jogador                                     |
| Observações | Assim como as armadilhas, uma provação  pode envolver resolver enigmas, enfrentar inimigos, ou superar obstáculos físicos e mentais |

| Nome             | Descrição                                                             | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ---------------- | --------------------------------------------------------------------- | ------------ | ------- | ------------------------------------------------------------------ |
| idArmadilha             | Número que identifica unicamente um desafio                                | SERIAL      |      | PK/ Not Null                                                       |
| recompensa             | Referência a um item liberado para o jogador caso ele vença a provação                                | varchar      |  15    | FK/ Not Null                                                       |                                                       |

## Referência Bibliográfica

> 1. 

## Histórico de Versões

| Versão | Data  |                                         Descrição                                         |                 Responsável                  |
| :----: | :---: | :---------------------------------------------------------------------------------------: | :------------------------------------------: |
|  1.0   | 18/07 |                                   Criação do documento                                    | [@Neitan2001](https://github.com/Neitan2001) |
|  2.0   | 18/07 | Criação das tabelas Jogador, Inimigo, TipoPersonagem, Nível, InimigoConcreto, Abate, Deus | [@Neitan2001](https://github.com/Neitan2001) |
|  3.0   | 19/07 |      Ajuste das restrições das chaves primárias de Jogador, Inimigo e tipoPersonagem      | [@Neitan2001](https://github.com/Neitan2001) |
|  5.0   | 22/07 |                                Criação das tabelas Regiao, Area, Desafio, Armadilha, Provacao, Consumíveis                                | [@Paulo Henrique](https://github.com/owhenrique) |