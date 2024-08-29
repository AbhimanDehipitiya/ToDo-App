import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:show_hide_password/show_hide_password_text_field.dart';
import 'package:todo_app/assets/myassets.dart';
import 'package:todo_app/authentication/userdata.dart';
import 'package:todo_app/screens/dashboard.dart';
import 'package:todo_app/screens/loginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  final String title = "Login Screen";
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  
  Userdata user1 = Userdata();
  final emailController = TextEditingController();
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double HEIGHT = MediaQuery.of(context).size.height;

    return Scaffold(
        //resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: CustomScrollView(scrollDirection: Axis.vertical, slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: HEIGHT * 0.006,
                  ),
                  Image.asset(Myassets.signupImg, scale: HEIGHT * 0.0072),
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
                        SizedBox(
                    height: HEIGHT * 0.006,
                  ),
                        TextFormField(
                          controller: nameController,
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
                        SizedBox(
                    height: HEIGHT * 0.006,
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
                        SizedBox(
                    height: HEIGHT * 0.03,
                  ),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              if (passwordController1.text ==
                                  passwordController2.text) {
                                final credentials = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController1.text,
                                );
                                await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController1.text,
                                  );
                                String uid = credentials.user!.uid;
                                await FirebaseFirestore.instance.collection("users").doc(uid).set({
                                  "id": uid,
                                  "userName": nameController.text,
                                  // ... other params
                                });
                                  user1.id = uid;
                                  user1.name = nameController.text;
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard(user: user1,)),
                              );
                            } on FirebaseException catch (error) {
                              if (passwordController1.text !=
                                  passwordController2.text) {
                                Fluttertoast.showToast(
                                    msg: 'Passwords are not matching',
                                    gravity: ToastGravity.TOP,
                                    textColor: Theme.of(context).primaryColor,
                                    backgroundColor:
                                        const Color.fromARGB(149, 164, 236, 220));
                              } else {
                                Fluttertoast.showToast(
                                    msg: error.message.toString(),
                                    gravity: ToastGravity.TOP,
                                    textColor: Theme.of(context).primaryColor,
                                    backgroundColor:
                                        const Color.fromARGB(149, 164, 236, 220));
                              }
                            }
                          },
                          child: const Text('Signup'),
                        ),
                        SizedBox(
                    height: HEIGHT * 0.03,
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
                  SizedBox(
                    height: HEIGHT * 0.005,
                  ),
                ],
              ))
        ]));
  }
}
