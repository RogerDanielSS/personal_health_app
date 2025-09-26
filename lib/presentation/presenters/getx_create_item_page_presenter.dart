import 'package:get/get.dart';
import 'package:personal_health_app/data/protocols/file_selector/file_selector.dart';
import 'package:personal_health_app/domain/entities/entities.dart';
import 'package:personal_health_app/UI/pages/create_item/create_item_page_presenter.dart';
import 'package:personal_health_app/domain/entities/local_file.dart';
import 'package:personal_health_app/domain/usecases/select_many_files.dart';

import '../../../domain/usecases/usecases.dart';
import '../../domain/helpers/domain_error.dart';
import '../helpers/errors/ui_error.dart';
import '../mixins/mixins.dart';

class GetxCreateItemPagePresenter extends GetxController
    with SessionManager, NavigationManager, UIErrorManager, LoadingManager
    implements CreateItemPagePresenter {
  final LoadCurrentCategory loadCurrentCategory;
  final CreateItem createItem;
  final SelectFiles selectFiles;

  final _category = Rx<CategoryEntity?>(null);
  final _selectedImages = Rx<List<LocalFileEntity>?>(null);

  GetxCreateItemPagePresenter(
      {required this.loadCurrentCategory,
      required this.createItem,
      required this.selectFiles});

  @override
  Stream<CategoryEntity?> get currentCategoryStream => _category.stream;
  @override
  Stream<List<LocalFileEntity>?> get selectedImagesStream =>
      _selectedImages.stream;

  @override
  Future<void> loadCurrentCategoryData() async {
    try {
      final currentCategory = await loadCurrentCategory.load();
      if (currentCategory == null) {
        throw DomainError.unexpected;
      }
      _category.value = currentCategory;
    } on Error {
      mainError = UIError.unexpected;
    }
  }

  @override
  Future<void> createItemData(
      int categoryId, Map<String, String> fields) async {
    try {
      final item = ItemEntity(
          categoryId: categoryId,
          fields: fields,
          images: _selectedImages.value);
      await createItem.create(item);

      navigateTo = '/items';
    } catch (error) {
      mainError = UIError.unexpected;
    }
  }

  @override
  Future<void> selectImageFiles() async {
    List<LocalFileEntity> selectedImages = [];
    try {
      selectedImages =
          await selectFiles.select(LocalFileType.image, ['jpeg', 'png']);
    } on Error {
      return;
    }
    _selectedImages.value = (_selectedImages.value ?? []) + selectedImages;
  }
}
