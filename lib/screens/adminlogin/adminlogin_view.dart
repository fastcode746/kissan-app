import 'package:adminpanelapp/components/button/button.dart';
import 'package:adminpanelapp/components/loginField/loginfield.dart';
import 'package:adminpanelapp/screens/admin/admin_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  //controllers
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  adminLogin(context) async {
    setState(() {
      isLoading = true;
    });
    try {
      
      //Condition
      if (emailController.text == 'admin@gmail.com' &&
          passwordController.text == "admin123") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AdminScreen()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('You are not an Admin')));
    }
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4157FF),
        title: const Text(
          'Admin Login',
          style: TextStyle(color: Colors.white),
        ),
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
                        adminLogin(context);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
