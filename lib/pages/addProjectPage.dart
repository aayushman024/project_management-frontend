// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:project_management_system/api/apis.dart';
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

  void handleProjectAddition() {
    if (!validateFields()) {
      return;
    }
    createProject();
    projectAddedSuccessfully();
    resetTextFields();
  }

  @override
  void initState() {
    resetTextFields();
    super.initState();
  }

  bool validateFields() {
    if (projectNameController.text.isEmpty ||
        aboutProjectController.text.isEmpty ||
        researchEffortsController.text.isEmpty ||
        designEffortsController.text.isEmpty ||
        developmentEffortsController.text.isEmpty ||
        testingEffortsController.text.isEmpty ||
        researchDateController.text.isEmpty ||
        designDateController.text.isEmpty ||
        developmentDateController.text.isEmpty ||
        testingDateController.text.isEmpty ||
        releaseDateController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Incomplete Fields'),
          content: Text('Please fill out all fields before proceeding.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return false;
    }

    int researchEfforts = int.tryParse(researchEffortsController.text) ?? 0;
    int designEfforts = int.tryParse(designEffortsController.text) ?? 0;
    int developmentEfforts = int.tryParse(developmentEffortsController.text) ?? 0;
    int testingEfforts = int.tryParse(testingEffortsController.text) ?? 0;

    int totalEfforts = researchEfforts + designEfforts + developmentEfforts + testingEfforts;

    if (totalEfforts != 100) {
      showDialog(
        context: context,
        builder: (context) => IncorrectEffortDialog(),
      );
      return false;
    }

    return true;
  }

  void resetTextFields() {
    projectNameController.clear();
    aboutProjectController.clear();
    researchEffortsController.clear();
    designEffortsController.clear();
    developmentEffortsController.clear();
    testingEffortsController.clear();
    researchDateController.clear();
    designDateController.clear();
    developmentDateController.clear();
    testingDateController.clear();
    releaseDateController.clear();
    selectedNames.clear();
  }

  void projectAddedSuccessfully() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            height: 80,
            child: Lottie.asset(
              '/completedAnimation.json',
              width: 1,
            ),
          ),
        ),
        content: Text(
          'Project Added Successfully!',
          style: GoogleFonts.lato(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
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
      ),
      drawer: CustomAppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 70, right: 70),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                CustomTextField(controller: projectNameController, labelText: 'Project Name'),
                CustomTextField(controller: aboutProjectController, labelText: 'About the Project'),

                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20, right: 30),
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
                              researchDateController.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(controller: researchEffortsController, suffixIcon: Icon(Icons.percent_rounded), hintText: '(0-100%)', labelText: 'Research Efforts'),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20, left: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20),
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
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20, right: 30),
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
                              designDateController.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(controller: designEffortsController, suffixIcon: Icon(Icons.percent_rounded), hintText: '(0-100%)', labelText: 'Design Efforts'),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20, left: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20),
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
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20, right: 30),
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
                              developmentDateController.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(controller: developmentEffortsController, suffixIcon: Icon(Icons.percent_rounded), hintText: '(0-100%)', labelText: 'Development Efforts'),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20, left: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20),
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
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20, right: 30),
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
                              testingDateController.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(controller: testingEffortsController, suffixIcon: Icon(Icons.percent_rounded), hintText: '(0-100%)', labelText: 'Testing Efforts'),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20, left: 30),
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
                              releaseDateController.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Assign People :',
                  style: GoogleFonts.lato(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),
                ),
                SelectableChips(),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color(0xff0098FF))),
                        onPressed: () {
                          handleProjectAddition();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text(
                            'Add Project',
                            style: GoogleFonts.lato(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
