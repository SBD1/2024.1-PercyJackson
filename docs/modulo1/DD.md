# Dicionário de Dados

## Tabelas

### Tabela Jogador

| Tabela      | jogador                                                                                                                                     |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará as informações referente ao personagem jogável do usuário                                                                        |
| Observações | Essa tabela é uma especificação de Personagem, a tabela tipoPersonagem será a responsável por armazenar as chaves e o tipo da especificação |

| Nome             | Descrição                                                                                                                                                                                                          | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------ | ------- | ------------------------------------------------------------------ |
| nome             | Nome que irá identificar unicamente o personagem do jogador                                                                                                                                                        | VARCHAR      | 15      | PK, FK, Not Null                                                   |
| defesa           | O número de defesa define a dificuldade para um atacante acertar um ataque. Esse valor é calculado com base no valor de agilidade                                                                                  | INTEGER      | -       | Not Null, Default = 10                                             |
| vidaMax          | O limite de vida do personagem. É separado da vida atual do personagem pois ele pode encontrar itens que recuperam a saúde, mas não deve passar desse limite                                                       | INTEGER      | -       | Not Null, Default = 50                                             |
| forca            | O número de força define o quão forte o personagem é. Quanto maior o valor, maiores são as chances do personagem conseguir quebrar/levantar coisas. A força também define quantos itens o personagem pode carregar | INTEGER      | -       | Not Null                                                           |
| intelecto        | O número de intelecto define o quão inteligente o personagem é. Quanto maior o valor, maiores são as chances do personagem conseguir desvendar enigmas, confundir/convencer inimigos                               | INTEGER      | -       | Not Null                                                           |
| agilidade        | O número de agilidade define o quão rápido o personagem é. Quanto maior o valor, maiores são as chances do personagem conseguir fugir de armadilhas, escapar de inimigos                                           | INTEGER      | -       | Not Null                                                           |
| combate          | O número de intelecto define o quão bom em combate o personagem é. Quanto maior o valor, maiores são as chances do personagem conseguir acertar ataques                                                            | INTEGER      | -       | Not Null                                                           |
| carga            | O número de carga define o multiplicador para definir quantos itens o personagem pode carregar. A quantidade de peso que o personagem consegue carregar é definido da seguinte forma: carga x forca                | INTEGER      | -       | Not Null, Default = 2                                              |
| vidaAtual        | A vida atual do personagem, ao chegar a 0 o personagem morre e o jogo deve começar do zero                                                                                                                         | INTEGER      | -       | Not Null, Default = 50, Check(vidaAtual <= vidaMax)                |
| experienciaAtual | Número de pontos que determina o nível do personagem                                                                                                                                                               | INTEGER      | -       | Not Null, Default = 0                                              |
| armadura         | Referência ao item de defesa que o personagem possui equipado. Oferece bônus no atributo de defesa. Quando o valor for "null", então o personagem não possui nenhum Item de defesa equipado                        | INTEGER      | -       | FK                                                                 |
| arma             | Referência ao item de ataque que o personagem possui equipado. Oferece bônus no atributo de força e combate. Quando o valor for "null", então o personagem não possui nenhum Item de ataque equipado               | INTEGER      | -       | FK                                                                 |
| itemMagico       | Referência ao item mágico que o personagem possui equipado. Oferece bônus em vários atributos dependendo do item. Quando o valor for "null", então o personagem não possui nenhum Item mágico equipado             | INTEGER      | -       | FK                                                                 |
| deus             | Referência ao deus que define os atributos inicias do personagem                                                                                                                                                   | VARCHAR      | 15      | FK, Not Null                                                       |
| areaAtual        | Referência à área que o personagem se encontra dentro do mapa do jogo                                                                                                                                              | VARCHAR      | 15      | FK, Not Null                                                       |
| nivel            | Referência ao nível atual do personagem. Ao atingir os pontos base do próximo nível, o personagem muda para o nível acima do atual                                                                                 | INTEGER      | -       | FK, Not Null, Default = 1                                          |

### Tabela Inimigo

