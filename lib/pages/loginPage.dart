// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_management_system/pages/registerPage.dart';
import 'package:project_management_system/pages/registerTeam.dart';
import '../components/customTextField.dart';
import '../controllers/controllers.dart';
import 'homePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isPasswordVisible = true;
  bool isHovered = false;
  String? team;

  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void checkLogin() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      // Show error snack bar if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          duration: Duration(seconds: 4),
          elevation: 0,
          content: AwesomeSnackbarContent(
            title: 'Error!',
            titleTextStyle: GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 20),
            message: 'One or more fields are empty',
            contentType: ContentType.failure,
            messageTextStyle: GoogleFonts.lato(fontWeight: FontWeight.w500),
          ),
        ),
      );
    } else {
      // If fields are filled, navigate to the next page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [

          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff252525),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 20,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  width: screenWidth * 0.45,
                ),
                Image.asset(
                  '/login.jpg',
                  width: screenWidth * 0.45,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(height: screenWidth*0.03,),

                  SizedBox(height: screenHeight * 0.04, child: Image.asset('/nokiaLogo.png',
                    color: Color(0xff005AFF))),

                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Text(
                      'Project Management System',
                      style: GoogleFonts.lato(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 30),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 50),
                    padding: EdgeInsets.only(top: 40, left: 50, right: 50),
                    height: screenHeight * 0.4,
                    width: screenWidth * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color(0xffF6F6F6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 0.5,
                            blurRadius: 18,
                            offset: Offset(0, 0),
                          ),
                        ]
                    ),
                    child: Column(
                      children: [

                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                  labelText: 'Email ID',
                                  obscureText: false,
                                  controller: emailController),

                              CustomTextField(
                                labelText: 'Password',
                                obscureText: isPasswordVisible,
                                suffixIcon: IconButton(
                                  onPressed: togglePasswordView,
                                  icon: Icon(
                                    isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.grey,
                                    size: screenWidth * 0.016,
                                  ),
                                ),
                                controller: passwordController,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: ElevatedButton(
                            onPressed: checkLogin,
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              side: WidgetStatePropertyAll(BorderSide(color: Color(0xff0098FF), width: 2)),
                              padding: WidgetStateProperty.all(
                                EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                              ),
                              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                                  if (states.contains(WidgetState.hovered)) {
                                    return Colors.white;
                                  }
                                  return Color(0xff0098FF);
                                },
                              ),
                              foregroundColor: WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                                  if (states.contains(WidgetState.hovered)) {
                                    return Colors.black;
                                  }
                                  return Colors.white;
                                },
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 3),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              height: 24,
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterTeam()));
                            },
                            child: Text(
                              'Register Your Team',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
