import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_management_system/fontStyle.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomTimeline extends StatefulWidget {
  final String currentMilestone;
  final String researchDeadline;
  final String designDeadline;
  final String developmentDeadline;
  final String testingDeadline;
  final String releaseDeadline;

  CustomTimeline({
    required this.currentMilestone,
    required this.researchDeadline,
    required this.designDeadline,
    required this.developmentDeadline,
    required this.testingDeadline,
    required this.releaseDeadline,
  });

  @override
  State<CustomTimeline> createState() => _CustomTimelineState();
}

class _CustomTimelineState extends State<CustomTimeline> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final milestones = ["Research", "Design", "Development", "Testing", "Release"];

    Color getColor(String milestone) {
      final currentIndex = milestones.indexOf(widget.currentMilestone);
      final milestoneIndex = milestones.indexOf(milestone);
      if (widget.currentMilestone == "Released") {
        return Colors.green;
      }

      return milestoneIndex <= currentIndex ? Colors.green : Colors.blue;
    }


    return SizedBox(
      height: screenHeight * 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: TimelineTile(
              startChild: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'Research\n(${widget.researchDeadline})',
                  textAlign: TextAlign.center,
                  style:AppTextStyles.regular(fontSize: 12, color: Colors.black54)
                ),
              ),
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              isFirst: true,
              indicatorStyle: IndicatorStyle(
                color: getColor("Research"),
                iconStyle: IconStyle(
                  iconData: Icons.check,
                  color: Colors.white,
                ),
              ),
              beforeLineStyle: LineStyle(color: getColor("Research")),
            ),
          ),
          Flexible(
            child: TimelineTile(
              endChild: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'Design\n(${widget.designDeadline})',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.regular(fontSize: 12, color: Colors.black54)
                ),
              ),
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              indicatorStyle: IndicatorStyle(
                color: getColor("Design"),
                iconStyle: IconStyle(
                  iconData: Icons.done,
                  color: Colors.white,
                ),
              ),
              beforeLineStyle: LineStyle(color: getColor("Design")),
            ),
          ),
          Flexible(
            child: TimelineTile(
              startChild: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'Development\n(${widget.developmentDeadline})',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.regular(fontSize: 12, color: Colors.black54
                  ),
                ),
              ),
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              indicatorStyle: IndicatorStyle(
                color: getColor("Development"),
                iconStyle: IconStyle(
                  iconData: Icons.done,
                  color: Colors.white,
                ),
              ),
              beforeLineStyle: LineStyle(color: getColor("Development")),
            ),
          ),
          Flexible(
            child: TimelineTile(
              endChild: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'Testing\n(${widget.testingDeadline})',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.regular(fontSize: 12, color: Colors.black54)
                ),
              ),
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              indicatorStyle: IndicatorStyle(
                color: getColor("Testing"),
                iconStyle: IconStyle(
                  iconData: Icons.done,
                  color: Colors.white,
                ),
              ),
              beforeLineStyle: LineStyle(color: getColor("Testing")),
            ),
          ),
          Flexible(
            child: TimelineTile(
              startChild: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text(
                  'Release\n(${widget.releaseDeadline})',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.regular(fontSize: 12, color: Colors.black54)
                ),
              ),
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              isLast: true,
              indicatorStyle: IndicatorStyle(
                color: getColor("Release"),
                iconStyle: IconStyle(
                  iconData: Icons.done,
                  color: Colors.white,
                ),
              ),
              beforeLineStyle: LineStyle(color: getColor("Release")),
            ),
          ),
        ],
      ),
    );
  }
}