| Tabela      | inimigo                                                                                                                                                                                                                   |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará as informações referente a um inimigo do jogo. Um inimigo é uma criatura com o objetivo de matar o personagem do jogador                                                                                       |
| Observações | Essa tabela é uma especificação de Personagem, a tabela tipoPersonagem será a responsável por armazenar as chaves e o tipo da especificação. Esta tabela defini uma "ficha" de inimigo que irá gerar "Inimigos Concretos" |

| Nome              | Descrição                                                                                                                                                                                                          | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------ | ------- | ------------------------------------------------------------------ |
| nome              | Nome que irá identificar unicamente o personagem do inimigo                                                                                                                                                        | VARCHAR      | 15      | PK, FK, Not Null                                                   |
| defesa            | O número de defesa define a dificuldade para um atacante acertar um ataque. Esse valor é calculado com base no valor de agilidade                                                                                  | INTEGER      |         | Not Null, Default = 10                                             |
| vidaMax           | O limite de vida do personagem. É separado da vida atual do personagem pois ele pode encontrar itens que recuperam a saúde, mas não deve passar desse limite                                                       | INTEGER      |         | Not Null                                                           |
| forca             | O número de força define o quão forte o personagem é. Quanto maior o valor, maiores são as chances do personagem conseguir quebrar/levantar coisas. A força também define quantos itens o personagem pode carregar | INTEGER      |         | Not Null                                                           |
| intelecto         | O número de intelecto define o quão inteligente o personagem é. Quanto maior o valor, maiores são as chances do personagem conseguir desvendar enigmas, confundir/convencer inimigos                               | INTEGER      |         | Not Null                                                           |
| agilidade         | O número de agilidade define o quão rápido o personagem é. Quanto maior o valor, maiores são as chances do personagem conseguir fugir de armadilhas, escapar de inimigos                                           | INTEGER      |         | Not Null                                                           |
| combate           | O número de intelecto define o quão bom em combate o personagem é. Quanto maior o valor, maiores são as chances do personagem conseguir acertar ataques                                                            | INTEGER      |         | Not Null                                                           |
| pontosExperiencia | O número de pontos de experiência que um jogador ganha ao derrotar uma instância deste inimigo                                                                                                                     | INTEGER      |         | Not Null                                                           |
| nivel             | Referência ao nível atual do personagem. Diferente do jogador, o nível do inimigo não muda. Ele é usado como referência a fim de balancear os combates                                                             | INTEGER      |         | FK, Not Null                                                       |

### Tabela TipoPersonagem

| Tabela      | tipoPersonagem                                                                                      |
| ----------- | --------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará a relação de nome do Personagem com o tipo dele, Jogador ou Inimigo                      |
| Observações | Esta tabela possui a finalidade de diferenciar quais personagens são Jogadores e Quais são Inimigos |

| Nome | Descrição                                                                                                                                                             | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ---- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ | ------- | ------------------------------------------------------------------ |
| nome | Nome que irá identificar unicamente um personagem                                                                                                                     | VARCHAR      | 15      | PK, Not Null                                                       |
| tipo | Este atributo especifica se o Personagem é um Jogador ou um Inimigo. Os valores permitidos para este atributo será o caracter 'J', para Jogador, ou 'I', para Inimigo | CHAR         | 1       | Check (tipo == 'J' or tipo == 'I')                                 |

### Tabela Nível

| Tabela      | nivel                                                            |
| ----------- | ---------------------------------------------------------------- |
| Descrição   | Armazenará os pontos necessários para atingir cada um dos níveis |
| Observações |                                                                  |

| Nome              | Descrição                                                                                                                                                                     | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ | ------- | ------------------------------------------------------------------ |
| idNivel           | Um número sequencial que indica o nível de um personagem. Quanto maior o nível, mais poderoso o personagem é                                                                  | INTEGER      |         | PK, Not Null, Identity                                             |
| pontosExperiencia | O número de pontos necessário para atingir o nível. O número de pontos de um nível precisa ser maior do que o anterior. Essa checagem deverá ser feita por meio de um trigger | INTEGER      |         | Not Null                                                           |

### Tabela InimigoConcreto

| Tabela      | inimigoConcreto                                                                                                   |
| ----------- | ----------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará as informações da instância de um inimigo                                                              |
| Observações | Esta tabela existe a fim de reutilizar informações da tabela Inimigo e evitar redundâncias e sobrecarga no banco. |

