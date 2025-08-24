import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/entities.dart';
import 'package:personal_health_app/presentation/components/fields/dynamic_fields_form.dart';
import 'package:personal_health_app/presentation/components/loadings/circular_loading.dart';
import 'package:personal_health_app/presentation/pages/create_item/create_item_page_presenter.dart';

class CreateItemPage extends StatefulWidget {
  final CreateItemPagePresenter presenter;

  const CreateItemPage({super.key, required this.presenter});

  @override
  State<CreateItemPage> createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePage();
    });
  }

  Future<void> _initializePage() async {
    widget.presenter.loadCurrentCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: widget.presenter.currentCategoryStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                DynamicFieldsForm(
                  dynamicFields: snapshot.data?.dynamicFields,
                  onSubmit: (Map<String, String> fields) {
                    widget.presenter.createItemData(snapshot.data!.id, fields);
                  },
                )
              ],
            );
          }

          return const CircularLoading();
        },
      ),
    );
  }
}
