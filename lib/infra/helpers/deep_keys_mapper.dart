dynamic deepKeyTransform(dynamic input, String Function(String) keyTransform) {
  if (input is Map) {
    Map<String, dynamic> result = {};

    input.forEach((key, value) {
      String newKey = keyTransform(key);

      if (value is Map) {
        result[newKey] = deepKeyTransform(value, keyTransform);
      } else if (value is List) {
        result[newKey] = value.map((item) => deepKeyTransform(item, keyTransform)).toList();
      } else {
        result[newKey] = value;
      }
    });

    return result;
  } else if (input is List) {
    return input.map((item) => deepKeyTransform(item, keyTransform)).toList();
  } else {
    return input;
  }
}
