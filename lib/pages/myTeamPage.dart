// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_management_system/components/employeeCard.dart';

import '../components/customAppDrawer.dart';
import 'loginPage.dart';

class MyTeamPage extends StatefulWidget {
  const MyTeamPage({super.key});

  @override
  State<MyTeamPage> createState() => _MyTeamPageState();
}

class _MyTeamPageState extends State<MyTeamPage> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color(0xffFDFDFD),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text('My Team',
            style: GoogleFonts.lato(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),),
          backgroundColor: Color(0xff282828),
          actions: [
            Padding(
              padding: const EdgeInsets.all(6),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Text(
                    'Innovation & Performance, Plot-25, GGN, IN',
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                  },
                  icon: Icon(
                    Icons.logout_rounded,
                    size: screenHeight * 0.025,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        drawer: CustomAppDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      EmployeeCard(
                        empColor: Color(0xff203351),
                          empName: 'Shiv Sahu',
                          empDesig: 'ON Care Innovation and Performance Lead',
                      ),
                      EmployeeCard(
                        empColor: Color(0xff203351),
                        empName: 'Niraj Garg',
                        empDesig: 'ON Care Innovation and Performance Expert',
                      ),
                      EmployeeCard(
                        empColor: Color(0xff203351),
                        empName: 'Siddharth Dinodia',
                        empDesig: 'ON Care Innovation and Performance Expert',
                      ),
                      EmployeeCard(
                        empColor: Color(0xff203351),
                        empName: 'Anil Prajapati',
                        empDesig: 'Automation Expert',
                      ),
                      EmployeeCard(
                        empColor: Color(0xff203351),
                        empName: 'Tony Ravindran',
                        empDesig: 'ON Care Innovation and Performance Expert',
                      ),
                      SizedBox(height: screenHeight*0.6,)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      EmployeeCard(
                        empColor: Color(0xffDFECFF),
                        empName: 'Aayushman Ranjan',
                        empTextColor: Colors.black,
                        empDesig: 'Mobile App Developer Intern',
                      ),
                      EmployeeCard(
                        empColor: Color(0xffDFECFF),
                        empName: 'Rishabh Sharma',
                        empTextColor: Colors.black,
                        empDesig: 'Mobile App Developer Intern',
                      ),
                      EmployeeCard(
                        empColor: Color(0xffDFECFF),
                        empName: 'Kashish Mittal',
                        empTextColor: Colors.black,
                        empDesig: 'Backend Developer Intern',
                      ),
                      EmployeeCard(
                        empColor: Color(0xffDFECFF),
                        empName: 'Tejasvita Jaini',
                        empTextColor: Colors.black,
                        empDesig: 'Backend Developer Intern',
                      ),
                      EmployeeCard(
                        empColor: Color(0xffDFECFF),
                        empName: 'Khushi Sharma',
                        empTextColor: Colors.black,
                        empDesig: 'Automation Intern',
                      ),
                      EmployeeCard(
                        empColor: Color(0xffDFECFF),
                        empName: 'Yuvraj S. Tanwar',
                        empTextColor: Colors.black,
                        empDesig: 'Backend Developer Intern',
                      ),
                      EmployeeCard(
                        empColor: Color(0xffDFECFF),
                        empName: 'Vansh Chaudhary',
                        empTextColor: Colors.black,
                        empDesig: 'Frontend Developer Intern',
                      ),
                      EmployeeCard(
                        empColor: Color(0xffDFECFF),
                        empName: 'Reya Kumar',
                        empTextColor: Colors.black,
                        empDesig: 'Frontend Developer',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
