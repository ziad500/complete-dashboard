import 'package:dashboard/screens/category/presentation/category_screen/screen/category_screen.dart';
import 'package:dashboard/screens/main_screen/presentation/screen/main_screen.dart';
import 'package:dashboard/screens/profile_screen/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_screen_states.dart';

class DashboardMainScreenCubit extends Cubit<DashboardMainScreenState> {
  DashboardMainScreenCubit() : super(DashboardMainScreenInitial());
  // BlocProvider.of<DashboardMainScreenCubit>(context)

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
}
