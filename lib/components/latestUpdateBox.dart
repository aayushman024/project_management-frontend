// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:project_management_system/api/apis.dart';
import 'package:project_management_system/fontStyle.dart';
import 'package:project_management_system/pages/projectProgressPage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LatestUpdate extends StatefulWidget {
  final int projectID;
  final latestUpdate;
  final dateTime;
  final postedBy;
  final projectName;
  final String? assignedTo;
  final VoidCallback onPosted;

  const LatestUpdate({
    Key? key,
    required this.projectID,
    required this.assignedTo,
    required this.projectName,
    required this.latestUpdate,
    required this.postedBy,
    required this.dateTime,
    required this.onPosted
  }) : super(key: key);

  @override
  State<LatestUpdate> createState() => _LatestUpdateState();
}

class _LatestUpdateState extends State<LatestUpdate> {

  // Method to post the latest update
  Future<void> postLatestUpdate(String updateText) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userID = prefs.getInt('userId');
    String? username = prefs.getString('username');

    if (userID == null) {
      print('User ID not found');
      return;
    }

    final url = 'http://10.131.213.166:8080/latest-update/';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'latest_update': updateText,
        'posted_by': username,
        'user': userID,
        'project': widget.projectID,
      }),
    );

    if (response.statusCode == 200) {
      print('Update posted successfully');
    } else {
      print('Failed to post update: ${response.statusCode}');
    }
  }

  // Method to show the dialog box
  void showUpdateDialog() {
    TextEditingController updateController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Latest Update'),
          content: TextField(
            maxLines: null,
           // expands: true,
            controller: updateController,
            decoration: InputDecoration(hintText: "Enter the update"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                String updateText = updateController.text.trim();
                if (updateText.isNotEmpty) {
                  postLatestUpdate(updateText);
                  Navigator.of(context).pop();
                  widget.onPosted();
                } else {

                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Text field is empty')),
                  );
                  print('Update text cannot be empty');
                  Navigator.of(context).pop();
                }
              },
              child: Text('Post Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }

  String formatDate(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) {
      return "N/A";
    }
    try {
      DateTime utcDate = DateTime.parse(dateTime).toUtc();
      DateTime istDate = utcDate.add(Duration(hours: 5, minutes: 30));

      return DateFormat('dd/MM/yyyy, hh:mm a').format(istDate);
    } catch (e) {
      print('Error parsing date: $e');
      return "Invalid Date";
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 5),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      width: screenWidth * 0.45,
      decoration: BoxDecoration(
        color: const Color(0xffDFECFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Latest Update',
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'Updated on: ${formatDate(widget.dateTime)}, By: ${widget.postedBy}',
            style: GoogleFonts.lato(
              color: Colors.black38,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: screenWidth*0.26,
                child: Text(
                  widget.latestUpdate,
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(side: BorderSide(width: 0.5, color: Colors.black), borderRadius: BorderRadius.circular(10)))
                ),
                onPressed: () {
                  showUpdateDialog();
                },
                child: Text('Post Update', style: GoogleFonts.lato(color: Colors.black),),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('View previous updates...',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    decorationThickness: 1,
                    decoration: TextDecoration.underline,)
                  ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> ProjectProgressPage(
                        assignedTo: widget.assignedTo,
                          projectID: widget.projectID,
                          projectName: widget.projectName)));
                    },
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      side: WidgetStateProperty.all(
                          const BorderSide(color: Color(0xff0098FF), width: 2)),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                      ),
                      backgroundColor:
                      WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.hovered)) {
                            return Colors.blue.shade100;
                          }
                          return Colors.white;
                        },
                      ),
                      foregroundColor:
                      WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.hovered)) {
                            return Colors.black;
                          }
                          return Colors.white;
                        },
                      ),
                    ),
                    child: Text('View Daily Progress',
                    style: AppTextStyles.regular(fontSize: 14, color: Colors.black),))
              ],
            ),
          )
        ],
      ),
    );
  }
}
