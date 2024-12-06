// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_management_system/components/aboutProjectBox.dart';
import 'package:project_management_system/components/bugsBox.dart';
import 'package:project_management_system/components/detailContainer.dart';
import 'package:project_management_system/components/latestUpdateBox.dart';
import 'package:project_management_system/components/timeline.dart';
import 'package:project_management_system/dialogBoxes/addBugs.dart';
import 'package:project_management_system/dialogBoxes/addFeature.dart';
import 'package:project_management_system/pages/editPage.dart';

import '../components/customAppDrawer.dart';
import '../components/featureBox.dart';
import '../globals.dart';
import 'loginPage.dart';
import 'myTeamPage.dart';

class ProjectDetail extends StatefulWidget {
  const ProjectDetail({super.key});

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color(0xffFDFDFD),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Row(
            children: [
              Text(
                'TS Hot Issues Dashboard',
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: IconButton(
                    tooltip: 'Edit',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> EditPage()));
                    },
                    icon: Icon(
                      Icons.edit_calendar_rounded,
                      size: screenHeight * 0.028,
                      color: Colors.white,
                    )),
              )
            ],
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
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomTimeline(),
                        )),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 40),
                          child: CircularPercentIndicator(
                            radius: screenWidth * 0.03,
                            animation: true,
                            animationDuration: 1000,
                            backgroundColor: Color(0xff70C5FF),
                            progressColor: Color(0xff0073C0),
                            circularStrokeCap: CircularStrokeCap.butt,
                            lineWidth: screenWidth * 0.0072,
                            percent: percentage,
                            center: Text(
                              '${percentage * 100}%',
                              style: GoogleFonts.lato(color: Color(0xff0098FF), fontWeight: FontWeight.w900, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    DetailContainer(),
                    LatestUpdate(),
                    AboutProject()
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 20,
                    offset: Offset(0, 4),
                  ),
                ],
                color: Color(0xff252525),
              ),
              height: screenHeight,
              width: screenWidth * 0.45,
              child: Center(
                child: SizedBox(
                  width: screenWidth * 0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Features (10)',
                              style: GoogleFonts.lato(color: Color(0xff0098FF), fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                            Text('(Completed : 4)',
                            style: GoogleFonts.lato(
                              color: Color(0xffDFECFF),
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                            ),),
                            //SizedBox(height: screenHeight*0.05,),
                            SizedBox(
                              height: screenHeight * 0.6,
                              child: LiveList(
                                showItemInterval: Duration(milliseconds: 50),
                                showItemDuration: Duration(milliseconds: 500),
                                reAnimateOnVisibility: true,
                                scrollDirection: Axis.vertical,
                                itemCount: 10,
                                itemBuilder: (context, index, animation) => FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: Offset(0, 0),
                                      end: Offset(0, 0),
                                    ).animate(animation),
                                    child: FeatureBox(index: 10 - index),
                                  ),
                                ),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                showDialog(context: context, builder: (context)=> AddFeature());
                              },
                              style: ButtonStyle(
                                side: WidgetStateProperty.all(
                                  BorderSide(color: Colors.blue, width: 1),
                                ),
                              ),
                              child: Text(
                                'Add a Feature',
                                style: GoogleFonts.lato(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Bugs (6)',
                              style: GoogleFonts.lato(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                            Text('(Resolved : 2)',
                              style: GoogleFonts.lato(
                                  color: Color(0xffECA1A1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500
                              ),),
                            SizedBox(
                              height: screenHeight * 0.6,
                              child: LiveList(
                                showItemInterval: Duration(milliseconds: 50),
                                showItemDuration: Duration(milliseconds: 500),
                                reAnimateOnVisibility: true,
                                scrollDirection: Axis.vertical,
                                itemCount: 10,
                                itemBuilder: (context, index, animation) => FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: Offset(0, 0),
                                      end: Offset(0, 0),
                                    ).animate(animation),
                                    child: BugsBox(index: 10 - index),
                                  ),
                                ),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                showDialog(context: context, builder: (context)=> AddBugs());
                              },
                              style: ButtonStyle(
                                side: WidgetStateProperty.all(
                                  BorderSide(color: Colors.red, width: 1),
                                ),
                              ),
                              child: Text(
                                'Report a Bug',
                                style: GoogleFonts.lato(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
