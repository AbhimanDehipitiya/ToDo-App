import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:todo_app/assets/myassets.dart';
import 'package:todo_app/screens/LoginScreen.dart';
import 'package:todo_app/assets/myassets.dart';
import 'package:todo_app/screens/addtask.dart';
import 'package:todo_app/authentication/userdata.dart';

class Dashboard extends StatefulWidget {
  final Userdata user;

  //final Userdata
  const Dashboard({super.key, required this.user});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final searchbarController = TextEditingController();

  Color color1 =  Myassets.colorgreen;
  Color color2 =  Myassets.colorblack;
  Color color3 =  Myassets.colorblack;

  void setcolor(Color c1,Color c2,Color c3,){
    color1 = c1;
    color2 = c2;
    color3 = c3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTask(user: widget.user,)),
            );
        },
        //tooltip: 'Increment Counter',
        child: const Icon(Icons.add, size: 30,),
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Myassets.colorgreen,
        leading: Image.asset(
          Myassets.personImg,
          scale: 1,
        ),
        title: const Column(
          children: [
            SizedBox(height: 20,),
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
        actions: [
            GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Iconsax.logout_copy,
                  size: 50,
                  color: Color.fromARGB(255, 255, 255, 255),
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
                hintStyle: WidgetStatePropertyAll(TextStyle(fontSize: 20, color: Myassets.colorgreen, fontWeight: FontWeight.bold)),
                textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 20, color: Myassets.colorgreen, fontWeight: FontWeight.bold)),
                  backgroundColor: const WidgetStatePropertyAll(
                      Color.fromRGBO(255, 255, 255, 1)),
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
                    Icon(Icons.search, size: 40,),
                  ]),
            ),
          ),
          const SizedBox(height: 20,),
          Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '  My tasks',
                  style: TextStyle(
                      color: Myassets.colorblack,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                )),
          const SizedBox(height: 20,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      setcolor(Myassets.colorgreen, Myassets.colorblack, Myassets.colorblack);
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
                      setcolor(Myassets.colorblack, Myassets.colorgreen, Myassets.colorblack);
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
                      setcolor(Myassets.colorblack, Myassets.colorblack, Myassets.colorgreen);
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
        ],
      ),
    );
  }
}
