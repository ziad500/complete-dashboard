import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/features/category/data/remote/data_source/category_remote_data_source.dart';
import 'package:dashboard/features/category/data/remote/data_source/category_remote_data_source_impl.dart';
import 'package:dashboard/features/category/data/repository/category_repo_impl.dart';
import 'package:dashboard/features/category/domain/repository/category_repo.dart';
import 'package:dashboard/features/category/domain/usecases/add_category_usecase.dart';
import 'package:dashboard/features/category/domain/usecases/delete_category_usecase.dart';
import 'package:dashboard/features/category/domain/usecases/delete_product_usecase.dart';
import 'package:dashboard/features/category/domain/usecases/get_category_usecase.dart';
import 'package:dashboard/features/category/presentation/category_screen/cubit/category_screen_cubit.dart';
import 'package:dashboard/features/dashboard_screen/data/remote/dashboard_remote_data_source.dart';
import 'package:dashboard/features/dashboard_screen/data/remote/dashboard_remote_data_source_impl.dart';
import 'package:dashboard/features/dashboard_screen/data/repository/dashboard_repo_impl.dart';
import 'package:dashboard/features/dashboard_screen/domain/repository/dashboard_repo.dart';
import 'package:dashboard/features/category/domain/usecases/get_product_usecase.dart';
import 'package:dashboard/features/dashboard_screen/domain/usecase/product_usecase.dart';
import 'package:dashboard/features/dashboard_screen/presentation/cubit/dashboard_screen_cubit.dart';
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
  sl.registerFactory<DashboardMainScreenCubit>(
      () => DashboardMainScreenCubit(sl.call(), sl.call()));

  sl.registerFactory<CategoryScreenCubit>(() => CategoryScreenCubit(
      addCategoryUseCase: sl.call(),
      getCategoryUseCase: sl.call(),
      deleteCategoryUseCase: sl.call(),
      getProductUseCase: sl.call(),
      deleteProductUseCase: sl.call()));

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

  sl.registerLazySingleton<AddProductUseCase>(
      () => AddProductUseCase(sl.call()));

  sl.registerLazySingleton<GetProductUseCase>(
      () => GetProductUseCase(sl.call()));

  sl.registerLazySingleton<DeleteProductUseCase>(
      () => DeleteProductUseCase(sl.call()));

  //repository
  sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(sl.call()));

  sl.registerLazySingleton<MainScreenRepository>(
      () => MainScreenRepositoryImpl(sl.call()));

  sl.registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl(sl.call()));

  //data source
  sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(sl.call()));

  sl.registerLazySingleton<MainScreenRemoteDataSource>(
      () => MainScreenRemoteDataSourceImpl(sl.call()));

  sl.registerLazySingleton<DashboardRemoteDataSource>(
      () => DashboardRemoteDataSourceImpl(sl.call()));

  //external
  final fireStore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => fireStore);
}
