class GetAllProjects {
  int? id;
  String? researchDeadline;
  String? designDeadline;
  String? developmentDeadline;
  String? testingDeadline;
  String? releaseDate;
  int? totalFeedbackCount;
  int? isAddedFeedbackCount;
  List<OpenFeedbackByPerson>? openFeedbackByPerson;
  String? projectName;
  String? createdAt;
  String? description;
  String? priority;
  String? ledBy;
  String? review;
  String? researchEffort;
  String? designEffort;
  String? developmentEffort;
  String? testingEffort;
  String? assignedBy;
  String? assignedTo;
  String? currentMilestone;
  String? lastUpdate;
  int? completionPercentage;
  bool? completed;
  String? projectURL;

  GetAllProjects(
      {this.id,
        this.researchDeadline,
        this.designDeadline,
        this.developmentDeadline,
        this.testingDeadline,
        this.releaseDate,
        this.totalFeedbackCount,
        this.isAddedFeedbackCount,
        this.openFeedbackByPerson,
        this.projectName,
        this.createdAt,
        this.description,
        this.priority,
        this.ledBy,
        this.review,
        this.researchEffort,
        this.designEffort,
        this.developmentEffort,
        this.testingEffort,
        this.assignedBy,
        this.assignedTo,
        this.currentMilestone,
        this.lastUpdate,
        this.completionPercentage,
        this.completed,
        this.projectURL});

  GetAllProjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    researchDeadline = json['research_deadline'];
    designDeadline = json['design_deadline'];
    developmentDeadline = json['development_deadline'];
    testingDeadline = json['testing_deadline'];
    releaseDate = json['release_date'];
    totalFeedbackCount = json['total_feedback_count'];
    isAddedFeedbackCount = json['is_added_feedback_count'];
    if (json['open_feedback_by_person'] != null) {
      openFeedbackByPerson = <OpenFeedbackByPerson>[];
      json['open_feedback_by_person'].forEach((v) {
        openFeedbackByPerson!.add(new OpenFeedbackByPerson.fromJson(v));
      });
    }
    projectName = json['project_name'];
    createdAt = json['created_at'];
    description = json['description'];
    priority = json['priority'];
    ledBy = json['led_by'];
    review = json['review'];
    researchEffort = json['research_effort'];
    designEffort = json['design_effort'];
    developmentEffort = json['development_effort'];
    testingEffort = json['testing_effort'];
    assignedBy = json['assigned_by'];
    assignedTo = json['assigned_to'];
    currentMilestone = json['current_milestone'];
    lastUpdate = json['last_update'];
    completionPercentage = json['completion_percentage'];
    completed = json['completed'];
    projectURL = json['project_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['research_deadline'] = this.researchDeadline;
    data['design_deadline'] = this.designDeadline;
    data['development_deadline'] = this.developmentDeadline;
    data['testing_deadline'] = this.testingDeadline;
    data['release_date'] = this.releaseDate;
    data['total_feedback_count'] = this.totalFeedbackCount;
    data['is_added_feedback_count'] = this.isAddedFeedbackCount;
    if (this.openFeedbackByPerson != null) {
      data['open_feedback_by_person'] =
          this.openFeedbackByPerson!.map((v) => v.toJson()).toList();
    }
    data['project_name'] = this.projectName;
    data['created_at'] = this.createdAt;
    data['description'] = this.description;
    data['priority'] = this.priority;
    data['led_by'] = this.ledBy;
    data['review'] = this.review;
    data['research_effort'] = this.researchEffort;
    data['design_effort'] = this.designEffort;
    data['development_effort'] = this.developmentEffort;
    data['testing_effort'] = this.testingEffort;
    data['assigned_by'] = this.assignedBy;
    data['assigned_to'] = this.assignedTo;
    data['current_milestone'] = this.currentMilestone;
    data['last_update'] = this.lastUpdate;
    data['completion_percentage'] = this.completionPercentage;
    data['completed'] = this.completed;
    data['project_url'] = this.projectURL;
    return data;
  }
}

class OpenFeedbackByPerson {
  String? user;
  int? count;

  OpenFeedbackByPerson({this.user, this.count});

  OpenFeedbackByPerson.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['count'] = this.count;
    return data;
  }
}
