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

class ProjectData {
  static List<Project> allProjects = [
    Project(
      title: "Sample Project",
      jobType: "Remote",
      details: "Sample project details",
      deliveryTime: "1 month",
      requirements: ["Flutter", "Firebase"],
      acceptedPrice: 1000.00,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 30)),
      status: ProjectStatus.pending,
    ),
  ];

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