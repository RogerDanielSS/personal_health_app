import 'package:flutter/material.dart';
import 'package:personal_health_app/UI/components/fields/dynamic_fields_form.dart';
import 'package:personal_health_app/UI/components/file_picker/file_picker.dart';
import 'package:personal_health_app/UI/components/loadings/circular_loading.dart';
import 'package:personal_health_app/UI/pages/create_item/create_item_page_presenter.dart';

import '../../mixins/mixins.dart';

class CreateItemPage extends StatefulWidget with ColorHelper {
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
            return Container(
              color: widget.hexToColor(snapshot.data?.color ?? ''),
              height: double.maxFinite,
              child: Column(
                spacing: 8,
                children: [
                  Text(
                    snapshot.data?.name ?? '',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: widget.getContrastColor(snapshot.data?.color ??
                          ''), // Replace with your desired color
                    ),
                  ),
                  FilePickerExample(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.8,
                      constraints: BoxConstraints(
                        maxWidth: 500,
                      ),
                      child: Icon(
                        Icons.image,
                        size: MediaQuery.of(context).size.width * 0.4,
                      ),
                    ),
                  ),
                  DynamicFieldsForm(
                    dynamicFields: snapshot.data?.dynamicFields,
                    onSubmit: (Map<String, String> fields) {
                      widget.presenter
                          .createItemData(snapshot.data!.id, fields);
                    },
                  )
                ],
              ),
            );
          }

          return const CircularLoading();
        },
      ),
    );
  }
}
