import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'project_data.dart';

class OngoingProjectsPage extends StatelessWidget {
  const OngoingProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ongoingProjects = ProjectData.allProjects;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Ongoing Projects",
          style: GoogleFonts.roboto(
            color: Colors.black, // Green text for title
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF38E54D)), // Green icons
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
    final clientNames = ['TechSolutions Inc.', 'Digital Ventures', 'CodeCraft LLC'];
    final developerNames = ['Alex Johnson', 'Sam Wilson', 'Taylor Smith'];

    final clientName = clientNames[index % clientNames.length];
    final developerName = developerNames[index % developerNames.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF38E54D).withOpacity(0.1), // Subtle green shadow
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Color(0xFF38E54D).withOpacity(0.2), // Light green border
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    project.title,
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF38E54D), // Green text for title
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF38E54D).withOpacity(0.1), // Light green background
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xFF38E54D).withOpacity(0.3), // Green border
                    ),
                  ),
                  child: Text(
                    "Ongoing",
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF38E54D), // Green text
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Text(
              project.details,
              style: GoogleFonts.roboto(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),

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
            color: isMoney ? Color(0xFF38E54D) : Colors.black, // Green for money, black for others
          ),
        ),
      ],
    );
  }
}