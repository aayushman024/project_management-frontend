// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_management_system/components/barGraph.dart';
import 'package:project_management_system/components/dashboardCard.dart';
import 'package:project_management_system/components/projectCard.dart';
import 'package:project_management_system/components/customAppDrawer.dart';
import 'package:project_management_system/pages/loginPage.dart';

import '../controllers/controllers.dart';
import '../globals.dart';
import 'myTeamPage.dart';

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
        title: Text(
          'Project Management System',
          style: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
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
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MyTeamPage()));
                    },
                    child: Text(
                      'Innovation & Performance, Plot-25, GGN, IN',
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),)
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
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                },
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
                crossAxisAlignment: CrossAxisAlignment.start,
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

                  SizedBox(height: screenHeight*0.04),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: TextField(
                                // onChanged: (value) {
                                //   filterIssues(value);
                                // },
                                cursorColor: Colors.white30,
                                controller: searchController,
                                maxLines: null,
                                autofocus: false,
                                keyboardType: TextInputType.name,
                                style: GoogleFonts.lato(color: Colors.black, fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.search_rounded,
                                    color: Colors.black54,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),),
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20)),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.black, width: 2)),
                                 label : Text('Search Ongoing Projects',
                                 style: GoogleFonts.lato(
                                   color: Colors.black,
                                   fontSize: 15,
                                   fontWeight: FontWeight.w400
                                 ),)
                                )),
                          ),
                        ),

                        Flexible(
                          child: ExpansionTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '   Filters    ',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(
                                  Icons.filter_list,
                                  color: Colors.black,
                                  size: screenHeight * 0.024,
                                ),
                              ],
                            ),
                            collapsedIconColor: Colors.black,
                            iconColor: Colors.black,
                            collapsedBackgroundColor: Color(0xffF0F0F0),
                            backgroundColor: Color(0xffD9D9D9),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            childrenPadding: EdgeInsets.all(10),
                            children: [
                              CheckboxListTile(
                                dense: true,
                                activeColor: Colors.black,
                                checkColor: Colors.white,
                                checkboxShape: CircleBorder(),
                                title: Text(
                                  'High',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: isHigh,
                                onChanged: (value) {
                                  setState(() {
                                    isHigh = value ?? false;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                dense: true,
                                activeColor: Colors.black,
                                checkColor: Colors.white,
                                checkboxShape: CircleBorder(),
                                title: Text(
                                  'Medium',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: isMedium,
                                onChanged: (value) {
                                  setState(() {
                                    isMedium = value ?? false;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                dense: true,
                                activeColor: Colors.black,
                                checkColor: Colors.white,
                                checkboxShape: CircleBorder(),
                                title: Text(
                                  'Low',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: isLow,
                                onChanged: (value) {
                                  setState(() {
                                    isLow = value ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    itemCount: projectNames.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '            QUICK INSIGHTS',
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
                  DashboardCarousel(),
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
