// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_management_system/components/timeline.dart';
import 'package:project_management_system/pages/projectDetailPage.dart';

import '../globals.dart';

class ProjectCard extends StatefulWidget {
  final String projectName;

  ProjectCard({
    required this.projectName,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {

  //local variables
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context)=> ProjectDetail()));
      },
      child: MouseRegion(

        onEnter: (_) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: AnimatedScale(
            scale: _isHovered ? 1.04 : 1.0,
            duration: Duration(milliseconds: 200),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffDFECFF),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: ListTile(
                        horizontalTitleGap: 0,
                        title: Text(
                          widget.projectName,
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right_rounded,
                          color: Colors.black,
                          size: screenHeight * 0.04,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 30),
                          child: SizedBox(
                            width: screenWidth * 0.32,
                            child: CustomTimeline(),
                          ),
                        ),
                        Expanded(
                          child: CircularPercentIndicator(
                            radius: screenWidth*0.03,
                            animation: true,
                            animationDuration: 1000,
                            backgroundColor: Color(0xff70C5FF),
                            progressColor: Color(0xff0073C0),
                            circularStrokeCap: CircularStrokeCap.butt,
                            lineWidth: screenWidth*0.0072,
                            percent: percentage,
                            center: Text('${percentage*100}%',
                              style: GoogleFonts.lato(
                                  color: Color(0xff0098FF),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18
                              ),),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            horizontalTitleGap: 0,
                            leading: Icon(
                              Icons.circle,
                              size: screenHeight * 0.008,
                            ),
                            title: Text(
                              'Last Updated : 09/11/2024',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            horizontalTitleGap: 0,
                            leading: Icon(
                              Icons.circle,
                              size: screenHeight * 0.008,
                            ),
                            title: Text(
                              'Priority : Medium',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListTile(
                            horizontalTitleGap: 0,
                            leading: Icon(
                              Icons.circle,
                              size: screenHeight * 0.008,
                            ),
                            title: Text(
                              '24 days until release',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            horizontalTitleGap: 0,
                            leading: Icon(
                              Icons.circle,
                              size: screenHeight * 0.008,
                            ),
                            title: Text(
                              'Led by Anil Kr Prajapati',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}