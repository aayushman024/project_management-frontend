import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:project_management_system/api/apis.dart';
import 'package:project_management_system/dialogBoxes/addComment.dart';
import 'dart:convert';
import '../api/models/getFeedbacks.dart';
import '../dialogBoxes/editFeature.dart';
import '../fontStyle.dart';

class FeatureBox extends StatefulWidget {
  final Feedbacks feature;
  final int feedbackID;
  final String? allPeople;

  const FeatureBox({super.key, required this.feature, required this.feedbackID, required this.allPeople});

  @override
  State<FeatureBox> createState() => _FeatureBoxState();
}

class _FeatureBoxState extends State<FeatureBox> {
  late bool isResolved;
  late bool isBug;

  @override
  void initState() {
    super.initState();
    isResolved = widget.feature.isAdded ?? false;
    isBug = widget.feature.isBug ?? false;
  }

  Future<void> updateFeatureStatus(bool resolve) async {
    final String apiUrl = "http://10.131.213.166:8080/api/feedback/${widget.feature.id}/";

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'feedback_description': widget.feature.feedbackDescription,
          'is_added': resolve,
          'is_bug': widget.feature.isBug,
          'posted_by': widget.feature.postedBy,
          'user': 1,
          'project': widget.feature.project,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          isResolved = resolve;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Text(
              resolve ? 'Feedback marked as completed, kindly refresh to reflect the changes' : 'Feedback marked as not completed, kindly refresh to reflect the changes',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            backgroundColor: resolve ? Colors.green : Colors.orange,
            duration: const Duration(seconds: 4),
          ),
        );
      } else {
        throw Exception('Failed to update feedback status: ${response.statusCode}');
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

  void openEditFeatureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditFeature(
          allPeople: widget.allPeople,
          projectID: widget.feature.project!,
          feature: widget.feature,
          assignedPeople: widget.feature.assignedTo,
          onFeatureAdded: () async {
            // Fetch the updated feedback data
            await fetchFeedbacks(widget.feature.project!);
            if (mounted) {
              setState(() {});
            }
          },
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
      DateTime istDate = utcDate.add(const Duration(hours: 5, minutes: 30));

      return DateFormat('dd/MM/yyyy, hh:mm a').format(istDate);
    } catch (e) {
      print('Error parsing date: $e');
      return "Invalid Date";
    }
  }

  void openAddCommentDialog() {
    showDialog(
        context: context,
        builder: (context) => AddComment(
              feedbackId: widget.feature.id!,
              refreshComments: () {
                setState(() {
                  fetchFeedbacks(widget.feature.project!);
                });
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        width: screenWidth * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffD9D9D9),
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
                        'Feedback #${widget.feedbackID}',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (widget.feature.isAdded == true || widget.feature.isBug == true)
                        Container(
                          width: 1,
                          height: 16,
                          color: Colors.black54,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                      if (widget.feature.isAdded == true)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Added',
                                style: AppTextStyles.bold(
                                  fontSize: 12,
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(width: 10),
                      if (widget.feature.isBug == true)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 20,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Marked as Bug',
                                style: AppTextStyles.bold(
                                  fontSize: 12,
                                  color: Colors.red.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  PopupMenuButton<String>(
                    color: Colors.white,
                    onSelected: (value) {
                      if (value == 'Completed') {
                        updateFeatureStatus(true);
                      } else if (value == 'Not Completed') {
                        updateFeatureStatus(false);
                      } else if (value == 'Edit') {
                        openEditFeatureDialog();
                      } else if (value == 'Add Comment') {
                        openAddCommentDialog();
                      }
                    },
                    itemBuilder: (context) => [
                      if (!isResolved)
                        const PopupMenuItem(
                          value: 'Completed',
                          child: Text('Mark as Completed'),
                        ),
                      if (isResolved)
                        const PopupMenuItem(
                          value: 'Not Completed',
                          child: Text('Mark as Not Completed'),
                        ),
                      const PopupMenuItem(
                        value: 'Edit',
                        child: Text('Edit Feedback'),
                      ),
                      const PopupMenuItem(
                        value: 'Add Comment',
                        child: Text('Add Comment'),
                      ),
                    ],
                    icon: const Icon(Icons.more_vert, color: Colors.black, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                widget.feature.feedbackDescription ?? '',
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Assigned To :',
                        style: AppTextStyles.bold(fontSize: 12, color: Colors.blue),
                      ),
                      Text(
                        (widget.feature.assignedTo != null && widget.feature.assignedTo!.isNotEmpty) ? widget.feature.assignedTo! : 'Not Yet Assigned',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.account_circle,
                            color: Colors.black54,
                            size: 15,
                          ),
                          Text(
                            '    ${widget.feature.postedBy},'
                            '\n    ${formatDate(widget.feature.postingTime)}',
                            style: GoogleFonts.lato(
                              color: Colors.black54,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            Text(
                              (widget.feature.reportedBy != null && widget.feature.reportedBy!.isNotEmpty) ? '           Reported By : ${widget.feature.reportedBy}' : '',
                              style: GoogleFonts.lato(
                                color: Colors.black54,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              if (widget.feature.comments != null && widget.feature.comments!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Comments :',
                    style: AppTextStyles.bold(fontSize: 12, color: Colors.indigo),
                  ),
                ),
              if (widget.feature.comments != null && widget.feature.comments!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.feature.comments!.map((comment) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffc2c1c0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment.content ?? '',
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.account_circle_outlined,
                                  color: Colors.black54,
                                  size: 15,
                                ),
                                Text(
                                  '   ${comment.postedBy}, ${formatDate(comment.postingTime)}',
                                  style: GoogleFonts.lato(
                                    color: Colors.black54,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
