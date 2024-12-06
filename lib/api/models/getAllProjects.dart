class GetAllProjects {
  int? id;
  String? projectName;
  String? description;
  String? priority;
  String? ledBy;
  String? review;
  String? researchDeadline;
  String? researchEffort;
  String? designDeadline;
  String? designEffort;
  String? developmentDeadline;
  String? developmentEffort;
  String? testingDeadline;
  String? testingEffort;
  String? assignedBy;
  String? assignedTo;
  String? currentMilestone;
  int? completionPercentage;
  bool? completed;
  String? releaseDate;

  GetAllProjects(
      {this.id,
        this.projectName,
        this.description,
        this.priority,
        this.ledBy,
        this.review,
        this.researchDeadline,
        this.researchEffort,
        this.designDeadline,
        this.designEffort,
        this.developmentDeadline,
        this.developmentEffort,
        this.testingDeadline,
        this.testingEffort,
        this.assignedBy,
        this.assignedTo,
        this.currentMilestone,
        this.completionPercentage,
        this.completed,
        this.releaseDate});

  GetAllProjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['project_name'];
    description = json['description'];
    priority = json['priority'];
    ledBy = json['led_by'];
    review = json['review'];
    researchDeadline = json['research_deadline'];
    researchEffort = json['research_effort'];
    designDeadline = json['design_deadline'];
    designEffort = json['design_effort'];
    developmentDeadline = json['development_deadline'];
    developmentEffort = json['development_effort'];
    testingDeadline = json['testing_deadline'];
    testingEffort = json['testing_effort'];
    assignedBy = json['assigned_by'];
    assignedTo = json['assigned_to'];
    currentMilestone = json['current_milestone'];
    completionPercentage = json['completion_percentage'];
    completed = json['completed'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_name'] = this.projectName;
    data['description'] = this.description;
    data['priority'] = this.priority;
    data['led_by'] = this.ledBy;
    data['review'] = this.review;
    data['research_deadline'] = this.researchDeadline;
    data['research_effort'] = this.researchEffort;
    data['design_deadline'] = this.designDeadline;
    data['design_effort'] = this.designEffort;
    data['development_deadline'] = this.developmentDeadline;
    data['development_effort'] = this.developmentEffort;
    data['testing_deadline'] = this.testingDeadline;
    data['testing_effort'] = this.testingEffort;
    data['assigned_by'] = this.assignedBy;
    data['assigned_to'] = this.assignedTo;
    data['current_milestone'] = this.currentMilestone;
    data['completion_percentage'] = this.completionPercentage;
    data['completed'] = this.completed;
    data['release_date'] = this.releaseDate;
    return data;
  }
}
