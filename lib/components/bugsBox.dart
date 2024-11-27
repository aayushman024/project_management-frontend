// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BugsBox extends StatefulWidget {
  final int index;

  BugsBox({required this.index});

  @override
  State<BugsBox> createState() => _BugsBoxState();
}

class _BugsBoxState extends State<BugsBox> {
  bool isResolved = false; // To track the resolved state

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        width: screenWidth * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffD9D9D9),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Bug #${widget.index}',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 5),
                      if (isResolved)
                        Icon(Icons.check_circle, color: Colors.green, size: 20), // Green tick if resolved
                    ],
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'Resolve') {
                        setState(() {
                          isResolved = true; // Mark as resolved when selected
                        });
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'Resolve',
                        child: Text('Mark as Resolved'),
                      ),
                    ],
                    icon: Icon(Icons.more_vert, color: Colors.black, size: 20,),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Add the feature to add custom alarm commands preset.',
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Shiv Sahu, 10/11/2024',
                  style: GoogleFonts.lato(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
