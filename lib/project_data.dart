// project_data.dart
import 'projects_page_c.dart';

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