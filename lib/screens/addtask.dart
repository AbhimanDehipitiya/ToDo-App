import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:todo_app/assets/myassets.dart';
import 'package:todo_app/authentication/userdata.dart';
import 'package:todo_app/screens/LoginScreen.dart';
import 'package:todo_app/assets/myassets.dart';
import 'package:todo_app/screens/dashboard.dart';

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
          onPressed: () {},
          //tooltip: 'Increment Counter',
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
                  MaterialPageRoute(builder: (context) => Dashboard(user: widget.user,)),
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Add A Task',
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
                            fillColor: Color.fromRGBO(255, 255, 255, 1),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.black38, fontSize: 20),
                            filled: true,
                            prefixIcon: Icon(Icons.title, color: Theme.of(context).primaryColor,),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Myassets.colorgreen, width: 2)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Myassets.colorgreen, width: 2)
                            )
                            ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                            labelText: 'Description',
                            fillColor: Color.fromRGBO(255, 255, 255, 1),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.black38, fontSize: 20),
                            filled: true,
                            prefixIcon: Icon(Icons.note, color: Theme.of(context).primaryColor,),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Myassets.colorgreen, width: 2)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Myassets.colorgreen, width: 2)
                            )
                            ),
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
                            fillColor: Color.fromRGBO(255, 255, 255, 1),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.black38, fontSize: 20),
                            filled: true,
                            prefixIcon: Icon(Icons.calendar_today, color: Theme.of(context).primaryColor,),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Myassets.colorgreen, width: 2)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Myassets.colorgreen, width: 2)
                            )
                            ),
                            readOnly: true,
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: subtaskController,
                        decoration: InputDecoration(
                            labelText: 'Add Subtask',
                            fillColor: Color.fromRGBO(255, 255, 255, 1),
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
                              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Myassets.colorgreen,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                
                                child: const Icon(Icons.add_outlined, color: Color.fromRGBO(255, 255, 255, 1),),
                              ),)
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Myassets.colorgreen, width: 2)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Myassets.colorgreen, width: 2)
                            )
                            ),
                      ),
                      const SizedBox(height: 20,),
                      Expanded(
                        child: ListView.builder(
                          itemCount: subtasks.length,
                          itemBuilder: (BuildContext, int index) {
                            return GestureDetector(
                              onDoubleTap: (){
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
