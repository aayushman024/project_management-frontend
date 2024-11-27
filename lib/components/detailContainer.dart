// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailContainer extends StatefulWidget {
  const DetailContainer({super.key});

  @override
  State<DetailContainer> createState() => _DetailContainerState();
}

class _DetailContainerState extends State<DetailContainer> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.2,
      width: screenWidth * 0.4,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: ListTile(
                    minTileHeight: 0,
                    leading: Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: 6,
                    ),
                    horizontalTitleGap: 0,
                    title: Text(
                      'Priority : Medium',
                      style: GoogleFonts.lato(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Flexible(
                  child: ListTile(
                    minTileHeight: 0,
                    leading: Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: 6,
                    ),
                    horizontalTitleGap: 0,
                    title: Text(
                      'Last Updated : 09/11/2024',
                      style: GoogleFonts.lato(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: ListTile(
                    minTileHeight: 0,
                    leading: Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: 6,
                    ),
                    horizontalTitleGap: 0,
                    title: Text(
                      'Led by Anil Kr. Prajapati',
                      style: GoogleFonts.lato(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Flexible(
                  child: ListTile(
                    minTileHeight: 0,
                    leading: Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: 6,
                    ),
                    horizontalTitleGap: 0,
                    title: Text(
                      '24 days until release',
                      style: GoogleFonts.lato(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: ListTile(
                    minTileHeight: 0,
                    leading: Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: 6,
                    ),
                    horizontalTitleGap: 0,
                    title: Text(
                      'Date Assigned : 01/11/2024',
                      style: GoogleFonts.lato(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Flexible(
                  child: ListTile(
                    minTileHeight: 0,
                    leading: Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: 6,
                    ),
                    horizontalTitleGap: 0,
                    title: Text(
                      'Weekly Review : Monday',
                      style: GoogleFonts.lato(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
