enum UISuccess {
  emailResent,
}

extension UISuccessExtension on UISuccess {
  String get description {
    switch (this) {
      case UISuccess.emailResent:
        return 'E-mail reenviado com sucesso!';
    }
  }
}
