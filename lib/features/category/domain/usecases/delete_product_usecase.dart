import '../repository/category_repo.dart';

class DeleteProductUseCase {
  final CategoryRepository repository;
  DeleteProductUseCase(this.repository);

  Future<void> execute(String productId) async {
    return repository.deleteProduct(productId);
  }
}
