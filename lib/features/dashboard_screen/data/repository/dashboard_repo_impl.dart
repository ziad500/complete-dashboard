import 'package:dashboard/features/dashboard_screen/data/remote/dashboard_remote_data_source.dart';
import 'package:dashboard/features/dashboard_screen/domain/model/product_entity.dart';

import '../../domain/repository/dashboard_repo.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;
  DashboardRepositoryImpl(this.remoteDataSource);
  @override
  Future<void> addProduct(ProductEntity productEntity) =>
      remoteDataSource.addProduct(productEntity);
}
