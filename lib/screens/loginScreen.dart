import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:show_hide_password/show_hide_password_text_field.dart';
import 'package:todo_app/assets/myassets.dart';
import 'package:todo_app/authentication/userdata.dart';
import 'package:todo_app/screens/dashboard.dart';
import 'package:todo_app/screens/SignupScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  final String title = "Login Screen";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Userdata user1 = Userdata();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late Future<DocumentSnapshot> userDocument;

  @override
  Widget build(BuildContext context) {
    final double HEIGHT = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: CustomScrollView(scrollDirection: Axis.vertical, slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: HEIGHT * 0.005,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      ' Welcome Back',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: HEIGHT * 0.00115 * 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Image.asset(Myassets.loginImg, scale: HEIGHT * 0.007),
                  Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'Enter the Email',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: Colors.black38, fontSize: HEIGHT * 0.00115 * 16),
                                floatingLabelStyle:
                                    Theme.of(context).textTheme.titleLarge,
                                icon: Icon(
                                  Icons.email,
                                  color: Theme.of(context).primaryColor,
                                ),
                                labelText: 'Email',
                              ),
                            ),
                            SizedBox(
                              height: HEIGHT * 0.005,
                            ),
                            ShowHidePasswordTextField(
                              controller: passwordController,
                              visibleOffIcon: Iconsax.eye_slash,
                              visibleOnIcon: Iconsax.eye,
                              decoration: InputDecoration(
                                hintText: 'Enter the password',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w500,
                                        fontSize: HEIGHT * 0.00115 * 12),
                                floatingLabelStyle:
                                    Theme.of(context).textTheme.titleLarge,
                                icon: Icon(
                                  Icons.key,
                                  color: Theme.of(context).primaryColor,
                                ),
                                labelText: 'Password',
                              ),
                            ),
                            SizedBox(
                              height: HEIGHT * 0.025,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                try {
                                  final credentials = await FirebaseAuth
                                      .instance
                                      .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  String uid = credentials.user!.uid;
                                  user1.id = uid;

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Dashboard(
                                              user: user1,
                                            )),
                                  );
                                } on FirebaseAuthException catch (error) {
                                  Fluttertoast.showToast(
                                      msg: error.message.toString(),
                                      gravity: ToastGravity.TOP,
                                      textColor: Theme.of(context).primaryColor,
                                      backgroundColor: const Color.fromARGB(
                                          149, 164, 236, 220));
                                }
                              },
                              child: const Text('Login'),
                            ),
                            SizedBox(
                              height: HEIGHT * 0.025,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'If you haven\'t an account, please ',
                                        style: TextStyle(
                                            fontSize: HEIGHT * 0.00115 * 15,
                                            color: const Color.fromARGB(
                                                255, 6, 108, 74)),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignupScreen()),
                                          );
                                        },
                                        child: Text(
                                          'signup',
                                          style: TextStyle(
                                              fontSize: HEIGHT * 0.00115 * 15,
                                              color: const Color.fromARGB(
                                                  255, 0, 53, 36)),
                                        ),
                                      ),
                                    ])),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: HEIGHT * 0.005,
                  ),
                ],
              ))
        ]));
  }
}
