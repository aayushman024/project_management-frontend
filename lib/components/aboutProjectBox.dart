import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutProject extends StatefulWidget {
  const AboutProject({super.key});

  @override
  State<AboutProject> createState() => _AboutProjectState();
}

class _AboutProjectState extends State<AboutProject> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 90),
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
            'sTSI or Simplified Technical Support Interface is a network automation tool which enables technical support engineers to remotely perform log collection & health check. Furthermore, it acts as an information repository comprising of plans of action & troubleshooting guides for network alarms with compilation of knowledge base articles & optical specifications. With features like logs parsing & network alarms analysis, sTSI improves the TSE\'s performance with its innovative approach.',
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
                text: 'Rishabh Sharma, Reya Kumar, Vansh Chaudhary, Kashish Mittal',
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
                  text: 'Nitesh Verma',
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
                text: 'Medium',
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
                  text: '10/10/2024',
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
                text: 'Anil Kr. Prajapati',
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
