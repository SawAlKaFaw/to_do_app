import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:to_do_list/screens/login.dart';
import '../screens/task_screen.dart';

class AuthenicationController extends GetxController {
  static AuthenicationController authenicationController = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> user;

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(_auth.currentUser);
    user.bindStream(_auth.userChanges());
    ever(user, initialScreen);
  }

  initialScreen(User? user) async {
    if (user == null) {
      await Future.delayed(const Duration(microseconds: 500));
      Get.offAll(const LoginScreen());
    } else {
      await Future.delayed(const Duration(microseconds: 500));
      Get.offAll(TaskScreen());
    }
  }

  Future register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.showSnackbar(const GetSnackBar(
        title: "Register",
        message: "Account Creation Successful",
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        title: "Error",
        message: "Account Creation Failed",
        duration: Duration(milliseconds: 700),
      ));

      print("Your error is ${e.toString()}");
    }
  }

  Future login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.showSnackbar(const GetSnackBar(
        title: "Login",
        message: "Login Successful",
        duration: Duration(milliseconds: 700),
      ));
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        title: "Error",
        message: "Login Failed",
        duration: Duration(milliseconds: 700),
      ));
    }
  }

  logOut() async {
    await _auth.signOut();
  }
}
