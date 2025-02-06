import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_management_system/pages/projectDetailPage.dart';
import '../api/apis.dart';
import '../api/models/getAllProjects.dart';
import '../components/completedProjectCard.dart';
import '../components/customAppDrawer.dart';
import '../components/projectCard.dart';
import '../controllers/controllers.dart';
import '../globals.dart';
import 'loginPage.dart';
import 'myTeamPage.dart';

class CompletedProjects extends StatefulWidget {
  const CompletedProjects({super.key});

  @override
  State<CompletedProjects> createState() => _CompletedProjectsState();
}

class _CompletedProjectsState extends State<CompletedProjects> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xffFDFDFD),
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Project Management System',
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
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyTeamPage()));
                        },
                        child: Text(
                          'Innovation & Performance, Plot-25, GGN, IN',
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ))),
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  icon: Icon(
                    Icons.logout_rounded,
                    size: screenHeight * 0.025,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ]),
      drawer: CustomAppDrawer(),
      body: SingleChildScrollView(
        child: FutureBuilder<List<GetAllProjects>>(
          future: fetchAllProjects(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error fetching projects: ${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final List<GetAllProjects> projects = snapshot.data!;
              final filteredProjects = projects.where((project) {
                final nameMatch = project.projectName?.toLowerCase().contains(searchController.text.toLowerCase()) ?? false;
                final priorityMatch = (isHigh && project.priority == 'High') || (isMedium && project.priority == 'Medium') || (isLow && project.priority == 'Low');
                final isCompleted = project.completed == true;

                return nameMatch && (priorityMatch || !(isHigh || isMedium || isLow)) && isCompleted;
              }).toList();

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.18,
                ),
                itemCount: filteredProjects.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final project = filteredProjects[index];

                  return Padding(
                    padding: const EdgeInsets.only(top: 10, left: 50, right: 50, bottom: 50),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjectDetail(
                              projects: project,
                              completionPercentage: calculateCompletionPercentage(project),
                              currentMilestone: project.currentMilestone!,
                            ),
                          ),
                        );
                      },
                      child: CompletedProjectCard(
                        onTap: () {},
                        daysLeft: '0',
                        lastUpdated: project.lastUpdate,
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
                        completionPercentage: calculateCompletionPercentage(project),
                        releaseDate: project.releaseDate,
                      ),
                    ),
                  );
                },
              );
            }

            return Center(
              child: Text(
                'No completed projects available',
                style: TextStyle(fontSize: 16),
              ),
            );
          },
        ),
      ),
    );
  }

  double calculateCompletionPercentage(GetAllProjects project) {
    final efforts = {
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
}
