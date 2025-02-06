import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_management_system/api/models/getFeedbacks.dart';
import 'package:project_management_system/api/models/getUsers.dart';
import 'package:project_management_system/controllers/controllers.dart';
import 'package:project_management_system/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/getAllProjects.dart';
import 'models/getAssignedProjects.dart';
import 'models/getBugs.dart';
import 'models/getDailyProgressOld.dart';
import 'models/getLatestUpdate.dart';
import 'models/getQuickInsights.dart';

String apiBaseURL = 'http://10.131.213.166:8080/';

//fetch projects
Future<List<GetAllProjects>> fetchAllProjects() async {
  final response = await http.get(Uri.parse(apiBaseURL+ 'projects/'));

  if (response.statusCode == 200) {
    List<dynamic> jsonData = jsonDecode(response.body);
    List<GetAllProjects> projects =
    jsonData.map((json) => GetAllProjects.fromJson(json)).toList();
    return projects;
  } else {
    throw Exception('Failed to load projects');
  }
}

//addNewProject
Future<void> createProject() async {
  final projectData = {
    "project_name": projectNameController.text,
    "description": aboutProjectController.text,
    "priority": selectedPriority,
    "led_by": selectedLeader,
    "review": selectedWeekDay,
    "research_deadline": researchDateController.text,
    "research_effort": researchEffortsController.text,
    "design_deadline": designDateController.text,
    "design_effort": designEffortsController.text,
    "development_deadline": developmentDateController.text,
    "development_effort": developmentEffortsController.text,
    "testing_deadline": testingDateController.text,
    "testing_effort": testingEffortsController.text,
    "assigned_by": 'Admin',
    "assigned_to": selectedNames.join(', '),
    "current_milestone": "Research",
    "completion_percentage": 0.0,
    "completed": false,
    "release_date": releaseDateController.text,
  };

  try {
    final response = await http.post(
      Uri.parse(apiBaseURL + 'projects/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(projectData),
    );

    if (response.statusCode == 201) {

      print('Project created successfully');
    } else {
      print('Failed to create project: ${response.body}');
      throw Exception('Failed to create project');
    }
  } catch (e) {
    print('Error: $e');
    throw e;
  }
}

//editProject
Future<void> updateProject(int projectId) async {
  final projectData = {
    "project_name": projectNameController.text,
    "description": aboutProjectController.text,
    "priority": selectedPriority,
    "led_by": selectedLeader,
    "review": selectedWeekDay,
    "research_deadline": researchDateController.text,
    "research_effort": researchEffortsController.text,
    "design_deadline": designDateController.text,
    "design_effort": designEffortsController.text,
    "development_deadline": developmentDateController.text,
    "development_effort": developmentEffortsController.text,
    "testing_deadline": testingDateController.text,
    "testing_effort": testingEffortsController.text,
    "assigned_by": 'Admin',
    "assigned_to": selectedNames.join(', '),
    "current_milestone": currentMilestone,
    "completion_percentage": 0.0,
    "completed": currentMilestone == 'Released' ? true : false,
    "release_date": releaseDateController.text,
    "project_url" : projectURLController.text ?? '',
  };

  try {
    final response = await http.put(
      Uri.parse(apiBaseURL + 'projects/$projectId/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(projectData),
    );

    if (response.statusCode == 200) {
      print('Project updated successfully');
      print('Completed: ${currentMilestone == 'Released' ? true : false}');

    } else {
      print('Failed to update project: ${response.body}');
      throw Exception('Failed to update project');
    }
  } catch (e) {
    print('Error: $e');
    throw e;
  }
}


//fetch quick insights
Future <List<getQuickInsights>> fetchQuickInsights() async {
  final response = await http.get(Uri.parse(apiBaseURL + 'quick-insights/'));

  if (response.statusCode == 200){
    List <dynamic> jsonData = jsonDecode(response.body);
    List<getQuickInsights> quickInsights =
    jsonData.map((json)=> getQuickInsights.fromJson(json)).toList();
    return quickInsights;
  }
  else {
    throw Exception('Failed to load quick insights');
  }
}

//fetchDailyProgress
// Future<List<getDailyProgress>> fetchDailyProgress(int projectID) async{
//   final response = await http.get(Uri.parse(apiBaseURL + 'daily-progress/project/$projectID'));
//
//   if (response.statusCode == 200){
//     List<dynamic> jsonData = jsonDecode(response.body);
//     List <getDailyProgress> dailyProgress = jsonData.map((json)=>
//         getDailyProgress.fromJson(json)).toList();
//     return dailyProgress;
//   }
//   else {
//     throw Exception('Failed to load daily progress');
//   }
// }

//fetch Bugs
Future<List<Bugs>> fetchBugs(int projectID) async {
  final response = await http.get(Uri.parse('$apiBaseURL/api/bugs/project/$projectID'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);

    if (jsonData is Map && jsonData['bugs'] is List) {
      List<dynamic> bugsList = jsonData['bugs'];
      return bugsList.map((json) => Bugs.fromJson(json)).toList();
    } else {
      throw Exception('Unexpected JSON structure: Missing or invalid "bugs" key');
    }
  } else {
    throw Exception('Failed to load bugs: ${response.statusCode}');
  }
}

// Fetch Feedbacks
Future<List<Feedbacks>> fetchFeedbacks(int projectID) async {
  final response = await http.get(Uri.parse('$apiBaseURL/api/feedback/project/$projectID'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

    if (jsonData['feedbacks'] is List) {

      getFeedback feedbackData = getFeedback.fromJson(jsonData);
      return feedbackData.feedbacks ?? [];
    } else {
      throw Exception('Unexpected JSON structure: Missing or invalid "feedbacks" key');
    }
  } else {
    throw Exception('Failed to load feedbacks: ${response.statusCode}');
  }
}

// Fetch Feedbacks
Future<int> fetchFeedbacksCount(int projectID) async {
  final response = await http.get(Uri.parse('$apiBaseURL/api/feedback/project/$projectID'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

    if (jsonData['feedbacks'] is List) {

      getFeedback feedbackData = getFeedback.fromJson(jsonData);
      List<Feedbacks> feedbacks = feedbackData.feedbacks ?? [];

      int unassignedCount = feedbacks.where((feedback) {
        return feedback.assignedTo == null || feedback.assignedTo?.isEmpty == true;
      }).length;

      return unassignedCount;
    } else {
      throw Exception('Unexpected JSON structure: Missing or invalid "feedbacks" key');
    }
  } else {
    throw Exception('Failed to load feedbacks: ${response.statusCode}');
  }
}


//registerUser
Future<void> registerUser({
  required String name,
  required String email,
  required String team,
  required String role,
  required String linkedinProfile,
  required String password,
}) async {
  final url = Uri.parse('http://10.131.213.166:8080/api/individuals/');

  final body = {
    "name": name,
    "email": email,
    "team": team,
    "role": role,
    "linkedin_profile": linkedinProfile,
    "password": password,
  };

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      print('User registered successfully.');
    } else {
      print('Failed to register user. Error: ${response.body}');
    }
  } catch (error) {
    print('An error occurred: $error');
  }
}

// Function to fetch daily progress
// Future<Map<String, dynamic>> getDailyProgress() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final String? token = prefs.getString('accessToken');
//   final int? userId = prefs.getInt('userId');
//
//   if (token == null || userId == null) {
//     throw Exception("Authorization token or user ID is missing");
//   }
//
//   final response = await http.get(
//     Uri.parse(apiBaseURL + 'daily-progress/'),
//     headers: {
//       'Authorization': 'Token $token',
//     },
//   );
//
//   if (response.statusCode == 200) {
//     return jsonDecode(response.body);
//   } else {
//     throw Exception('Failed to fetch daily progress: ${response.body}');
//   }
// }


// Function to post daily progress
Future<void> postDailyProgress(String date, String progress, int projectID) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('accessToken');
  final int? userId = prefs.getInt('userId');

  if (token == null || userId == null) {
    throw Exception("Authorization token or user ID is missing");
  }

  final response = await http.post(
    Uri.parse(apiBaseURL + 'daily-progress/'),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "user": userId,
      "project": projectID,
      "date": date,
      "progress": progress,
    }),
  );

  if (response.statusCode == 201) {
    print("Progress updated successfully!");
  } else {
    throw Exception('Failed to post daily progress: ${response.body}');
  }
}

