# Dicionário de Dados

## Introdução

## Tabelas

### Tabela Fulano

| Tabela      | Veiculo                                                  |
| ----------- | -------------------------------------------------------- |
| Descrição   | Armazenará as informações dos veículos                   |
| Observações | Essa tabela possui uma chave estrangeira da tabela Marca |

| Nome       | Descrição                                                | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, Not Null, Check, Default, Identity) |
| ---------- | -------------------------------------------------------- | ------------ | ------- | ------------------------------------------------------------------ |
| Codigo     | Código de identificação da tabela                        | Int          |         | PK / Identity                                                      |
| Placa      | Placa do ônibus                                          | Varchar      | 20      | Unique / Not Null                                                  |
| Anoveiculo | Ano de fabricação do ônibus                              | Int          |         | Not Null                                                           |
| Anocompra  | Ano de compra do veículo                                 | Int          |         | Not Null                                                           |
| Codmarca   | Chave estrangeira referenciando o código da tabela Marca | Int          |         | FK                                                                 |

## Referência Bibliográfica

> 1. 

## Histórico de Versões

|  Versão  | Data | Descrição | Responsável |
| :---: | :---: | :---: | :---: | 
| 1.0 | 18/07 | Criação do documento | [@Neitan2001](https://github.com/Neitan2001) |