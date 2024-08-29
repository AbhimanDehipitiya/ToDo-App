import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    final double HEIGHT = MediaQuery.of(context).size.height;
    final double WIDTH = MediaQuery.of(context).size.width;

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
          toolbarHeight: HEIGHT * 0.12,
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
              SizedBox(
                height: HEIGHT * 0.005,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${widget.user.numOfTasks} task(s) today',
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: HEIGHT * 0.02,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Title',
                              style: TextStyle(
                                  color: Myassets.colorblack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(25, 118, 210, 1.0),
                                  // border: Border.all(
                                  //   color: Color.fromARGB(255, 0, 69, 242),
                                  //   width: 4,
                                  // ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: SingleChildScrollView(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 4, 10, 4),
                                  child: Text(
                                    '${widget.user.task}',
                                    style: const TextStyle(
                                        color: Myassets.colorwhite,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )),
                            ),
                            SizedBox(
                              height: HEIGHT * 0.02,
                            ),
                            const Text(
                              'Description',
                              style: TextStyle(
                                  color: Myassets.colorblack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(25, 118, 210, 1.0),
                                  // border: Border.all(
                                  //   color: Color.fromARGB(255, 0, 69, 242),
                                  //   width: 4,
                                  // ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: SingleChildScrollView(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 4, 10, 4),
                                  child: Text(
                                    '${widget.user.docSnap?['description'] ?? ''}',
                                    style: const TextStyle(
                                        color: Myassets.colorwhite,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    textAlign: TextAlign.justify,
                                  )),
                            ),
                            SizedBox(
                              height: HEIGHT * 0.02,
                            ),
                            const Text(
                              'Deadline',
                              style: TextStyle(
                                  color: Myassets.colorblack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${widget.user.docSnap!['deadline']}',
                                  style: const TextStyle(
                                      color: Myassets.colorblack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                // GestureDetector(
                                //   onTap: () => openDialog_state(),
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //         color: widget.user.docSnap!['completed']
                                //             ? Color.fromARGB(90, 248, 248, 2)
                                //             : Color.fromARGB(90, 8, 234, 19),
                                //         border: Border.all(
                                //           color: widget
                                //                   .user.docSnap!['completed']
                                //               ? Color.fromARGB(255, 248, 166, 2)
                                //               : Color.fromARGB(252, 8, 234, 19),
                                //           width: 4,
                                //         ),
                                //         borderRadius:
                                //             BorderRadius.circular(20)),
                                //     child: Padding(
                                //         padding: const EdgeInsets.fromLTRB(
                                //             8, 1, 8, 1),
                                //         child: Text(
                                //           widget.user.docSnap!['completed']
                                //               ? 'Completed'
                                //               : 'On Progress',
                                //           style: const TextStyle(
                                //               color: Myassets.colorblack,
                                //               fontWeight: FontWeight.bold,
                                //               fontSize: 20),
                                //         )),
                                //   ),
                                // ),
                                ElevatedButton(
                                  onPressed: () => openDialog_state(),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                      widget.user.docSnap!['completed']
                                          ? Color.fromARGB(217, 245, 245, 95)
                                          : Color.fromARGB(255, 139, 252, 144),
                                    ),
                                    side: WidgetStateProperty.all<BorderSide>(
                                        BorderSide(
                                      color: widget.user.docSnap!['completed']
                                          ? Color.fromARGB(255, 248, 166, 2)
                                          : Color.fromARGB(252, 8, 234, 19),
                                      width: 4,
                                    )),
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    widget.user.docSnap!['completed']
                                        ? 'Completed'
                                        : 'On Progress',
                                    style: const TextStyle(
                                        color: Myassets.colorblack,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20), // Text color
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: HEIGHT * 0.02,
                            ),
                            const Text(
                              'Stages of Task',
                              style: TextStyle(
                                  color: Myassets.colorblack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: HEIGHT * 0.02,
                            ),
                            //Text(widget.user.docSnap!['subtasks'].isEmpty ? 'no': '${widget.user.docSnap!['subtasks'][0]}'),
                            //final List<dynamic> stages = widget.user.docSnap?['subtasks'] ?? [],
                          ],
                        ),
                        widget.user.docSnap!['subtasks'].isEmpty
                            ? Expanded(
                                child: Align(
                                alignment: Alignment.center,
                                child:
                                    Image.asset(Myassets.notaskImg, scale: HEIGHT * 0.003,),
                              ))
                            : Expanded(
                                child: ListView.builder(
                                itemBuilder: (context, int index) {
                                  return Card(
                                      color: Color.fromRGBO(25, 118, 210, 1.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              widget.user.docSnap!['subtasks']
                                                  [index],
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            )),
                                      ));
                                },
                                itemCount:
                                    widget.user.docSnap!['subtasks'].length,
                              ))
                      ],
                    ),
                  )
                  //Text('${widget.user.docSnap?['deadline']}');
                  ))
        ]));
  }

  Future openDialog_state() => showDialog(
      context: context,
      builder: (context) => Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.02, vertical: MediaQuery.of(context).size.height * 0.3,),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(Myassets.completedImg, scale: MediaQuery.of(context).size.height * 0.006),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () {
                    updateDocument(false);
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        const Color.fromARGB(255, 139, 252, 144)),
                    side: WidgetStateProperty.all<BorderSide>(const BorderSide(
                      color: Color.fromARGB(252, 8, 234, 19),
                      width: 4,
                    )),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    'On Progress',
                    style: TextStyle(
                        color: Myassets.colorblack,
                        fontWeight: FontWeight.bold,
                        fontSize: 25), // Text color
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () {
                    updateDocument(true);
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        Color.fromARGB(217, 245, 245, 95)),
                    side: WidgetStateProperty.all<BorderSide>(const BorderSide(
                      color: Color.fromARGB(255, 248, 166, 2),
                      width: 4,
                    )),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Completed',
                    style: TextStyle(
                        color: Myassets.colorblack,
                        fontWeight: FontWeight.bold,
                        fontSize: 25), // Text color
                  ),
                )
              ],
            ),
          )));

  void updateDocument(bool updatedData) async {
    try {
      final CollectionReference dbRef = FirebaseFirestore.instance
          .collection("users")
          .doc(widget.user.id)
          .collection("task_list");

      await dbRef
          .doc(widget.user.docSnap?.id)
          .update({'completed': updatedData});

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Dashboard(
                  user: widget.user,
                )),
      );

      Fluttertoast.showToast(
        msg: "Document updated successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color.fromARGB(255, 255, 127, 80),
        textColor: Myassets.colorblack,
        fontSize: 16.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to update document: ${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color.fromARGB(255, 255, 127, 80),
        textColor: Myassets.colorblack,
        fontSize: 16.0,
      );
    }
  }
}
