*** Settings ***
Library    SeleniumLibrary
Library    String
Resource    ../variables.robot
Resource    common_keywords.robot

*** Variables ***
${INPUT_BUSCA}               id=input-busca
${XPATH_PRIMEIRO_PRODUTO}    xpath=(//a[contains(@class, 'productLink')])[1]
${BOTAO_COMPRAR}             xpath=//button[contains(text(),'COMPRAR')]
${GARANTIA_ESTENDIDA}        xpath=//span[contains(text(),'12 Meses de garantia')]/parent::div/parent::div/preceding-sibling::input
${BOTAO_IR_PARA_CARRINHO}    xpath=//button[span[contains(text(),'Adicionar serviços')]]
${TITULO_PRODUTO}            xpath=//div[contains(@class, 'col-purchase')]//h1
${PRECO_PIX}                 xpath=//h4[contains(@class, 'finalPrice')]
${PRECO_CARTAO}              xpath=//b[contains(@class, 'regularPrice')]
${SERVICOS_ADICIONAIS}       xpath=//div[contains(@class, 'flex justify-between') and span[contains(text(), 'Valor total dos serviços:')]]/strong
${TITULO_PRODUTO_CARRINHO}   xpath=//a[contains(@class, 'productName') and contains(@class, 'productLink')]
${PRECO_PIX_CARRINHO}        xpath=//div[contains(@class, 'InCashPrice-styles__Container')]//p[contains(@class, 'InCashPrice-styles__Price')]
${PRECO_CARTAO_CARRINHO}     xpath=//div[@id='valorDosProdutos']/b
${SERVICOS_ADICIONAIS_CARRINHO}    xpath=(//b[contains(@class, 'text-sm') and contains(@class, 'text-right') and contains(@class, 'text-black-800')])[2]

*** Keywords ***
Abrir o Site Kabum
    Open Browser    ${URL_KABUM}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    ${INPUT_BUSCA}    10s

Buscar Produto
    [Arguments]    ${produto}
    Wait Until Element Is Visible    ${INPUT_BUSCA}    10s
    Input Text And Wait    ${INPUT_BUSCA}    ${produto}
    Press Keys    ${INPUT_BUSCA}    ENTER
    Wait Until Element Is Visible    ${XPATH_PRIMEIRO_PRODUTO}    10s

Selecionar Primeiro Produto
    ${element_existe}    Run Keyword And Return Status    Element Should Be Visible    id=onetrust-accept-btn-handler
    Run Keyword If    ${element_existe}    Click Button    id=onetrust-accept-btn-handler
    Scroll Element Into View    ${XPATH_PRIMEIRO_PRODUTO}
    Wait For Element And Click    ${XPATH_PRIMEIRO_PRODUTO}
    Wait Until Element Is Visible    ${TITULO_PRODUTO}    10s

Digitar CEP e Validar Frete
    [Arguments]    ${cep}
    Input Text And Wait    id=inputCalcularFrete    ${cep}
    Click And Wait   id=botaoCalcularFrete
    Wait Until Element Is Visible    id=listaOpcoesFrete    15s

Fechar Tela de Frete
    Click And Wait   xpath=//div[@role='dialog']//button[@aria-label='Fechar']

Clicar em Comprar
    Click And Wait    ${BOTAO_COMPRAR}

Selecionar Garantia Estendida
    Click And Wait    ${GARANTIA_ESTENDIDA}

Ir para o Carrinho
    Click And Wait    ${BOTAO_IR_PARA_CARRINHO}

Capturar Dados do Produto
    Wait Until Element Is Visible    ${TITULO_PRODUTO}    10s
    ${descricao}    Get Text    ${TITULO_PRODUTO}
    ${preco_pix}    Get Text    ${PRECO_PIX}
    ${preco_cartao}    Get Text    ${PRECO_CARTAO}

    Run Keyword If    '${descricao}' == ''    Fail    "Erro: A descrição do produto não foi capturada."

    Set Global Variable    ${descricao}    ${descricao}
    Set Global Variable    ${preco_pix}    ${preco_pix}
    Set Global Variable    ${preco_cartao}    ${preco_cartao}

Validar Produto no Carrinho
    Wait Until Element Is Visible    ${TITULO_PRODUTO_CARRINHO}    10s
    ${descricao_carrinho}    Get Text    ${TITULO_PRODUTO_CARRINHO}
    ${preco_pix_carrinho}    Get Text    ${PRECO_PIX_CARRINHO}
    ${preco_cartao_carrinho}    Get Text    ${PRECO_CARTAO_CARRINHO}

    Should Be Equal As Strings    ${descricao}    ${descricao_carrinho}
    Should Be Equal As Strings    ${preco_pix}    ${preco_pix_carrinho}
    Should Be Equal As Strings    ${preco_cartao}    ${preco_cartao_carrinho}

Capturar Valores dos Serviços
    Wait Until Element Is Visible    ${SERVICOS_ADICIONAIS}    10s
    ${total_servicos}    Get Text    ${SERVICOS_ADICIONAIS}
    ${total_servicos}    Converter Valor Para Número    ${total_servicos}
    Set Global Variable    ${total_servicos}

Validar Serviços no Carrinho
    Wait Until Element Is Visible    ${SERVICOS_ADICIONAIS_CARRINHO}    10s
    ${total_servicos_carrinho}    Get Text    ${SERVICOS_ADICIONAIS_CARRINHO}
    ${total_servicos_carrinho}    Converter Valor Para Número    ${total_servicos_carrinho}
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

*** Keywords ***
Converter Valor Para Número
    [Arguments]    ${valor}
    ${valor}    Strip String    ${valor}
    ${valor}    Replace String    ${valor}    R$    ${EMPTY}
    ${valor}    Replace String    ${valor}    .    ${EMPTY}
    ${valor}    Replace String    ${valor}    ,    .
    ${valor}    Convert To Number    ${valor}
    RETURN    ${valor}