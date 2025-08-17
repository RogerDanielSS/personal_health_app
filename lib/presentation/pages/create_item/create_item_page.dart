import 'package:flutter/material.dart';
import 'package:personal_health_app/presentation/components/fields/fields_list.dart';
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
              children: <Widget>[FieldsList(dynamicFields: snapshot.data?.dynamicFields)],
            );
          }

          return const CircularLoading();
        },
      ),
    );
  }
}
