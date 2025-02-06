import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_management_system/components/employeeCard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_management_system/globals.dart';
import 'package:project_management_system/pages/registerMemberAdmin.dart';
import '../api/models/getUsers.dart';
import '../components/customAppDrawer.dart';
import 'loginPage.dart';

class MyTeamPage extends StatefulWidget {
  const MyTeamPage({super.key});

  @override
  State<MyTeamPage> createState() => _MyTeamPageState();
}

class _MyTeamPageState extends State<MyTeamPage> {
  late Future<List<getUsers>> _futureUsers;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _futureUsers = getUserDetails();
  }

  Future<List<getUsers>> getUserDetails() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.131.213.166:8080/api/individuals/'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((user) => getUsers.fromJson(user))
            .toList();
      } else {
        throw Exception('Failed to fetch user details (${response.statusCode})');
      }
    } catch (error) {
      throw Exception('Error fetching user details: $error');
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      _isRefreshing = true;
      _futureUsers = getUserDetails();
      _isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'My Team',
          style: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          Flexible(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Innovation & Performance, APAC - India',
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          IconButton(
            tooltip: 'Logout',
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => LoginPage())),
            icon: Icon(Icons.logout_rounded, color: Colors.white),
          ),
        ],
      ),
      drawer: CustomAppDrawer(),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              if (userRole == 'Manager')
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RegisterPageAdmin())),
                    icon: Icon(Icons.person_add, size: 16),
                    label: Text('Add Team Member',
                        style: GoogleFonts.lato(fontWeight: FontWeight.w500)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: FutureBuilder<List<getUsers>>(
                  future: _futureUsers,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(strokeWidth: 2),
                            SizedBox(height: 8),
                            Text('Loading...',
                                style: TextStyle(color: Colors.grey[600])),
                          ],
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline,
                                size: 28, color: Colors.red[400]),
                            SizedBox(height: 8),
                            Text('Error loading team members',
                                style: TextStyle(color: Colors.red[400])),
                            TextButton(
                                onPressed: _refreshData,
                                child: Text('Try Again')),
                          ],
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text('No team members found',
                              style: TextStyle(color: Colors.grey[600])));
                    }

                    final users = snapshot.data!;
                    final leads = users
                        .where((user) =>
                    (user.role == 'Manager' ||
                        user.role == 'Senior Specialist') &&
                        user.team == 'Innovation & Performance GGN')
                        .toList();
                    final interns = users
                        .where((user) =>
                    user.role == 'Intern' &&
                        user.team == 'Innovation & Performance GGN')
                        .toList();
                    final otherTeamMembers = users
                        .where((user) =>
                    user.team != 'Innovation & Performance GGN')
                        .toList();

                    return CustomScrollView(
                      slivers: [
                        if (leads.isNotEmpty) ...[
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Employees',
                                    style: GoogleFonts.lato(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87)),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                          SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                                  (context, index) => EmployeeCard(
                                empName: leads[index].name ?? '',
                                empDesig: leads[index].role ?? 'Employee',
                                empLinkedIn: leads[index].linkedinProfile,
                                imageUrl: 'inpTeam/${leads[index].id}.jpg',
                              ),
                              childCount: leads.length,
                            ),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: _calculateCrossAxisCount(context),
                              childAspectRatio: 2.2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                          ),
                        ],
                        if (interns.isNotEmpty) ...[
                          SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                                  (context, index) => EmployeeCard(
                                empName: interns[index].name ?? '',
                                empDesig: 'Employee',
                                empLinkedIn: interns[index].linkedinProfile,
                                imageUrl: 'inpTeam/${interns[index].id}.jpg',
                              ),
                              childCount: interns.length,
                            ),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: _calculateCrossAxisCount(context),
                              childAspectRatio: 2.2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                          ),
                        ],
                        if (otherTeamMembers.isNotEmpty) ...[
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 24),
                                Text('Other Team Members',
                                    style: GoogleFonts.lato(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87)),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                          SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                                  (context, index) => EmployeeCard(
                                empName: otherTeamMembers[index].name ?? '',
                                empDesig: (otherTeamMembers[index].team) ?? 'Employee',
                                empLinkedIn: otherTeamMembers[index].linkedinProfile,
                              ),
                              childCount: otherTeamMembers.length,
                            ),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: _calculateCrossAxisCount(context),
                              childAspectRatio: 2.2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _calculateCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 800) return 3;
    if (width > 600) return 2;
    return 1;
  }
}