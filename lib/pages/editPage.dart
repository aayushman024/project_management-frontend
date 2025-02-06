// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:project_management_system/pages/projectDetailPage.dart';

import '../api/apis.dart';
import '../api/models/getAllProjects.dart';
import '../components/customAppDrawer.dart';
import '../components/customTextField.dart';
import '../components/selectableButtons.dart';
import '../controllers/controllers.dart';
import '../dialogBoxes/incorrectEffortDialog.dart';
import '../globals.dart';
import 'homePage.dart';
import 'loginPage.dart';
import 'myTeamPage.dart';

class EditPage extends StatefulWidget {
  final GetAllProjects projects;
  final currentMilestone;

  EditPage({
    required this.projects,
    this.currentMilestone,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override

  @override
  void initState() {
    super.initState();
    selectedPriority = widget.projects.priority ?? 'High';
    selectedWeekDay = widget.projects.review ?? 'Monday';
    selectedLeader = widget.projects.ledBy ?? '';
    selectedNames = widget.projects.assignedTo?.split(', ') ??  [];
    currentMilestone = widget.currentMilestone;
    projectNameController.text = widget.projects.projectName ?? '';
    aboutProjectController.text = widget.projects.description ?? '';
    researchEffortsController.text = widget.projects.researchEffort?.toString() ?? '';
    designEffortsController.text = widget.projects.designEffort?.toString() ?? '';
    developmentEffortsController.text = widget.projects.developmentEffort?.toString() ?? '';
    testingEffortsController.text = widget.projects.testingEffort?.toString() ?? '';
    researchDateController.text = widget.projects.researchDeadline ?? '';
    designDateController.text = widget.projects.designDeadline ?? '';
    developmentDateController.text = widget.projects.developmentDeadline ?? '';
    testingDateController.text = widget.projects.testingDeadline ?? '';
    releaseDateController.text = widget.projects.releaseDate ?? '';
    projectURLController.text = widget.projects.projectURL ?? '';
  }

  void handleProjectAddition() {
    if (!validateFields()) {
      return;
    }
    updateProject(widget.projects.id!);
    projectAddedSuccessfully();
    resetTextFields();
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
    projectURLController.clear();
    selectedNames.clear();
      selectedLeader = null;
      selectedWeekDay = null;
      selectedPriority = null;
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
          'Project Edited Successfully!',
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
          'Edit ${widget.projects.projectName} Project',
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
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 60, left: 100, right: 100, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
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
                              'Update Current Milestone',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            value: currentMilestone,
                            items: milestones
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
                                currentMilestone = newValue;
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
                    CustomTextField(labelText: 'Project URL', controller: projectURLController),
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
                                label: Text('Research Deadline'),
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
                                label: Text('Design Deadline'),
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
                                label: Text('Development Deadline'),
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
                                label: Text('Testing Deadline'),
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
                                label: Text('Release Date'),
                                focusColor: Colors.grey,
                                suffixIcon: Icon(Icons.calendar_month),
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
                      'Edit Assigned People :',
                      style: GoogleFonts.lato(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    SelectableChips(),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
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
                                'Edit ${widget.projects.projectName} Project',
                                style: GoogleFonts.lato(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 40),
            //   child: Stack(
            //     alignment: Alignment.center,
            //     children: [
            //       Container(
            //         decoration: BoxDecoration(
            //           color: Color(0xff252525),
            //           borderRadius: BorderRadius.circular(10),
            //           boxShadow: [
            //             BoxShadow(
            //               color: Colors.black.withOpacity(0.5),
            //               spreadRadius: 2,
            //               blurRadius: 20,
            //               offset: Offset(0, 4),
            //             ),
            //           ],
            //         ),
            //         width: screenWidth * 0.45,
            //       ),
            //       Image.asset(
            //         '/newProj.jpg',
            //         width: screenWidth * 0.45,
            //         height: double.infinity,
            //         fit: BoxFit.cover,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
