import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/assets/myassets.dart';
import 'package:todo_app/screens/LoginScreen.dart';
import 'package:todo_app/screens/addtask.dart';
import 'package:todo_app/authentication/userdata.dart';
import 'package:todo_app/screens/tasksview.dart';

class Dashboard extends StatefulWidget {
  final Userdata user;

  //final Userdata
  const Dashboard({super.key, required this.user});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final searchbarController = TextEditingController();

  int state = 1;

  Color color1 = Myassets.colorgreen;
  Color color2 = Myassets.colorblack;
  Color color3 = Myassets.colorblack;

  void setcolor(
    Color c1,
    Color c2,
    Color c3,
  ) {
    color1 = c1;
    color2 = c2;
    color3 = c3;
  }

  //Userdata user1 = Userdata();

  late CollectionReference<Map<String, dynamic>> dbRef = FirebaseFirestore
      .instance
      .collection("users")
      .doc(widget.user.id)
      .collection("task_list");

  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //String date = DateTime.now().toLocal();
  late Future<QuerySnapshot<Map<String, dynamic>>> tasksDocument_today = dbRef
      .where('completed', isEqualTo: false)
      .where('deadline', isEqualTo: formattedDate)
      .orderBy('deadline', descending: true)
      .get();
  late Future<QuerySnapshot<Map<String, dynamic>>> tasksDocument_upcoming =
      dbRef
          .orderBy('deadline', descending: true)
          .where('completed', isEqualTo: false)
          .get();
  late Future<QuerySnapshot<Map<String, dynamic>>> tasksDocument_completed =
      dbRef
          .orderBy('deadline', descending: true)
          .where('completed', isEqualTo: true)
          .get();
  late Future<QuerySnapshot<Map<String, dynamic>>> tasksDocument;
  //late Future<AggregateQuerySnapshot> aggQuery = dbRef.count().get();

  late Future<DocumentSnapshot> userDocument;

