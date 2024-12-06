// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:project_management_system/components/customTextField.dart';
import 'package:project_management_system/components/selectableButtons.dart';
import 'package:project_management_system/controllers/controllers.dart';
import 'package:project_management_system/dialogBoxes/addFeature.dart';
import 'package:project_management_system/dialogBoxes/incorrectEffortDialog.dart';
import 'package:project_management_system/globals.dart';
import 'package:project_management_system/pages/homePage.dart';
import 'package:project_management_system/pages/myTeamPage.dart';

import '../components/customAppDrawer.dart';
import 'loginPage.dart';

class AddProjectPage extends StatefulWidget {
  const AddProjectPage({super.key});

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {

  String? selectedPriority;
  String? selectedLeader;
  String? selectedWeekDay;

  bool checkEfforts() {
    int researchEfforts = int.tryParse(researchEffortsController.text) ?? 0;
    int designEfforts = int.tryParse(designEffortsController.text) ?? 0;
    int developmentEfforts = int.tryParse(developmentEffortsController.text) ?? 0;
    int testingEfforts = int.tryParse(testingEffortsController.text) ?? 0;

    int totalEffortsInt = researchEfforts + designEfforts + developmentEfforts + testingEfforts;

    if (totalEffortsInt != 100) {
      showDialog(
        context: context,
        builder: (context) => IncorrectEffortDialog(),
      );
      return false;
    }
    return true;
  }

  void handleProjectAddition() {
    if (checkEfforts()) {
      projectAddedSuccessfully();
    }
  }

  void projectAddedSuccessfully(){
    showDialog(context: context, builder: (context)=> AlertDialog(
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          height: 80,
          child: Lottie.asset('/completedAnimation.json',
          width: 1,),
        ),
      ),
    content:  Text('Project Added Successfully!',
      style: GoogleFonts.lato(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),),),
    );
    Future.delayed(
      Duration(seconds: 2),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xffFDFDFD),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Add a Project',
          style: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
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
                child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MyTeamPage()));
                    },
                    child: Text(
                      'Innovation & Performance, Plot-25, GGN, IN',
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),),
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
      body: Padding(
        padding: const EdgeInsets.only(left: 40),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 60, left: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: projectNameController,
                          labelText: 'Project Name'),

                      CustomTextField(
                        controller: aboutProjectController,
                          labelText: 'About the Project'),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(10),
                                  focusColor: Colors.transparent,
                                  hint: Text(
                                    'Priority',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  value: selectedPriority,
                                  items: priority
                                      .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedPriority = newValue;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                  dropdownColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(10),
                                  focusColor: Colors.transparent,
                                  hint: Text(
                                    'Led By',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  value: selectedLeader,
                                  items: inpTeam
                                      .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedLeader = newValue;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                  dropdownColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(10),
                                  focusColor: Colors.transparent,
                                  hint: Text(
                                    'Weekly Review',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  value: selectedWeekDay,
                                  items: weeklyReview
                                      .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedWeekDay = newValue;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                  dropdownColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40, right: 30),
                          child: TextField(
                            controller: researchDateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              focusColor: Colors.grey,
                              suffixIcon: Icon(Icons.calendar_month),
                              hintText: 'Enter Research Deadline',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                            ),
                            onTap: () async {
                              DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                                builder: (context, child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      primaryColor: Colors.blue,
                                      hintColor: Colors.blue,
                                      colorScheme: ColorScheme.light(
                                        primary: Colors.blue,
                                        onPrimary: Colors.white,
                                        onSurface: Colors.black,
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (selectedDate != null) {
                                researchDateController.text = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                              }
                            },
                          ),
                        ),
                      ),
                     Expanded(
                       child: CustomTextField(
                         controller: researchEffortsController,
                         suffixIcon: Icon(Icons.percent_rounded),
                           hintText: '(0-100%)',
                           labelText: 'Research Efforts'),
                     )
                    ],
                  ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 40, right: 30),
                              child: TextField(
                                controller: designDateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  focusColor: Colors.grey,
                                  suffixIcon: Icon(Icons.calendar_month),
                                  hintText: 'Enter Design Deadline',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                ),
                                onTap: () async {
                                  DateTime? selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                    builder: (context, child) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                          primaryColor: Colors.blue,
                                          hintColor: Colors.blue,
                                          colorScheme: ColorScheme.light(
                                            primary: Colors.blue,
                                            onPrimary: Colors.white,
                                            onSurface: Colors.black,
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.blue,
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (selectedDate != null) {
                                    designDateController.text = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                                  }
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: CustomTextField(
                              controller: designEffortsController,
                                suffixIcon: Icon(Icons.percent_rounded),
                                hintText: '(0-100%)',
                                labelText: 'Design Efforts'),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 40, right: 30),
                              child: TextField(
                                controller: developmentDateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  focusColor: Colors.grey,
                                  suffixIcon: Icon(Icons.calendar_month),
                                  hintText: 'Enter Development Deadline',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                ),
                                onTap: () async {
                                  DateTime? selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                    builder: (context, child) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                          primaryColor: Colors.blue,
                                          hintColor: Colors.blue,
                                          colorScheme: ColorScheme.light(
                                            primary: Colors.blue,
                                            onPrimary: Colors.white,
                                            onSurface: Colors.black,
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.blue,
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (selectedDate != null) {
                                    developmentDateController.text = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                                  }
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: CustomTextField(
                              controller: developmentEffortsController,
                                suffixIcon: Icon(Icons.percent_rounded),
                                hintText: '(0-100%)',
                                labelText: 'Development Efforts'),
                          )
                        ],
                      ),
                  Row(
                    children: [
                      Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 40, right: 30),
                        child: TextField(
                          controller: testingDateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            focusColor: Colors.grey,
                            suffixIcon: Icon(Icons.calendar_month),
                            hintText: 'Enter Testing Deadline',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                              builder: (context, child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    primaryColor: Colors.blue,
                                    hintColor: Colors.blue,
                                    colorScheme: ColorScheme.light(
                                      primary: Colors.blue,
                                      onPrimary: Colors.white,
                                      onSurface: Colors.black,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (selectedDate != null) {
                              testingDateController.text = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                            }
                          },
                        ),
                      ),
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: testingEffortsController,
                            suffixIcon: Icon(Icons.percent_rounded),
                            hintText: '(0-100%)',
                            labelText: 'Testing Efforts'),
                      )
                    ],
                  ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: TextField(
                          controller: releaseDateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            focusColor: Colors.grey,
                            suffixIcon: Icon(Icons.calendar_month),
                            hintText: 'Enter Release Date',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                              builder: (context, child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    primaryColor: Colors.blue,
                                    hintColor: Colors.blue,
                                    colorScheme: ColorScheme.light(
                                      primary: Colors.blue,
                                      onPrimary: Colors.white,
                                      onSurface: Colors.black,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (selectedDate != null) {
                              releaseDateController.text = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                            }
                          },
                        ),
                      ),

                  Text('Assign People :',
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                      ),),

                      SelectableChips(),

                      SizedBox(height: screenHeight*0.1,),

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(Color(0xff0098FF))
                            ),
                              onPressed: (){
                              handleProjectAddition();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: Text('Add Project',
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
                                ),),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff252525),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 20,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    width: screenWidth * 0.45,
                  ),
                  Image.asset(
                    '/newProj.jpg',
                    width: screenWidth * 0.45,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      );
  }
}