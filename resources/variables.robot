*** Variables ***
${BROWSER}    chrome
${URL_KABUM}    https://www.kabum.com.br
${API_VIACEP}    https://viacep.com.br/ws/
${CEP_VALIDO}    01001000
${CEP_INVALIDO}    99999999
${URL_API}    https://viacep.com.br/ws
${CEP_FORMATO_ERRADO}    123
${CEP_CARACTERES_ESPECIAIS}    1234-@#$%
${XPATH_PRIMEIRO_PRODUTO}    xpath=(//a[contains(@class, 'productLink')])[1]
${INPUT_BUSCA}    id=input-busca
${BASE_URL}    https://viacep.com.br/ws
${CEP_VALIDO}    01001-000
${CEP_INVALIDO}    99999999
${CEP_FORMATO_INCORRETO}    123
${CEP_CARACTERES_ESPECIAIS}    1234-@#$%

${PRODUTO_PADRAO}    notebook

# JSON esperado para CEP válido
&{JSON_CEP_VALIDO}
...    cep=01001-000
...    logradouro=Praça da Sé
...    complemento=lado ímpar
...    unidade=
...    bairro=Sé
...    localidade=São Paulo
...    uf=SP
...    estado=São Paulo
...    regiao=Sudeste
...    ibge=3550308
...    gia=1004
...    ddd=11
...    siafi=7107

# JSON esperado para CEP inválido
&{JSON_CEP_INVALIDO}
...    erro=true