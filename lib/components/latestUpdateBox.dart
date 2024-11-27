// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_management_system/components/dailyProgress.dart';

class LatestUpdate extends StatefulWidget {
  const LatestUpdate({super.key});

  @override
  State<LatestUpdate> createState() => _LatestUpdateState();
}

class _LatestUpdateState extends State<LatestUpdate> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      width: screenWidth*0.4,
      decoration: BoxDecoration(
        color: Color(0xffDFECFF),
            borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Latest Update',
          style: GoogleFonts.lato(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 18
          ),),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Text('Frontend development has been completed, integration '
                'with backend is in progress, feature #09 has been implemented',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 13
              ),),
          ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => DailyProgress(),
              );
            },
            child: Text(
              'View Daily Progress',
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
