import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'client_requests_page.dart';
import 'developer_requests_page.dart';
import 'available_projects_page.dart';
import 'ongoing_projects_page.dart';
import 'completed_projects_page.dart';

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
      'title': 'Available Projects',
      'icon': Icons.work_outline,
      'page': AvailableProjectsPage(),
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
