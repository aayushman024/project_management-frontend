// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import 'models/getAllProjects.dart';
//
// String apiBaseURL = '';
// List <GetAllProjects> allProjects = [];
//
//
// //fetch all Projects
// Future<List<GetAllProjects>> fetchAllProjects() async {
//
//   final response = await http.get(Uri.parse(apiBaseURL),);
//
//   if (response.statusCode == 200) {
//     List<dynamic> jsonData = jsonDecode(response.body);
//     List<GetAllProjects> projects = jsonData.map((json) => GetAllProjects.fromJson(json)).toList();
//     print("Fetched issues: ${projects.length}");
//     projects.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
//
//     allProjects = projects;
//     return allProjects;
//   } else {
//     throw Exception('Failed to load projects');
//   }
// }