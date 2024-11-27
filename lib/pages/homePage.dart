// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_management_system/components/barGraph.dart';
import 'package:project_management_system/components/dashboardCard.dart';
import 'package:project_management_system/components/projectCard.dart';
import 'package:project_management_system/components/customAppDrawer.dart';

import '../globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xffFDFDFD),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Project Management System',
          style: GoogleFonts.lato(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 20,
        ),),
        backgroundColor: Color(0xff282828),
        actions: [
          Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Text(
                  'Innovation & Performance, Plot-25, GGN, IN',
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.logout_rounded,
                  size: screenHeight * 0.025,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: CustomAppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(40, 30, 40, 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Parent column for projects
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Divider(
                          color: Colors.black,
                          thickness: 1,
                          endIndent: 10,
                        ),
                      ),
                      Text(
                        'ONGOING PROJECTS      ',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  // ListView for ongoing projects
                  ListView.builder(
                    itemCount: projectNames.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: ProjectCard(
                          projectName: projectNames[index],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            // Column for Quick Insights
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'QUICK INSIGHTS',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Flexible(
                        child: Divider(
                          color: Colors.black,
                          thickness: 1,
                          indent: 10,
                        ),
                      ),
                    ],
                  ),
                  DashboardCard(),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: BarGraph(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}