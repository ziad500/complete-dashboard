import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/features/category/domain/model/category_entity.dart';
import 'package:dashboard/features/category/domain/usecases/add_category_usecase.dart';
import 'package:dashboard/features/category/domain/usecases/delete_product_usecase.dart';
import 'package:dashboard/features/category/domain/usecases/get_next_products_usecase.dart';
import 'package:dashboard/features/category/domain/usecases/get_product_usecase.dart';
import 'package:dashboard/features/main_screen/presentation/cubit/main_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dashboard_screen/domain/model/product_entity.dart';
import '../../../domain/usecases/delete_category_usecase.dart';
import '../../../domain/usecases/get_category_usecase.dart';
import 'category_screen_states.dart';

class CategoryScreenCubit extends Cubit<CategoryScreenState> {
  CategoryScreenCubit(
      {required this.getCategoryUseCase,
      required this.addCategoryUseCase,
      required this.deleteCategoryUseCase,
      required this.getProductUseCase,
      required this.getNextProductsUseCase,
      required this.deleteProductUseCase})
      : super(CategoryScreenInitial());
  // BlocProvider.of<CategoryScreenCubit>(context)
  final AddCategoryUseCase addCategoryUseCase;
  final GetCategoryUseCase getCategoryUseCase;
  final GetNextProductsUseCase getNextProductsUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;
  final GetProductUseCase getProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

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

  List<ProductEntity> productsList = [];
  void getProduct() async {
    emit(GetProductLoadingState());

    try {
      getProductUseCase.execute().listen((event) {
        productsList = [];
        for (var element in event) {
          productsList.add(element);
        }
        emit(GetProductSuccessState());
      });
    } on SocketException catch (_) {
      emit(GetProductErrorState());
    } catch (_) {
      emit(GetProductErrorState());
    }
  }

  //bool enoughData = false;

  void getNextProductList() async {
    emit(GetProductLoadingState());

    try {
      getNextProductsUseCase
          .execute(productsList[productsList.length - 1].dateOfCreation!)
          .listen((event) {
        if (event.isEmpty) {
          //enoughData = true;
          emit(GetProductEmptyState());
        } else {
          productsList.addAll(event);
          emit(GetProductSuccessState());
        }
      });
    } on SocketException catch (_) {
      emit(GetProductErrorState());
    } catch (_) {
      emit(GetProductErrorState());
    }
  }

  void deleteProduct(String productId) async {
    try {
      await deleteProductUseCase.execute(productId);
    } on SocketException catch (_) {
      emit(DeleteProductErrorState());
    } catch (_) {
      emit(DeleteProductErrorState());
    }
  }
}
