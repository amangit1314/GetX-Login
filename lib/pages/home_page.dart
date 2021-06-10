import 'package:firebase_getx_login/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hello ${authController.firebaseUser.displayName}',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          TextButton(onPressed: authController.signOut, child: Text('Sign Out'))
        ],
      ),
    );
  }
}
