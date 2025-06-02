import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'project_data.dart';

class CompletedProjectsPage extends StatelessWidget {
  const CompletedProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final completedProjects = ProjectData.allProjects;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Completed Projects",
          style: GoogleFonts.roboto(
            color: Colors.black, // Green text
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF38E54D)), // Green icons
      ),
      body: completedProjects.isEmpty
          ? Center(
        child: Text(
          "No completed projects yet",
          style: GoogleFonts.roboto(
            color: Colors.grey[600],
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF38E54D).withOpacity(0.05), // Very subtle green shadow
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF38E54D).withOpacity(0.2), // Light green border
          width: 1.5,
        ),
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
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF38E54D),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF38E54D).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF38E54D).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    "Completed",
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF38E54D),
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
              style: GoogleFonts.roboto(
                color: Colors.grey[700],
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
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Icon(
                  Icons.verified,
                  color: const Color(0xFF38E54D), // Green icon
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
              color: const Color(0xFF38E54D), // Green icon
            ),
            const SizedBox(width: 4),
            Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.roboto(
            fontSize: isMoney ? 16 : 14,
            fontWeight: isMoney ? FontWeight.w600 : FontWeight.w500,
            color: isMoney ? const Color(0xFF38E54D) : Colors.black, // Green for money, black for others
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