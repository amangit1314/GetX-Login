import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_getx_login/pages/home_page.dart';
import 'package:firebase_getx_login/pages/login_page.dart';
import 'package:firebase_getx_login/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  late FirebaseApp firebaseApp;
  late User firebaseUser;
  late FirebaseAuth firebaseAuth;

  Future<void> initializeFirebaseApp() async {
    firebaseApp = await Firebase.initializeApp();
  }

  Future<Widget> checkUserLoggedIn() async {
    if (firebaseApp == null) {
      await initializeFirebaseApp();
    }
    if (firebaseAuth == null) {
      firebaseAuth = FirebaseAuth.instance;
      update();
    }
    if (firebaseAuth.currentUser == null) {
      return LoginPage();
    } else {
      firebaseUser = firebaseAuth.currentUser!;
      update();
      var snapshot;
      return HomePage();
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      Get.dialog(Center(child: LodingWidget()), barrierDismissible: false);
      await initializeFirebaseApp();
      firebaseAuth = FirebaseAuth.instance;
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredentialData =
          await FirebaseAuth.instance.signInWithCredential(credential);
      firebaseUser = UserCredentialData.user!;
      update();
      Get.back();
      var snapshot;
      Get.to(HomePage());
    } catch (ex) {
      Get.back();
      Get.snackbar(
        'Sign In Error',
        'Error Singing in',
        duration: Duration(seconds: 5),
        backgroundColor: Colors.black,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
    }
  }

  Future<void> signOut() async {
    Get.dialog(Center(child: LodingWidget()), barrierDismissible: false);
    await firebaseAuth.signOut();
    Get.back();
    Get.offAll(LoginPage());
  }
}
