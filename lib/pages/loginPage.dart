import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:project_management_system/controllers/controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/customTextField.dart';
import 'homePage.dart';
import 'registerPage.dart';
import 'registerTeam.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = true;

  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  Future<void> checkLogin(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'One or more fields are empty',
            style: GoogleFonts.lato(fontWeight: FontWeight.w500),
          ),
        ),
      );
      return;
    }

    try {
      final url = Uri.parse('http://10.131.213.166:8080/api/login/');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('accessToken', data['token']);
        await prefs.setBool('isLoggedIn', true);
        await prefs.setInt('userId', data['user_id']);
        await prefs.setString('username', data['username']);
        await prefs.setStringList(
          'userGroups',
          List<String>.from(data['groups']),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Logged In successfully.',
              style: GoogleFonts.lato(fontWeight: FontWeight.w500),
            ),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Invalid credentials or server error.',
              style: GoogleFonts.lato(fontWeight: FontWeight.w500),
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                    color: const Color(0xff252525),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 20,
                        offset: const Offset(0, 4),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.04,
                  child: Image.asset(
                    '/nokiaLogo.png',
                    color: const Color(0xff005AFF),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Text(
                    'Project Management System',
                    style: GoogleFonts.lato(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 30),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  padding:
                  const EdgeInsets.only(top: 40, left: 50, right: 50),
                  width: screenWidth * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xffF6F6F6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 0.5,
                        blurRadius: 18,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CustomTextField(
                        labelText: 'Email ID',
                        obscureText: false,
                        controller: emailController,
                      ),
                      CustomTextField(
                        onSubmitted: (_){
                          checkLogin(emailController.text, passwordController.text);
                        },
                        labelText: 'Password',
                        obscureText: isPasswordVisible,
                        suffixIcon: IconButton(
                          onPressed: togglePasswordView,
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),
                        controller: passwordController,
                      ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        checkLogin(emailController.text, passwordController.text);
                      },
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        side: WidgetStateProperty.all(
                            const BorderSide(color: Color(0xff0098FF), width: 2)),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 60),
                        ),
                        backgroundColor:
                        WidgetStateProperty.resolveWith<Color>(
                              (Set<WidgetState> states) {
                            if (states.contains(WidgetState.hovered)) {
                              return Colors.white;
                            }
                            return const Color(0xff0098FF);
                          },
                        ),
                        foregroundColor:
                        WidgetStateProperty.resolveWith<Color>(
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
                      ),),
                  )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage())),
                        child: const Text(' Register',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
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
