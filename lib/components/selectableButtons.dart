// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectableChips extends StatefulWidget {
  @override
  _SelectableChipsState createState() => _SelectableChipsState();
}

class _SelectableChipsState extends State<SelectableChips> {
  List<String> names = [
    'Aayushman',
    'Rishabh',
    'Yuvraj',
    'Khushi',
    'Vansh',
    'Kashish',
    'Reya',
    'Tejasvita',
    'Anil K.',
    'Niraj',
    'Tony',
    'Shiv K.',
    'Siddharth'
  ];
  List<String> selectedNames = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: names.map((name) {
            final isSelected = selectedNames.contains(name);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedNames.remove(name);
                  } else {
                    selectedNames.add(name);
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFF3D3D3D),
                  borderRadius: BorderRadius.circular(18),
                  border: isSelected
                      ? Border.all(color: Colors.green, width: 2)
                      : Border.all(color: Colors.transparent, width: 2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      )
                    ),
                    if (isSelected) ...[
                      SizedBox(width: 8),
                      Icon(Icons.check_circle, color: Colors.green, size: 18),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
  }
}
