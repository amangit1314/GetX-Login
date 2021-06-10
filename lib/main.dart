import 'package:firebase_getx_login/controllers/auth_controller.dart';
import 'package:firebase_getx_login/pages/home_page.dart';
import 'package:firebase_getx_login/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),
    ),
  );
}

class App extends StatelessWidget {
  // Inject auth controller to View.
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authController.checkUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        }
        if (snapshot.hasError) {
          snapshot.printError();
          return Center(
            child: Text(
              'Error Processing',
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        return LodingWidget();
      },
    );
  }
}
