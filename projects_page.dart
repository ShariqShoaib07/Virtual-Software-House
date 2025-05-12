import 'package:flutter/material.dart';

// ...existing code...

enum ProjectStatus {
  notStarted,
  developerRequested,
  inProgress,
  completed,
}

class Project {
  final String title;
  final String jobType;
  final String details;
  final String deliveryTime;
  final List<String> requirements;
  final double acceptedPrice;
  final DateTime startDate;
  final DateTime endDate;
  ProjectStatus status;

  Project({
    required this.title,
    required this.jobType,
    required this.details,
    required this.deliveryTime,
    required this.requirements,
    required this.acceptedPrice,
    required this.startDate,
    required this.endDate,
    this.status = ProjectStatus.notStarted,
  });
}

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  // ...existing code...

  void _filterProjects() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredProjects = notStartedProjects.where((project) {
        final matchesSearch = project.title.toLowerCase().contains(query) ||
            project.details.toLowerCase().contains(query);
        final matchesFilter = _filterJobType == "all" ||
            project.jobType.toLowerCase() == _filterJobType;
        return matchesSearch && matchesFilter && project.status == ProjectStatus.notStarted;
      }).toList();
    });
  }

  void _applyForProject(int index) {
    setState(() {
      notStartedProjects[index].status = ProjectStatus.developerRequested;
      _filterProjects();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Application submitted successfully!"),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              notStartedProjects[index].status = ProjectStatus.notStarted;
              _filterProjects();
            });
          },
        ),
      ),
    );
  }

  // ...existing code...

  Widget _buildFilterChip(String label, bool selected) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (isSelected) {
        setState(() {
          if (label.toLowerCase() == "all") {
            _filterJobType = "all";
          } else {
            _filterJobType = isSelected ? label.toLowerCase() : "all";
          }
          _filterProjects();
        });
      },
      backgroundColor: Colors.white,
      selectedColor: const Color(0xFF38E54D),
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.grey[700],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: selected ? 2 : 0,
    );
  }

  Widget _buildProjectCard(Project project, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ...existing code...
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ...existing code...
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF38E54D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    "Apply",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () => _applyForProject(
                    notStartedProjects.indexWhere((p) => p.title == project.title),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ...existing code...
}
