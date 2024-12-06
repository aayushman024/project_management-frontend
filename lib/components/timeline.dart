// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../globals.dart';

class CustomTimeline extends StatefulWidget {
  const CustomTimeline({super.key});

  @override
  State<CustomTimeline> createState() => _CustomTimelineState();
}

class _CustomTimelineState extends State<CustomTimeline> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight*0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: TimelineTile(
              startChild: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text('Research\n(12/11/24)',
                  textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
                ),),
              ),
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              isFirst: true,
              indicatorStyle: IndicatorStyle(
                color: Colors.green,
                iconStyle: IconStyle(
                  iconData: Icons.check,
                  color: Colors.white,
                ),
              ),
              beforeLineStyle: LineStyle(color: Colors.green),
            ),
          ),
          Flexible(
            child: TimelineTile(
              endChild: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text('Design\n(26/11/24)',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                  ),),
              ),
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              isLast: false,
              indicatorStyle: IndicatorStyle(
                color: Colors.green,
                iconStyle: IconStyle(
                  iconData: Icons.done,
                  color: Colors.white,
                ),
              ),
              beforeLineStyle: LineStyle(color: Colors.green),
            ),
          ),
          Flexible(
            child: TimelineTile(
              startChild: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text('Development\n(02/01/25)',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                  ),),
              ),
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              isLast: false,
              indicatorStyle: IndicatorStyle(
                color: Colors.blue,
                iconStyle: IconStyle(
                  iconData: Icons.done,
                  color: Colors.white,
                ),
              ),
              beforeLineStyle: LineStyle(color: Colors.blue),
            ),
          ),
          Flexible(
            child: TimelineTile(
              endChild: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text('Testing\n(26/01/25)',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                  ),),
              ),
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              isLast: false,
              indicatorStyle: IndicatorStyle(
                color: Colors.blue,
                iconStyle: IconStyle(
                  iconData: Icons.done,
                  color: Colors.white,
                ),
              ),
              beforeLineStyle: LineStyle(color: Colors.blue),
            ),),
          Flexible(
            child: TimelineTile(
              startChild: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text('Release\n(01/02/25)',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                  ),),
              ),
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              isLast: true,
              indicatorStyle: IndicatorStyle(
                color: Colors.blue,
                iconStyle: IconStyle(
                  iconData: Icons.done,
                  color: Colors.white,
                ),
              ),
              beforeLineStyle: LineStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
