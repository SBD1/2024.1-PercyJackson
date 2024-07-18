# Normalização

## Introdução

## Tabelas

## Tabela Jogador

De acordo com o dicionário de dados da [Tabela de Jogador](./DD.md#tabela-jogador), a dependência funcional dessa tabela é a seguinte:

nome ➡️ defesa, vidaMax, forca, intelecto, agilidade, combate, carga, vidaAtual, experienciaAtual, armadura, arma, itemMagico, deus, areaAtual, nivel

"nome" é o único atributo que não se repete na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- 1° Forma Normal: Todos os atributos são atômicos e monovalorados
- 2° Forma Normal: Há somente um único atributo como chave, logo não há atributos comuns dependentes parcialmente de uma chave
- 3° Forma Normal: Nenhum atributo comun depende transitivamente de qualquer superchave
- Forma Normal de Boyce-Codd: para cada depedência funcional, o lado esquerdo é uma chave candidata
- 4° Forma Normal: Não há dependências multivaloradas

## Tabela Inimigo

De acordo com o dicionário de dados da [Tabela de Inimigo](./DD.md#tabela-inimigo), a dependência funcional dessa tabela é a seguinte:

nome ➡️ defesa, vidaMax, forca, intelecto, agilidade, combate, pontosExperiencia ,nivel

"nome" é o único atributo que não se repete na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- 1° Forma Normal: Todos os atributos são atômicos e monovalorados
- 2° Forma Normal: Há somente um único atributo como chave, logo não há atributos comuns dependentes parcialmente de uma chave
- 3° Forma Normal: Nenhum atributo comun depende transitivamente de qualquer superchave
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
- 3° Forma Normal: Nenhum atributo comun depende transitivamente de qualquer superchave
- Forma Normal de Boyce-Codd: para cada depedência funcional, o lado esquerdo é uma chave candidata
- 4° Forma Normal: Não há dependências multivaloradas

## Tabela Nível

De acordo com o dicionário de dados da [Tabela de Nível](./DD.md#tabela-nivel), a dependência funcional dessa tabela é a seguinte:

idNivel ➡️ pontosExperiencia

"idNivel" é o único atributo que não se repete na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- 1° Forma Normal: Todos os atributos são atômicos e monovalorados
- 2° Forma Normal: Há somente um único atributo como chave, logo não há atributos comuns dependentes parcialmente de uma chave
- 3° Forma Normal: Nenhum atributo comun depende transitivamente de qualquer superchave
- Forma Normal de Boyce-Codd: para cada depedência funcional, o lado esquerdo é uma chave candidata
- 4° Forma Normal: Não há dependências multivaloradas

## Tabela InimigoConcreto

De acordo com o dicionário de dados da [Tabela de InimigoConcreto](./DD.md#tabela-inimigoconcreto), a dependência funcional dessa tabela é a seguinte:

nomeConcreto ➡️ vidaAtual, inimigo, areaAtual, loot

"nomeConcreto" é o único atributo que não se repete na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- 1° Forma Normal: Todos os atributos são atômicos e monovalorados
- 2° Forma Normal: Há somente um único atributo como chave, logo não há atributos comuns dependentes parcialmente de uma chave
- 3° Forma Normal: Nenhum atributo comun depende transitivamente de qualquer superchave
- Forma Normal de Boyce-Codd: para cada depedência funcional, o lado esquerdo é uma chave candidata
- 4° Forma Normal: Não há dependências multivaloradas

## Tabela Abate

De acordo com o dicionário de dados da [Tabela de Abate](./DD.md#tabela-abate), a dependência funcional dessa tabela é a seguinte:

nomeJogador, nomeInimigo ➡️ quantidade

"nomeJogador" e "nomeInimigo" são os únicos atributos que não se repetem na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- 1° Forma Normal: Todos os atributos são atômicos e monovalorados
- 2° Forma Normal: Há somente um único atributo como chave, logo não há atributos comuns dependentes parcialmente de uma chave
- 3° Forma Normal: Nenhum atributo comun depende transitivamente de qualquer superchave
- Forma Normal de Boyce-Codd: para cada depedência funcional, o lado esquerdo é uma chave candidata
- 4° Forma Normal: Não há dependências multivaloradas

## Tabela Deus

De acordo com o dicionário de dados da [Tabela de Deus](./DD.md#tabela-deus), a dependência funcional dessa tabela é a seguinte:

nome ➡️ forcaInicial, intelectoInicial, agilidadeInicial, combateInicial

"nome" é o único atributo que não se repete na tabela, assim é a única Superchave, Superchave Mínima e Chave Candidata desta tabela.

Esta tabela está dentro das seguintes Formas Normais:

- 1° Forma Normal: Todos os atributos são atômicos e monovalorados
- 2° Forma Normal: Há somente um único atributo como chave, logo não há atributos comuns dependentes parcialmente de uma chave
- 3° Forma Normal: Nenhum atributo comun depende transitivamente de qualquer superchave
- Forma Normal de Boyce-Codd: para cada depedência funcional, o lado esquerdo é uma chave candidata
- 4° Forma Normal: Não há dependências multivaloradas

## Referência Bibliográfica

> 1. 

## Histórico de Versões

| Versão | Data  |                                         Descrição                                         |                 Responsável                  |
| :----: | :---: | :---------------------------------------------------------------------------------------: | :------------------------------------------: |
|  1.0   | 18/07 |                                   Criação do documento                                    | [@Neitan2001](https://github.com/Neitan2001) |
|  2.0   | 18/07 | Criação das tabelas Jogador, Inimigo, TipoPersonagem, Nível, InimigoConcreto, Abate, Deus | [@Neitan2001](https://github.com/Neitan2001) |