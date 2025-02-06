// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailContainer extends StatelessWidget {
  final String priority;
  final String lastUpdated;
  final String ledBy;
  final int untilRelease;
  final String dateAssigned;
  final String weeklyReview;
  final String about;
  final String assignedTo;
  final String assignedBy;

  const DetailContainer({
    required this.priority,
    required this.about,
    required this.lastUpdated,
    required this.ledBy,
    required this.untilRelease,
    required this.dateAssigned,
    required this.weeklyReview,
    required this.assignedTo,
    required this.assignedBy,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ABOUT THE PROJECT',
            style: GoogleFonts.lato(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              about,
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ),
          _buildInfoRow('Priority', priority, 'Last Updated', lastUpdated),
          _buildInfoRow('Led By', ledBy, 'Days Until Release', '$untilRelease days'),
          _buildInfoRow('Date Assigned', dateAssigned, 'Weekly Review', weeklyReview),
          _buildInfoRow('Assigned To', assignedTo, 'Assigned By', assignedBy),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label1, String value1, String label2, String value2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: _buildInfoTile(label1, value1),
          ),
          SizedBox(width: 20),
          Flexible(
            child: _buildInfoTile(label2, value2),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: Colors.black,
          size: 6,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            '$label: $value',
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
