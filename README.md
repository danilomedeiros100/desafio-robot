# Documentação dos Testes Automatizados – Desafio Neurotech

## 1. Visão Geral
Este projeto contém testes automatizados desenvolvidos em **Robot Framework** para validar funcionalidades frontend e backend, conforme descrito nos desafios técnicos fornecidos.

Os testes de frontend interagem com a interface web do site **KaBuM** para validar a adição de um produto ao carrinho. Já os testes de backend verificam a API **ViaCEP**, garantindo que diferentes cenários de consulta de CEP sejam corretamente tratados.

## 2. Estrutura do Projeto
O projeto é estruturado da seguinte forma:

```
📂 projeto_robot_neurotech/
│── 📂 tests/
│   ├── 📄 backend.robot         # Testes automatizados da API ViaCEP
│   ├── 📄 frontend.robot        # Testes automatizados no site KaBuM
│── 📂 keywords/
│   ├── 📄 backend_keywords.robot   # Palavras-chave reutilizáveis para testes backend
│   ├── 📄 frontend_keywords.robot  # Palavras-chave reutilizáveis para testes frontend
│   ├── 📄 common_keywords.robot    # Palavras-chave genéricas e compartilhadas
│── 📂 resources/
│   ├── 📄 variables.robot      # Definição de variáveis do projeto
│── 📄 requirements.txt         # Dependências do projeto
│── 📄 README.md                # Instruções de instalação e execução
```

---

## 3. Como Executar os Testes
Antes de rodar os testes, siga os passos abaixo:

### 3.1. Clonando o Projeto do GitHub
Caso o projeto esteja disponível em um repositório Git, clone-o com o seguinte comando:
```sh
git clone https://github.com/danilomedeiros100/desafio-robot.git
cd desafio-robot
```

### 3.2. Criando um Ambiente Virtual
Para evitar conflitos entre dependências, utilize um ambiente virtual:

**Linux/macOS:**
```sh
python3 -m venv venv
source venv/bin/activate
```

**Windows:**
```sh
python -m venv venv
venv\Scripts\activate
```

### 3.3. Atualizando o Pip e Instalando Dependências
Após ativar o ambiente virtual, atualize o **pip** e instale os pacotes necessários:

```sh
pip install --upgrade pip
pip install -r requirements.txt
```

### 3.4. Executando os Testes
Os testes podem ser executados diretamente pelo Robot Framework:

#### Rodar todos os testes
```sh
robot -A argumentfile.txt tests/
```

#### Testes Backend (API ViaCEP)
```sh
robot -A argumentfile.txt tests/backend.robot
```

#### Testes Frontend (KaBuM)
```sh
robot -A argumentfile.txt tests/frontend.robot
```

Os resultados dos testes serão gerados na pasta **results/**.

---

## 4. Detalhes dos Testes

### 4.1. Desafio 1 – Testes de Frontend
Os testes interagem com o site **KaBuM** para validar a compra de um notebook. As etapas implementadas incluem:

1. **Acessar o site** [www.kabum.com.br](https://www.kabum.com.br).
2. **Buscar pelo termo** "notebook".
3. **Selecionar o primeiro produto da lista** de resultados.
4. **Inserir um CEP** e validar os valores do frete.
5. **Fechar a tela de frete** e prosseguir com a compra.
6. **Adicionar garantia estendida** de 12 meses.
7. **Ir para o carrinho** e validar se o produto foi corretamente adicionado.

#### Resultados Esperados
- O teste deve verificar se os elementos estão visíveis e interagíveis.
- A página de frete deve exibir valores válidos.
- O carrinho deve conter o produto correto.
- O teste valida que:
  - A descrição do produto selecionado é a mesma no carrinho;
  - Valida valor de pagamento por pix é o mesmo da tela do produto selecionado;
  - Valida valor de pagamento em até 10x é o mesmo da tela do produto selecionado;
  - Valida que a soma dos serviços de garantia selecionados é igual ao total do valor de serviços na tela do carrinho

---

### 4.2. Desafio 2 – Testes de Backend
Os testes verificam a API **ViaCEP** para garantir a correta manipulação de CEPs. São testados os seguintes cenários:

1. **Consulta com CEP válido**: Verifica se os dados retornados estão corretos.
2. **Consulta com CEP inválido**: Garante que o sistema retorne um erro apropriado.
3. **Formato incorreto de CEP**: Testa entradas com menos ou mais de 8 dígitos.
4. **Caracteres não numéricos**: Verifica a resposta ao inserir caracteres especiais.

#### Resultados Esperados
- A API deve retornar corretamente os dados de um CEP válido.
- Para CEPs inexistentes, deve ser retornada uma mensagem de erro.
- O sistema deve rejeitar entradas inválidas e caracteres especiais.

---

## 5. Relatórios e Logs
### Para visualizar os relatórios:

```sh
allure serve output/allure 
```

Os logs de execução são gerados automaticamente na pasta **results/**, incluindo:
- **Output.xml**: Log detalhado da execução.
- **Log.html**: Registro interativo de cada etapa dos testes.
- **Report.html**: Resumo final da execução.

Para visualizar os relatórios:
```sh
xdg-open results/report.html  # Linux
start results/report.html     # Windows
```

---

## 6. Considerações Finais
O projeto segue boas práticas de automação, incluindo:
✔ Uso de palavras-chave reutilizáveis (arquivos `keywords.robot`).  
✔ Separação de responsabilidades entre frontend e backend.  
✔ Relatórios automáticos para análise de falhas.  

