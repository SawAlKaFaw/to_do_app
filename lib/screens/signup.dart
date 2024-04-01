import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class SingnUpScreen extends StatelessWidget {
  SingnUpScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Singup",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "SignUp",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Please register to create your account",
                style: TextStyle(fontSize: 16)),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: emailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Required email";
                }
                return null;
              },
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  labelText: "Email",
                  hintText: "example.com",
                  filled: true,
                  fillColor: Colors.amber[50],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Required Password";
                }
                return null;
              },
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.https_outlined),
                  labelText: "Password require at least 6characters",
                  filled: true,
                  fillColor: Colors.amber[50],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 50,
                width: 120,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      AuthenicationController.authenicationController.register(
                          emailController.text, passwordController.text);
                    },
                    icon: const Icon(Icons.chevron_right),
                    label: const Text("Sign Up")),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Do you  have an account?"),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        " Back",
                        style: TextStyle(
                            color: Colors.amber[900],
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
