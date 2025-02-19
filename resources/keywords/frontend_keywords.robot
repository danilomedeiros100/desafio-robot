*** Settings ***
Library    SeleniumLibrary
Library    String
Resource    ../variables.robot
Resource    common_keywords.robot


*** Keywords ***
Abrir o Site Kabum
    Open Browser    ${URL_KABUM}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${INPUT_BUSCA}    10s

Buscar Produto
    [Arguments]    ${produto}
    Input Text    ${INPUT_BUSCA}    ${produto}
    Press Keys    ${INPUT_BUSCA}    ENTER
    Wait Until Element Is Visible    ${XPATH_PRIMEIRO_PRODUTO}    10s

Selecionar Primeiro Produto
    ${element_existe}    Run Keyword And Return Status    Element Should Be Visible    id=onetrust-accept-btn-handler
    Run Keyword If    ${element_existe}    Click Button    id=onetrust-accept-btn-handler
    Click Element    ${XPATH_PRIMEIRO_PRODUTO}
    Wait Until Element Is Visible    xpath=//h1[contains(@class, 'sc-')]

Digitar CEP e Validar Frete
    [Arguments]    ${cep}
    Wait Until Element Is Visible    id=inputCalcularFrete    10s
    Wait Until Element Is Enabled    id=inputCalcularFrete    5s
    Click Element    id=inputCalcularFrete
    Clear Element Text    id=inputCalcularFrete
    Input Text    id=inputCalcularFrete    ${cep}
    Esperar e Clicar    id=botaoCalcularFrete
    Wait Until Element Is Visible    id=listaOpcoesFrete    15s

Fechar Tela de Frete
    Esperar e Clicar    xpath=//div[@role='dialog']//button[@aria-label='Fechar']

Clicar em Comprar
    Esperar e Clicar    xpath=//button[contains(text(),'COMPRAR')]

Selecionar Garantia Estendida
    Esperar e Clicar    xpath=//span[contains(text(),'12 Meses de garantia')]/parent::div/parent::div/preceding-sibling::input

Ir para o Carrinho
    Esperar e Clicar    xpath=//button[span[contains(text(),'Adicionar serviços')]]

Capturar Dados do Produto
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'col-purchase')]//h1    10s
    ${descricao}    Get Text    xpath=//div[contains(@class, 'col-purchase')]//h1
    ${preco_pix}    Get Text    xpath=//h4[contains(@class, 'finalPrice')]
    ${preco_cartao}    Get Text    xpath=//b[contains(@class, 'regularPrice')]

#    Log To Console    "Descrição do Produto Capturada: ${descricao}"

    # Verifica se a descrição foi capturada corretamente
    Run Keyword If    '${descricao}' == ''    Fail    "Erro: A descrição do produto não foi capturada."

    Set Global Variable    ${descricao}    ${descricao}
    Set Global Variable    ${preco_pix}    ${preco_pix}
    Set Global Variable    ${preco_cartao}    ${preco_cartao}


Validar Produto no Carrinho
    Wait Until Element Is Visible    xpath=//a[contains(@class, 'productName') and contains(@class, 'productLink')]    10s
    ${descricao_carrinho}    Get Text    xpath=//a[contains(@class, 'productName') and contains(@class, 'productLink')]
    ${preco_pix_carrinho}    Get Text    xpath=//div[contains(@class, 'InCashPrice-styles__Container')]//p[contains(@class, 'InCashPrice-styles__Price')]
    ${preco_cartao_carrinho}    Get Text    xpath=//div[@id='valorDosProdutos']/b

    Should Be Equal As Strings    ${descricao}    ${descricao_carrinho}
    Should Be Equal As Strings    ${preco_pix}    ${preco_pix_carrinho}
    Should Be Equal As Strings    ${preco_cartao}    ${preco_cartao_carrinho}

Capturar Valores dos Serviços
    Wait Until Element Is Visible    xpath=//span[contains(text(),'Valor total dos serviços:')]/following-sibling::strong    10s
    ${total_servicos}    Get Text    xpath=//span[contains(text(),'Valor total dos serviços:')]/following-sibling::strong


    ${total_servicos}    Strip String    ${total_servicos}
    ${total_servicos}    Replace String    ${total_servicos}    R$    ${EMPTY}
    ${total_servicos}    Replace String    ${total_servicos}    .    ${EMPTY}
    ${total_servicos}    Replace String    ${total_servicos}    ,    .
    ${total_servicos}    Convert To Number    ${total_servicos}


    Set Global Variable    ${total_servicos}

Validar Serviços no Carrinho
    Wait Until Element Is Visible    xpath=//div[@id='servicosAdicionais']/b    10s
    ${total_servicos_carrinho}    Get Text    xpath=//div[@id='servicosAdicionais']/b

    ${total_servicos_carrinho}    Strip String    ${total_servicos_carrinho}
    ${total_servicos_carrinho}    Replace String    ${total_servicos_carrinho}    R$    ${EMPTY}
    ${total_servicos_carrinho}    Replace String    ${total_servicos_carrinho}    .    ${EMPTY}
    ${total_servicos_carrinho}    Replace String    ${total_servicos_carrinho}    ,    .
    ${total_servicos_carrinho}    Convert To Number    ${total_servicos_carrinho}

    Should Be Equal As Numbers    ${total_servicos}    ${total_servicos_carrinho}

Exibir Resumo Final
   Log To Console    "\n"
    Log To Console    "==============================================="
    Log To Console    "-------------RESUMO FINAL DA COMPRA------------"
    Log To Console    "==============================================="
    Log To Console    Produto Selecionado:\n ${descricao}
    Log To Console    Valor no PIX: >>> ${preco_pix}
    Log To Console    Valor no Cartão: >>> ${preco_cartao}
    Log To Console    Valor total dos Serviços: >>> ${total_servicos}