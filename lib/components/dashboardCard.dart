// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardCard extends StatefulWidget {
  const DashboardCard({super.key});

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: Container(
        padding: EdgeInsets.only(top: 30, bottom: 30),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(3, 5),
            ),
          ],
          color: Color(0xff282828),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // First column with TOTAL PROJECTS, 8, MOST BUGS, and sTSI(8)
            Column(
              children: [
                Text(
                  'TOTAL PROJECTS',
                  style: GoogleFonts.lato(
                    color: Color(0xffDFECFF),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '8',
                  style: GoogleFonts.lato(
                    color: Color(0xffDFECFF),
                    fontWeight: FontWeight.w800,
                    fontSize: 45,
                  ),
                ),
                SizedBox(height: screenHeight*0.05),
                Text(
                  'MOST BUGS',
                  style: GoogleFonts.lato(
                    color: Color(0xffDFECFF),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'sTSI (8)',
                    style: GoogleFonts.lato(
                      color: Color(0xffDFECFF),
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),

            // Divider between columns
            Container(
              color: Color(0xffDFECFF),
              width: 1,
              height: screenHeight * 0.12,
            ),

            // Second column with COMPLETED, 0, UPCOMING DEADLINE, and NMS Care
            Column(
              children: [
                Text(
                  'COMPLETED',
                  style: GoogleFonts.lato(
                    color: Color(0xffDFECFF),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '0',
                  style: GoogleFonts.lato(
                    color: Color(0xffDFECFF),
                    fontWeight: FontWeight.w800,
                    fontSize: 45,
                  ),
                ),
                SizedBox(height: screenHeight*0.05),
                Text(
                  'UPCOMING RELEASE',
                  style: GoogleFonts.lato(
                    color: Color(0xffDFECFF),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'NMS Care',
                    style: GoogleFonts.lato(
                      color: Color(0xffDFECFF),
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    ),
                  ),
                ),
                // Text(
                //   '(24 days)',
                //   style: GoogleFonts.lato(
                //     color: Color(0xff98A1AE),
                //     fontWeight: FontWeight.w600,
                //     fontSize: 20,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}