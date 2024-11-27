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
            // Add your action here
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
