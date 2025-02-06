import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart';

class AddFeature extends StatefulWidget {
  final int projectID;
  final String? assignedPeople;
  final VoidCallback onFeatureAdded;

  const AddFeature({
    required this.projectID,
    required this.assignedPeople,
    required this.onFeatureAdded,
    super.key,
  });

  @override
  State<AddFeature> createState() => _AddFeatureState();
}

class _AddFeatureState extends State<AddFeature> {
  final TextEditingController _featureController = TextEditingController();
  final TextEditingController _reportedByController = TextEditingController();
  final List<String> _selectedPeople = [];
  bool? isBug = false;

  List<String> get _assignedPeopleList {
    return widget.assignedPeople?.split(',').map((e) => e.trim()).toList() ?? [];
  }

  Future<void> postFeatureRequest() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? username = prefs.getString('username');
      final url = Uri.parse('http://10.131.213.166:8080/api/feedback/');
      final body = {
        "feedback_description": _featureController.text,
        "posted_by": userName,
        "is_added": false,
        'is_bug': isBug,
        "user": 1,
        "reported_by": _reportedByController.text,
        "project": widget.projectID,
        "assigned_to": _selectedPeople.join(', '),
      };

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        widget.onFeatureAdded();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Feature added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add feature: ${response.body}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding feature: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _submitFeature() {
    if (_featureController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Feature description cannot be empty!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    postFeatureRequest();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a Feedback'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              minLines: 3,
              maxLines: null,
              controller: _featureController,
              onSubmitted: (value) => _submitFeature,
              decoration: const InputDecoration(hintText: 'Type your feedback here...'),
            ),
            const SizedBox(height: 20),
            TextField(
              maxLines: null,
              controller: _reportedByController,
              decoration: const InputDecoration(hintText: 'Reported By (Optional)'),
            ),
            const SizedBox(height: 16),
            // Mark as Bug checkbox
            Row(
              children: [
                Checkbox(
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                  value: isBug,
                  onChanged: (value) {
                    setState(() {
                      isBug = value ?? false;
                    });
                  },
                ),
                const Text('Mark as Bug'),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Assign Task to (Optional):'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _assignedPeopleList.map((person) {
                final isSelected = _selectedPeople.contains(person);
                return ChoiceChip(
                  selectedColor: Colors.blue[100],
                  label: Text(person),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedPeople.add(person);
                      } else {
                        _selectedPeople.remove(person);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: _submitFeature,
          child: const Text('Add', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _featureController.dispose();
    _reportedByController.dispose();
    super.dispose();
  }
}
