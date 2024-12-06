// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddFeature extends StatefulWidget {
  const AddFeature({super.key});

  @override
  State<AddFeature> createState() => _AddFeatureState();
}

class _AddFeatureState extends State<AddFeature> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Add a Feature',
      style: GoogleFonts.lato(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w600
      ),),
      content: TextField(
        decoration: InputDecoration(
          hintText: 'Type your feature here...'
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel',
          style: GoogleFonts.lato(
            color: Colors.red
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
                content: Text('Feature request added',
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
          child: Text('Add',
          style: GoogleFonts.lato(
            color: Colors.blue
          ),),
        ),
      ],
    );
  }
}
