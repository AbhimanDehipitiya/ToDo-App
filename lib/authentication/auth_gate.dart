import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';
import 'package:todo_app/authentication/userdata.dart';
import 'package:todo_app/screens/addtask.dart';
import 'package:todo_app/screens/dashboard.dart';
import 'package:todo_app/screens/loginScreen.dart';


class AuthGate extends StatelessWidget {
  AuthGate({super.key});

  final Userdata user1 = Userdata();
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoginScreen();
        }
        user1.id = snapshot.data!.uid;

        return AddTask(user: user1,);
      },
    );
  }
}
