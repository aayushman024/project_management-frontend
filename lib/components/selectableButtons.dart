// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../globals.dart';

class SelectableChips extends StatefulWidget {
  @override
  _SelectableChipsState createState() => _SelectableChipsState();
}

class _SelectableChipsState extends State<SelectableChips> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: names.map((name) {
          return FilterChip(
            label: Text(
              name,
              style: GoogleFonts.lato(
                color: selectedNames.contains(name) ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            selected: selectedNames.contains(name),
            onSelected: (isSelected) {
              setState(() {
                if (isSelected) {
                  selectedNames.add(name);
                } else {
                  selectedNames.remove(name);
                }
              });
            },
            backgroundColor: Color(0xFFE0E0E0),
            selectedColor: Color(0xFF00C106),
            checkmarkColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          );
        }).toList(),
      ),
    );
  }
}
