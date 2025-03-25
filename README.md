# App Filmes Marvel

Aplicativo em Flutter para listagem e visualização de detalhes de personagens da Marvel, utilizando a API Marvel.

## Descrição

Este aplicativo exibe uma lista de personagens da Marvel, com a possibilidade de visualizar detalhes de cada personagem, como biografia e quadrinhos relacionados.

## Estrutura do Projeto

O projeto foi desenvolvido seguindo os princípios da Clean Architecture:

- **Core**: Componentes centrais como configurações de API, erro e utilitários.
- **Data**: Implementações de repositórios e fontes de dados.
- **Domain**: Entidades, interfaces de repositórios e casos de uso.
- **Presentation**: Interface do usuário (pages, widgets) e gerenciamento de estado.

## Tecnologias Utilizadas

- **Flutter**: SDK de desenvolvimento de aplicativos multiplataforma.
- **MobX**: Para gerenciamento de estado reativo.
- **Flutter Modular**: Para injeção de dependências e gerenciamento de rotas.
- **Dio**: Cliente HTTP para comunicação com a API.
- **Clean Architecture**: Para separação de responsabilidades e testabilidade.

## Instalação

1. Clone o repositório:

```
git clone https://github.com/seu-usuario/app_filmes_marvel.git
cd app_filmes_marvel
```

2. Instale as dependências:

```
flutter pub get
```

3. Execute o build runner para gerar os arquivos MobX:

```
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Execute o aplicativo:

```
flutter run
```

## Configuração da API

Este aplicativo utiliza o Firebase Remote Config para armazenar as chaves da API Marvel de forma segura. Para configurar:

1. Crie uma conta em [developer.marvel.com](https://developer.marvel.com/)
2. Obtenha sua chave pública e privada em [developer.marvel.com/account](https://developer.marvel.com/account)
3. Configure um projeto no [Firebase Console](https://console.firebase.google.com/)
4. Adicione um app Android com o pacote `br.com.devnerd.appfilmesmarvel.app_filmes_marvel`
5. Baixe o arquivo `google-services.json` e coloque-o na pasta `android/app/` do projeto
6. No Firebase Console, vá para Remote Config e adicione os seguintes parâmetros:
   - `marvel_public_key`: sua chave pública da API Marvel
   - `marvel_private_key`: sua chave privada da API Marvel
7. Publique as alterações

Para desenvolvimento, você também pode editar os valores padrão em `lib/core/util/api_config.dart`:

```dart
await remoteConfig.setDefaults({
  'marvel_public_key': 'YOUR_PUBLIC_KEY',
  'marvel_private_key': 'YOUR_PRIVATE_KEY',
});
```

Substitua `YOUR_PUBLIC_KEY` e `YOUR_PRIVATE_KEY` pelas suas chaves para testes locais.

## Recursos

- Listagem de personagens Marvel
- Rolagem infinita para carregar mais personagens
- Detalhes do personagem, incluindo biografia e quadrinhos
- Tratamento de erros de API e conexão

## Estrutura de Arquivos

```
lib/
  ├── core/                   # Componentes centrais
  │   ├── di/                 # Injeção de dependências
  │   ├── error/              # Classes de erro
  │   └── util/               # Utilitários
  ├── data/                   # Camada de dados
  │   ├── datasources/        # Fontes de dados
  │   ├── models/             # Modelos de dados
  │   └── repositories/       # Implementações de repositórios
  ├── domain/                 # Camada de domínio
  │   ├── entities/           # Entidades
  │   ├── repositories/       # Interfaces de repositórios
  │   └── usecases/           # Casos de uso
  └── presentation/           # Camada de apresentação
      ├── controllers/        # Controladores MobX
      ├── pages/              # Páginas da aplicação
      └── widgets/            # Widgets reutilizáveis
```

## Versões Utilizadas

- Flutter: 3.19.3
- Dart: 3.3.1
- dio: 5.4.2
- flutter_modular: 6.3.2
- mobx: 2.3.0+1
- flutter_mobx: 2.2.0+2