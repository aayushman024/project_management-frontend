import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IncorrectEffortDialog extends StatefulWidget {
  const IncorrectEffortDialog({super.key});

  @override
  State<IncorrectEffortDialog> createState() => _IncorrectEffortDialogState();
}

class _IncorrectEffortDialogState extends State<IncorrectEffortDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('ERROR',
      style: GoogleFonts.lato(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600
      ),),
      content: Text('Total efforts entered exceeds 100%',
      style: GoogleFonts.lato(
        color: Colors.red,
        fontSize: 15,
        fontWeight: FontWeight.w500
      ),),
    );
  }
}
