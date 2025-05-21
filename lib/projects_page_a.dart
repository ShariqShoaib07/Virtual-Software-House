import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'client_requests_page.dart';
import 'developer_requests_page.dart';
import 'ongoing_projects_page.dart';
import 'completed_projects_page.dart';
import 'project_data.dart';

class ProjectsPage extends StatelessWidget {
  final List<Map<String, dynamic>> projectSections = [
    {
      'title': 'Client Project Requests',
      'icon': Icons.person_outline,
      'page': ClientRequestsPage(),
    },
    {
      'title': 'Developer Project Requests',
      'icon': Icons.engineering,
      'page': DeveloperRequestsPage(),
    },
    {
      'title': 'Ongoing Projects',
      'icon': Icons.sync,
      'page': OngoingProjectsPage(),
    },
    {
      'title': 'Completed Projects',
      'icon': Icons.check_circle_outline,
      'page': CompletedProjectsPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF011B10),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'PROJECTS',
                  style: GoogleFonts.orbitron(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent,
                    letterSpacing: 2,
                  ),
                ),
              ),
              SizedBox(height: 32),
              ...projectSections.map((section) => _buildProjectCard(context, section)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> section) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => section['page']),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Color(0xFF0F3D2C),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.greenAccent.withOpacity(0.4),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(section['icon'], color: Colors.greenAccent, size: 30),
            SizedBox(width: 16),
            Text(
              section['title'],
              style: GoogleFonts.orbitron(
                fontSize: 16,
                color: Colors.greenAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, color: Colors.greenAccent, size: 16),
          ],
        ),
      ),
    );
  }
}

class DeveloperRequestsPage extends StatefulWidget {
  @override
  _DeveloperRequestsPageState createState() => _DeveloperRequestsPageState();
}

class _DeveloperRequestsPageState extends State<DeveloperRequestsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF011B10),
      body: Center(
        child: Column(
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
                          Text(
                            project.title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            project.details,
                            style: TextStyle(color: Colors.white70),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${project.acceptedPrice.toStringAsFixed(2)}',
                                style: TextStyle(color: Colors.greenAccent),
                              ),
                              Text(
                                project.deliveryTime,
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.close, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    project.status = ProjectStatus.rejected;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Project rejected'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  });
                                },
                              ),
                              SizedBox(width: 8),
                              IconButton(
                                icon: Icon(Icons.check, color: Colors.green),
                                onPressed: () {
                                  setState(() {
                                    project.status = ProjectStatus.ongoing;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Project approved'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  });
                                },
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
      ),
    );
  }
}