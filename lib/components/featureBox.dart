// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeatureBox extends StatefulWidget {
  final int index;

  FeatureBox({required this.index});

  @override
  State<FeatureBox> createState() => _FeatureBoxState();
}

class _FeatureBoxState extends State<FeatureBox> {
  bool isResolved = false;

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
                        'Feature #${widget.index}',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 5),
                      if (isResolved)
                        Icon(Icons.check_circle, color: Colors.green, size: 20),

                    ],
                  ),
                  PopupMenuButton<String>(
                    color: Colors.white,
                    onSelected: (value) {
                      if (value == 'Added') {
                        setState(() {
                          isResolved = true;
                        });

                        // Show Material Banner
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            margin: EdgeInsets.symmetric(vertical: 50, horizontal: 500),
                            showCloseIcon: true,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              content: Text('Feature marked as added',
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
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'Added',
                        child: Text('Mark as Added'),
                      ),
                    ],
                  )
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
