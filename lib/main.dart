// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_management_system/pages/homePage.dart';
import 'package:project_management_system/pages/loginPage.dart';
import 'package:project_management_system/pages/myTeamPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PMS());
}

class PMS extends StatefulWidget {
  const PMS({super.key});

  @override
  State<PMS> createState() => _PMSState();
}

class _PMSState extends State<PMS> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isLoggedIn ? HomePage() : LoginPage(),
      //MyTeamPage()
    );
  }
}
