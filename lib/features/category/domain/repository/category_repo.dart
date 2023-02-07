import 'package:dashboard/features/category/domain/model/category_entity.dart';

abstract class CategoryRepository {
  Future<void> addCategory(String category);
  Stream<List<CategoryEntity>> getCategory();
  Future<void> deleteCategory(String categoryId);
}
