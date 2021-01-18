import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as Trans;
import 'package:my_diary/controller/home_controller.dart';
import 'package:my_diary/pages/diary_detail_page.dart';
import 'package:my_diary/pages/diary_form_page.dart';
import 'package:my_diary/pages/home_page.dart';
import 'package:my_diary/pages/login_page.dart';
import 'package:my_diary/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}

final ThemeData appThemeData = ThemeData(
  scaffoldBackgroundColor: Color(0xFFF8F8F8),
  primaryColor: Colors.blueAccent,
  primarySwatch: Colors.blue,
  appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Roboto',
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
);

class App extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
              title: "Wholesale",
              debugShowCheckedModeBanner: false,
              initialRoute: '/auth/login',
              theme: appThemeData,
              defaultTransition: Trans.Transition.native,
              getPages: [
                // Auth
                GetPage(name: "/auth/login", page: () => LoginPage()),
                GetPage(name: "/auth/register", page: () => RegisterPage()),
                GetPage(
                    name: "/home", page: () => HomePage(), binding: HomeBind()),
                GetPage(name: "/diary/detail", page: () => DiaryDetailPage()),
                GetPage(name: "/diary/form", page: () => DiaryFormPage()),
              ]);
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          home: Scaffold(
            body: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class HomeBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
