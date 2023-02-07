import 'package:dashboard/features/category/data/remote/data_source/category_remote_data_source.dart';
import 'package:dashboard/features/category/domain/model/category_entity.dart';
import 'package:dashboard/features/category/domain/repository/category_repo.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addCategory(String category) =>
      remoteDataSource.addCategory(category);

  @override
  Stream<List<CategoryEntity>> getCategory() => remoteDataSource.getCategory();

  @override
  Future<void> deleteCategory(String categoryId) =>
      remoteDataSource.deleteCategory(categoryId);
}
