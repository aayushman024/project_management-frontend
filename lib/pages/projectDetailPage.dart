// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_management_system/api/apis.dart';
import 'package:project_management_system/api/models/getAllProjects.dart';
import 'package:project_management_system/components/aboutProjectBox.dart';
import 'package:project_management_system/components/bugsBox.dart';
import 'package:project_management_system/components/detailContainer.dart';
import 'package:project_management_system/components/latestUpdateBox.dart';
import 'package:project_management_system/components/timeline.dart';
import 'package:project_management_system/dialogBoxes/addBugs.dart';
import 'package:project_management_system/dialogBoxes/addFeature.dart';
import 'package:project_management_system/dialogBoxes/feedbacksAndBugs.dart';
import 'package:project_management_system/fontStyle.dart';
import 'package:project_management_system/pages/editPage.dart';
import 'package:project_management_system/pages/homePage.dart';
import 'package:project_management_system/pages/unassignedFeedbacks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../api/models/getBugs.dart';
import '../api/models/getDailyProgressOld.dart';
import '../api/models/getFeedbacks.dart';
import '../api/models/getLatestUpdate.dart';
import '../components/customAppDrawer.dart';
import '../components/featureBox.dart';
import '../components/previousUpdates.dart';
import '../globals.dart';
import 'loginPage.dart';
import 'myTeamPage.dart';

class ProjectDetail extends StatefulWidget {
  final GetAllProjects projects;
  final double completionPercentage;
  final String currentMilestone;

  ProjectDetail({
    required this.projects,
    required this.completionPercentage,
    required this.currentMilestone,
  });

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  late Future<List<Feedbacks>> feedbacksFuture;
  List<Feedbacks> filteredFeatures = [];
  late Future<getLatestUpdate> latestUpdateFuture;
  int unassignedFeedbacksCount = 0;

