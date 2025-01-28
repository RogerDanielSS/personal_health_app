enum DomainError { accessDenied, wrongPassword, unexpected, invalidCredentials, emailInUse }

extension DomainErrorExtension on DomainError {
  String get description {
    switch (this) {
      case DomainError.accessDenied:
        return 'Acesso negado.';
      case DomainError.wrongPassword:
        return 'Senha incorreta.';
      case DomainError.invalidCredentials:
        return 'Credenciais inválidas.';
      case DomainError.emailInUse:
        return 'Email em uso.';
      default:
        return 'Algo errado aconteceu. Tente novamente em breve.';
    }
  }
}
