*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     BuiltIn
Resource    ../variables.robot  # Importando corretamente as variáveis


*** Keywords ***
Criar Sessão API
    Create Session    viacep    ${BASE_URL}    verify=True

Consultar CEP Válido
    [Arguments]    ${cep}
    ${response}    GET On Session    viacep    /${cep}/json
    Should Not Be Empty    ${response.content}    "Erro: Nenhuma resposta recebida da API"

    ${json_response}    Evaluate    json.loads($response.content.decode('utf-8'))    json
    ${status_code}    Evaluate    $response.status_code

    Should Be Equal As Numbers    ${status_code}    200    "Erro: Status Code inesperado para CEP válido!"
    Dictionary Should Contain Key    ${json_response}    cep    "Erro: A resposta não contém a chave 'cep'"

    # Comparação entre JSON retornado e esperado
    Dictionaries Should Be Equal    ${json_response}    ${JSON_CEP_VALIDO}    "Erro: O JSON de resposta não é o esperado!"

    Log To Console    \n Consulta bem-sucedida e JSON validado: ${json_response}
    RETURN    ${json_response}



    # Comparação entre JSON retornado e esperado
    Dictionaries Should Be Equal    ${json_response}    &{JSON_CEP_VALIDO}    "Erro: O JSON de resposta não é o esperado!"

    Log To Console    \n Consulta bem-sucedida e JSON validado: ${json_response}
    RETURN    ${json_response}

Consultar CEP Inválido
    [Arguments]    ${cep}
    ${response}    GET On Session    viacep    /${cep}/json

    # Valida se a resposta não é None
    Should Not Be Empty    ${response.content}    "Erro: Nenhuma resposta recebida da API"

    ${json_response}    Evaluate    json.loads($response.content)    json
    ${status_code}    Evaluate    $response.status_code

    # Verifica se o status code está correto (o ViaCEP retorna 200 mesmo para CEPs inválidos)
    Should Be Equal As Numbers    ${status_code}    200    "Erro: Status Code inesperado para CEP inválido!"

    # JSON esperado para CEP inválido
    ${json_esperado}    Create Dictionary    erro=true

    # Valida se a resposta é exatamente o JSON esperado
    Dictionaries Should Be Equal    ${json_response}    ${json_esperado}    "Erro: O JSON retornado para CEP inválido não está correto!"

    Log To Console    \n CEP inválido tratado corretamente: ${cep}
    RETURN    ${json_response}

Consultar CEP com Formato Incorreto
    [Arguments]    ${cep}
    ${error_message}    Run Keyword And Expect Error    *400 Client Error*    GET On Session    viacep    /${cep}/json

    Should Contain    ${error_message}    400 Client Error    "Erro: A API não retornou erro 400 para um CEP com formato inválido!"

    Log To Console    \n Formato de CEP inválido corretamente rejeitado: ${cep}

Consultar CEP com Caracteres Especiais
    [Arguments]    ${cep}
    ${error_message}    Run Keyword And Expect Error    *400 Client Error*    GET On Session    viacep    /${cep}/json

    Should Contain    ${error_message}    400 Client Error    "Erro: A API não retornou erro 400 para CEP com caracteres especiais!"

    Log To Console    \n API corretamente rejeitou caracteres especiais em CEP: ${cep}