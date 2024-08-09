import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:show_hide_password/show_hide_password_text_field.dart';
import 'package:todo_app/assets/myassets.dart';
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

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: CustomScrollView(scrollDirection: Axis.vertical, slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      ' Welcome Back',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Image.asset(Myassets.loginImg, scale: 6.5),
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
                                        color: Colors.black38, fontSize: 16),
                                floatingLabelStyle:
                                    Theme.of(context).textTheme.titleLarge,
                                icon: Icon(
                                  Icons.email,
                                  color: Theme.of(context).primaryColor,
                                ),
                                labelText: 'Email',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
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
                                        fontSize: 12),
                                floatingLabelStyle:
                                    Theme.of(context).textTheme.titleLarge,
                                icon: Icon(
                                  Icons.key,
                                  color: Theme.of(context).primaryColor,
                                ),
                                labelText: 'Password',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                
                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Dashboard()),
                                  );
                                } on FirebaseAuthException catch (error) {
                                    Fluttertoast.showToast(msg: error.message.toString(),gravity: ToastGravity.TOP,textColor: Theme.of(context).primaryColor, backgroundColor: Color.fromARGB(149, 164, 236, 220));
                                }
                              },
                              child: const Text('Login'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'If you haven\'t an account, please ',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
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
                                        child: const Text(
                                          'signup',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 0, 53, 36)),
                                        ),
                                      ),
                                    ])),
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ))
        ]));
  }
}
