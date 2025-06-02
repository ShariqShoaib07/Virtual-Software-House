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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Available Projects",
          style: GoogleFonts.roboto(
            color: Colors.black, // Green title
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF38E54D)), // Green icons
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF38E54D).withOpacity(0.1), // Green tinted shadow
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: 'Search projects...',
                  hintStyle: GoogleFonts.roboto(
                    color: Colors.grey[600],
                  ),
                  prefixIcon: Icon(Icons.search, color: Color(0xFF38E54D)), // Green icon
                  filled: true,
                  fillColor: Colors.transparent,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
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
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filteredProjects.length,
                itemBuilder: (context, index) {
                  final project = _filteredProjects[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16),
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
    // Sample client and developer data - replace with your actual data source
    final clientNames = ['TechSolutions Inc.', 'Digital Ventures', 'CodeCraft LLC'];
    final developerNames = ['Alex Johnson', 'Sam Wilson', 'Taylor Smith'];
    final clientName = clientNames[_filteredProjects.indexOf(project) % clientNames.length];
    final developerName = developerNames[_filteredProjects.indexOf(project) % developerNames.length];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF38E54D).withOpacity(0.1), // Green tinted shadow
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: Color(0xFF38E54D).withOpacity(0.2), // Light green border
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Title
            Text(
              project.title,
              style: GoogleFonts.roboto(
                color: Color(0xFF38E54D), // Green title
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),

            // Project Description
            Text(
              project.details,
              style: GoogleFonts.roboto(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
            SizedBox(height: 16),

            // Client and Developer Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoTile(
                  icon: Icons.business,
                  title: "Client",
                  value: clientName,
                ),
                _buildInfoTile(
                  icon: Icons.code,
                  title: "Developer",
                  value: developerName,
                ),
              ],
            ),
            SizedBox(height: 16),

            // Project Metrics Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoTile(
                  icon: Icons.attach_money,
                  title: "Budget",
                  value: "\$${project.acceptedPrice.toStringAsFixed(2)}",
                  isMoney: true,
                ),
                _buildInfoTile(
                  icon: Icons.schedule,
                  title: "Timeline",
                  value: project.deliveryTime,
                ),
                _buildInfoTile(
                  icon: Icons.work,
                  title: "Type",
                  value: project.jobType,
                ),
              ],
            ),
            SizedBox(height: 8),

            // Requirements Chips
            if (project.requirements.isNotEmpty) ...[
              SizedBox(height: 12),
              Text(
                "Requirements:",
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: project.requirements
                    .take(3)
                    .map((req) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF38E54D).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color(0xFF38E54D).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    req,
                    style: GoogleFonts.roboto(
                      color: Color(0xFF38E54D),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
    bool isMoney = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: Color(0xFF38E54D), // Green icon
            ),
            SizedBox(width: 4),
            Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.roboto(
            fontSize: isMoney ? 16 : 14,
            fontWeight: isMoney ? FontWeight.w600 : FontWeight.w500,
            color: isMoney ? Color(0xFF38E54D) : Colors.black, // Green for money
          ),
        ),
      ],
    );
  }
}