import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/entities.dart';
import 'package:personal_health_app/presentation/components/fields/field/multitype_field.dart';

class FieldsList extends StatelessWidget {
  final List<DynamicFieldEntity>? dynamicFields;
  final TextEditingController _controller = TextEditingController();

  FieldsList({super.key, this.dynamicFields});

  List<Widget> buildFields(int count) {
    return List.generate(
        count,
        (index) => MultiTypeField(
              dynamicField: dynamicFields![index],
              textController: _controller,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          key: key,
          spacing: 16,
          children: buildFields((dynamicFields ?? []).length),
        ),
      )
    );
  }
}
