import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'project_data.dart';

class DeveloperRequestsPage extends StatefulWidget {
  @override
  _DeveloperRequestsPageState createState() => _DeveloperRequestsPageState();
}

class _DeveloperRequestsPageState extends State<DeveloperRequestsPage> {
  void _handleStatusChange(Project project, ProjectStatus newStatus) {
    setState(() {
      ProjectData.updateProjectStatus(project, newStatus);
    });

    // Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(newStatus == ProjectStatus.ongoing
            ? 'Project approved'
            : 'Project rejected'),
        backgroundColor: newStatus == ProjectStatus.ongoing
            ? Colors.green
            : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF011B10),
      body: ProjectData.developerRequestedProjects.isEmpty
          ? Center(
        child: Text(
          'No developer requests available',
          style: GoogleFonts.orbitron(
            color: Colors.greenAccent.withOpacity(0.6),
          ),
        ),
      )
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Developer Requests',
              style: GoogleFonts.orbitron(
                  color: Colors.greenAccent,
                  fontSize: 18
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ProjectData.developerRequestedProjects.length,
              itemBuilder: (context, index) {
                final project = ProjectData.developerRequestedProjects[index];
                return Card(
                  color: Color(0xFF0F3D2C),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ... (keep your existing content) ...
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () => _handleStatusChange(
                                  project,
                                  ProjectStatus.rejected
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.check, color: Colors.green),
                              onPressed: () => _handleStatusChange(
                                  project,
                                  ProjectStatus.ongoing
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}