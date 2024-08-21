import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:todo_app/assets/myassets.dart';
import 'package:todo_app/authentication/userdata.dart';
import 'package:todo_app/screens/LoginScreen.dart';
import 'package:todo_app/assets/myassets.dart';
import 'package:todo_app/screens/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskView extends StatefulWidget {
  final Userdata user;

  const TaskView({super.key, required this.user});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  List<String> subtasks = [];
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final subtaskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final db = await FirebaseFirestore.instance;

            final docRef = db
                .collection("users")
                .doc(widget.user.id)
                .collection("task_list")
                .doc(titleController.text);
            docRef.get().then((DocumentSnapshot doc) async {
              final data = doc.data();
              if (data == null) {
                try {
                  db
                      .collection("users")
                      .doc(widget.user.id)
                      .collection("task_list")
                      .doc(titleController.text)
                      .set({
                    "description": descriptionController.text,
                    "deadline": dateController.text,
                    "subtasks": subtasks,
                    "completed": false,
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Dashboard(
                              user: widget.user,
                            )),
                  );
                } on FirebaseException catch (error) {
                  Fluttertoast.showToast(
                      msg: error.message.toString(),
                      gravity: ToastGravity.BOTTOM,
                      textColor: Theme.of(context).primaryColor,
                      backgroundColor: Color.fromARGB(149, 164, 236, 220));
                }
              } else {
                Fluttertoast.showToast(
                    msg: 'A task has alredy with this name ',
                    gravity: ToastGravity.BOTTOM,
                    textColor: Theme.of(context).primaryColor,
                    backgroundColor: Color.fromARGB(149, 164, 236, 220));
              }
            }, onError: (e) {
              Fluttertoast.showToast(
                  msg: e.message.toString(),
                  gravity: ToastGravity.BOTTOM,
                  textColor: Theme.of(context).primaryColor,
                  backgroundColor: Color.fromARGB(149, 164, 236, 220));
            });
          },
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(height: 50.0),
        ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Dashboard(
                            user: widget.user,
                          )),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Iconsax.arrow_circle_left,
                  size: 50,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            )
          ],
          toolbarHeight: 100,
          backgroundColor: Myassets.colorgreen,
          leading: Image.asset(
            Myassets.personImg,
            scale: 1,
          ),
          title: const Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Hi, John Patrick',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '20 tasks today',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ))
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
        body: const CustomScrollView(scrollDirection: Axis.vertical, slivers: [
          SliverFillRemaining(
              hasScrollBody: true,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [])))
        ]));
  }

  Future<void> selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (picked != null) {
      setState(() {
        dateController.text = picked.toString().split(" ")[0];
      });
    }
  }
}
