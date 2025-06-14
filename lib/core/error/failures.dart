abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  NetworkFailure() : super('Erro de conexão. Verifique sua internet.');
}

class ApiKeyFailure extends Failure {
  ApiKeyFailure() : super('Erro de autenticação com a API.');
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure() : super('Ocorreu um erro inesperado.');
}
