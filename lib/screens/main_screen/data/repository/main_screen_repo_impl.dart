import 'package:dashboard/screens/main_screen/data/remote/data_source/main_screen_data_source.dart';
import 'package:dashboard/screens/main_screen/domain/repository/main_screen_repo.dart';

class MainScreenRepositoryImpl implements MainScreenRepository {
  final MainScreenRemoteDataSource remoteDataSource;
  MainScreenRepositoryImpl(this.remoteDataSource);

  @override
  Future<int> getCategoryCount() => remoteDataSource.getCategoryCount();
}
