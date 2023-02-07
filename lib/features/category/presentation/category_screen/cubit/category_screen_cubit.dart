import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/features/category/domain/model/category_entity.dart';
import 'package:dashboard/features/category/domain/usecases/add_category_usecase.dart';
import 'package:dashboard/features/main_screen/presentation/cubit/main_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/delete_category_usecase.dart';
import '../../../domain/usecases/get_category_usecase.dart';
import 'category_screen_states.dart';

class CategoryScreenCubit extends Cubit<CategoryScreenState> {
  CategoryScreenCubit(
      {required this.getCategoryUseCase,
      required this.addCategoryUseCase,
      required this.deleteCategoryUseCase})
      : super(CategoryScreenInitial());
  // BlocProvider.of<CategoryScreenCubit>(context)
  final AddCategoryUseCase addCategoryUseCase;
  final GetCategoryUseCase getCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;

  final TextEditingController categoryController = TextEditingController();
  void addCategory() async {
    if (categoryController.text != "") {
      try {
        await addCategoryUseCase.execute(categoryController.text);
        emit(AddCategorySuccessState());
      } on SocketException catch (_) {
        emit(AddCategoryFaildState());
      } catch (_) {
        emit(AddCategoryFaildState());
      }
      categoryController.text = "";
    }
  }

  List<CategoryEntity> categoryList = [];
  void getCategory() async {
    emit(GetCategoryLoadingState());

    try {
      getCategoryUseCase.execute().listen((event) {
        categoryList = [];
        for (var element in event) {
          categoryList.add(element);
        }
        emit(GetCategorySuccessState());
      });
    } on SocketException catch (_) {
      emit(GetCategoryErrorState());
    } catch (_) {
      emit(GetCategoryErrorState());
    }
  }

  void deleteCategory(String categoryId) async {
    try {
      await deleteCategoryUseCase.execute(categoryId);
    } on SocketException catch (_) {
      emit(DeleteCategoryErrorState());
    } catch (_) {
      emit(DeleteCategoryErrorState());
    }
  }
}
