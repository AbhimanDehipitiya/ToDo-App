import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:show_hide_password/show_hide_password_text_field.dart';
import 'package:todo_app/assets/myassets.dart';
import 'package:todo_app/screens/dashboard.dart';
import 'package:todo_app/screens/loginScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  final String title = "Login Screen";
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String err = "";

  final emailController = TextEditingController();
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: false,
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
                  Image.asset(Myassets.signupImg, scale: 6.5),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Enter the Email',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.black38, fontSize: 16),
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
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            hintText: 'Enter the Name',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.black38, fontSize: 16),
                            floatingLabelStyle:
                                Theme.of(context).textTheme.titleLarge,
                            icon: Icon(
                              Icons.person,
                              color: Theme.of(context).primaryColor,
                            ),
                            labelText: 'Name',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ShowHidePasswordTextField(
                          controller: passwordController1,
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
                        ShowHidePasswordTextField(
                          controller: passwordController2,
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
                            labelText: 'Confirm Password',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              if (passwordController1.text ==
                                  passwordController2.text) {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController1.text,
                                );
                              }
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController1.text,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Dashboard()),
                              );
                            } on FirebaseAuthException catch (error) {
                              if (passwordController1.text ==
                                  passwordController2.text){
                                     Fluttertoast.showToast(msg: 'Passwords are not matching',gravity: ToastGravity.TOP,textColor: Theme.of(context).primaryColor, backgroundColor: Color.fromARGB(149, 164, 236, 220));
                                
                                  }else{
                                     Fluttertoast.showToast(msg: error.message.toString(),gravity: ToastGravity.TOP,textColor: Theme.of(context).primaryColor, backgroundColor: Color.fromARGB(149, 164, 236, 220));
                                  }
                                   }
                          },
                          child: const Text('Signup'),
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
                                    'If you have an account, please ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 6, 108, 74)),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()),
                                      );
                                    },
                                    child: const Text(
                                      'login',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromARGB(255, 0, 53, 36)),
                                    ),
                                  ),
                                ])),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ))
        ]));
  }
}
