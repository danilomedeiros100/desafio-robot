*** Settings ***
Library    SeleniumLibrary
Library     BuiltIn
Library     Collections

*** Keywords ***
Click And Wait
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=10s
    Click Element    ${locator}

Wait For Element And Click
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=10s
    Wait Until Element Is Enabled    ${locator}    timeout=5s
    Click Element    ${locator}

Input Text And Wait
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}    timeout=10s
    Wait Until Element Is Enabled    ${locator}    timeout=5s
    Click Element    ${locator}
    Clear Element Text    ${locator}
    Input Text    ${locator}    ${text}

Validate Text
    [Arguments]    ${locator}    ${expected_text}
    Wait Until Element Is Visible    ${locator}    timeout=10s
    ${actual_text}=    Get Text    ${locator}
    Should Be Equal As Strings    ${actual_text}    ${expected_text}

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