import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];

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

  late Future<QuerySnapshot<Map<String, dynamic>>> tasksDocument_today = dbRef
      .where('completed', isEqualTo: false)
      .where('deadline', isEqualTo: DateFormat('yyyy-MM-dd').format(DateTime.now()))
      .orderBy('deadline', descending: true)
      .get();
  late Future<QuerySnapshot<Map<String, dynamic>>> tasksDocument_upcoming =
      dbRef
          .orderBy('deadline', descending: false)
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
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                        return const Align(
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
                        return const Center(
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
                        return const Center(
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
                            style: const TextStyle(
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
                        return const Align(
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
                        return const Center(
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
                        return const Align(
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
                            style: const TextStyle(
                                color: Myassets.colorwhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ));
                    })
              ]),
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
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
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Iconsax.logout_copy,
                      size: 50,
                      color: Myassets.colorwhite,
                    ),
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(132, 0, 0, 0),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: SearchBar(
                        hintText: 'Search',
                        hintStyle: const WidgetStatePropertyAll(TextStyle(
                            fontSize: 20,
                            color: Myassets.colorgreen,
                            fontWeight: FontWeight.bold)),
                        textStyle: const WidgetStatePropertyAll(TextStyle(
                            fontSize: 20,
                            color: Myassets.colorgreen,
                            fontWeight: FontWeight.bold)),
                        backgroundColor:
                            const WidgetStatePropertyAll(Myassets.colorwhite),
                        controller: _searchController,
                        padding: const WidgetStatePropertyAll<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 20)),
                        onChanged: (query) {
                          _searchDocuments(query);
                          if (_searchResults.isNotEmpty) {
                            Container(
                              color: Colors.grey[200],
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _searchResults.length,
                                  itemBuilder: (context, index) {
                                    final doc = _searchResults[index];
                                    final name = doc['name'];
                                    return ListTile(
                                      title: Text(name),
                                      subtitle: Text(doc.id),
                                      onTap: () {
                                        // Handle document tap
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                        },
                        trailing: const <Widget>[
                          Icon(
                            Icons.search,
                            size: 40,
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'My tasks',
                        style: TextStyle(
                            color: Myassets.colorblack,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  FutureBuilder(
                      future: tasksDocument,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              'Oooops! Something went wrong...',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          );
                        }
                        if (snapshot.connectionState ==
                                ConnectionState.waiting &&
                            state == 1) {
                          return Expanded(child:  Align(
                              alignment: Alignment.bottomCenter,
                              child: Align(
                                alignment: Alignment.center,
                                child:
                                    Image.asset(Myassets.loadingImg, scale: 2),
                              )));
                        }
                        //subtasks.clear();
                        // QuerySnapshot a = tasksDocument_today as QuerySnapshot<Object?>;
                        //final docSnap = tasksDocument_today.toList();
                        //final docs = docSnap as Map<String, dynamic>;
                        //final k = docs.length;
                        //subtasks = docs;

                        state = 0;
                        final documents = snapshot.data!.docs;
                        return 
                        documents.isEmpty? Expanded(child: Align(alignment: Alignment.center,child:Image.asset(Myassets.doneImg, scale: 3),)):
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final document = documents[index];
                              final deadline = document.get('deadline') as String?;
                              String formattedDate = DateFormat('dd MMMM yyyy').format(DateTime.parse(deadline!));
                              final taskID = document.id;
                              return GestureDetector(
                                onTap: () {
                                  widget.user.task = taskID;
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
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color:
                                      Myassets.colorgreen, // Background color
                                  elevation: 5.0,
                                  child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                taskID.toUpperCase(),
                                                style: const TextStyle(
                                                  fontSize:
                                                      24.0, // Font size for the task name
                                                  fontWeight: FontWeight.bold,
                                                  color: Myassets.colorblack,
                                                ),
                                              ),
                                              const SizedBox(height: 8.0),
                                              Container(
                                                      padding: const EdgeInsets.fromLTRB(5, 2, 5, 2), // Padding inside the container
                                                      decoration: BoxDecoration(
                                                        color: Myassets.colorwhite,
                                                        borderRadius:
                                                            BorderRadius.circular( 
                                                                5.0), // Rounded borders
                                                      ),
                                                      child: Text(
                                                        formattedDate,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                          color: DateTime.parse(deadline).isAfter(DateTime.now()) ?    Myassets.colorblack : Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                openDialog_delete(taskID);
                                              });
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              size: 50,
                                              color: Myassets.colorwhite,
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                ],
              ),
            ));
      },
    );
  }

  Future openDialog_delete(String documentId) => showDialog(
      context: context,
      builder: (context) => Dialog(
              child: Container(
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete_outline,
                  size: 75,
                  color: Color.fromRGBO(25, 118, 210, 1.0),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        Color.fromARGB(255, 139, 252, 144)),
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
                    'Go Back',
                    style: TextStyle(
                        color: Myassets.colorblack,
                        fontWeight: FontWeight.bold,
                        fontSize: 25), // Text color
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      deleteDocument(documentId);
                    });
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
                    'Delete',
                    style: TextStyle(
                        color: Myassets.colorblack,
                        fontWeight: FontWeight.bold,
                        fontSize: 25), // Text color
                  ),
                )
              ],
            ),
          )));

  void deleteDocument(String documentId) async {
    try {
      await dbRef.doc(documentId).delete();

      Fluttertoast.showToast(
        msg: "Document deleted successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color.fromARGB(255, 255, 127, 80),
        textColor: Myassets.colorblack,
        fontSize: 16.0,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Dashboard(
                  user: widget.user,
                )),
      );
    } catch (e) {
      // Show an error message using a toast
      Fluttertoast.showToast(
        msg: "Failed to delete document: ${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color.fromARGB(255, 255, 127, 80),
        textColor: Myassets.colorblack,
        fontSize: 16.0,
      );
    }
  }

  void _searchDocuments(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    try {
      final querySnapshot = await dbRef
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      setState(() {
        _searchResults = querySnapshot.docs;
      });
    } catch (e) {
      print('Error searching documents: $e');
    }
  }
}