| Nome         | Descrição                                                                                                                                                                                                                            | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------ | ------- | ------------------------------------------------------------------ |
| nomeConcreto | O nome que identifica unicamente uma instância de Inimigo                                                                                                                                                                            | VARCGAR      | 15      | PK, Not Null                                                       |
| vidaAtual    | A vida atual da instância de Inimigo, ao chegar a 0 a instância é derrotada. O valor inicial deste atributo deve ser o mesmo valor do atributo vidaMax do Inimigo gerador da instância, isso poderá ser feito a partir de um trigger | INTEGER      |         | Not Null                                                           |
| inimigo      | Referência ao Inimigo gerador desta instância                                                                                                                                                                                        | VARCHAR      | 15      | FK, Not Null                                                       |
| areaAtual    | Referência à área que o personagem se encontra dentro do mapa do jogo                                                                                                                                                                | VARCHAR      | 25      | FK, Not Null                                                       |
| loot         | Referência ao item que o jogador ganha ao derrotar esta instância de Inimigo                                                                                                                                                         | INTEGER      |         | FK, Not Null                                                       |

### Tabela Abate

| Tabela      | abate                                                                                                                                                                                                                                                                                          |
| ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará a quantidade de instâncias de um mesmo Inimigo que um Jogador derrotou                                                                                                                                                                                                              |
| Observações | Possui uma chave primária composta com os atributos nomeJogador e nomeInimigo. Quando um jogador derrotar um Inimigo, deve verificar se já existe uma tupla de abate com o mesmo Jogador e Inimigo: se não existir, deve criar uma tupla, e se existir, deve incrementar o atributo quantidade |

| Nome        | Descrição                                                                                | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ----------- | ---------------------------------------------------------------------------------------- | ------------ | ------- | ------------------------------------------------------------------ |
| nomeJogador | Nome do jogador que realizou o abate de um Inimigo                                       | VARCHAR      | 15      | PK, FK Not Null                                                    |
| nomeInimigo | nome do Inimigo derrotado por um Jogador                                                 | VARCHAR      | 15      | PK, FK Not Null                                                    |
| quantidade  | Número que indica a quantidade de instância de um mesmo Inimigo derrotado por um Jogador | INTEGER      |         | Not Null, Default = 0                                              |

### Tabela Deus

| Tabela      | deus                                                                                                                                      |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará os atributos iniciais dados ao Personagem que escolhe um Deus/Deusa como seu pai/mãe                                           |
| Observações | Os atributos iniciais de forca, intelecto, agilidade e combate são definidos pelo Deus/Deusa que o Jogador escolher ao criar o personagem |

| Nome             | Descrição                                                             | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ---------------- | --------------------------------------------------------------------- | ------------ | ------- | ------------------------------------------------------------------ |
| nome             | Nome que identifica unicamente um Deus                                | VARCHAR      | 15      | PK, Not Null                                                       |
| forcaInicial     | O número de Força inicial do Jogador descendente desse Deus/Deusa     | INTEGER      |         | Not Null, Check (Valores entre 0 e 5)                              |
| intelectoInicial | O número de Intelecto inicial do Jogador descendente desse Deus/Deusa | INTEGER      |         | Not Null, Check (Valores entre 0 e 5)                              |
| agilidadeInicial | O número de Agilidade inicial do Jogador descendente desse Deus/Deusa | INTEGER      |         | Not Null, Check (Valores entre 0 e 5)                              |
| combateInicial   | O número de Combate inicial do Jogador descendente desse Deus/Deusa   | INTEGER      |         | Not Null, Check (Valores entre 0 e 5)                              |

### Tabela Inventario

| Tabela    | inventario                                                                                                                                            |
| --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição | Armazenará a relação entre os jogadores e os itens que possuem. Ela registra quantos itens de um determinado tipo cada jogador tem em seu inventário. |

| Nome       | Descrição                                | Tipo de dado | Tamanho | Restrições de domínio             |
| ---------- | ---------------------------------------- | ------------ | ------- | --------------------------------- |
| jogador    | Identificador do jogador                 | INTEGER      | -       | PK, FK, Not Null                  |
| item       | Identificador do item                    | INTEGER      | -       | PK, FK, Not Null                  |
| quantidade | Quantidade do item no estoque do jogador | INTEGER      | -       | Not Null, Check (quantidade >= 0) |

