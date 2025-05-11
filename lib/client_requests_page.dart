import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Updated Project model with clientId
class Project {
  final String title;
  final String details;
  final String deliveryTime;
  final List<String> requirements;
  final double acceptedPrice;
  final DateTime startDate;
  final DateTime endDate;
  final String? srsFile;
  final String clientId;

  Project({
    required this.title,
    required this.details,
    required this.deliveryTime,
    required this.requirements,
    required this.acceptedPrice,
    required this.startDate,
    required this.endDate,
    required this.clientId,
    this.srsFile,
  });
}

// Updated sample data with clientIds
class ProjectData {
  static final List<Project> notStartedProjects = [
    Project(
      title: "E-commerce Website",
      details: "Build a complete e-commerce platform with product listings and payment integration.",
      deliveryTime: "2 Months",
      requirements: ["Flutter", "Firebase", "Payment Gateway"],
      acceptedPrice: 2500.00,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 60)),
      clientId: "CL-1001",
    ),
    Project(
      title: "Mobile Banking App",
      details: "Develop a secure mobile banking application with transaction features.",
      deliveryTime: "3 Months",
      requirements: ["Flutter", "Node.js", "Security"],
      acceptedPrice: 3500.00,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 90)),
      clientId: "CL-1002",
    ),
  ];
}

class ClientRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF011B10),
      appBar: AppBar(
        title: Text(
          'Client Project Requests',
          style: GoogleFonts.orbitron(color: Colors.greenAccent, fontSize: 18),
        ),
        backgroundColor: Color(0xFF0F2C3D),
        centerTitle: true,
        elevation: 6,
        shadowColor: Colors.greenAccent.withOpacity(0.4),
      ),
      body: ProjectData.notStartedProjects.isEmpty
          ? Center(
        child: Text(
          'No project requests yet',
          style: GoogleFonts.orbitron(
            color: Colors.greenAccent.withOpacity(0.6),
            fontSize: 16,
          ),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: ProjectData.notStartedProjects.length,
        itemBuilder: (context, index) {
          final project = ProjectData.notStartedProjects[index];
          return _buildProjectCard(project, context);
        },
      ),
    );
  }

  Widget _buildProjectCard(Project project, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Color(0xFF0F3D2C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.greenAccent.withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent.withOpacity(0.2),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                project.title,
                style: GoogleFonts.orbitron(
                  color: Colors.greenAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFF013C2F),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  project.clientId,
                  style: GoogleFonts.orbitron(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),

          // Details
          Text(
            project.details,
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 16),

          // Delivery time and price
          Row(
            children: [
              _buildDetailChip(Icons.access_time, project.deliveryTime, Colors.cyanAccent),
              SizedBox(width: 12),
              _buildDetailChip(Icons.attach_money, "\$${project.acceptedPrice.toStringAsFixed(2)}", Colors.lightGreenAccent),
            ],
          ),
          SizedBox(height: 16),

          // Requirements
          Text(
            "Requirements:",
            style: GoogleFonts.orbitron(
              color: Colors.greenAccent,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: project.requirements
                .map(
                  (skill) => Chip(
                label: Text(skill, style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
                backgroundColor: Color(0xFF01432E),
                shape: StadiumBorder(side: BorderSide(color: Colors.greenAccent.withOpacity(0.5))),
              ),
            )
                .toList(),
          ),
          SizedBox(height: 20),

          // Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Project accepted from ${project.clientId}"),
                      backgroundColor: Colors.green,
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF38E54D).withOpacity(0.2),
                    foregroundColor: Color(0xFF38E54D),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text("Accept", style: GoogleFonts.orbitron(fontSize: 14)),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Project rejected from ${project.clientId}"),
                      backgroundColor: Colors.redAccent,
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent.withOpacity(0.2),
                    foregroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text("Reject", style: GoogleFonts.orbitron(fontSize: 14)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.orbitron(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}