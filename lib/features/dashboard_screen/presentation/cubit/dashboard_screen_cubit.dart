import 'dart:io';

import 'package:dashboard/features/category/presentation/category_screen/screen/category_screen.dart';
import 'package:dashboard/features/dashboard_screen/data/model/product_model.dart';
import 'package:dashboard/features/dashboard_screen/domain/model/product_entity.dart';
import 'package:dashboard/features/category/domain/usecases/get_product_usecase.dart';
import 'package:dashboard/features/dashboard_screen/domain/usecase/product_usecase.dart';
import 'package:dashboard/features/main_screen/presentation/screen/main_screen.dart';
import 'package:dashboard/features/profile_screen/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_screen_states.dart';

class DashboardMainScreenCubit extends Cubit<DashboardMainScreenState> {
  final AddProductUseCase addProductUseCase;
  final GetProductUseCase getProductUseCase;

  DashboardMainScreenCubit(this.addProductUseCase, this.getProductUseCase)
      : super(DashboardMainScreenInitial());
  // BlocProvider.of<DashboardMainScreenCubit>(context)

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<Widget> screens = [
    MainScreen(),
    CategoryScreen(),
    ProfileScreen(),
    MainScreen()
  ];

  int currentIndex = 0;
  selectIndex(value) {
    currentIndex = value;
    emit(SelectSuccess());
  }

  bool isExpanded = false;
  expand() {
    isExpanded = !isExpanded;
    emit(ExpandSuccess());
  }

  void addProduct() async {
    if (descriptionController.text != "" &&
        productNameController.text != "" &&
        selectedCategory != "Category") {
      try {
        await addProductUseCase.execute(ProductModel(
            category: selectedCategory,
            description: descriptionController.text,
            image:
                "https://www.google.com/url?sa=i&url=http%3A%2F%2Farabic.britannicaenglish.com%2Fapple&psig=AOvVaw1E0ftycI6A7HfugYvJapta&ust=1675886478436000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCNDL8uOZhP0CFQAAAAAdAAAAABAE",
            productName: productNameController.text));

        emit(AddProductSuccessState());
      } on SocketException catch (_) {
        emit(AddProductFaildState());
      } catch (_) {
        emit(AddProductFaildState());
      }
      descriptionController.text = "";
      productNameController.text = "";
      selectedCategory = "Category";
    }
  }

  String selectedCategory = "Category";
  selectCategory(String value) {
    selectedCategory = value;
    emit(SelectCategoryState());
  }
}
