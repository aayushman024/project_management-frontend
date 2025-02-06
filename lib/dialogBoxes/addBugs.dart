// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddBugs extends StatefulWidget {

  final projectID;
  final VoidCallback onBugAdded;

  const AddBugs({
    required this.projectID,
    required this.onBugAdded,
  });

  @override
  State<AddBugs> createState() => _AddBugsState();
}

class _AddBugsState extends State<AddBugs> {
  final TextEditingController _bugController = TextEditingController();

  Future<void> postBugReport({
    required String bugDescription,
    required String postedBy,
    required bool isResolved,
    required int userId,
    required int projectId,
    required String apiBaseURL,
  }) async {
    final url = Uri.parse('$apiBaseURL/api/bugs/');

    final body = {
      "bug_description": bugDescription,
      "is_resolved": isResolved,
      "posted_by": postedBy,
      "user": userId,
      "project": projectId,
    };

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      widget.onBugAdded();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Bug reported successfully!',
            style: GoogleFonts.lato(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 4),
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to report bug: ${response.body}',
            style: GoogleFonts.lato(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 4),
        ),
      );
    }
  }

  void _submitBug() async {
    if (_bugController.text.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      String? username = prefs.getString('username');
      await postBugReport(
        bugDescription: _bugController.text,
        postedBy: username!,
        isResolved: false,
        userId: 1,
        projectId: widget.projectID,
        apiBaseURL: 'http://10.131.213.166:8080',
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Bug description cannot be empty!',
            style: GoogleFonts.lato(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'Report a Bug',
        style: GoogleFonts.lato(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: TextField(
        minLines: 3,
        maxLines: null,
        autofocus: true,
        onSubmitted: (value) => _submitBug(),
        controller: _bugController,
        decoration: InputDecoration(hintText: 'Type your bug here...'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: GoogleFonts.lato(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: _submitBug,
          child: Text(
            'Report',
            style: GoogleFonts.lato(color: Colors.red),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _bugController.dispose();
    super.dispose();
  }
}
