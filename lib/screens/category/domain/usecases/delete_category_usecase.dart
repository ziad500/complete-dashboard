import '../repository/category_repo.dart';

class DeleteCategoryUseCase {
  final CategoryRepository repository;
  DeleteCategoryUseCase(this.repository);

  Future<void> execute(String categoryId) async {
    return repository.deleteCategory(categoryId);
  }
}
