import 'package:dashboard/features/category/domain/model/category_entity.dart';

import '../../../../dashboard_screen/domain/model/product_entity.dart';

abstract class CategoryRemoteDataSource {
  Future<void> addCategory(String category);
  Stream<List<CategoryEntity>> getCategory();
  Future<void> deleteCategory(String categoryId);
  Stream<List<ProductEntity>> getProduct();
}
