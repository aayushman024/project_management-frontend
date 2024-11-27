import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_management_system/controllers/controllers.dart';

class DailyProgress extends StatefulWidget {
  const DailyProgress({super.key});

  @override
  State<DailyProgress> createState() => _DailyProgressState();
}

class _DailyProgressState extends State<DailyProgress> {
  DateTime _selectedMonth = DateTime.now();
  Map<DateTime, String> _dailyProgress = {};

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    List<DateTime> daysInMonth = List.generate(
      DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0).day,
          (index) => DateTime(_selectedMonth.year, _selectedMonth.month, index + 1),
    );

    // Filter out future dates
    DateTime today = DateTime.now();
    daysInMonth = daysInMonth
        .where((date) => date.isBefore(today) || date.isAtSameMomentAs(today))
        .toList();

    // Reverse the list so that the last day is at the top
    daysInMonth = daysInMonth.reversed.toList();

    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => setState(() {
              _selectedMonth = DateTime(
                _selectedMonth.year,
                _selectedMonth.month - 1,
              );
            }),
          ),
          Text(
            DateFormat.yMMMM().format(_selectedMonth),
            style: GoogleFonts.lato(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 28,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => setState(() {
              _selectedMonth = DateTime(
                _selectedMonth.year,
                _selectedMonth.month + 1,
              );
            }),
          ),
        ],
      ),
      content: SizedBox(
        width: screenWidth * 0.8,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: daysInMonth.length,
          itemBuilder: (context, index) {
            DateTime day = daysInMonth[index];
            String dayName = DateFormat('EEEE').format(day);

            return ListTile(
              leading: Container(
                width: screenWidth * 0.3,
                child: Row(
                  children: [
                    Text(
                      DateFormat('dd').format(day),
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: screenWidth*0.014),
                    Text(
                      dayName,
                      style: GoogleFonts.lato(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              horizontalTitleGap: screenWidth * 0.04,
              title: Text(
                _dailyProgress[day] ?? "No progress added",
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () => _addProgress(day),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Close",
            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void _addProgress(DateTime day) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Add Progress for ${DateFormat.yMMMMd().format(day)}",
          style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: TextField(
          controller: dailyProgressController,
          decoration: const InputDecoration(hintText: "Enter progress"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (dailyProgressController.text.isNotEmpty) {
                setState(() {
                  _dailyProgress[day] = dailyProgressController.text;
                });
              }
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
