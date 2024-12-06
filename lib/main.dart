// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_management_system/pages/addProjectPage.dart';
import 'package:project_management_system/pages/homePage.dart';
import 'package:project_management_system/pages/loginPage.dart';
import 'package:project_management_system/pages/myTeamPage.dart';
import 'package:project_management_system/pages/projectDetailPage.dart';
import 'package:project_management_system/pages/registerPage.dart';
import 'package:project_management_system/pages/registerTeam.dart';

void main(){
  runApp(const PMS());
}

class PMS extends StatefulWidget {
  const PMS({super.key});

  @override
  State<PMS> createState() => _PMSState();
}

class _PMSState extends State<PMS> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      //RegisterPage(),
      //LoginPage()
      //RegisterTeam()
     //ProjectDetail(),
      //AddProjectPage(),
      //MyTeamPage(),
    );
  }
}