### Tabela Item

| Tabela      | tipoItem                                                                                                                                                                                                                                                                |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará informações gerais sobre todos os itens disponíveis no jogo. Cada registro representa um item com detalhes como nome, descrição, peso e classificação. A classificação indicará qual especificação o item é, podendo ser: defesa, ataque, magico, consumivel |
| Observações | Esta tabela possui a finalidade de diferenciar os itens                                                                                                                                                                                                                 |

| Nome          | Descrição                         | Tipo de dado | Tamanho | Restrições de domínio                                                           |
| ------------- | --------------------------------- | ------------ | ------- | ------------------------------------------------------------------------------- |
| id            | Identificador único do item       | INTEGER      | -       | PK, Identity                                                                    |
| nome          | Nome do item                      | VARCHAR      | 15      | Not Null                                                                        |
| descricao     | Descrição detalhada do item       | TEXT         | -       |                                                                                 |
| peso          | Peso do item em unidades de massa | FLOAT        | -       | Check (peso >= 0)                                                               |
| classificacao | Classificação do item             | VARCHAR      | 15      | Not Null, Check (classificacao in ('Arma', 'Armadura', 'Consumível', 'Mágico')) |

### Tabela Defesa

| Tabela      | defesa                                                                                                                                                                           |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará informações específicas sobre itens de defesa, como escudos ou armaduras. Cada registro inclui o nome do item e o valor do modificador de defesa que ele proporciona. |
| Observações | Essa tabela é uma especificação de Item, a tabela tipoItem será a responsável por armazenar o id, nome, descrição, peso e a classificação                                        |

| Nome      | Descrição                      | Tipo de dado | Tamanho | Restrições de domínio  |
| --------- | ------------------------------ | ------------ | ------- | ---------------------- |
| id        | Identificador único de defesa  | INTEGER      | -       | PK, Identity           |
| nome      | Nome do item de defesa         | VARCHAR      | 15      | Not Null, FK           |
| modDefesa | Valor do modificador de defesa | INTEGER      | -       | Check (modDefesa >= 0) |

### Tabela Ataque

| Tabela      | ataque                                                                                                                                                                  |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará informações sobre itens de ataque, como armas. Cada registro inclui o nome do item e os valores dos modificadores de combate e de força que ele proporciona. |
| Observações | Essa tabela é uma especificação de Item, a tabela tipoItem será a responsável por armazenar o id, nome, descrição, peso e a classificação                               |

| Nome       | Descrição                       | Tipo de dado | Tamanho | Restrições de domínio   |
| ---------- | ------------------------------- | ------------ | ------- | ----------------------- |
| id         | Identificador único de ataque   | INTEGER      | -       | PK, Identity            |
| nome       | Nome do item de ataque          | VARCHAR      | 15      | Not Null, FK            |
| modCombate | Valor do modificador de combate | INTEGER      | -       | Check (modCombate >= 0) |
| modForca   | Valor do modificador de força   | INTEGER      | -       | Check (modForca >= 0)   |

### Tabela Magico

| Tabela      | magico                                                                                                                                                                                                 |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Descrição   | Armazenará informações sobre itens mágicos. Cada registro contém o nome do item mágico e os valores dos modificadores de combate, força, defesa, agilidade, carga, além dos tempos de recarga e atual. |
| Observações | Essa tabela é uma especificação de Item, a tabela tipoItem será a responsável por armazenar o id, nome, descrição, peso e a classificação                                                              |

| Nome           | Descrição                              | Tipo de dado | Tamanho | Restrições de domínio       |
| -------------- | -------------------------------------- | ------------ | ------- | --------------------------- |
| id             | Identificador único de item mágico     | INTEGER      | -       | PK, Identity                |
| nome           | Nome do item mágico                    | VARCHAR      | 15      | Not Null, FK                |
| modCombate     | Valor do modificador de combate mágico | INTEGER      | -       | Check (modCombate >= 0)     |
| modForca       | Valor do modificador de força mágica   | INTEGER      | -       | Check (modForca >= 0)       |
| modDefesa      | Valor do modificador de defesa mágica  | INTEGER      | -       | Check (modDefesa >= 0)      |
| modAgilidade   | Valor do modificador de agilidade      | INTEGER      | -       | Check (modAgilidade >= 0)   |
| modCarga       | Valor do modificador de carga mágica   | INTEGER      | -       | Check (modCarga >= 0)       |
| tempoDeRecarga | Tempo de recarga em segundos           | INTEGER      | -       | Check (tempoDeRecarga >= 0) |
| tempoAtual     | Tempo atual em segundos                | INTEGER      | -       | Check (tempoAtual >= 0)     |

