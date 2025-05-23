import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'project_data.dart';

class OngoingProjectsPage extends StatelessWidget {
  const OngoingProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ongoingProjects = ProjectData.allProjects;
    return Scaffold(
      backgroundColor: const Color(0xFF011B10),
      appBar: AppBar(
        title: Text(
          "Ongoing Projects",
          style: GoogleFonts.orbitron(
            color: Colors.greenAccent,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFF011B10),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: ongoingProjects.length,
        itemBuilder: (context, index) {
          final project = ongoingProjects[index];
          return _buildProjectCard(project, index);
        },
      ),
    );
  }

  Widget _buildProjectCard(Project project, int index) {
    // Static data for demo - in real app you'd get this from your data model
    final clientNames = ['TechSolutions Inc.', 'Digital Ventures', 'CodeCraft LLC'];
    final developerNames = ['Alex Johnson', 'Sam Wilson', 'Taylor Smith'];

    final clientName = clientNames[index % clientNames.length];
    final developerName = developerNames[index % developerNames.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F3D2C),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
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
                Flexible(
                  child: Text(
                    project.title,
                    style: GoogleFonts.orbitron(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.yellow.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    "Ongoing",
                    style: GoogleFonts.orbitron(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.yellow,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Project Details
            Text(
              project.details,
              style: GoogleFonts.orbitron(
                color: Colors.greenAccent.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),

            // Client and Developer Info
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
            const SizedBox(height: 16),

            // Project Metrics
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
                  title: "Delivery Time",
                  value: project.deliveryTime,
                ),
                _buildInfoTile(
                  icon: Icons.work,
                  title: "Job Type",
                  value: project.jobType,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Progress Bar (static for now)
            LinearProgressIndicator(
              value: 0.3, // Example 30% progress
              backgroundColor: Colors.greenAccent.withOpacity(0.1),
              color: Colors.greenAccent,
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "30% Completed",
                  style: GoogleFonts.orbitron(
                    fontSize: 12,
                    color: Colors.greenAccent.withOpacity(0.7),
                  ),
                ),
                Text(
                  "Due in 4 weeks",
                  style: GoogleFonts.orbitron(
                    fontSize: 12,
                    color: Colors.greenAccent.withOpacity(0.7),
                  ),
                ),
              ],
            ),
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
              color: Colors.greenAccent.withOpacity(0.7),
            ),
            const SizedBox(width: 4),
            Text(
              title,
              style: GoogleFonts.orbitron(
                fontSize: 12,
                color: Colors.greenAccent.withOpacity(0.7),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.orbitron(
            fontSize: isMoney ? 16 : 14,
            fontWeight: isMoney ? FontWeight.w600 : FontWeight.w500,
            color: Colors.greenAccent,
          ),
        ),
      ],
    );
  }
}