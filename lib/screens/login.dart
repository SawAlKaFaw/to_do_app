import 'package:flutter/material.dart';
import 'package:to_do_list/screens/signup.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalkey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Login Screen",
        style: TextStyle(color: Colors.black),
      )),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _globalkey,
            child: singUpandLoginForm(
                title: "Login",
                subTitle: "Please sign in to continue",
                label: "Sign In",
                haveAccount: "Don't have an account?",
                alreadyAccount: " Create account")),
      ),
    );
  }

  Column singUpandLoginForm(
      {required String title,
      required String subTitle,
      required String label,
      required String haveAccount,
      required String alreadyAccount}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(subTitle, style: TextStyle(fontSize: 16)),
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
              filled: true,
              fillColor: Colors.amber[50],
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: passwordController,
          obscureText: !switchValue,
          validator: (value) {
            if (value!.isEmpty) {
              return "Required Password";
            }
            return null;
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.https_outlined),
              labelText: "Password",
              filled: true,
              fillColor: Colors.amber[50],
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Switch(
                value: switchValue,
                onChanged: (switchChange) {
                  setState(() {
                    switchValue = switchChange;
                  });
                }),
            const Text("Show Password")
          ],
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
                onPressed: () async {
                  bool valid = _globalkey.currentState!.validate();
                  if (valid) {
                    await AuthenicationController.authenicationController
                        .login(emailController.text, passwordController.text);
                    print("login Successful");
                  } else {
                    print("Login Fail");
                  }
                },
                icon: const Icon(Icons.chevron_right),
                label: Text(label)),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 25),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(haveAccount),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return SingnUpScreen();
                    }));
                  },
                  child: Text(
                    alreadyAccount,
                    style: TextStyle(
                        color: Colors.amber[900], fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
