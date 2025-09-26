import 'package:flutter/material.dart';
import 'package:personal_health_app/UI/components/fields/dynamic_fields_form.dart';
import 'package:personal_health_app/UI/components/images_selector/images_selector.dart';
import 'package:personal_health_app/UI/components/loadings/circular_loading.dart';
import 'package:personal_health_app/UI/pages/create_item/create_item_page_presenter.dart';

import '../../mixins/mixins.dart';

class CreateItemPage extends StatefulWidget
    with ColorHelper, NavigationManager, UIErrorManager {
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
    return Builder(builder: (context) {
      widget.handleNavigation(widget.presenter.navigateToStream);
      widget.handleMainError(context, widget.presenter.mainErrorStream);

      return Scaffold(
        body: StreamBuilder(
          stream: widget.presenter.currentCategoryStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  color: widget.hexToColor(snapshot.data?.color ?? ''),
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 8,
                      children: [
                        Text(
                          snapshot.data?.name ?? '',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: widget.getContrastColor(
                                snapshot.data?.color ??
                                    ''), // Replace with your desired color
                          ),
                        ),
                        if (snapshot.data?.allowAttachments == true)
                          StreamBuilder(
                            stream: widget.presenter.selectedImagesStream,
                            builder: (context, snapshot) {
                              return ImagesSelector(
                                handleSelectFiles:
                                    widget.presenter.selectImageFiles,
                                files: snapshot.data ?? [],
                              );
                            },
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
                  ));
            }

            return const CircularLoading();
          },
        ),
      );
    });
  }
}
