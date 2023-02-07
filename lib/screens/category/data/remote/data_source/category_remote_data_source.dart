import 'package:dashboard/screens/category/domain/model/category_entity.dart';

abstract class CategoryRemoteDataSource {
  Future<void> addCategory(String category);
  Stream<List<CategoryEntity>> getCategory();
  Future<void> deleteCategory(String categoryId);
}
