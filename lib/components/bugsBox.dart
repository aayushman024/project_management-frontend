import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api/models/getBugs.dart';

class BugsBox extends StatefulWidget {
  final Bugs bug;
  final int bugIndex;

  BugsBox({required this.bug, required this.bugIndex});

  @override
  State<BugsBox> createState() => _BugsBoxState();
}

class _BugsBoxState extends State<BugsBox> {
  late bool isResolved;

  @override
  void initState() {
    super.initState();
    isResolved = widget.bug.isResolved ?? false;
  }

  Future<void> updateBugStatus(bool resolve) async {
    final String apiUrl = "http://10.131.213.166:8080/api/bugs/${widget.bug.id}/";

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'bug_description': widget.bug.bugDescription,
          'is_resolved': resolve,
          'posted_by': widget.bug.postedBy,
          'project': widget.bug.project,
          'user': 1,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          isResolved = resolve;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.05,
              horizontal: MediaQuery.of(context).size.width * 0.1,
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Text(
              resolve ? 'Bug marked as resolved' : 'Bug marked as unresolved',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            backgroundColor: resolve ? Colors.green : Colors.orange,
            duration: Duration(seconds: 4),
          ),
        );
      } else {
        throw Exception('Failed to update bug status: ${response.statusCode}');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: $error',
            style: GoogleFonts.lato(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        width: screenWidth * 0.85,
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
                        'Bug #${widget.bugIndex}',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 5),
                      if (isResolved) Icon(Icons.check_circle, color: Colors.green, size: 20),
                    ],
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'Resolve') {
                        updateBugStatus(true);
                      } else if (value == 'Unresolve') {
                        updateBugStatus(false);
                      }
                    },
                    itemBuilder: (context) => [
                      if (!isResolved)
                        const PopupMenuItem(
                          value: 'Resolve',
                          child: Text('Mark as Resolved'),
                        ),
                      if (isResolved)
                        const PopupMenuItem(
                          value: 'Unresolve',
                          child: Text('Mark as Unresolved'),
                        ),
                    ],
                    icon: Icon(Icons.more_vert, color: Colors.black, size: 20),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                widget.bug.bugDescription ?? 'No description available.',
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
                  '${widget.bug.postedBy ?? 'Unknown'}, ${widget.bug.postingTime ?? 'Unknown date'}',
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
