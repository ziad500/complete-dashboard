import 'package:dashboard/screens/category/presentation/category_screen/cubit/category_screen_cubit.dart';
import 'package:dashboard/screens/dashboard_screen/dashboard_screen.dart';
import 'package:dashboard/screens/dashboard_screen/dashboard_screen_cubit.dart';
import 'package:dashboard/screens/main_screen/presentation/cubit/main_screen_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dashboard/dependancy_injection.dart' as di;

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DashboardMainScreenCubit(),
          ),
          BlocProvider(
            create: (context) => di.sl<CategoryScreenCubit>(),
          ),
          BlocProvider(
            create: (context) => di.sl<MainScreenCubit>()..getCategoryCount(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: DashBoardMainScreen(),
        ));
  }
}
