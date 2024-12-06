// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmployeeCard extends StatefulWidget {
  final String empName;
  final String empDesig;
  final String? empLinkedIn;
  final Color? empColor;
  final Color? empTextColor;

  EmployeeCard({
    required this.empName,
    required this.empDesig,
    this.empLinkedIn,
    this.empColor,
    this.empTextColor,
  });

  @override
  State<EmployeeCard> createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {

  // void _openLinkedIn(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url, forceWebView: true);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        width: screenWidth * 0.25,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        decoration: BoxDecoration(
          color: widget.empColor ?? Colors.blueGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Employee Name
            Text(
              widget.empName,
              style: GoogleFonts.lato(
                color: widget.empTextColor ?? Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            // Employee Designation
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 40),
              child: Text(
                widget.empDesig,
                style: GoogleFonts.lato(
                  color: widget.empTextColor ?? Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
              ),
            ),
            // LinkedIn Icon
              GestureDetector(
                //onTap: () => _openLinkedIn(widget.empLinkedIn!),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    '/linkedIn.png',
                    color: widget.empTextColor ?? Colors.white,
                    scale: 1.2,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
