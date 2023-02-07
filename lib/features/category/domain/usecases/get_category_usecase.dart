import 'package:dashboard/features/category/domain/model/category_entity.dart';

import '../repository/category_repo.dart';

class GetCategoryUseCase {
  final CategoryRepository repository;
  GetCategoryUseCase(this.repository);

  Stream<List<CategoryEntity>> execute() {
    return repository.getCategory();
  }
}
