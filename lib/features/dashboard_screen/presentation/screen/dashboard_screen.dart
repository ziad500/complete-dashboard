import 'package:dashboard/features/category/presentation/category_screen/cubit/category_screen_cubit.dart';
import 'package:dashboard/features/dashboard_screen/presentation/cubit/dashboard_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/dashboard_screen_cubit.dart';

class DashBoardMainScreen extends StatelessWidget {
  const DashBoardMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardMainScreenCubit, DashboardMainScreenState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        floatingActionButton: floatingActionButton(context),
        body: Row(
          children: [
            navigation(context),
            BlocProvider.of<DashboardMainScreenCubit>(context).screens[
                BlocProvider.of<DashboardMainScreenCubit>(context).currentIndex]
          ],
        ),
      ),
    );
  }

  Widget navigation(context) => Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 131, 33, 243),
            Color.fromARGB(255, 143, 54, 244),
          ],
        )),
        child: NavigationRail(
          onDestinationSelected: (value) {
            BlocProvider.of<DashboardMainScreenCubit>(context)
                .selectIndex(value);
          },
          extended:
              BlocProvider.of<DashboardMainScreenCubit>(context).isExpanded,
          backgroundColor: // LinearGradient(colors: colors),
              Colors.transparent,
          unselectedIconTheme:
              const IconThemeData(color: Colors.white, opacity: 1),
          unselectedLabelTextStyle: const TextStyle(color: Colors.white),
          selectedIconTheme: IconThemeData(color: Colors.deepPurple.shade900),
          destinations: const [
            NavigationRailDestination(
                icon: Icon(Icons.home), label: Text("Home")),
            NavigationRailDestination(
                icon: Icon(Icons.category) /*  Icon(Icons.bar_chart) */,
                label: Text("Category")),
            NavigationRailDestination(
                icon: Icon(Icons.person), label: Text("Profile")),
            NavigationRailDestination(
                icon: Icon(Icons.settings), label: Text("Settings"))
          ],
          selectedIndex:
              BlocProvider.of<DashboardMainScreenCubit>(context).currentIndex,
        ),
      );

  Widget floatingActionButton(context) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 131, 33, 243),
                Color.fromARGB(255, 143, 54, 244),
              ],
            )),
        child: FloatingActionButton(
          onPressed: () {
            if (BlocProvider.of<DashboardMainScreenCubit>(context)
                    .currentIndex ==
                1) {
              showAddProductAlert(context);
            }
          },
          backgroundColor: Colors.transparent,
          child: const Icon(Icons.add),
        ),
      );

  showAddProductAlert(context) {
    var categoryList =
        BlocProvider.of<CategoryScreenCubit>(context).categoryList;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            title: const Center(
              child: Text(
                "Add New Product",
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            content: SizedBox(
              height: 360,
              width: 500,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller:
                            BlocProvider.of<DashboardMainScreenCubit>(context)
                                .productNameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Product Name',
                            labelText: 'Product Name'),
                      ),
                    ),
                    BlocConsumer<DashboardMainScreenCubit,
                            DashboardMainScreenState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Container(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton(
                                isExpanded: true,
                                hint: Text(
                                    BlocProvider.of<DashboardMainScreenCubit>(
                                            context)
                                        .selectedCategory),
                                items: categoryList
                                    .map(
                                      (category) => DropdownMenuItem(
                                          onTap: () {
                                            BlocProvider.of<
                                                        DashboardMainScreenCubit>(
                                                    context)
                                                .selectCategory(category
                                                    .category
                                                    .toString());
                                          },
                                          value: category.category.toString(),
                                          child: Text(
                                              category.category.toString())),
                                    )
                                    .toList(),
                                onChanged: (value) {}),
                          );
                        }),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        maxLines: 4,
                        controller:
                            BlocProvider.of<DashboardMainScreenCubit>(context)
                                .descriptionController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Description Of Your Product',
                            labelText: 'Description'),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<DashboardMainScreenCubit>(
                                        context)
                                    .addProduct();

                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple.shade400,
                                // fixedSize: Size(250, 50),
                              ),
                              child: const Text(
                                "Submit",
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                // fixedSize: Size(250, 50),
                              ),
                              child: const Text(
                                "Cancel",
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
