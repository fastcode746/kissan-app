// ignore_for_file: avoid_print

import 'package:adminpanelapp/components/button/button.dart';
import 'package:adminpanelapp/components/loginField/loginfield.dart';
import 'package:adminpanelapp/screens/adminlogin/adminlogin_view.dart';
import 'package:adminpanelapp/screens/home/home.dart';
import 'package:adminpanelapp/screens/home/home_view.dart';
import 'package:adminpanelapp/screens/signup/signup_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //controllers
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  bool isLoading = false;

  signIn(context) async {
    setState(
      () {
        isLoading = true;
      },
    );
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      if (credential.user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomeView()));
      } else if (credential.user == null) {
        print('User Not Found');
      } else {
        setState(() {
          isLoading = true;
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4157FF),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 30),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminLogin()));
              },
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const Text(
                      'Admin Login',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 35),
                  child: Center(
                    child: Image.asset(
                      'assets/images/splash-img.jpeg',
                      width: 160,
                    ),
                  ),
                ),
                LoginField(
                  title: 'Email',
                  fieldName: 'Enter email',
                  controller: emailController,
                ),
                LoginField(
                  title: 'Password',
                  fieldName: 'Enter password',
                  controller: passwordController,
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Button(
                      onpressed: () {
                        signIn(context);
                      },
                      height: 45,
                      color: Colors.blue[700],
                      width: 400,
                      buttonText: isLoading
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: const Text("Don't have a account"),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