  @override
  void initState() {
    super.initState();
    feedbacksFuture = fetchFeedbacks(widget.projects.id!).then((features) {
      setState(() {
        filteredFeatures = features;
      });
      return features;
    });
    latestUpdateFuture = fetchLatestUpdates(widget.projects.id!);
    fetchFeedbacksCount(widget.projects.id!).then((count) {
      setState(() {
        unassignedFeedbacksCount = count;
      });
    });
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

  dynamic fetchProjectData() async {
    List<GetAllProjects> projects = await fetchAllProjects();
    return projects;
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

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(widget.projects.projectURL!);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
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

  // Add these to your widget's state class
  final TextEditingController searchController = TextEditingController();
  String? selectedStatus;

  void filterFeatures({
    required String searchQuery,
    required String? selectedStatus,
    required List<Feedbacks> features,
  }) {
    setState(() {
      filteredFeatures = features.where((feature) {
        final query = searchQuery.toLowerCase();

        final matchesDescription = searchQuery.isEmpty ||
            (feature.feedbackDescription?.toLowerCase().contains(query) ?? false);

        final matchesAssigned = searchQuery.isEmpty ||
            (feature.assignedTo?.toLowerCase().contains(query) ?? false);

        final matchesSearch = matchesDescription || matchesAssigned;

        final matchesStatus = selectedStatus == null ||
            (selectedStatus == 'added' && feature.isAdded == true) ||
            (selectedStatus == 'not_added' && feature.isAdded == false);

        return matchesSearch && matchesStatus;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SelectionArea(
      child: Scaffold(
        backgroundColor: Color(0xffFDFDFD),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Row(
            children: [
              Text(
                  (widget.projects.projectName != null && widget.projects.projectName!.length > 40)
                      ? '${widget.projects.projectName!.substring(0, 40)}...'
                      : (widget.projects.projectName ?? 'Unknown Project'),
                  style: AppTextStyles.bold(fontSize: 20, color: Colors.white)),
              if (widget.projects.assignedTo!.contains(userName) || userRole == 'Manager' || userRole == 'Senior Specialist')
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: IconButton(
                    tooltip: 'Edit',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPage(
                            projects: widget.projects,
                            currentMilestone: widget.currentMilestone,
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      size: screenHeight * 0.028,
                      color: Colors.white,
                    ),
                  ),
                ),
              if (widget.projects.projectURL != null)
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(side: BorderSide(width: 0.75, color: Colors.white), borderRadius: BorderRadius.circular(15)))),
                      onPressed: _launchURL,
                      child: Row(
                        children: [
                          Text(
                            'Try out this project  ',
                            style: AppTextStyles.regular(fontSize: 14, color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 10,
                          )
                        ],
                      )),
                )
            ],
          ),
          backgroundColor: Color(0xff282828),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: (context),
                      builder: (context) => FeedbacksAndBugs(
                            feedbacksFuture: feedbacksFuture,
                          ));
                },
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  side: WidgetStateProperty.all(const BorderSide(color: Color(0xff0098FF), width: 1)),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  ),
                  backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.hovered)) {
                        return Colors.white;
                      }
                      return Colors.transparent;
                    },
                  ),
                  foregroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.hovered)) {
                        return Colors.white;
                      }
                      return Colors.black;
                    },
                  ),
                ),
                child: Text('View Feedbacks & Bugs in Detail', style: AppTextStyles.regular(fontSize: 15, color: Colors.blue)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => UnassignedFeedbacks(
                                assignedPeople: widget.projects.assignedTo,
                                projectID: widget.projects.id!,
                              )));
                },
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: Colors.red, width: 1))),
                  backgroundColor: WidgetStatePropertyAll(Colors.black54),
                ),
                child: Row(
                  children: [
                    Text('Unassigned Feedbacks  ', style: AppTextStyles.regular(fontSize: 14, color: Colors.white)),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Center(
                          child: Text(
                        '$unassignedFeedbacksCount',
                        style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                      )),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: IconButton(
                tooltip: 'Refresh',
                onPressed: () {
                  fetchFeedbacks(widget.projects.id!).then((features) {
                    setState(() {
                      selectedStatus = null;
                      filteredFeatures = features;
                      feedbacksFuture = Future.value(features);
                    });
                  });
                },
                icon: Icon(
                  Icons.refresh_rounded,
                  size: screenHeight * 0.035,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        drawer: CustomAppDrawer(),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomTimeline(
                            currentMilestone: widget.currentMilestone,
                            releaseDeadline: widget.projects.releaseDate!,
                            designDeadline: widget.projects.designDeadline!,
                            developmentDeadline: widget.projects.developmentDeadline!,
                            testingDeadline: widget.projects.testingDeadline!,
                            researchDeadline: widget.projects.researchDeadline!,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 40),
                        child: CircularPercentIndicator(
                          radius: screenWidth * 0.03,
                          animation: true,
                          animationDuration: 1000,
                          backgroundColor: Color(0xff70C5FF),
                          progressColor: Color(0xff0073C0),
                          circularStrokeCap: CircularStrokeCap.butt,
                          lineWidth: screenWidth * 0.0072,
                          percent: widget.completionPercentage / 100,
                          center: Text(
                            '${widget.completionPercentage}%',
                            style: GoogleFonts.lato(
                              color: Color(0xff0098FF),
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: FutureBuilder<getLatestUpdate>(
                      future: latestUpdateFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 80),
                            child: CircularProgressIndicator(),
                          ));
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data == null || snapshot.data!.updates == null || snapshot.data!.updates!.isEmpty) {
                          return LatestUpdate(
                            onPosted: () {
                              setState(() {
                                latestUpdateFuture = fetchLatestUpdates(widget.projects.id!);
                              });
                            },
                            assignedTo: widget.projects.assignedTo,
                            projectName: '--',
                            postedBy: '--',
                            dateTime: '--',
                            latestUpdate: 'No updates available',
                            projectID: widget.projects.id!,
                          );
                        }

                        final updates = snapshot.data!.updates!;
                        final latestUpdate = updates.last;

                        bool isExpanded = false;

                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                    });
                                  },
                                  child: LatestUpdate(
                                    onPosted: () {
                                      setState(() {
                                        latestUpdateFuture = fetchLatestUpdates(widget.projects.id!);
                                      });
                                    },
                                    assignedTo: widget.projects.assignedTo,
                                    projectName: widget.projects.projectName,
                                    postedBy: latestUpdate.postedBy ?? '',
                                    dateTime: latestUpdate.postingTime,
                                    latestUpdate: latestUpdate.latestUpdate ?? 'No updates available',
                                    projectID: widget.projects.id!,
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.4,
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    height: isExpanded ? null : 0,
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: updates
                                          .sublist(0, updates.length - 1)
                                          .reversed
                                          .map((update) => Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                child: PreviousUpdates(
                                                  postedBy: update.postedBy ?? '--',
                                                  dateTime: update.postingTime ?? '--',
                                                  latestUpdate: update.latestUpdate ?? 'No updates available',
                                                  projectID: widget.projects.id!,
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DetailContainer(
                      lastUpdated: formatDate(widget.projects.lastUpdate),
                      weeklyReview: widget.projects.review!,
                      untilRelease: getRemainingDays(widget.projects.releaseDate),
                      dateAssigned: formatDate(widget.projects.createdAt),
                      ledBy: widget.projects.ledBy!,
                      priority: widget.projects.priority!,
                      about: widget.projects.description!,
                      assignedBy: widget.projects.assignedBy!,
                      assignedTo: widget.projects.assignedTo!,
                    ),
                  ),
                ]),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 20,
                    offset: Offset(0, 4),
                  ),
                ],
                color: Color(0xff252525),
              ),
              height: screenHeight,
              width: screenWidth * 0.48,
              child: Center(
                child: SizedBox(
                  width: screenWidth * 0.44,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FutureBuilder<List<Feedbacks>>(
                                future: feedbacksFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                        'Failed to load feedbacks: ${snapshot.error}',
                                        style: GoogleFonts.lato(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return Center(
                                      child: Text(
                                        'No feedbacks found',
                                        style: GoogleFonts.lato(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  } else {
                                    final features = snapshot.data!;
                                    if (filteredFeatures.isEmpty) {
                                      filteredFeatures = features;
                                    }
                                    final completedCount = features.where((feedback) => feedback.isAdded!).length;

                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 20),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(
                                                    'Feedbacks (${features.length})',
                                                    style: GoogleFonts.lato(
                                                      color: Color(0xff0098FF),
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    '(Completed: $completedCount)',
                                                    style: GoogleFonts.lato(
                                                      color: Color(0xffDFECFF),
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  OutlinedButton(
                                                    onPressed: () async {
                                                      final result = await showDialog<bool>(
                                                        context: context,
                                                        barrierDismissible: false,
                                                        builder: (context) => AddFeature(
                                                          assignedPeople: widget.projects.assignedTo!,
                                                          onFeatureAdded: () {
                                                            Navigator.of(context).pop(true);
                                                          },
                                                          projectID: widget.projects.id!,
                                                        ),
                                                      );

                                                      if (result == true) {
                                                        await Future.wait([
                                                          fetchFeedbacksCount(widget.projects.id!).then((count) {
                                                            setState(() {
                                                              unassignedFeedbacksCount = count;
                                                            });
                                                          }),
                                                          fetchFeedbacks(widget.projects.id!).then((features) {
                                                            setState(() {
                                                              filteredFeatures = features;
                                                              feedbacksFuture = Future.value(features);
                                                            });
                                                          }),
                                                        ]);
                                                      }
                                                    },
                                                    style: ButtonStyle(
                                                      side: WidgetStateProperty.all(
                                                        BorderSide(color: Colors.blue, width: 1),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'Add a Feedback',
                                                      style: GoogleFonts.lato(
                                                        color: Colors.blue,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                child: Row(
                                                  children: [
                                                    // Search Field (70%)
                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        controller: searchController,
                                                        onChanged: (value) {
                                                          filterFeatures(
                                                            searchQuery: value,
                                                            selectedStatus: selectedStatus,
                                                            features: features,
                                                          );
                                                        },
                                                        decoration: InputDecoration(
                                                          hintText: 'Search by description or name',
                                                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                                                          filled: true,
                                                          fillColor: Color(0xff353535),
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                            borderSide: BorderSide.none,
                                                          ),
                                                          hintStyle: GoogleFonts.lato(
                                                            color: Colors.grey,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        cursorColor: Colors.blue,
                                                        style: GoogleFonts.lato(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 8),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                                        decoration: BoxDecoration(
                                                          color: Color(0xff353535),
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: DropdownButtonHideUnderline(
                                                          child: DropdownButton<String>(
                                                            isExpanded: true,
                                                            value: selectedStatus,
                                                            hint: Text(
                                                              'Filter by status',
                                                              style: GoogleFonts.lato(
                                                                color: Colors.grey,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            dropdownColor: Color(0xff353535),
                                                            style: GoogleFonts.lato(
                                                              color: Colors.white,
                                                              fontSize: 14,
                                                            ),
                                                            items: [
                                                              DropdownMenuItem<String>(
                                                                value: null,
                                                                child: Text('All Status'),
                                                              ),
                                                              DropdownMenuItem<String>(
                                                                value: 'added',
                                                                child: Text('Added'),
                                                              ),
                                                              DropdownMenuItem<String>(
                                                                value: 'not_added',
                                                                child: Text('Not Added'),
                                                              ),
                                                            ],
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedStatus = value;
                                                                if (value == null) {
                                                                  // Show all features when no filter is selected
                                                                  filteredFeatures = features;
                                                                } else if (value == 'added') {
                                                                  // Filter to only show features marked as added
                                                                  filteredFeatures = features.where((feedback) => feedback.isAdded!).toList();
                                                                } else if (value == 'not_added') {
                                                                  // Filter to show features that are not marked as added
                                                                  filteredFeatures = features.where((feedback) => !feedback.isAdded!).toList();
                                                                }
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.7,
                                          child: ListView.builder(
                                            itemCount: filteredFeatures.length,
                                            itemBuilder: (context, index) {
                                              final feature = filteredFeatures.reversed.toList()[index];
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                child: FeatureBox(
                                                  allPeople: widget.projects.assignedTo,
                                                  feature: feature,
                                                  feedbackID: filteredFeatures.length - index,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
