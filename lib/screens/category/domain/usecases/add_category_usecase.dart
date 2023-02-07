import '../repository/category_repo.dart';

class AddCategoryUseCase {
  final CategoryRepository repository;
  AddCategoryUseCase(this.repository);

  Future<void> execute(String category) async {
    return repository.addCategory(category);
  }
}
