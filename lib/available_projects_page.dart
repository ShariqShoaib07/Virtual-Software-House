import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AvailableProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF011B10),
      body: Center(
        child: Column(
          children: [
            Text(
              'Available Projects',
              style: GoogleFonts.orbitron(color: Colors.greenAccent, fontSize: 18),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ProjectData.notStartedProjects.length,
                itemBuilder: (context, index) {
                  final project = ProjectData.notStartedProjects[index];
                  return ListTile(
                    title: Text(project.title, style: TextStyle(color: Colors.white)),
                    subtitle: Text(project.details, style: TextStyle(color: Colors.white70)),
                    onTap: () {
                      // Show project details
                    },
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
