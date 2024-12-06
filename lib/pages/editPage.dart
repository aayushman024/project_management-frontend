// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:project_management_system/pages/projectDetailPage.dart';

import '../components/customAppDrawer.dart';
import '../components/customTextField.dart';
import '../components/selectableButtons.dart';
import '../controllers/controllers.dart';
import '../globals.dart';
import 'loginPage.dart';
import 'myTeamPage.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override

  String? selectedPriority;
  String? selectedLeader;
  String? selectedWeekDay;
  String? currentMilestone;

  void projectEditedSuccessfully(){
    showDialog(context: context, builder: (context)=> AlertDialog(
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          height: 80,
          child: Lottie.asset('/completedAnimation.json',
            ),
        ),
      ),
      content:  Text('Project Edited Successfully!',
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
        MaterialPageRoute(builder: (context) => ProjectDetail()),
      ),
    );
  }

  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xffFDFDFD),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Edit Project',
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
                    ),)
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
                          controller: latestUpdateController,
                          labelText: 'Enter Latest Update'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
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
                                'Update Timeline Milestone',
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
                              )).toList(),

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
                      CustomTextField(
                          controller: projectNameController,
                          labelText: 'Edit Project Name'),
                      CustomTextField(
                          controller: aboutProjectController,
                          labelText: 'Edit About the Project'),
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
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  focusColor: Colors.transparent,
                                  hint: Text(
                                    'Change Priority',
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
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  focusColor: Colors.transparent,
                                  hint: Text(
                                    'Change Led By',
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
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  focusColor: Colors.transparent,
                                  hint: Text(
                                    'Edit Weekly Review',
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
                                  hintText: 'Edit Research Deadline',
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
                                labelText: 'Edit Research Efforts'),
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
                                  hintText: 'Edit Design Deadline',
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
                                labelText: 'Edit Design Efforts'),
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
                                  hintText: 'Edit Development Deadline',
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
                                labelText: 'Edit Development Efforts'),
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
                                  hintText: 'Edit Testing Deadline',
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
                                labelText: 'Edit Testing Efforts'),
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
                            hintText: 'Edit Release Date',
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

                      Text('Edit Assigned People :',
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
                                projectEditedSuccessfully();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: Text('Edit Project',
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
