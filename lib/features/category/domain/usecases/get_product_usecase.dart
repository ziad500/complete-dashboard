import 'package:dashboard/features/category/domain/model/category_entity.dart';
import 'package:dashboard/features/category/domain/repository/category_repo.dart';
import 'package:dashboard/features/dashboard_screen/domain/model/product_entity.dart';

class GetProductUseCase {
  final CategoryRepository repository;
  GetProductUseCase(this.repository);

  Stream<List<ProductEntity>> execute() {
    return repository.getProduct();
  }
}
