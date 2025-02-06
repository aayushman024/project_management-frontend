// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:project_management_system/components/customTextField.dart';
import 'package:project_management_system/controllers/controllers.dart';
import 'package:project_management_system/pages/homePage.dart';
import 'package:project_management_system/pages/loginPage.dart';
import 'package:project_management_system/pages/registerTeam.dart';

import '../globals.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isPasswordVisible = true;
  String? team;
  String? position;

  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void checkRegistration() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty ||
        nameController.text.isEmpty || confirmPasswordController.text.isEmpty
        || team == null || position == null) {
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
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      // Show error if passwords do not match
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          duration: Duration(seconds: 4),
          elevation: 0,
          content: AwesomeSnackbarContent(
            title: 'Error!',
            titleTextStyle: GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 20),
            message: 'Passwords do not match',
            contentType: ContentType.failure,
            messageTextStyle: GoogleFonts.lato(fontWeight: FontWeight.w500),
          ),
        ),
      );
      return;
    }

    // API Call
    try {
      final url = Uri.parse('http://10.131.213.166:8080/api/individuals/');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": nameController.text,
          "email": emailController.text,
          "team": team,
          "role": position,
          "linkedin_profile": linkedinController.text,
          "password": passwordController.text,
        }),
      );

      if (response.statusCode == 201) {
        // Registration successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            duration: Duration(seconds: 4),
            elevation: 0,
            content: AwesomeSnackbarContent(
              title: 'Success!',
              titleTextStyle: GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 20),
              message: 'Registration successful',
              contentType: ContentType.success,
              messageTextStyle: GoogleFonts.lato(fontWeight: FontWeight.w500),
            ),
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        // Show error from the server
        final errorMessage = jsonDecode(response.body)['message'] ?? 'Something went wrong!';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            duration: Duration(seconds: 4),
            elevation: 0,
            content: AwesomeSnackbarContent(
              title: 'Error!',
              titleTextStyle: GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 20),
              message: errorMessage,
              contentType: ContentType.failure,
              messageTextStyle: GoogleFonts.lato(fontWeight: FontWeight.w500),
            ),
          ),
        );
      }
    } catch (e) {
      // Handle network or unexpected errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          duration: Duration(seconds: 4),
          elevation: 0,
          content: AwesomeSnackbarContent(
            title: 'Error!',
            titleTextStyle: GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 20),
            message: 'An error occurred: $e',
            contentType: ContentType.failure,
            messageTextStyle: GoogleFonts.lato(fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.04,
                child: Image.asset(
                  '/nokiaLogo.png',
                  color: Color(0xff005AFF),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  'Project Management System',
                  style: GoogleFonts.lato(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 26),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                padding: EdgeInsets.only(top: 20, left: 50, right: 50),
               // height: screenHeight * 0.5,
                width: screenWidth * 0.8,
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
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomTextField(
                                labelText: 'Enter Your Name',
                                obscureText: false,
                                controller: nameController,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      focusColor: Colors.transparent,
                                      hint: Text(
                                        'Select Team',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      value: team,
                                      items: teams
                                          .map((item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          team = newValue;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      ),
                                      dropdownColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      focusColor: Colors.transparent,
                                      hint: Text(
                                        'Select Position',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      value: position,
                                      items: positions
                                          .map((item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          position = newValue;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      ),
                                      dropdownColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              // CustomTextField(
                              //   labelText: 'LinkedIn Profile URL',
                              //   obscureText: false,
                              //   controller: linkedinController,
                              // )
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.1),
                        Expanded(
                          child: Column(
                            children: [
                              CustomTextField(
                                labelText: 'Email ID',
                                obscureText: false,
                                controller: emailController,
                              ),
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
                              CustomTextField(
                                labelText: 'Confirm Password',
                                obscureText: isPasswordVisible,
                                suffixIcon: IconButton(
                                  onPressed: togglePasswordView,
                                  icon: Icon(
                                    isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.grey,
                                    size: screenWidth * 0.016,
                                  ),
                                ),
                                controller: confirmPasswordController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: ElevatedButton(
                        onPressed: checkRegistration,
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                          ),
                          backgroundColor: WidgetStatePropertyAll(Color(0xff0098FF)),
                        ),
                        child: Text(
                          'Register',
                          style: GoogleFonts.lato(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    'Already Registered? Login',
                    style: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}