### Tabela Consumíveis

| Tabela      | consumíveis                                                                                                                                                |
| ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará informações sobre itens consumíveis, como poções. Cada registro inclui o nome do item e a quantidade de vida que ele recupera quando utilizado. |
| Observações | Essa tabela é uma especificação de Item, a tabela tipoItem será a responsável por armazenar o id, nome, descrição, peso e a classificação                  |

| Nome           | Descrição                                     | Tipo de dado | Tamanho | Restrições de domínio       |
| -------------- | --------------------------------------------- | ------------ | ------- | --------------------------- |
| id             | Identificador único de consumível             | INTEGER      | -       | PK, Identity                |
| nome           | Nome do item consumível                       | VARCHAR      | 15      | Not Null, FK                |
| vidaRecuperada | Quantidade de vida recuperada pelo consumível | INTEGER      | -       | Check (vidaRecuperada >= 0) |

### Tabela Aliado

| Tabela      | aliado                                                                                                              |
| ----------- | ------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará informações sobre aliados. Cada registro contém o nome deste aliado, a sua descrição e a área que ocupa. |
| Observações |                                                                                                                     |

| Nome      | Descrição                                                         | Tipo de dado | Tamanho | Restrições de domínio |
| --------- | ----------------------------------------------------------------- | ------------ | ------- | --------------------- |
| nome      | Identificador único de aliado                                     | VARCHAR      | 15      | PK, Not Null          |
| descricao | Descrição do aliado a ser apresentada                             | TEXT         | -       | Not Null              |
| nomeArea  | Referência à área que o aliado se encontra dentro do mapa do jogo | VARCHAR      | 15      | FK, Not Null          |

### Tabela Dialogo

| Tabela      | dialogo                                                                                                           |
| ----------- | ----------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará informações sobre os dialogos dos aliados. Cada registro contém o número do diálogo e o nome do aliado |
| Observações | Esta tabela também possui referências à tabela resposta                                                           |

| Nome       | Descrição                          | Tipo de dado | Tamanho | Restrições de domínio |
| ---------- | ---------------------------------- | ------------ | ------- | --------------------- |
| numero     | Identificador único do dialogo     | INTEGER      | -       | PK, Not Null          |
| nomeAliado | Identificador do aliado            | VARCHAR      | 15      | PK, FK, Not Null      |
| frase      | Frase a ser apresentada ao jogador | TEXT         | -       | Not Null              |

### Tabela Resposta

| Tabela      | resposta                                                                                            |
| ----------- | --------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará informações sobre as respostas. Cada registro contém identificador e a frase da resposta |
| Observações | Possui referência à entidade dialogo                                                                |

| Nome          | Descrição                          | Tipo de dado | Tamanho | Restrições de domínio |
| ------------- | ---------------------------------- | ------------ | ------- | --------------------- |
| numero        | Identificador da resposta          | INTEGER      | -       | PK, Not Null          |
| numeroDialogo | Identificador do dialogo           | INTEGER      | -       | PK, FK, Not Null      |
| nomeAliado    | Identificador do aliado            | VARCHAR      | 15      | PK, FK, Not Null      |
| frase         | Frase a ser apresentada ao jogador | TEXT         | -       | Not Null              |

### Tabela Profecia

| Tabela      | profecia                                                                                                                                                        |
| ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará informações sobre as profecias. Cada registro contém identificador, um inimigo a dizimar, quantidade necessária e turnos a serem adicionados ao jogo |
| Observações | Possui referência à entidade inimigo                                                                                                                            |

