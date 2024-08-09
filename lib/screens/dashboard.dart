import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/LoginScreen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  final String title = "Login Screen";
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  
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
      body: Center(
        child: GestureDetector(
          onDoubleTap: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
          },
          child: const Text('Logout'),
        ),
      )
    );
    
  }
}
