import 'package:firebase_getx_login/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  // Inject our auth contorller into the login view
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text(
            'Login with Google',
          ),
          onPressed: () {
            // Call the sign in method
            authController.signInWithGoogle();
          },
        ),
      ),
    );
  }
}
