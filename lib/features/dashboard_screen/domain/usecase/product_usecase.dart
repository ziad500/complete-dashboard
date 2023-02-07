import 'package:dashboard/features/dashboard_screen/domain/model/product_entity.dart';
import 'package:dashboard/features/dashboard_screen/domain/repository/dashboard_repo.dart';

class AddProductUseCase {
  final DashboardRepository repository;
  AddProductUseCase(this.repository);

  Future<void> execute(ProductEntity productEntity) async {
    return repository.addProduct(productEntity);
  }
}
