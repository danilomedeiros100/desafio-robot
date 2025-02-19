*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/keywords/frontend_keywords.robot
Resource    ../resources/variables.robot

*** Test Cases ***
Teste de Compra no Kabum
    Abrir o Site Kabum
    Buscar Produto    ${PRODUTO_PADRAO}
    Selecionar Primeiro Produto
    Capturar Dados do Produto
    Digitar CEP e Validar Frete    ${CEP_VALIDO}
    Fechar Tela de Frete
    Clicar em Comprar
    Selecionar Garantia Estendida
    Capturar Valores dos Serviços
    Ir para o Carrinho
    Validar Produto no Carrinho
    Validar Serviços no Carrinho
    Exibir Resumo Final