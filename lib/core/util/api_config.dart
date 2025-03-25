class ApiConfig {
  // URL base da PokéAPI
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  // A PokéAPI é uma API aberta que não requer autenticação
  static bool get hasValidKeys => true;
}
