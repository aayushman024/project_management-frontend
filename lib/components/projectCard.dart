// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_management_system/components/timeline.dart';
import 'package:project_management_system/fontStyle.dart';
import 'package:project_management_system/pages/projectDetailPage.dart';

import '../globals.dart';

class ProjectCard extends StatefulWidget {
  final projectName;
  final onTap;
  String? description;
  String? priority;
  String? ledBy;
  String? review;
  String? researchDeadline;
  String? researchEffort;
  String? designDeadline;
  String? designEffort;
  String? developmentDeadline;
  String? developmentEffort;
  String? testingDeadline;
  String? testingEffort;
  String? assignedBy;
  String? assignedTo;
  String? currentMilestone;
  double? completionPercentage;
  bool? completed;
  String? releaseDate;
  String? lastUpdated;
  dynamic daysLeft;

  ProjectCard({
    required this.projectName,
    required this.onTap,
    required this.description,
    required this.priority,
    required this.ledBy,
    required this.review,
    required this.researchDeadline,
    required this.researchEffort,
    required this.designDeadline,
    required this.designEffort,
    required this.developmentDeadline,
    required this.developmentEffort,
    required this.testingDeadline,
    required this.testingEffort,
    required this.assignedBy,
    required this.assignedTo,
    required this.currentMilestone,
    required this.completionPercentage,
    this.completed,
    required this.releaseDate,
    required this.lastUpdated,
    required this.daysLeft

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

    return MouseRegion(

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
        padding: const EdgeInsets.only(top: 15),
        child: AnimatedScale(
          curve: Curves.easeIn,
          scale: _isHovered ? 1.04 : 1.0,
          duration: Duration(milliseconds: 200),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
             // border: Border.all(color: Color(0xff003840), width: 0.5),
              color: Colors.blue.withOpacity(0.1)
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
                        style: AppTextStyles.bold(fontSize: 20, color: Colors.black)
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
                          child: CustomTimeline(
                            currentMilestone: widget.currentMilestone!,
                            releaseDeadline: widget.releaseDate!,
                            designDeadline: widget.designDeadline!,
                            developmentDeadline: widget.developmentDeadline!,
                            testingDeadline: widget.testingDeadline!,
                            researchDeadline: widget.researchDeadline!,
                          ),
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
                          percent: widget.completionPercentage!/100,
                          center: Text('${widget.completionPercentage}%',
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
                          title: Text('Last Updated : ${widget.lastUpdated!}',
                            style: AppTextStyles.regular(fontSize: 13, color: Colors.black)
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
                            'Priority : ${widget.priority}',
                            style: AppTextStyles.regular(fontSize: 13, color: Colors.black)
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
                            '${widget.daysLeft} days until release',
                            style: AppTextStyles.regular(fontSize: 13, color: Colors.black)
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
                            'Led by ${widget.ledBy}',
                            style: AppTextStyles.regular(fontSize: 13, color: Colors.black)
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
    );
  }
}