| Nome          | Descrição                                      | Tipo de dado | Tamanho | Restrições de domínio |
| ------------- | ---------------------------------------------- | ------------ | ------- | --------------------- |
| idProfecia    | Identificador da profecia                      | INTEGER      | -       | PK, Identity          |
| numaroDialogo | Referência ao dialogo                          | INTEGER      | -       | FK, Not Null          |
| nomeAliado    | Referência ao aliado que fornece a profecia    | VARCHAR      | 15      | FK, Not Null          |
| nomeInimigo   | Referência ao inimigo a ser derrotado          | VARCHAR      | 15      | FK, Not Null          |
| quantAbate    | Quantidade de unidades a serem derortadas      | INTEGER      | -       | Not Null              |
| turnosAMais   | Quantidade de turnos de recompensa da profecia | INTEGER      | -       | Not Null              |

### Tabela Adquire

| Tabela      | adquire                                                                                                                                                 |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Tabela de relacionamento entre um jogador e uma profecia que ele carrega. Cada registro as referências aos mesmos e o status de cumprimento da profecia |
| Observações |                                                                                                                                                         |

| Nome           | Descrição                                    | Tipo de dado | Tamanho | Restrições de domínio |
| -------------- | -------------------------------------------- | ------------ | ------- | --------------------- |
| nomeJogador    | Referência ao jogador que carrega a profecia | VARCHAR      | 15      | PK, FK, Not Null      |
| numeroProfecia | Referência à profecia carregada pelo jogador | INTEGER      | -       | PK, FK, Not Null      |
| completado     | Status de cumprimento da profecia            | Boolean      | -       | Not Null              |

### Tabela Região

| Tabela      | regiao                                                                                                                                                                 |
| ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará informações referente as diferentes regiões existentes no mapa                                                                                              |
| Observações | Essa tabela é uma específicação das diferentes regiões, a tabela area é responsável por armazenar as informações das diferentes areas existentes dentro de cada região |

| Nome      | Descrição                                                                                        | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| --------- | ------------------------------------------------------------------------------------------------ | ------------ | ------- | ------------------------------------------------------------------ |
| nome      | Nome que identifica unicamente uma região                                                        | VARCHAR      | 15      | PK/ Not Null                                                       |
| descricao | Descrição detalhada de uma região e suas singularidades                                          | TEXT         | -       | Not Null                                                           |
| nivel     | A referência ao nível da região é utilizada como parâmetro para balancear os combates e desafios | INTEGER      |         | Not Null                                                           |

### Tabela Área

| Tabela      | area                                                                                  |
| ----------- | ------------------------------------------------------------------------------------- |
| Descrição   | Armazenará informações referente as diferentes áreas existentes que compõe uma região |
| Observações | Essa tabela é uma específicação de área                                               |

| Nome        | Descrição                                                         | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ----------- | ----------------------------------------------------------------- | ------------ | ------- | ------------------------------------------------------------------ |
| nome        | Nome que identifica unicamente uma área                           | VARCHAR      | 15      | PK, Not Null                                                       |
| regiaoAtual | Referência à Região que a área se encontra dentro do mapa do jogo | VARCHAR      | 15      | FK, Not Null                                                       |
| desafio     | Referência ao desafio que se encontra dentro da área              | INTEGER      |         | FK, Not Null                                                       |

### Tabela Desafio

| Tabela      | desafio                                                                                                                                                                                                             |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará informações referente aos desafios do jogo. Os desafios são situações ou obstáculos que o jogador deve enfrentar pra receber uma recompensa, escapar de uma armadilha ou alcançar um objetivo específico |
| Observações | Um desafio pode ser uma provação ou armadilha, as tabelas provacao e armadilha, serão responsáveis por armazenar as informações dos diferentes tipos de desafio                                                     |

| Nome        | Descrição                                                          | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ----------- | ------------------------------------------------------------------ | ------------ | ------- | ------------------------------------------------------------------ |
| idDesafio   | Número que identifica unicamente um desafio                        | INTEGER      |         | PK, Identity                                                       |
| tipoDesafio | Variável para identificar o  tipo de desafio (armação ou provação) | CHAR         | 15      | Check (tipoDesafio == 'a' or tipoDesafio == 'p')                   |

### Tabela Armadilha