//edit  daily progress
Future<void> updateDailyProgress(String date, String progress, progressID) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('accessToken');
  final int? userId = prefs.getInt('userId');

  if (token == null || userId == null) {
    throw Exception("Authorization token or user ID is missing");
  }

  final response = await http.post(
    Uri.parse('${apiBaseURL}daily-progress/edit/$progressID'),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "user": userId,
      "id": progressID,
      "date": date,
      "progress": progress,
    }),
  );

  if (response.statusCode == 201) {
    print("Progress updated successfully!");
  } else {
    throw Exception('Failed to post daily progress: ${response.body}');
  }
}


//latest update
Future<getLatestUpdate> fetchLatestUpdates(int projectID) async {
  try {
    final response = await http.get(Uri.parse('${apiBaseURL}latest-update/project/$projectID'));

    if (response.statusCode == 200) {
      return getLatestUpdate.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load updates: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load updates: $e');
  }
}

// Post a new update
Future<bool> postLatestUpdate(Map<String, dynamic> updateData, int projectID) async {
  final url = '${apiBaseURL}project/$projectID';
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode(updateData),
  );

  if (response.statusCode == 201) {
    return true;
  } else {
    print('Failed to post update: ${response.body}');
    return false;
  }
}

//fetch users
Future<List<getUsers>> getUserDetails() async {
  final url = Uri.parse('http://10.131.213.166:8080/api/individuals/');

  try {
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> userDetails = jsonDecode(response.body);

      // Map JSON to `getUsers` objects and return the list
      return userDetails.map((user) => getUsers.fromJson(user)).toList();
    } else {
      print('Failed to fetch user details. Status code: ${response.statusCode}');
      throw Exception('Failed to fetch user details');
    }
  } catch (error) {
    print('An error occurred: $error');
    throw Exception('Error fetching user details: $error');
  }
}

// Function to fetch assigned projects
Future<List<AssignedProject>> fetchAssignedProjects() async {
  const url = 'http://10.131.213.166:8080/assigned-project/';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['data'] as List)
          .map((item) => AssignedProject.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load data. Status Code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching assigned projects: $e');
  }
}
