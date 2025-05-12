import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'project_data.dart';

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
            Text(
              'Developer Requests',
              style: GoogleFonts.orbitron(color: Colors.greenAccent, fontSize: 18),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ProjectData.developerRequestedProjects.length,
                itemBuilder: (context, index) {
                  final project = ProjectData.developerRequestedProjects[index];
                  return Card(
                    color: Color(0xFF0F3D2C),
                    child: ListTile(
                      title: Text(project.title, style: TextStyle(color: Colors.white)),
                      subtitle: Text(project.details, style: TextStyle(color: Colors.white70)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.check, color: Colors.green),
                            onPressed: () {
                              setState(() {
                                project.status = ProjectStatus.ongoing;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                project.status = ProjectStatus.rejected;
                              });
                            },
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