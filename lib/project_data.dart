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
      title: "E-commerce Mobile App",
      details: "Build a Flutter e-commerce app with product listings and cart",
      deliveryTime: "6 weeks",
      requirements: ["Flutter", "Firebase", "UI/UX"],
      acceptedPrice: 2500.00,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 42)),
      status: ProjectStatus.developerRequested, // <- This is the key status
      jobType: "Remote",
    ),
    Project(
      title: "Inventory System",
      details: "Desktop app for inventory tracking with barcode scanning",
      deliveryTime: "8 weeks",
      requirements: ["Java", "MySQL"],
      acceptedPrice: 3200.00,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 56)),
      status: ProjectStatus.developerRequested, // <- This is the key status
      jobType: "Hybrid",
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

class ClientProject {
  final String title;
  final String details;
  final List<String> requirements;
  final double acceptedPrice;
  final String deliveryTime;
  ProjectStatus status;


  ClientProject({
    required this.title,
    required this.details,
    required this.requirements,
    required this.acceptedPrice,
    required this.deliveryTime,
    this.status = ProjectStatus.pending,
  });
}

class DeveloperProject {
  final String title;
  final String details;
  final List<String> requirements;
  final String deliveryTime;
  ProjectStatus status;
  String jobType;


  DeveloperProject({
  required this.title,
  required this.details,
  required this.requirements,
  required this.deliveryTime,
  required this.jobType,
  this.status = ProjectStatus.pending,
  });
}

class ProjectApprovalManager {
  void approveProject(Project project) {
    if (project.status != ProjectStatus.completed) {
      project.status = ProjectStatus.ongoing;
      print("Project '${project.title}' has been approved and is now ongoing.");
    } else {
      print("Project '${project.title}' is already completed and cannot be approved.");
    }
  }
}

class ProjectRejectionManager {
  void rejectProject(Project project) {
    if (project.status != ProjectStatus.completed) {
      project.status = ProjectStatus.rejected;
      print("Project '${project.title}' has been rejected.");
    } else {
      print("Project '${project.title}' is already completed and cannot be rejected.");
    }
  }
}