import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:todo_app/assets/myassets.dart';
import 'package:todo_app/authentication/userdata.dart';
import 'package:todo_app/screens/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTask extends StatefulWidget {
  final Userdata user;

  const AddTask({super.key, required this.user});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
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
            final db = FirebaseFirestore.instance;

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
                      backgroundColor:
                          const Color.fromARGB(149, 164, 236, 220));
                }
              } else {
                Fluttertoast.showToast(
                    msg: 'A task has alredy with this name ',
                    gravity: ToastGravity.BOTTOM,
                    textColor: Theme.of(context).primaryColor,
                    backgroundColor: const Color.fromARGB(149, 164, 236, 220));
              }
            }, onError: (e) {
              Fluttertoast.showToast(
                  msg: e.message.toString(),
                  gravity: ToastGravity.BOTTOM,
                  textColor: Theme.of(context).primaryColor,
                  backgroundColor: const Color.fromARGB(149, 164, 236, 220));
            });
          },
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                    style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${widget.user.numOfTasks} tasks today',
                    style: const TextStyle(
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
        body: CustomScrollView(scrollDirection: Axis.vertical, slivers: [
          SliverFillRemaining(
              hasScrollBody: true,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Add a Task',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Myassets.colorblack,
                              fontSize: 25),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                            labelText: 'Title',
                            fillColor: const Color.fromRGBO(255, 255, 255, 1),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.black38, fontSize: 20),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.title,
                              color: Theme.of(context).primaryColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Myassets.colorgreen, width: 4)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Myassets.colorgreen, width: 4))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                            labelText: 'Description',
                            fillColor: const Color.fromRGBO(255, 255, 255, 1),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.black38, fontSize: 20),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.note,
                              color: Theme.of(context).primaryColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Myassets.colorgreen, width: 4)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Myassets.colorgreen, width: 4))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: dateController,
                        onTap: () {
                          selectDate();
                        },
                        decoration: InputDecoration(
                            labelText: 'Deadline',
                            fillColor: Myassets.colorwhite,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.black38, fontSize: 20),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).primaryColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Myassets.colorgreen, width: 4)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Myassets.colorgreen, width: 4))),
                        readOnly: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: subtaskController,
                        decoration: InputDecoration(
                            labelText: 'Add Stages',
                            fillColor: Myassets.colorwhite,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.black38, fontSize: 20),
                            filled: true,
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    subtasks.add(subtaskController.text);
                                    subtaskController.clear();
                                  });
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 2, 8, 2),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Myassets.colorgreen,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Icon(
                                      Icons.add_outlined,
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                  ),
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Myassets.colorgreen, width: 4)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Myassets.colorgreen, width: 4))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //Flexible(fit: FlexFit.loose,child: subtask(subtasks.length.toInt()),),
                      //subtask(subtasks.length.toInt()),
                      subtasks.isEmpty? Expanded(child: Align(alignment: Alignment.center,child:Image.asset(Myassets.addtaskImg, scale: 3),)): 
                      Expanded(
                        child: ListView.builder(
                          itemCount: subtasks.length,
                          itemBuilder: (BuildContext, int index) {
                            //subtask(subtasks.length.toInt());
                            return GestureDetector(
                              onDoubleTap: () {
                                setState(() {
                                  subtasks.removeAt(index);
                                });
                              },
                              child: Card(
                                  color: Myassets.colorgreen,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          subtasks[index],
                                          style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )),
                                  )),
                            );
                          },
                        ),
                      )
                    ],
                  )))
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
