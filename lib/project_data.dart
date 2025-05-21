// project_data.dart

enum ProjectStatus {
  pending,
  notStarted,
  developerRequested,
  ongoing,
  completed,
  rejected
}

class Project {
  final String title;
  final String details;
  final String deliveryTime;
  final List<String> requirements;
  final double acceptedPrice;
  final DateTime startDate;
  final DateTime endDate;
  final String? srsFile;
  ProjectStatus status;
  String jobType;

  Project({
    required this.title,
    required this.details,
    required this.deliveryTime,
    required this.requirements,
    required this.acceptedPrice,
    required this.startDate,
    required this.endDate,
    this.srsFile,
    required this.status,
    required this.jobType,
  });
}

class ProjectData {
  static List<Project> allProjects = [
    Project(
      title: "Sample Project",
      details: "Sample project details",
      deliveryTime: "1 month",
      requirements: ["Flutter", "Firebase"],
      acceptedPrice: 1000.00,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 30)),
      status: ProjectStatus.pending,
      jobType: "Remote",
    ),
  ];

  // Add this to your ProjectData class
  static void updateProjectStatus(Project project, ProjectStatus newStatus) {
    project.status = newStatus;
    // Add any notification logic here if needed
  }

  static void approveClientProject(Project project) {
    project.status = ProjectStatus.notStarted; // Now visible to developers
    // You might want to add notification logic here
  }

  // Add this method
  static void approveDeveloperRequest(Project project) {
    project.status = ProjectStatus.ongoing;
    // You might want to add notification logic here
  }

  static void addProject(Project project) {
    allProjects.add(project);
  }

  static List<Project> get pendingProjects => allProjects
      .where((project) => project.status == ProjectStatus.pending)
      .toList();

  static List<Project> get notStartedProjects => allProjects
      .where((project) => project.status == ProjectStatus.notStarted)
      .toList();

  static List<Project> get developerRequestedProjects => allProjects
      .where((project) => project.status == ProjectStatus.developerRequested)
      .toList();

  static List<Project> get ongoingProjects => allProjects
      .where((project) => project.status == ProjectStatus.ongoing)
      .toList();

  static List<Project> get completedProjects => allProjects
      .where((project) => project.status == ProjectStatus.completed)
      .toList();
}