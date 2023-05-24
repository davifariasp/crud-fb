# CRUD Firebase - Aplicação Flutter

Este repositório contém uma aplicação Flutter simples que utiliza a API do Firebase para realizar operações CRUD (Create, Read, Update, Delete) em uma coleção de pessoas. A aplicação também possui recursos de atualização em tempo real, garantindo que as alterações feitas na base de dados sejam refletidas instantaneamente na interface do usuário.

## Pré-requisitos

Antes de começar, verifique se você atende aos seguintes requisitos:

- Flutter SDK instalado e configurado em seu ambiente de desenvolvimento.
- Uma conta no Firebase e um projeto configurado.

## Configuração

Siga as etapas abaixo para configurar e executar a aplicação:

1. Clone este repositório em sua máquina local:

   ```shell
   git clone https://github.com/davifariasp/crud-fb.git
   ```

2. Acesse o diretório do projeto:

   ```shell
   cd crud-fb
   ```

3. Instale as dependências do Flutter:

   ```shell
   flutter pub get
   ```

4. Crie um novo projeto no Firebase (se ainda não tiver um) e configure o Firebase para o projeto.

   - Acesse o Console do Firebase em [https://console.firebase.google.com](https://console.firebase.google.com).
   - Crie um novo projeto e forneça um nome e uma ID exclusiva para ele.
   - Siga as instruções para adicionar o Firebase ao projeto Flutter, incluindo o download do arquivo de configuração `google-services.json`.
   - Copie o arquivo `google-services.json` para o diretório `android/app` do projeto Flutter.

5. Execute a aplicação:

   ```shell
   flutter run
   ```

## Uso

Após iniciar a aplicação, você poderá realizar as seguintes operações:

- **Criar uma nova pessoa**: Clique no botão "Adicionar pessoa" e preencha as informações necessárias nos campos exibidos. Em seguida, clique em "Salvar" para adicionar a pessoa à base de dados.
- **Atualizar uma pessoa**: Para atualizar os dados de uma pessoa, clique na pessoa desejada na lista e edite as informações nos campos exibidos. Em seguida, clique em "Salvar" para atualizar os dados na base de dados.
- **Excluir uma pessoa**: Para excluir uma pessoa, clique na pessoa desejada na lista e clique no botão "Excluir".
- **Visualizar informações em tempo real**: Qualquer alteração feita na base de dados será atualizada automaticamente na interface do usuário, garantindo uma experiência em tempo real.

## Contribuição

Contribuições são bem-vindas! Se você deseja melhorar este projeto, siga estas etapas:

1. Faça um fork deste repositório.
2. Crie um branch com a sua feature: `git checkout -b minha-feature`.
3. Faça as alterações desejadas e faça commit delas: `git commit -m 'Minha nova feature'`.
4. Envie para o branch principal: `git push origin minha-feature`.
5. Crie uma pull request.

## Licença

Este projeto está licenciado sob a [Licença MIT](LICENSE).

---

Espero que este README seja útil para você! Se tiver alguma dúvida ou precisar de mais informações, não hesite em entrar em contato. Aproveite o desenvolvimento da aplicação CRUD Firebase em Flutter!
