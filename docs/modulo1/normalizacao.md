# Normalização

## Tabelas

## Tabela Jogador

De acordo com o dicionário de dados da [Tabela de Jogador](./DD.md#tabela-jogador), a dependência funcional dessa tabela é a seguinte:

nome ➡️ defesa, vidaMax, forca, intelecto, agilidade, combate, carga, vidaAtual, experienciaAtual, armadura, arma, itemMagico, deus, areaAtual, nivel

"nome" é o único atributo que não se repete na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- 1° Forma Normal: Todos os atributos são atômicos e monovalorados
- 2° Forma Normal: Há somente um único atributo como chave, logo não há atributos comuns dependentes parcialmente de uma chave
- 3° Forma Normal: Nenhum atributo comum depende transitivamente de qualquer superchave
- Forma Normal de Boyce-Codd: para cada depedência funcional, o lado esquerdo é uma chave candidata
- 4° Forma Normal: Não há dependências multivaloradas

## Tabela Inimigo

De acordo com o dicionário de dados da [Tabela de Inimigo](./DD.md#tabela-inimigo), a dependência funcional dessa tabela é a seguinte:

nome ➡️ defesa, vidaMax, forca, intelecto, agilidade, combate, pontosExperiencia ,nivel

"nome" é o único atributo que não se repete na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- 1° Forma Normal: Todos os atributos são atômicos e monovalorados
- 2° Forma Normal: Há somente um único atributo como chave, logo não há atributos comuns dependentes parcialmente de uma chave
- 3° Forma Normal: Nenhum atributo comum depende transitivamente de qualquer superchave
- Forma Normal de Boyce-Codd: para cada depedência funcional, o lado esquerdo é uma chave candidata
- 4° Forma Normal: Não há dependências multivaloradas
- 
## Tabela TipoPersonagem

De acordo com o dicionário de dados da [Tabela de TipoPersonagem](./DD.md#tabela-tipopersonagem), a dependência funcional dessa tabela é a seguinte:

nome ➡️ tipo

"nome" é o único atributo que não se repete na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- 1° Forma Normal: Todos os atributos são atômicos e monovalorados
- 2° Forma Normal: Há somente um único atributo como chave, logo não há atributos comuns dependentes parcialmente de uma chave
- 3° Forma Normal: Nenhum atributo comum depende transitivamente de qualquer superchave
- Forma Normal de Boyce-Codd: para cada depedência funcional, o lado esquerdo é uma chave candidata
- 4° Forma Normal: Não há dependências multivaloradas

## Tabela Nível

De acordo com o dicionário de dados da [Tabela de Nível](./DD.md#tabela-nivel), a dependência funcional dessa tabela é a seguinte:

idNivel ➡️ pontosExperiencia

"idNivel" é o único atributo que não se repete na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- 1° Forma Normal: Todos os atributos são atômicos e monovalorados
- 2° Forma Normal: Há somente um único atributo como chave, logo não há atributos comuns dependentes parcialmente de uma chave
- 3° Forma Normal: Nenhum atributo comum depende transitivamente de qualquer superchave
- Forma Normal de Boyce-Codd: para cada depedência funcional, o lado esquerdo é uma chave candidata
- 4° Forma Normal: Não há dependências multivaloradas

## Tabela InimigoConcreto

De acordo com o dicionário de dados da [Tabela de InimigoConcreto](./DD.md#tabela-inimigoconcreto), a dependência funcional dessa tabela é a seguinte:

nomeConcreto ➡️ vidaAtual, inimigo, areaAtual, loot

"nomeConcreto" é o único atributo que não se repete na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- 1° Forma Normal: Todos os atributos são atômicos e monovalorados
- 2° Forma Normal: Há somente um único atributo como chave, logo não há atributos comuns dependentes parcialmente de uma chave
- 3° Forma Normal: Nenhum atributo comum depende transitivamente de qualquer superchave
- Forma Normal de Boyce-Codd: para cada depedência funcional, o lado esquerdo é uma chave candidata
- 4° Forma Normal: Não há dependências multivaloradas

## Tabela Abate

De acordo com o dicionário de dados da [Tabela de Abate](./DD.md#tabela-abate), a dependência funcional dessa tabela é a seguinte:

nomeJogador, nomeInimigo ➡️ quantidade

"nomeJogador" e "nomeInimigo" são os únicos atributos que não se repetem na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- 1° Forma Normal: Todos os atributos são atômicos e monovalorados
- 2° Forma Normal: Há somente um único atributo como chave, logo não há atributos comuns dependentes parcialmente de uma chave
- 3° Forma Normal: Nenhum atributo comum depende transitivamente de qualquer superchave
- Forma Normal de Boyce-Codd: para cada depedência funcional, o lado esquerdo é uma chave candidata
- 4° Forma Normal: Não há dependências multivaloradas

## Tabela Deus

De acordo com o dicionário de dados da [Tabela de Deus](./DD.md#tabela-deus), a dependência funcional dessa tabela é a seguinte:

nome ➡️ forcaInicial, intelectoInicial, agilidadeInicial, combateInicial

"nome" é o único atributo que não se repete na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.
Esta tabela está dentro das seguintes Formas Normais:

- 1° Forma Normal: Todos os atributos são atômicos e monovalorados
- 2° Forma Normal: Há somente um único atributo como chave, logo não há atributos comuns dependentes parcialmente de uma chave
- 3° Forma Normal: Nenhum atributo comum depende transitivamente de qualquer superchave
- Forma Normal de Boyce-Codd: para cada depedência funcional, o lado esquerdo é uma chave candidata
- 4° Forma Normal: Não há dependências multivaloradas

## Tabela Inventário

De acordo com o dicionário de dados da [Tabela inventário](./DD.md#tabela-inventário), a dependência funcional dessa tabela é a seguinte:

jogador, item ➡️ quantidade

"jogador, item" é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- **1° Forma Normal:** Está em 1NF, pois todos os atributos contêm valores atômicos.
- **2° Forma Normal:** Está em 2NF, pois não há dependências parciais; todos os atributos não chave dependem da chave primária inteira.
- **3° Forma Normal:** Está em 3NF, pois não há dependências transitivas; a única dependência funcional não trivial é jogador, item ➡️ quantidade.
- **Forma Normal de Boyce-Codd:** Está em BCNF, pois cada determinante é uma superchave.
- **4° Forma Normal:** Está em 4NF, pois não há dependências multivaloradas não triviais.

## Tabela item

De acordo com o dicionário de dados da [Tabela item](./DD.md#tabela-item), a dependência funcional dessa tabela é a seguinte:

id ➡️ nome, descricao, peso, classificacao

"id" é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- **1° Forma Normal:** Está em 1NF, pois todos os atributos contêm valores atômicos.
- **2° Forma Normal:** Está em 2NF, pois não há dependências parciais; todos os atributos não chave dependem da chave primária inteira.
- **3° Forma Normal:** Está em 3NF, pois não há dependências transitivas; a única dependência funcional não trivial é id ➡️ nome, descricao, peso, classificacao.
- **Forma Normal de Boyce-Codd:** Está em BCNF, pois cada determinante é uma superchave.
- **4° Forma Normal:** Está em 4NF, pois não há dependências multivaloradas não triviais.

## Tabela defesa

De acordo com o dicionário de dados da [Tabela defesa](./DD.md#tabela-defesa), a dependência funcional dessa tabela é a seguinte:

id ➡️ nome, modDefesa

"id" é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- **1° Forma Normal:** Está em 1NF, pois todos os atributos contêm valores atômicos.
- **2° Forma Normal:** Está em 2NF, pois não há dependências parciais; todos os atributos não chave dependem da chave primária inteira.
- **3° Forma Normal:** Está em 3NF, pois não há dependências transitivas; a única dependência funcional não trivial é id ➡️ nome, modDefesa.
- **Forma Normal de Boyce-Codd:** Está em BCNF, pois cada determinante é uma superchave.
- **4° Forma Normal:** Está em 4NF, pois não há dependências multivaloradas não triviais.

## Tabela ataque

De acordo com o dicionário de dados da [Tabela ataque](./DD.md#tabela-ataque), a dependência funcional dessa tabela é a seguinte:

id ➡️ nome, modCombate, modForca

"id" é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- **1° Forma Normal:** Está em 1NF, pois todos os atributos contêm valores atômicos.
- **2° Forma Normal:** Está em 2NF, pois não há dependências parciais; todos os atributos não chave dependem da chave primária inteira.
- **3° Forma Normal:** Está em 3NF, pois não há dependências transitivas; a única dependência funcional não trivial é id ➡️ nome, modCombate, modForca.
- **Forma Normal de Boyce-Codd:** Está em BCNF, pois cada determinante é uma superchave.
- **4° Forma Normal:** Está em 4NF, pois não há dependências multivaloradas não triviais.

## Tabela magico

De acordo com o dicionário de dados da [Tabela magico](./DD.md#tabela-magico), a dependência funcional dessa tabela é a seguinte:

id ➡️ nome, modCombate, modForca, modDefesa, modAgilidade, modCarga, tempoDeRecarga, tempoAtual

"id" é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- **1° Forma Normal:** Está em 1NF, pois todos os atributos contêm valores atômicos.
- **2° Forma Normal:** Está em 2NF, pois não há dependências parciais; todos os atributos não chave dependem da chave primária inteira.
- **3° Forma Normal:** Está em 3NF, pois não há dependências transitivas; a única dependência funcional não trivial é id ➡️ nome, modCombate, modForca, modDefesa, modAgilidade, modCarga, tempoDeRecarga, tempoAtual.
- **Forma Normal de Boyce-Codd:** Está em BCNF, pois cada determinante é uma superchave.
- **4° Forma Normal:** Está em 4NF, pois não há dependências multivaloradas não triviais.

## Tabela consumíveis

De acordo com o dicionário de dados da [Tabela consumíveis](./DD.md#tabela-consumíveis), a dependência funcional dessa tabela é a seguinte:

id ➡️ nome, vidaRecuperada

"id" é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- **1° Forma Normal:** Está em 1NF, pois todos os atributos contêm valores atômicos.
- **2° Forma Normal:** Está em 2NF, pois não há dependências parciais; todos os atributos não chave dependem da chave primária inteira.
- **3° Forma Normal:** Está em 3NF, pois não há dependências transitivas; a única dependência funcional não trivial é id ➡️ nome, vidaRecuperada.
- **Forma Normal de Boyce-Codd:** Está em BCNF, pois cada determinante é uma superchave.
- **4° Forma Normal:** Está em 4NF, pois não há dependências multivaloradas não triviais.

## Tabela Aliado

De acordo com o dicionário de dados da [Tabela Aliado](./DD.md#tabela-aliado), a dependência funcional dessa tabela é a seguinte:

nome ➡️ descricao, nomeArea

"nome" é o único atributo que não se repete na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- **1° Forma Normal:** Está em 1NF, pois todos os atributos contêm valores atômicos.
- **2° Forma Normal:** Está em 2NF, pois não há dependências parciais; todos os atributos não chave dependem da chave primária inteira.
- **3° Forma Normal:** Está em 3NF, pois não há dependências transitivas; a única dependência funcional não trivial é nome ➡️ descricao, nomeArea.
- **Forma Normal de Boyce-Codd:** Está em BCNF, pois cada determinante é uma superchave.
- **4° Forma Normal:** Está em 4NF, pois não há dependências multivaloradas não triviais.

## Tabela Dialogo

De acordo com o dicionário de dados da [Tabela Dialogo](./DD.md#tabela-dialogo), a dependência funcional dessa tabela é a seguinte:

nomePersonagem, numeroDialogo ➡️ frase

"nomePersonagem, numeroDialogo" é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- **1° Forma Normal:** Está em 1NF, pois todos os atributos contêm valores atômicos.
- **2° Forma Normal:** Está em 2NF, pois não há dependências parciais; todos os atributos não chave dependem da chave primária inteira.
- **3° Forma Normal:** Está em 3NF, pois não há dependências transitivas; a única dependência funcional não trivial é nomePersonagem, numeroDialogo ➡️ conteudo.
- **Forma Normal de Boyce-Codd:** Está em BCNF, pois cada determinante é uma superchave.
- **4° Forma Normal:** Está em 4NF, pois não há dependências multivaloradas não triviais.

## Tabela Resposta

De acordo com o dicionário de dados da [Tabela Resposta](./DD.md#tabela-resposta), a dependência funcional dessa tabela é a seguinte:

nomePersonagem, numeroDialogo, numeroResposta ➡️ frase, numeroDialogoDestino, nomeAliadoDestino

"nomePersonagem, numeroDialogo, numeroResposta" é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- **1° Forma Normal:** Está em 1NF, pois todos os atributos contêm valores atômicos.
- **2° Forma Normal:** Está em 2NF, pois não há dependências parciais; todos os atributos não chave dependem da chave primária inteira.
- **3° Forma Normal:** Está em 3NF, pois não há dependências transitivas; a única dependência funcional não trivial é nomePersonagem, numeroDialogo, numeroResposta ➡️ resposta.
- **Forma Normal de Boyce-Codd:** Está em BCNF, pois cada determinante é uma superchave.
- **4° Forma Normal:** Está em 4NF, pois não há dependências multivaloradas não triviais.

## Tabela Profecia

De acordo com o dicionário de dados da [Tabela Profecia](./DD.md#tabela-profecia), a dependência funcional dessa tabela é a seguinte:

idProfecia ➡️ numeroDialogo, numeroCapitulo, conteudo, descricao

"idProfecia" é o único atributo que não se repete na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- **1° Forma Normal:** Está em 1NF, pois todos os atributos contêm valores atômicos.
- **2° Forma Normal:** Está em 2NF, pois não há dependências parciais; todos os atributos não chave dependem da chave primária inteira.
- **3° Forma Normal:** Está em 3NF, pois não há dependências transitivas; a única dependência funcional não trivial é nome ➡️ numeroDialogo, numeroCapitulo, conteudo, descricao.
- **Forma Normal de Boyce-Codd:** Está em BCNF, pois cada determinante é uma superchave.
- **4° Forma Normal:** Está em 4NF, pois não há dependências multivaloradas não triviais.

## Tabela Adquire

De acordo com o dicionário de dados da [Tabela Adquire](./DD.md#tabela-adquire), a dependência funcional dessa tabela é a seguinte:

nomePersonagem, nomeItem ➡️ quantidade

"nomePersonagem, nomeItem" é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- **1° Forma Normal:** Está em 1NF, pois todos os atributos contêm valores atômicos.
- **2° Forma Normal:** Está em 2NF, pois não há dependências parciais; todos os atributos não chave dependem da chave primária inteira.
- **3° Forma Normal:** Está em 3NF, pois não há dependências transitivas; a única dependência funcional não trivial é nomePersonagem, nomeItem ➡️ quantidade.
- **Forma Normal de Boyce-Codd:** Está em BCNF, pois cada determinante é uma superchave.
- **4° Forma Normal:** Está em 4NF, pois não há dependências multivaloradas não triviais.

## Tabela Região

De acordo com o dicionário de dados da [Tabela de Região](./DD.md#tabela-regiao), a dependência funcional dessa tabela é a seguinte:

nome ➡️ descricao, nivel

"nome" é o único atributo que não se repete na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- 1° Forma Normal: Todos os atributos são atômicos e monovalorados
- 2° Forma Normal: Há somente um único atributo como chave, logo não há atributos comuns dependentes parcialmente de uma chave
- 3° Forma Normal: Nenhum atributo comum depende transitivamente de qualquer superchave
- Forma Normal de Boyce-Codd: para cada depedência funcional, o lado esquerdo é uma chave candidata
- 4° Forma Normal: Não há dependências multivaloradas

## Tabela Área

De acordo com o dicionário de dados da [Tabela de Área](./DD.md#tabela-area), a dependência funcional dessa tabela é a seguinte:

nome ➡️ regiaoAtual, desafio

"nome" é o único atributo que não se repete na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- 1° Forma Normal: Todos os atributos são atômicos e monovalorados
- 2° Forma Normal: Há somente um único atributo como chave, logo não há atributos comuns dependentes parcialmente de uma chave
- 3° Forma Normal: Nenhum atributo comum depende transitivamente de qualquer superchave
- Forma Normal de Boyce-Codd: para cada depedência funcional, o lado esquerdo é uma chave candidata
- 4° Forma Normal: Não há dependências multivaloradas

## Tabela Desafio

De acordo com o dicionário de dados da [Tabela de Desafio](./DD.md#tabela-desafio), a dependência funcional dessa tabela é a seguinte:

idDesafio ➡️ tipoDesafio

"idDesafio" é o único atributo que não se repete na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- 1° Forma Normal: Todos os atributos são atômicos e monovalorados
- 2° Forma Normal: Há somente um único atributo como chave, logo não há atributos comuns dependentes parcialmente de uma chave
- 3° Forma Normal: Nenhum atributo comum depende transitivamente de qualquer superchave
- Forma Normal de Boyce-Codd: para cada depedência funcional, o lado esquerdo é uma chave candidata
- 4° Forma Normal: Não há dependências multivaloradas

## Tabela Armadilha

De acordo com o dicionário de dados da [Tabela de Armadilha](./DD.md#tabela-armadilha), a dependência funcional dessa tabela é a seguinte:

idArmadilha ➡️ descricao, DTForca, DTAgilidade, DTInteligencia, areaTeletransporte

"idArmadilha" é o único atributo que não se repete na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- 1° Forma Normal: Todos os atributos são atômicos e monovalorados
- 2° Forma Normal: Há somente um único atributo como chave, logo não há atributos comuns dependentes parcialmente de uma chave
- 3° Forma Normal: Nenhum atributo comum depende transitivamente de qualquer superchave
- Forma Normal de Boyce-Codd: para cada depedência funcional, o lado esquerdo é uma chave candidata
- 4° Forma Normal: Não há dependências multivaloradas

## Tabela Provação

De acordo com o dicionário de dados da [Tabela de Provação](./DD.md#tabela-provacao), a dependência funcional dessa tabela é a seguinte:

idProvacao ➡️ descricao, DTForca, DTAgilidade, DTInteligencia, recompensa

"idProvacao" é o único atributo que não se repete na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- 1° Forma Normal: Todos os atributos são atômicos e monovalorados
- 2° Forma Normal: Há somente um único atributo como chave, logo não há atributos comuns dependentes parcialmente de uma chave
- 3° Forma Normal: Nenhum atributo comum depende transitivamente de qualquer superchave
- Forma Normal de Boyce-Codd: para cada depedência funcional, o lado esquerdo é uma chave candidata
- 4° Forma Normal: Não há dependências multivaloradas

## Histórico de Versões

| Versão | Data  |                                         Descrição                                         |                 Responsável                           |
| :----: | :---: | :---------------------------------------------------------------------------------------: | :---------------------------------------------------: |
|  1.0   | 18/07 | Criação do documento                                                                      | [@Neitan2001](https://github.com/Neitan2001)          |
|  2.0   | 18/07 | Criação das tabelas Jogador, Inimigo, TipoPersonagem, Nível, InimigoConcreto, Abate, Deus | [@Neitan2001](https://github.com/Neitan2001)          |
|  3.0   | 19/07 | Correção da palavra "comum"                                                               | [@Neitan2001](https://github.com/Neitan2001)          |
|  4.0   | 22/07 | Criação das tabelas Inventário, Item, Defesa, Ataque, Magico, Consumíveis                 | [Clara Marcelino](https://github.com/clara-ribeiro)   |
|  5.0   | 22/07 | Criação das tabelas Aliado, Dialogo, Resposta, Profecia e Adquire                         | [Charles Serafim](https://github.com/charles-serafim) |
|  6.0   | 22/07 | Criação das tabelas Regiao, Area, Desafio, Armadilha, Provacao, Consumíveis               | [Paulo Henrique](https://github.com/owhenrique)       |