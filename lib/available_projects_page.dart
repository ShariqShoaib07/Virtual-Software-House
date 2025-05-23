import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'project_data.dart';

class AvailableProjectsPage extends StatefulWidget {
  @override
  _AvailableProjectsPageState createState() => _AvailableProjectsPageState();
}

class _AvailableProjectsPageState extends State<AvailableProjectsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Project> _filteredProjects = [];
  List<Project> _allProjects = [];

  @override
  void initState() {
    super.initState();
    _allProjects = [
      Project(
        title: "E-commerce Mobile App",
        details: "Build a Flutter e-commerce app with product listings and cart",
        deliveryTime: "6 weeks",
        requirements: ["Flutter", "Firebase", "UI/UX"],
        acceptedPrice: 2500.00,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 42)),
        status: ProjectStatus.notStarted,
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
        status: ProjectStatus.notStarted,
        jobType: "Hybrid",
      ),
      // Add more sample projects as needed
      ...ProjectData.notStartedProjects,
    ];
    _filteredProjects = _allProjects;
    _searchController.addListener(_filterProjects);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProjects() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProjects = _allProjects.where((project) {
        return project.title.toLowerCase().contains(query) ||
            project.details.toLowerCase().contains(query) ||
            project.requirements.any((req) => req.toLowerCase().contains(query));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011B10),
      appBar: AppBar(
        title: Text(
          "Available Projects",
          style: GoogleFonts.roboto(
            color: Colors.greenAccent,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF011B10),
        iconTheme: const IconThemeData(color: Colors.greenAccent),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF0A261A),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                style: GoogleFonts.roboto(
                  color: Colors.greenAccent[200],
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: 'Search projects...',
                  hintStyle: GoogleFonts.roboto(
                    color: Colors.greenAccent[200]!.withOpacity(0.7),
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.greenAccent[400]),
                  filled: true,
                  fillColor: Colors.transparent,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _filterProjects();
                });
              },
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filteredProjects.length,
                itemBuilder: (context, index) {
                  final project = _filteredProjects[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildProjectCard(project),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Project project) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F3D2C),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: Colors.greenAccent.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Title and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    project.title,
                    style: GoogleFonts.roboto(
                      color: Colors.greenAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.greenAccent.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    project.jobType,
                    style: GoogleFonts.roboto(
                      color: Colors.greenAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Project Details
            Text(
              project.details,
              style: GoogleFonts.roboto(
                color: Colors.greenAccent.withOpacity(0.8),
                fontSize: 14,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),

            // Requirements
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.requirements
                  .take(3)
                  .map((req) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.greenAccent.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  req,
                  style: GoogleFonts.roboto(
                    color: Colors.greenAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ))
                  .toList(),
            ),
            const SizedBox(height: 16),

            // Budget and Timeline
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Budget",
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: Colors.greenAccent.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      '\$${project.acceptedPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Timeline",
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: Colors.greenAccent.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      project.deliveryTime,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Start Date",
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: Colors.greenAccent.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      "${project.startDate.day}/${project.startDate.month}/${project.startDate.year}",
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}