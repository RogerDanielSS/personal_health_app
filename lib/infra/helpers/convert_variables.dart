import 'dart:core';

String camelToSnake(String input) {
  return input.replaceAllMapped(RegExp(r'([A-Z])'), (match) {
    return '_${match.group(1)!.toLowerCase()}';
  });
}

String snakeToCamel(String input) {
  return input.replaceAllMapped(RegExp(r'_(\w)'), (match) {
    return match.group(1)!.toUpperCase();
  });
}
