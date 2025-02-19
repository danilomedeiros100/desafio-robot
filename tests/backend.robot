*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ../resources/variables.robot
Resource    ../resources/keywords/backend_keywords.robot
Resource    ../resources/keywords/common_keywords.robot

*** Test Cases ***
Validar Consulta de CEP Válido
    Criar Sessão API
    ${response}    Consultar CEP Válido    ${CEP_VALIDO}
    Should Not Be Empty    ${response}    "Erro: Nenhuma resposta foi retornada para CEP válido"

Validar Consulta de CEP Inválido
    Criar Sessão API
    ${response}    Consultar CEP Inválido    ${CEP_INVALIDO}
    Should Not Be Empty    ${response}    "Erro: Nenhuma resposta foi retornada para CEP inválido"

Validar CEP com Formato Incorreto
    Criar Sessão API
    Consultar CEP com Formato Incorreto    ${CEP_FORMATO_INCORRETO}

Validar CEP com Caracteres Especiais
    Criar Sessão API
    Consultar CEP com Caracteres Especiais    ${CEP_CARACTERES_ESPECIAIS}