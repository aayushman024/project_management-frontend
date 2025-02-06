// ignore_for_file: prefer_const_constructors

import 'package:google_fonts/google_fonts.dart';
import 'package:project_management_system/pages/addProjectPage.dart';
import 'package:project_management_system/pages/completedProjects.dart';
import 'package:project_management_system/pages/homePage.dart';
import 'package:project_management_system/pages/myTeamPage.dart';
import 'package:project_management_system/pages/profilePage.dart';

import '../globals.dart';
import '../main.dart';
import 'package:flutter/material.dart';

import '../pages/empSelectorProgress.dart';
import '../pages/progressPage.dart';
import '../pages/underMaintenance.dart';

class CustomAppDrawer extends StatefulWidget {
  const CustomAppDrawer({super.key});

  @override
  State<CustomAppDrawer> createState() => _CustomAppDrawerState();
}

class _CustomAppDrawerState extends State<CustomAppDrawer> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      width: screenWidth * 0.3,
      backgroundColor: const Color(0xff252525),
      child: Padding(
        padding: const EdgeInsets.only(left: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: screenHeight*0.05,
            ),
            ListTile(
              hoverColor: Colors.black87,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  HomePage()));
              },
              leading: const Icon(
                Icons.all_inbox_rounded,
                color: Colors.white,
              ),
              title: Text(
                'Home',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
            ListTile(
              hoverColor: Colors.black87,
              leading: const Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
              title: Text(
                'Completed Projects',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CompletedProjects()));
              },
            ),
            ListTile(
              hoverColor: Colors.black87,
              leading: const Icon(
                Icons.construction,
                color: Colors.white,
              ),
              title: Text(
                'Under Maintenance Projects',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> UnderMaintenance()));
              },
            ),
            ListTile(
              hoverColor: Colors.black87,
              onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => userRole == 'Intern'
                                    ? ProgressPage(
                                  userID: userId,
                                  username: userName,
                                )
                                    : EmployeeSelectorProgress()));
                        },
              leading: const Icon(
                Icons.calendar_month,
                color: Colors.white,
              ),
              title: Text(
                'Daily Progress',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
            ListTile(
              hoverColor: Colors.black87,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyTeamPage()));
              },
              leading: const Icon(
                Icons.check_circle_outline_outlined,
                color: Colors.white,
              ),
              title: Text(
                'My Team',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
            ListTile(
              hoverColor: Colors.black87,
              leading: const Icon(
                Icons.account_circle_rounded,
                color: Colors.white,
              ),
              title: Text(
                'Add a Project',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AddProjectPage()));
              },
            ),
            // ListTile(
            //   hoverColor: Colors.black87,
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => ProfilePage()));
            //   },
            //   leading: const Icon(
            //     Icons.person,
            //     color: Colors.white,
            //   ),
            //   title: Text(
            //     'PROFILE',
            //     style: GoogleFonts.poppins(color: Colors.white),
            //   ),
            // ),
            SizedBox(
              height: screenHeight * 0.3,
            ),
          ],
        ),
      ),
    );
  }
}
