import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo_app/pages/add_activity_page/data/data_sources/local_source.dart';
import 'package:todo_app/pages/add_activity_page/data/implements/add_activity_implements.dart';
import 'package:todo_app/pages/add_activity_page/presentation/controller/add_activity_controller.dart';
import 'package:todo_app/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup Dependency Injection manual atau via Get.put()
  final db = LocalDatabase();
  final repo = AddActivityRepositoryImplements(db);

  // Masukkan Controller ke memori
  Get.put(AddActivityController(repo));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child:  MaterialApp(
          title: 'Todo App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const SplashScreen(),
        )
    );
  }
}
