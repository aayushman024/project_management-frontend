// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_management_system/components/barGraph.dart';
import 'package:project_management_system/components/dashboardCard.dart';
import 'package:project_management_system/components/peopleProjectsCard.dart';
import 'package:project_management_system/components/projectCard.dart';
import 'package:project_management_system/components/customAppDrawer.dart';
import 'package:project_management_system/components/projectPeopleCard.dart';
import 'package:project_management_system/fontStyle.dart';
import 'package:project_management_system/pages/empSelectorProgress.dart';
import 'package:project_management_system/pages/loginPage.dart';
import 'package:project_management_system/pages/progressPage.dart';
import 'package:project_management_system/pages/projectDetailPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../api/models/getAllProjects.dart';
import '../api/apis.dart';
import '../components/projectsTimeline.dart';
import '../globals.dart';
import 'myTeamPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GetAllProjects> allProjects = [];
  List<GetAllProjects> filteredProjects = [];
  TextEditingController searchController = TextEditingController();

  bool isHigh = false;
  bool isMedium = false;
  bool isLow = false;

  @override
  void initState() {
    super.initState();
    fetchAndSetProjects();
    fetchUserDetails();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    // Remove all saved data
    await prefs.remove('accessToken');
    await prefs.remove('isLoggedIn');
    await prefs.remove('userId');
    await prefs.remove('username');
    await prefs.remove('userGroups');

    // Navigate to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Future<void> fetchAndSetProjects() async {
    try {
      List<GetAllProjects> projects = await fetchAllProjects();

      List<GetAllProjects> filteredProjectsList = projects.where((project) => project.completed == false).toList();

      setState(() {
        filteredProjectsList.sort((a, b) => b.releaseDate!.compareTo(a.releaseDate!));
        allProjects = filteredProjectsList;
        filteredProjects = filteredProjectsList;
      });
    } catch (e) {
      print('Error fetching projects: $e');
    }
  }

  void filterProjects(String query) {
    List<GetAllProjects> results = allProjects.where((project) {
      final nameMatch = project.projectName?.toLowerCase().contains(query.toLowerCase());
      final priorityMatch = (isHigh && project.priority == 'High') || (isMedium && project.priority == 'Medium') || (isLow && project.priority == 'Low');
      return nameMatch! && (priorityMatch || !(isHigh || isMedium || isLow));
    }).toList();

    setState(() {
      filteredProjects = results;
    });
  }

  Future<List<ProjectData>> fetchProjectData() async {
    try {
      final List<GetAllProjects> projects = await fetchAllProjects();
      final List<ProjectData> data = projects.where((project) => project.completed == false).map((project) {
        double completionPercentage = calculateCompletionPercentage(project);
        return ProjectData(
          project.projectName ?? 'Unnamed Project',
          completionPercentage,
        );
      }).toList();

      return data;
    } catch (e) {
      print('Error fetching project data: $e');
      return [];
    }
  }

  double calculateCompletionPercentage(GetAllProjects project) {
    final efforts = {
      "Null": '0',
      "Research": project.researchEffort,
      "Design": project.designEffort,
      "Development": project.developmentEffort,
      "Testing": project.testingEffort,
    };

    double totalPercentage = 0.0;
    for (var milestone in efforts.keys) {
      totalPercentage += double.tryParse(efforts[milestone]?.replaceAll('%', '') ?? '0') ?? 0.0;
      if (milestone == project.currentMilestone) break;
    }
    return totalPercentage;
  }

  int getRemainingDays(String? releaseDate) {
    if (releaseDate == null || releaseDate.isEmpty) {
      return 0;
    }

    try {
      final DateFormat dateFormat = DateFormat("dd/MM/yyyy");
      final parsedDate = dateFormat.parse(releaseDate);
      final currentDate = DateTime.now();
      final difference = parsedDate.difference(currentDate).inDays;

      return difference >= 0 ? difference + 1 : 0;
    } catch (e) {
      return 0;
    }
  }

  Future<void> fetchUserDetails() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedUserId = prefs.getInt('userId');

      if (storedUserId == null) {
        throw Exception("User ID is not available in shared preferences");
      }

      final response = await http.get(
        Uri.parse('http://10.131.213.166:8080/api/individuals/$storedUserId/'),
        headers: {
          'Authorization': 'Token ${prefs.getString('accessToken')}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          userId = data['id'];
          userName = data['name'];
          userRole = data['role'];
        });
      } else {
        throw Exception('Failed to fetch user details: ${response.body}');
      }
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

  String formatDate(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) {
      return "N/A";
    }
    try {
      DateTime utcDate = DateTime.parse(dateTime).toLocal();
      return DateFormat('dd/MM/yyyy').format(utcDate);
    } catch (e) {
      print('Error parsing date: $e');
      return "Invalid Date";
    }
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
          'Welcome, $userName',
          style: AppTextStyles.bold(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Color(0xff282828),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => userRole == 'Intern'
                          ? ProgressPage(
                              userID: userId,
                              username: userName,
                            )
                          : EmployeeSelectorProgress()));
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xffD9D9D9)),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            ),
            child: Text('View Daily Progress', style: AppTextStyles.regular(fontSize: 14, color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyTeamPage()));
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color(0xffD9D9D9)),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
              child: Text('Innovation & Performance, APAC - India', style: AppTextStyles.regular(fontSize: 14, color: Colors.black)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: IconButton(
              tooltip: 'Logout',
              onPressed: logout,
              icon: Icon(
                Icons.logout_rounded,
                size: screenHeight * 0.035,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      drawer: CustomAppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(40, 30, 40, 30),
        child: Column(
          children: [
            if (userRole == 'Manager' || userRole == 'Senior Specialist') ProjectsTimeline(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Parent column for projects
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Divider(
                              color: Colors.black,
                              thickness: 1,
                              endIndent: 10,
                            ),
                          ),
                          Text(' ONGOING PROJECTS      ', style: AppTextStyles.bold(fontSize: 20, color: Colors.black)),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: TextField(
                                  onChanged: filterProjects,
                                  cursorColor: Colors.white30,
                                  controller: searchController,
                                  maxLines: null,
                                  autofocus: false,
                                  keyboardType: TextInputType.name,
                                  style: GoogleFonts.lato(color: Colors.black, fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.search_rounded,
                                      color: Colors.black54,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black), borderRadius: BorderRadius.circular(20)),
                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.black, width: 2)),
                                    label: Text(
                                      'Search Ongoing Projects',
                                      style: GoogleFonts.lato(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: ExpansionTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '   Priority    ',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Icon(
                                      Icons.filter_list,
                                      color: Colors.black,
                                      size: screenHeight * 0.024,
                                    ),
                                  ],
                                ),
                                collapsedIconColor: Colors.black,
                                iconColor: Colors.black,
                                collapsedBackgroundColor: Color(0xffF0F0F0),
                                backgroundColor: Color(0xffD9D9D9),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                childrenPadding: EdgeInsets.all(10),
                                children: [
                                  CheckboxListTile(
                                    dense: true,
                                    activeColor: Colors.black,
                                    checkColor: Colors.white,
                                    checkboxShape: CircleBorder(),
                                    title: Text(
                                      'High',
                                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                                    ),
                                    value: isHigh,
                                    onChanged: (value) {
                                      setState(() {
                                        isHigh = value ?? false;
                                        filterProjects(searchController.text);
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    dense: true,
                                    activeColor: Colors.black,
                                    checkColor: Colors.white,
                                    checkboxShape: CircleBorder(),
                                    title: Text(
                                      'Medium',
                                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                                    ),
                                    value: isMedium,
                                    onChanged: (value) {
                                      setState(() {
                                        isMedium = value ?? false;
                                        filterProjects(searchController.text);
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    dense: true,
                                    activeColor: Colors.black,
                                    checkColor: Colors.white,
                                    checkboxShape: CircleBorder(),
                                    title: Text(
                                      'Low',
                                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                                    ),
                                    value: isLow,
                                    onChanged: (value) {
                                      setState(() {
                                        isLow = value ?? false;
                                        filterProjects(searchController.text);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      FutureBuilder<List<GetAllProjects>>(
                        future: fetchAllProjects(),
                        builder: (context, snapshot) {
                          // Loading state
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(color: Colors.blue),
                            );
                          }
                          // Error state
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Error fetching projects: ${snapshot.error}',
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                          }
                          // Data loaded state
                          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            final List<GetAllProjects> projects = snapshot.data!;
                            final filteredProjects = projects.where((project) {
                              final nameMatch = project.projectName?.toLowerCase().contains(searchController.text.toLowerCase()) ?? false;
                              final priorityMatch = (isHigh && project.priority == 'High') || (isMedium && project.priority == 'Medium') || (isLow && project.priority == 'Low');
                              final notCompleted = project.completed == false;

                              return nameMatch && (priorityMatch || !(isHigh || isMedium || isLow)) && notCompleted;
                            }).toList();

                            filteredProjects.sort((a, b) {
                              bool aIsAssigned = a.assignedTo!.contains(userName);
                              bool bIsAssigned = b.assignedTo!.contains(userName);
                              if (aIsAssigned && !bIsAssigned) {
                                return -1;
                              } else if (!aIsAssigned && bIsAssigned) {
                                return 1;
                              } else {
                                return b.lastUpdate!.compareTo(a.lastUpdate!);
                              }
                            });

                            return Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: filteredProjects.map((project) {
                                // Calculate completion percentage
                                double calculateCompletionPercentage(GetAllProjects project) {
                                  final efforts = {
                                    "Null": '0',
                                    "Research": project.researchEffort,
                                    "Design": project.designEffort,
                                    "Development": project.developmentEffort,
                                    "Testing": project.testingEffort,
                                  };

                                  double totalPercentage = 0.0;
                                  for (var milestone in efforts.keys) {
                                    totalPercentage += double.tryParse(efforts[milestone]?.replaceAll('%', '') ?? '0') ?? 0.0;
                                    if (milestone == project.currentMilestone) break;
                                  }
                                  return totalPercentage;
                                }
                                final totalPercentage = calculateCompletionPercentage(project);
                                final userFeedback = project.openFeedbackByPerson?.firstWhere(
                                      (feedback) => feedback.user == userName,
                                  orElse: () => OpenFeedbackByPerson(user: userName, count: 0),
                                );

                                return MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => ProjectDetail(
                                            projects: project,
                                            completionPercentage: totalPercentage,
                                            currentMilestone: project.currentMilestone!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Stack(
                                        children: [
                                ProjectCard(
                                        onTap: () {},
                                        daysLeft: getRemainingDays(project.releaseDate),
                                        lastUpdated: formatDate(project.lastUpdate),
                                        projectName: project.projectName,
                                        description: project.description,
                                        priority: project.priority,
                                        ledBy: project.ledBy,
                                        review: project.review,
                                        researchDeadline: project.researchDeadline,
                                        researchEffort: project.researchEffort,
                                        designDeadline: project.designDeadline,
                                        designEffort: project.designEffort,
                                        developmentDeadline: project.developmentDeadline,
                                        developmentEffort: project.developmentEffort,
                                        testingDeadline: project.testingDeadline,
                                        testingEffort: project.testingEffort,
                                        assignedBy: project.assignedBy,
                                        assignedTo: project.assignedTo,
                                        currentMilestone: project.currentMilestone,
                                        completionPercentage: totalPercentage,
                                        releaseDate: project.releaseDate,
                                      ),
                                          if (userFeedback?.count != null && userFeedback!.count! > 0)
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Tooltip(
                                                message: 'Your Open Feedbacks on this Project',
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.red,
                                                  radius: 14,
                                                  child: Text(
                                                    userFeedback.count.toString(),
                                                    style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ]),
                                  ),
                                );
                              }).toList(),
                            );
                          }

                          // No data state
                          return Center(
                            child: Text(
                              'No projects available',
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                // Column for Quick Insights
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('            QUICK INSIGHTS', style: AppTextStyles.bold(fontSize: 20, color: Colors.black)),
                          Flexible(
                            child: Divider(
                              color: Colors.black,
                              thickness: 1,
                              indent: 10,
                            ),
                          ),
                        ],
                      ),
                      DashboardCarousel(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                        child: BarGraph(
                          fetchProjectData: fetchProjectData(),
                        ),
                      ),
                      if (userRole == 'Intern')
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: ProjectPeopleCard(),
                        ),
                      if (userRole == 'Manager' || userRole == 'Senior Specialist') PeopleProjectsCard(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
