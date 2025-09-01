import 'package:flutter/material.dart';
import 'package:personal_health_app/UI/components/category_card/category_card.dart';
import 'package:personal_health_app/UI/components/loadings/circular_loading.dart';
import 'package:personal_health_app/UI/mixins/navigation_manager.dart';
import 'package:personal_health_app/domain/entities/category.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:personal_health_app/UI/pages/select_category/select_categoty_page_presenter.dart';

class SelectCategoryPage extends StatefulWidget with NavigationManager {
  final SelectCategoryPagePresenter presenter;

  const SelectCategoryPage({super.key, required this.presenter});

  @override
  State<SelectCategoryPage> createState() => _SelectCategoryPageState();
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePage();
    });
  }

  Future<void> _initializePage() async {
    widget.presenter.loadCategoriesData();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      widget.handleNavigation(widget.presenter.navigateToStream);

      return Scaffold(
        body: StreamBuilder(
          stream: widget.presenter.categoriesStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  padding: EdgeInsets.all(16),
                  child: SearchableList<CategoryEntity>(
                    initialList: snapshot.data ?? [],
                    itemBuilder: (CategoryEntity category) => CategoryCard(
                      category: category,
                      onPressed: () =>
                          {widget.presenter.handleSelectCategory(category)},
                    ),
                    filter: (value) => snapshot.data!
                        .where(
                          (element) =>
                              element.name.toLowerCase().contains(value),
                        )
                        .toList(),
                    emptyWidget: const Text('Nenhuma categoria encontrada...'),
                    inputDecoration: InputDecoration(
                      labelText: "Pesquisar categoria",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
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
