*** Settings ***
Library    SeleniumLibrary
Library     BuiltIn
Library     Collections

*** Keywords ***
Click And Wait
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=5s
    Wait Until Element Is Enabled    ${locator}    timeout=5s
    Click Element    ${locator}

Imprimir Separador
    Log To Console    "\n==============================================="

Logar Dados de Teste
    [Arguments]    ${descricao}    ${preco_pix}    ${preco_cartao}    ${total_servicos}
    Imprimir Separador
    Log To Console    "|          RESUMO FINAL DA COMPRA            |"
    Imprimir Separador
    Log To Console    "Descrição do Produto: ${descricao}"
    Log To Console    "Valor à Vista no PIX: ${preco_pix}"
    Log To Console    "Valor no Cartão: ${preco_cartao}"
    Log To Console    "Total de Serviços: ${total_servicos}"
    Imprimir Separador