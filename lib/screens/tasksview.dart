import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:todo_app/assets/myassets.dart';
import 'package:todo_app/authentication/userdata.dart';
import 'package:todo_app/screens/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskView extends StatefulWidget {
  final Userdata user;

  const TaskView({super.key, required this.user});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late Future<DocumentSnapshot> taskDocument;

  @override
  void initState() {
    super.initState();
    taskDocument = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user.id)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Myassets.colorwhite,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Iconsax.arrow_circle_left,
                  size: 50,
                  color: Myassets.colorwhite,
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
          title: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Hi, ${widget.user.name}',
                    style: TextStyle(
                        color: Myassets.colorwhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${widget.user.numOfTasks} tasks today',
                    style: TextStyle(
                        color: Myassets.colorwhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ))
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
        body: CustomScrollView(scrollDirection: Axis.vertical, slivers: [
          SliverFillRemaining(
              hasScrollBody: true,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FutureBuilder<DocumentSnapshot>(
                      future: taskDocument,
                      builder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Title',
                                        style: TextStyle(
                                            color: Myassets.colorblack,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Myassets.colorgreen,
                                              width: 4,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                            child: Text(
                                              '${widget.user.task}',
                                              style: TextStyle(
                                                  color: Myassets.colorblack,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Description',
                                        style: TextStyle(
                                            color: Myassets.colorblack,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Myassets.colorgreen,
                                              width: 4,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                                            child: Text(
                                              '${widget.user.docSnap!['description']}',
                                              style: TextStyle(
                                                  color: Myassets.colorblack,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Deadline',
                                        style: TextStyle(
                                            color: Myassets.colorblack,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                  Row(
                                    children: [
                                      Text(
                                              '${widget.user.docSnap!['deadline']}',
                                              style: TextStyle(
                                                  color: Myassets.colorblack,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                     Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: widget.user.docSnap!['completed']? Color.fromARGB(252, 8, 234, 19) : Color.fromARGB(255, 248, 2, 2),
                                              width: 4,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(4, 1, 4, 1),
                                            child: Text(
                                              widget.user.docSnap!['completed']? 'Done' : 'On Progress',
                                              style: TextStyle(
                                                  color: Myassets.colorblack,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            )),
                                      )
                                    ],
                                  ),
                                    ],
                                  )),
                                  
                            ],
                          ),
                        );
                        //Text('${widget.user.docSnap?['deadline']}');
                      })))
        ]));
  }
}
