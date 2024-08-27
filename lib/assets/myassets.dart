
import 'dart:ui';

import 'package:flutter/material.dart';

class Myassets {
  static const String loginImg = "lib/assets/loginscreen.webp";
  static const String signupImg = "lib/assets/signupscreen.webp";
  static const String personImg = "lib/assets/person.png";
  static const String loadingImg = "lib/assets/loading.png";
  static const String subtasksImg = "lib/assets/subtasks.png";
  static const String completedImg = "lib/assets/completed.png";
  static const String doneImg = "lib/assets/done.png";
  static const String addtaskImg = "lib/assets/addtask.png";
  static const String notaskImg = "lib/assets/notask.png";
  static const String wallImg = "lib/assets/wall.jpg";

  static const Color colorgreen = Color.fromARGB(255,0,156,134);
  static const Color colorblack = Color.fromRGBO(0, 0, 0, 1);
  static const Color colorwhite = Color.fromRGBO(255, 255, 255, 1);



 static screenHeight(BuildContext context){
  return MediaQuery.of( context).size.height;
 }

  static screenWidth(BuildContext context){
  return MediaQuery.of( context).size.width;
 }

}