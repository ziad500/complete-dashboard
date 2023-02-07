import 'package:dashboard/screens/dashboard_screen/dashboard_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_screen_cubit.dart';

class DashBoardMainScreen extends StatelessWidget {
  const DashBoardMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardMainScreenCubit, DashboardMainScreenState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        floatingActionButton: floatingActionButton(),
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

  Widget navigation(context) => NavigationRail(
        onDestinationSelected: (value) {
          BlocProvider.of<DashboardMainScreenCubit>(context).selectIndex(value);
        },
        extended: BlocProvider.of<DashboardMainScreenCubit>(context).isExpanded,
        backgroundColor: Colors.deepPurple.shade400,
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
      );

  Widget floatingActionButton() => FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurple.shade400,
        child: const Icon(Icons.add),
      );
}
