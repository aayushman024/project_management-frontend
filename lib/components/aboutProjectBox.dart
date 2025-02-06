import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutProject extends StatefulWidget {

  final about;
  final peopleAssigned;
  final priority;
  final assignedBy;
  final ledBy;
  final dateAssigned;

  AboutProject({
    required this.ledBy,
    required this.priority,
    required this.dateAssigned,
    required this.assignedBy,
    required this.about,
    required this.peopleAssigned,
});

  @override
  State<AboutProject> createState() => _AboutProjectState();
}

class _AboutProjectState extends State<AboutProject> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 90),
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
          padding: const EdgeInsets.only(top: 25, bottom: 25),
          child: Text(
            widget.about,
            style: GoogleFonts.lato(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ),

        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Assigned to : ',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: widget.peopleAssigned,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Assigned by : ',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: widget.assignedBy,
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),

        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Priority : ',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: widget.priority,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Date Assigned : ',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: widget.dateAssigned,
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),

        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Led by : ',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: widget.ledBy,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
