import 'dart:io';

import 'package:dashboard/screens/main_screen/domain/usecases/get_category_count_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_screen_states.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  final GetCategoryCountUseCase getCategoryCountUseCase;
  MainScreenCubit(this.getCategoryCountUseCase) : super(MainScreenInitial());

  int categoryCount = 0;

  void getCategoryCount() async {
    try {
      final categoryLenghth = await getCategoryCountUseCase.execute();
      categoryCount = categoryLenghth;
      emit(GetCategoryCountSuccessState());
    } on SocketException catch (_) {
      emit(GetCategoryCountErrorState());
    } catch (_) {
      emit(GetCategoryCountErrorState());
    }
  }
}
