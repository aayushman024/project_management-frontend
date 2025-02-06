// List of project names
import 'package:intl/intl.dart';

final List<String> projectNames = ['TS Hot Issues Dashboard', 'sTSI - Simplified Technical Support Interface v2.0', 'NMS Care', 'Technical Support Bot', 'NI Care Assist', ];


//globalDetails
String userName = '';
String? userRole;
int? userId;

List <String> priority = ['High', 'Medium', 'Low'];

List <String> milestones = ['Null', 'Research', 'Design', 'Development', 'Testing', 'Released'];

List <String> inpTeam = ['Shiv', 'Anil', 'Siddharth', 'Niraj', 'Tony'];

String? selectedPriority;
String? selectedLeader;
String? selectedWeekDay;
String? currentMilestone;

List<String> names = [
  'Aayushman Ranjan',
  'Rishabh Sharma',
  'Yuvraj Singh Tanwar',
  'Khushi Sharma',
  'Vansh Chaudhary',
  'Kashish Mittal',
  'Reya Kumar',
  'Tejasvita Jain',
  'Anil Prajapati',
  'Niraj Garg',
  'Tony Ravindran',
  'Shiv Sahu',
  'Siddharth Dinodia'
];
List<String> selectedNames = [];

List <String> weeklyReview = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

//expansion tiles
bool isHigh = false;
bool isMedium = false;
bool isLow = false;

//teamsOnPMS
List <String> teams = ['Innovation & Performance GGN', 'Other'];
//positionsOnPMS
List <String> positions = ['Manager', 'Senior Specialist', 'Intern'];

//format date
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
