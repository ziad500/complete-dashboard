import 'package:dashboard/features/main_screen/domain/repository/main_screen_repo.dart';

class GetCategoryCountUseCase {
  final MainScreenRepository repository;
  GetCategoryCountUseCase(this.repository);

  Future<int> execute() async {
    return repository.getCategoryCount();
  }
}
