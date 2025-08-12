import 'package:personal_health_app/domain/entities/entities.dart';

import '../protocols/http/http_error.dart';

class RemoteDynamicFieldModel {
  final int id;
  final String name;
  final String dataType;

  RemoteDynamicFieldModel({
    required this.id,
    required this.name,
    required this.dataType,
  });

  factory RemoteDynamicFieldModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['id', 'name', 'data_type'])) {
      throw HttpError.invalidData;
    }

    return RemoteDynamicFieldModel(
      id: json['id'],
      name: json['name'],
      dataType: json['dataType'],
    );
  }

  DynamicFieldEntity toEntity() => DynamicFieldEntity(
        id: id,
        name: name,
        dataType: dataType,
      );
}
