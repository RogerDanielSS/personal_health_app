mixin ValidationManager {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Insira seu email';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Insira um email válido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    return validateRequired(value, 'senha');
  }

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira sua $fieldName';
    }
    return null;
  }
}