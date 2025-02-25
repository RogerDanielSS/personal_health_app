enum UIError {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
  wrongPassword,
  emailInUse,
  doctorInTheTeam
}

extension UIErrorExtension on UIError {
  String get description {
    switch (this) {
      case UIError.requiredField:
        return 'Campo obrigatório.';
      case UIError.invalidField:
        return 'Campo inválido.';
      case UIError.invalidCredentials:
        return 'Credenciais inválidas.';
      case UIError.wrongPassword:
        return 'Senha incorreta.';
      case UIError.emailInUse:
        return 'E-mail em uso.';
      case UIError.doctorInTheTeam:
        return 'Este médico já está neste time.';
      default:
        return 'Algo errado aconteceu. Tente novamente em breve.';
    }
  }
}
