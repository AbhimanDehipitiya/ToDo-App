import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:todo_app/assets/myassets.dart';
import 'package:todo_app/screens/LoginScreen.dart';
import 'package:todo_app/assets/myassets.dart';
import 'package:todo_app/screens/dashboard.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const Dashboard()),
                // );
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
              hasScrollBody: false,
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
                        //controller: emailController,
                        decoration: InputDecoration(
                            hintText: 'Enter the title',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.black38, fontSize: 20),
                            floatingLabelStyle:
                                Theme.of(context).textTheme.titleLarge,
                            icon: Icon(
                              Icons.task,
                              color: Theme.of(context).primaryColor,
                            ),
                            labelText: 'Task Title',
                            labelStyle: const TextStyle(fontSize: 20)),
                      ),
                      TextFormField(
                        //controller: emailController,
                        decoration: InputDecoration(
                            hintText: 'Enter the description',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.black38, fontSize: 20),
                            floatingLabelStyle:
                                Theme.of(context).textTheme.titleLarge,
                            icon: Icon(
                              Icons.note,
                              color: Theme.of(context).primaryColor,
                            ),
                            labelText: 'Task Description',
                            labelStyle: const TextStyle(fontSize: 20)),
                      ),
                    ],
                  )))
        ]));
  }
}
