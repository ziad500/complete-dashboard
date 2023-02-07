import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/features/category/data/remote/data_source/category_remote_data_source.dart';
import 'package:dashboard/features/category/data/remote/data_source/category_remote_data_source_impl.dart';
import 'package:dashboard/features/category/data/repository/category_repo_impl.dart';
import 'package:dashboard/features/category/domain/repository/category_repo.dart';
import 'package:dashboard/features/category/domain/usecases/add_category_usecase.dart';
import 'package:dashboard/features/category/domain/usecases/delete_category_usecase.dart';
import 'package:dashboard/features/category/domain/usecases/get_category_usecase.dart';
import 'package:dashboard/features/category/presentation/category_screen/cubit/category_screen_cubit.dart';
import 'package:dashboard/features/main_screen/data/remote/data_source/main_screen_data_source.dart';
import 'package:dashboard/features/main_screen/data/remote/data_source/main_screen_data_source_impl.dart';
import 'package:dashboard/features/main_screen/data/repository/main_screen_repo_impl.dart';
import 'package:dashboard/features/main_screen/domain/repository/main_screen_repo.dart';
import 'package:dashboard/features/main_screen/domain/usecases/get_category_count_usecase.dart';
import 'package:dashboard/features/main_screen/presentation/cubit/main_screen_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //cubit
  sl.registerFactory<CategoryScreenCubit>(() => CategoryScreenCubit(
      addCategoryUseCase: sl.call(),
      getCategoryUseCase: sl.call(),
      deleteCategoryUseCase: sl.call()));

  sl.registerFactory<MainScreenCubit>(() => MainScreenCubit(sl.call()));

  //usecase
  sl.registerLazySingleton<AddCategoryUseCase>(
      () => AddCategoryUseCase(sl.call()));

  sl.registerLazySingleton<GetCategoryUseCase>(
      () => GetCategoryUseCase(sl.call()));

  sl.registerLazySingleton<DeleteCategoryUseCase>(
      () => DeleteCategoryUseCase(sl.call()));

  sl.registerLazySingleton<GetCategoryCountUseCase>(
      () => GetCategoryCountUseCase(sl.call()));

  //repository
  sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(sl.call()));

  sl.registerLazySingleton<MainScreenRepository>(
      () => MainScreenRepositoryImpl(sl.call()));

  //data source
  sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(sl.call()));

  sl.registerLazySingleton<MainScreenRemoteDataSource>(
      () => MainScreenRemoteDataSourceImpl(sl.call()));

  //external
  final fireStore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => fireStore);
}
