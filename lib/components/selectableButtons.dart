// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_management_system/api/apis.dart';
import 'package:project_management_system/api/models/getUsers.dart';

import '../globals.dart';

class SelectableChips extends StatefulWidget {
  @override
  _SelectableChipsState createState() => _SelectableChipsState();
}

class _SelectableChipsState extends State<SelectableChips> {
  @override
  void initState() {
    super.initState();
    _fetchUserNames();
  }

  /// Fetch user details from the API, update the global `names` list,
  /// and then call setState() so that preselected chips (from global selectedNames)
  /// remain as before.
  void _fetchUserNames() async {
    try {
      // Assume getUserDetails returns Future<List<getUsers>>
      List<getUsers> users = await getUserDetails();
      // Clear the global names list and add the fetched names (ignoring null names)
      names
        ..clear()
        ..addAll(users.where((user) => user.name != null).map((user) => user.name!));

      setState(() {}); // Refresh the UI after fetching the names.
    } catch (error) {
      print("Error fetching user details: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Optionally show a loader if the names list is empty (data is still loading).
    if (names.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: names.map((name) {
          return FilterChip(
            label: Text(
              name,
              style: GoogleFonts.lato(
                color: selectedNames.contains(name) ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            selected: selectedNames.contains(name),
            onSelected: (isSelected) {
              setState(() {
                if (isSelected) {
                  selectedNames.add(name);
                } else {
                  selectedNames.remove(name);
                }
              });
            },
            backgroundColor: Color(0xFFE0E0E0),
            selectedColor: Color(0xFF00C106),
            checkmarkColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          );
        }).toList(),
      ),
    );
  }
}
