// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddBugs extends StatefulWidget {
  const AddBugs({super.key});

  @override
  State<AddBugs> createState() => _AddBugsState();
}

class _AddBugsState extends State<AddBugs> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Report a Bug',
        style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600
        ),),
      content: TextField(
        decoration: InputDecoration(
            hintText: 'Type your bug here...'
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel',
            style: GoogleFonts.lato(
                color: Colors.black
            ),),
        ),
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                margin: EdgeInsets.symmetric(vertical: 50, horizontal: 500),
                showCloseIcon: true,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                content: Text('Bug Reported',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 4),
              ),
            );
            Navigator.of(context).pop();
          },
          child: Text('Report',
            style: GoogleFonts.lato(
                color: Colors.red
            ),),
        ),
      ],
    );
  }
  }
