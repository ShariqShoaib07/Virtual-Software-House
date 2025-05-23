import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'project_data.dart';

class CompletedProjectsPage extends StatelessWidget {
  const CompletedProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final completedProjects = ProjectData.allProjects; //convert allProjects to completedProjects for real time data

    return Scaffold(
      backgroundColor: const Color(0xFF011B10),
      appBar: AppBar(
        title: Text(
          "Completed Projects",
          style: GoogleFonts.orbitron(
            color: Colors.greenAccent,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF011B10),
      ),
      body: completedProjects.isEmpty
          ? Center(
        child: Text(
          "No completed projects yet",
          style: GoogleFonts.orbitron(
            color: Colors.greenAccent.withOpacity(0.5),
          ),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: completedProjects.length,
        itemBuilder: (context, index) {
          final project = completedProjects[index];
          return _buildCompletedProjectCard(project, index);
        },
      ),
    );
  }

  Widget _buildCompletedProjectCard(Project project, int index) {
    final clientNames = ['TechSolutions Inc.', 'Digital Ventures', 'CodeCraft LLC'];
    final developerNames = ['Alex Johnson', 'Sam Wilson', 'Taylor Smith'];

    final clientName = clientNames[index % clientNames.length];
    final developerName = developerNames[index % developerNames.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
            // Project Title and Completion Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    project.title,
                    style: GoogleFonts.orbitron(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.green.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    "Completed",
                    style: GoogleFonts.orbitron(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

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
            const SizedBox(height: 12),

            // Project Details
            Text(
              project.details,
              style: GoogleFonts.orbitron(
                color: Colors.greenAccent.withOpacity(0.8),
                fontSize: 14,
              ),
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
                  title: "Duration",
                  value: _calculateDuration(project.startDate, project.endDate),
                ),
                _buildInfoTile(
                  icon: Icons.work,
                  title: "Type",
                  value: project.jobType,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Completion Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Completed on: ${_formatDate(project.endDate)}",
                  style: GoogleFonts.orbitron(
                    fontSize: 12,
                    color: Colors.greenAccent.withOpacity(0.7),
                  ),
                ),
                Icon(
                  Icons.verified,
                  color: Colors.greenAccent,
                  size: 20,
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

  String _calculateDuration(DateTime start, DateTime end) {
    final duration = end.difference(start);
    final weeks = (duration.inDays / 7).ceil();
    return "$weeks ${weeks == 1 ? 'week' : 'weeks'}";
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}