# Pokedex App

Um aplicativo Flutter que exibe uma coleção de Pokémon usando a PokeAPI.

## Funcionalidades

- Lista de Pokémon com paginação infinita
- Busca de Pokémon por nome
- Detalhes do Pokémon
- Interface moderna e responsiva
- Gerenciamento de estado com MobX
- Arquitetura limpa (Clean Architecture)

## Tecnologias Utilizadas

- Flutter
- MobX para gerenciamento de estado
- Modular para injeção de dependência
- PokeAPI para dados dos Pokémon
- Clean Architecture

## Estrutura do Projeto

O projeto segue os princípios da Clean Architecture:

```
lib/
├── core/
│   ├── di/          # Injeção de dependência
│   ├── error/       # Tratamento de erros
│   └── usecases/    # Casos de uso base
├── data/
│   ├── datasources/ # Fontes de dados (API, local)
│   ├── models/      # Modelos de dados
│   └── repositories/# Implementações dos repositórios
├── domain/
│   ├── entities/    # Entidades do domínio
│   ├── repositories/# Interfaces dos repositórios
│   └── usecases/    # Casos de uso específicos
└── presentation/
    ├── controllers/ # Controladores (MobX stores)
    ├── pages/       # Telas do aplicativo
    └── widgets/     # Widgets reutilizáveis
```

## Configuração do Ambiente

1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/pokedex-app.git
cd pokedex-app
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Execute o aplicativo:
```bash
flutter run
```

## Configuração do Projeto

1. Crie um arquivo `.env` na raiz do projeto com as seguintes variáveis:
```env
POKEAPI_BASE_URL=https://pokeapi.co/api/v2
```

## Estrutura de Commits

Este projeto segue o padrão de commits do Conventional Commits:

- `feat`: Nova funcionalidade
- `fix`: Correção de bug
- `docs`: Alterações na documentação
- `style`: Alterações de estilo (formatação, espaços, etc)
- `refactor`: Refatoração de código
- `test`: Adição ou correção de testes
- `chore`: Atualizações de build, configurações, etc