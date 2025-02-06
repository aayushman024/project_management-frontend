import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_management_system/pages/loginPage.dart';
import 'package:project_management_system/pages/registerPage.dart';

import '../components/customTextField.dart';
import '../controllers/controllers.dart';

class RegisterTeam extends StatefulWidget {
  const RegisterTeam({super.key});

  @override
  State<RegisterTeam> createState() => _RegisterTeamState();
}

class _RegisterTeamState extends State<RegisterTeam> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(height: screenWidth*0.03,),

                  SizedBox(height: screenHeight * 0.03, child: Image.asset('/nokiaLogo.png',
                      color: Color(0xff005AFF))),

                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      'Register Your Team for Project Management System',
                      style: GoogleFonts.lato(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(top: 40, left: 50, right: 50),
                    height: screenHeight * 0.68,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                  labelText: 'Team Name',
                                  obscureText: false,
                                  controller: teamNameController,
                              ),

                              CustomTextField(
                                labelText: 'Team Manager',
                                controller: teamLeaderController,
                              ),

                              CustomTextField(
                                labelText: 'Team Location',
                                controller: teamLocationController,
                              ),

                              CustomTextField(
                                labelText: 'Team Description',
                                controller: teamDescriptionController,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ElevatedButton(
                            onPressed: (){},
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
                              'Register Team',
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
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 3),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 14.0,
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
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                            },
                            child: const Text(
                              'Login Here',
                              style: TextStyle(
                                fontSize: 14.0,
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
          Padding(
            padding: const EdgeInsets.only(left: 40),
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
        ],
      ),
    );
  }
}
