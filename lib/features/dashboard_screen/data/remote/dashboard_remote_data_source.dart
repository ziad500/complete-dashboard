import 'package:dashboard/features/dashboard_screen/domain/model/product_entity.dart';

abstract class DashboardRemoteDataSource {
  Future<void> addProduct(ProductEntity productEntity);
}