| Tabela      | armadilha                                                                                                                                                                                             |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará informações referente às armadilhas do jogo. Uma armadilha é uma situação perigosa preparada para pegar o jogador desprevenido, exigindo dele forca, agilidade e inteligencia para escapar |
| Observações | Uma armadilha pode envolver resolver enigmas, enfrentar inimigos, ou superar obstáculos físicos e mentais                                                                                             |

| Nome               | Descrição                                                                          | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ------------------ | ---------------------------------------------------------------------------------- | ------------ | ------- | ------------------------------------------------------------------ |
| idArmadilha        | Número que identifica unicamente uma armadilha                                     | INTEGER      |         | PK, FK, Identity                                                   |
| descricao          | Descrição detalhada de uma armadilha e suas singularidades                         | TEXT         | -       | Not Null                                                           |
| DTForca            | Número de força mínima que um jogador deve possuir para vencer a armadilha         | INTEGER      |         | Not Null                                                           |
| DTAgilidade        | Número de agilidade mínima que um jogador deve possuir para vencer a armadilha     | INTEGER      |         | Not Null                                                           |
| DTInteligencia     | Número de inteligência mínima que um jogador deve possuir para vencer a armadilha  | INTEGER      |         | Not Null                                                           |
| areaTeletransporte | Referência à área para onde o jogador será teletransportado caso caia na armadilha | VARCHAR      | 15      | FK, Not Null                                                       |

### Tabela Provação

| Tabela      | provacao                                                                                                                                        |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| Descrição   | Armazenará informações referente às provações do jogo. Uma provação é uma situação que testa as habilidades e conhecimentos ou moral do jogador |
| Observações | Assim como as armadilhas, uma provação  pode envolver resolver enigmas, enfrentar inimigos, ou superar obstáculos físicos e mentais             |

| Nome           | Descrição                                                                        | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| -------------- | -------------------------------------------------------------------------------- | ------------ | ------- | ------------------------------------------------------------------ |
| idProvacao     | Número que identifica unicamente uma provação                                    | INTEGER      |         | PK, FK, Identity                                                   |
| descricao      | Descrição detalhada de uma provação e suas singularidades                        | TEXT         | -       | Not Null                                                           |
| DTForca        | Número de força mínima que um jogador deve possuir para vencer a provação        | INTEGER      |         | Not Null                                                           |
| DTAgilidade    | Número de agilidade mínima que um jogador deve possuir para vencer a provação    | INTEGER      |         | Not Null                                                           |
| DTInteligencia | Número de inteligência mínima que um jogador deve possuir para vencer a provação | INTEGER      |         | Not Null                                                           |
| recompensa     | Referência ao item que o jogador receberá caso vença a provação                  | VARCHAR      | 15      | FK, Not Null                                                       |

## Histórico de Versões

| Versão | Data  |                                         Descrição                                         |                      Responsável                      |
| :----: | :---: | :---------------------------------------------------------------------------------------: | :---------------------------------------------------: |
|  1.0   | 18/07 |                                   Criação do documento                                    |     [@Neitan2001](https://github.com/Neitan2001)      |
|  2.0   | 18/07 | Criação das tabelas Jogador, Inimigo, TipoPersonagem, Nível, InimigoConcreto, Abate, Deus |     [@Neitan2001](https://github.com/Neitan2001)      |
|  3.0   | 19/07 |      Ajuste das restrições das chaves primárias de Jogador, Inimigo e tipoPersonagem      |     [@Neitan2001](https://github.com/Neitan2001)      |
|  4.0   | 22/07 |         Criação das tabelas Inventário, Item, Defesa, Ataque, Magico, Consumíveis         |  [Clara Marcelino](https://github.com/clara-ribeiro)  |
|  5.0   | 22/07 |             Criação das tabelas Aliado, Dialogo, Resposta, Profecia, Adquire              | [Charles Serafim](https://github.com/charles-serafim) |
|  6.0   | 22/07 |        Criação das tabelas Regiao, Area, Desafio, Armadilha, Provacao, Consumíveis        |    [Paulo Henrique](https://github.com/owhenrique)    |
|  7.0   | 06/08 |  Correção de inconsistências e adições de checks em atributos de Jogador, tipoPersonagem  |     [@Neitan2001](https://github.com/Neitan2001)      |