  @override
  void initState() {
    super.initState();

    tasksDocument = tasksDocument_today;

    // tasksDocument_today.then(
    //   (querySnapshot) {
    //     debugPrint("Successfully completed");
    //     for (var docSnapshot in querySnapshot.docs) {
    //       //print('${docSnapshot.id} => ${docSnapshot.data()}');
    //       subtasks.add(docSnapshot.id);
    //     }
    //   },
    //   onError: (e) => print("Error completing: $e"),
    // );

    // final numTasks = subtasks.length.toString();

    userDocument = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user.id)
        .get();
  }

  //late List<String> subtasks = [];
  //late String numTasks;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoginScreen();
        }
        //user1.id = snapshot.data!.uid;

        //return Dashboard(user: user1,);

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddTask(
                          user: widget.user,
                        )),
              );
            },
            //tooltip: 'Increment Counter',
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
          backgroundColor: Myassets.colorwhite,
          appBar: AppBar(
            toolbarHeight: 100,
            backgroundColor: Myassets.colorgreen,
            leading: Image.asset(
              Myassets.personImg,
              scale: 1,
            ),
            title: Column(children: [
              FutureBuilder<DocumentSnapshot>(
                  future: userDocument,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        state == 1) {
                      widget.user.name = 'Waiting...';
                      return Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Waiting...',
                            style: TextStyle(
                                color: Myassets.colorwhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ));
                    }
                    if (snapshot.hasError) {
                      widget.user.name = 'Error!';
                      return Center(
                          child: Text(
                        'Error!',
                        style: TextStyle(
                            color: Myassets.colorwhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ));
                    }
                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      widget.user.name = 'User not found.';
                      return Center(
                          child: Text(
                        'User not found.',
                        style: TextStyle(
                            color: Myassets.colorwhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ));
                    }

                    final userData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    final username = userData['userName'] ?? 'No username';
                    widget.user.name = username;

                    return Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Hi, $username',
                          style: TextStyle(
                              color: Myassets.colorwhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ));
                  }),
              FutureBuilder(
                  future: tasksDocument_today,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        state == 1) {
                      widget.user.name = 'Waiting...';
                      return Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Waiting...',
                            style: TextStyle(
                                color: Myassets.colorwhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ));
                    }
                    if (snapshot.hasError) {
                      widget.user.name = 'Error!';
                      return Center(
                          child: Text(
                        'Error!',
                        style: TextStyle(
                            color: Myassets.colorwhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ));
                    }
                    if (!snapshot.hasData) {
                      widget.user.name = '0 tasks today';
                      return Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '0 tasks today',
                            style: TextStyle(
                                color: Myassets.colorwhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ));
                    }

                    final documentCount = snapshot.data!.docs.length;
                    widget.user.numOfTasks = documentCount;

                    return Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '$documentCount tasks today',
                          style: TextStyle(
                              color: Myassets.colorwhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ));
                  })
            ]),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            actions: [
              GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Iconsax.logout_copy,
                    size: 50,
                    color: Myassets.colorwhite,
                  ),
                ),
              )
            ],
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(132, 0, 0, 0), // Border color
                      width: 2.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(30.0), // Border radius
                  ),
                  child: SearchBar(
                      hintText: 'Search',
                      hintStyle: WidgetStatePropertyAll(TextStyle(
                          fontSize: 20,
                          color: Myassets.colorgreen,
                          fontWeight: FontWeight.bold)),
                      textStyle: WidgetStatePropertyAll(TextStyle(
                          fontSize: 20,
                          color: Myassets.colorgreen,
                          fontWeight: FontWeight.bold)),
                      backgroundColor: WidgetStatePropertyAll(
                          Myassets.colorwhite),
                      controller: searchbarController,
                      padding: const WidgetStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 20)),
                      onTap: () {
                        //SearchController.openView();
                      },
                      onChanged: (_) {
                        //SearchController.openView();
                      },
                      trailing: const <Widget>[
                        Icon(
                          Icons.search,
                          size: 40,
                        ),
                      ]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '  My tasks',
                    style: TextStyle(
                        color: Myassets.colorblack,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          setcolor(Myassets.colorgreen, Myassets.colorblack,
                              Myassets.colorblack);
                          tasksDocument = tasksDocument_today;
                        });
                      },
                      child: Text(
                        'Today',
                        style: TextStyle(
                            color: color1,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          setcolor(Myassets.colorblack, Myassets.colorgreen,
                              Myassets.colorblack);
                          tasksDocument = tasksDocument_upcoming;
                        });
                      },
                      child: Text(
                        'Upcoming',
                        style: TextStyle(
                            color: color2,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          setcolor(Myassets.colorblack, Myassets.colorblack,
                              Myassets.colorgreen);
                          tasksDocument = tasksDocument_completed;
                        });
                      },
                      child: Text(
                        'Completed',
                        style: TextStyle(
                            color: color3,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: FutureBuilder(
                    future: tasksDocument,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'Oooops! Something went wrong...',
                            style: TextStyle(
                                color: Myassets.colorblack,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting &&
                          state == 1) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(Myassets.loadingImg, scale: 6.5),
                        );
                      }
                      //subtasks.clear();
                      // QuerySnapshot a = tasksDocument_today as QuerySnapshot<Object?>;
                      //final docSnap = tasksDocument_today.toList();
                      //final docs = docSnap as Map<String, dynamic>;
                      //final k = docs.length;
                      //subtasks = docs;
                      state = 0;
                      final documentIds =
                          snapshot.data!.docs.map((doc) => doc.id).toList();
                      return Flex(direction: Axis.vertical, children: [
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                widget.user.task = documentIds[index];
                                final document = snapshot.data!.docs.firstWhere(
                                  (doc) => doc.id == documentIds[index],
                                ) as DocumentSnapshot;
                                widget.user.docSnap = document;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TaskView(
                                            user: widget.user,
                                          )),
                                );
                              },
                              child: Card(
                                  color: Myassets.colorgreen,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          documentIds[index],
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
                      ]);
                    }),
              )
            ],
          ),
        );
      },
    );
  }
}
