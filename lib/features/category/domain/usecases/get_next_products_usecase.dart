import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/features/dashboard_screen/domain/model/product_entity.dart';
import '../repository/category_repo.dart';

class GetNextProductsUseCase {
  final CategoryRepository repository;
  GetNextProductsUseCase({required this.repository});

  Stream<List<ProductEntity>> execute(Timestamp date) {
    return repository.getNextProductList(date);
  }
}
